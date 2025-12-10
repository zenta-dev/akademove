import { m } from "@repo/i18n";
import { RepositoryError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { logger } from "@/utils/logger";
import { WalletSpec } from "./wallet-spec";

const { pub, priv } = createORPCRouter(WalletSpec);

export const WalletHandler = pub.router({
	get: priv.get.handler(async ({ context }) => {
		const res = await context.repo.wallet.getByUserId(context.user.id);

		return {
			status: 200,
			body: { message: m.server_wallet_retrieved(), data: res },
		};
	}),
	getMonthlySummary: priv.getMonthlySummary.handler(
		async ({ context, input: { query } }) => {
			const res = await context.repo.wallet.getMonthlySummary({
				...query,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: { message: m.server_wallet_summary_retrieved(), data: res },
			};
		},
	),
	topUp: priv.topUp.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const res = await context.repo.payment.charge(
				{
					...body,
					transactionType: "TOPUP",
					userId: context.user.id,
					orderType: "TOPUP",
				},
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_wallet_retrieved(), data: res.payment },
			};
		});
	}),
	pay: priv.pay.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const res = await context.repo.wallet.pay(
				{
					...body,
					userId: context.user.id,
				},
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_wallet_retrieved(), data: res },
			};
		});
	}),
	transfer: priv.transfer.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const opts = { tx };

			// Get sender wallet
			const senderWallet = await context.repo.wallet.getByUserId(
				context.user.id,
				opts,
			);

			// Get recipient wallet
			const recipientWallet = await tx.query.wallet.findFirst({
				where: (f, op) => op.eq(f.id, body.walletId),
			});

			if (!recipientWallet) {
				throw new RepositoryError("Recipient wallet not found", {
					code: "NOT_FOUND",
				});
			}

			// Prevent self-transfer
			if (senderWallet.id === recipientWallet.id) {
				throw new RepositoryError("Cannot transfer to your own wallet", {
					code: "BAD_REQUEST",
				});
			}

			// Get minimum transfer amount from configuration
			const businessConfig = await BusinessConfigurationService.getConfig(
				context.svc.db,
				context.svc.kv,
			);
			if (body.amount < businessConfig.minTransferAmount) {
				throw new RepositoryError(
					`Minimum transfer amount is ${businessConfig.minTransferAmount.toLocaleString("id-ID")} IDR`,
					{ code: "BAD_REQUEST" },
				);
			}

			// Use atomic transfer to prevent race conditions
			// This will throw if sender has insufficient balance
			const {
				senderBalanceBefore,
				senderBalanceAfter,
				recipientBalanceBefore,
				recipientBalanceAfter,
			} = await context.repo.wallet.transfer(
				{
					senderWalletId: senderWallet.id,
					recipientWalletId: recipientWallet.id,
					amount: body.amount,
				},
				opts,
			);

			// Create transfer transactions (using ADJUSTMENT type)
			const [senderTransaction, recipientTransaction] = await Promise.all([
				// Deduct from sender
				context.repo.transaction.insert(
					{
						walletId: senderWallet.id,
						type: "ADJUSTMENT",
						amount: -body.amount,
						balanceBefore: senderBalanceBefore,
						balanceAfter: senderBalanceAfter,
						status: "SUCCESS",
						description: `Transfer to wallet ${body.walletId.slice(0, 8)}`,
						referenceId: body.walletId,
						metadata: {
							recipientWalletId: body.walletId,
							transferType: "out",
						},
					},
					opts,
				),

				// Credit to recipient
				context.repo.transaction.insert(
					{
						walletId: recipientWallet.id,
						type: "ADJUSTMENT",
						amount: body.amount,
						balanceBefore: recipientBalanceBefore,
						balanceAfter: recipientBalanceAfter,
						status: "SUCCESS",
						description: `Transfer from wallet ${senderWallet.id.slice(0, 8)}`,
						referenceId: senderWallet.id,
						metadata: {
							senderWalletId: senderWallet.id,
							transferType: "in",
						},
					},
					opts,
				),
			]);

			logger.info(
				{
					userId: context.user.id,
					senderWalletId: senderWallet.id,
					recipientWalletId: body.walletId,
					amount: body.amount,
				},
				"[WalletHandler] Transfer completed",
			);

			return {
				status: 200,
				body: {
					message: m.server_wallet_retrieved(),
					data: {
						id: senderTransaction.id,
						transactionId: senderTransaction.id,
						provider: "MANUAL" as const,
						method: "wallet" as const,
						amount: body.amount,
						status: senderTransaction.status,
						metadata: {
							senderTransaction,
							recipientTransaction,
							recipientWalletId: body.walletId,
						},
						createdAt: senderTransaction.createdAt,
						updatedAt: senderTransaction.updatedAt,
					},
				},
			};
		});
	}),
	withdraw: priv.withdraw.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const opts = { tx };
			const wallet = await context.repo.wallet.getByUserId(
				context.user.id,
				opts,
			);

			// Get minimum withdrawal amount from configuration
			const businessConfig = await BusinessConfigurationService.getConfig(
				context.svc.db,
				context.svc.kv,
			);
			if (body.amount < businessConfig.minWithdrawalAmount) {
				throw new RepositoryError(
					`Minimum withdrawal amount is ${businessConfig.minWithdrawalAmount.toLocaleString("id-ID")} IDR`,
					{ code: "BAD_REQUEST" },
				);
			}

			// Use atomic balance deduction to prevent race conditions
			// This will throw if insufficient balance (atomically checks and deducts)
			const { balanceBefore, balanceAfter } =
				await context.repo.wallet.atomicDeduct(
					{ walletId: wallet.id, amount: body.amount },
					opts,
				);

			// Create withdrawal transaction (PENDING status)
			// In production, this would trigger Midtrans disbursement API
			const transaction = await context.repo.transaction.insert(
				{
					walletId: wallet.id,
					type: "WITHDRAW",
					amount: body.amount,
					balanceBefore,
					balanceAfter,
					status: "PENDING",
					description: `Withdrawal to ${body.bankProvider} ${body.accountNumber}`,
					metadata: {
						bankProvider: body.bankProvider,
						accountNumber: body.accountNumber,
						accountName: body.accountName,
					},
				},
				opts,
			);

			logger.info(
				{
					userId: context.user.id,
					walletId: wallet.id,
					amount: body.amount,
					balanceBefore,
					balanceAfter,
				},
				"[WalletHandler] Withdrawal processed",
			);

			return {
				status: 200,
				body: {
					message: m.server_withdrawal_requested(),
					data: {
						id: transaction.id,
						transactionId: transaction.id,
						provider: "MIDTRANS" as const,
						method: "BANK_TRANSFER" as const,
						amount: body.amount,
						status: transaction.status,
						bankProvider: body.bankProvider,
						metadata: transaction.metadata,
						createdAt: transaction.createdAt,
						updatedAt: transaction.updatedAt,
					},
				},
			};
		});
	}),
});

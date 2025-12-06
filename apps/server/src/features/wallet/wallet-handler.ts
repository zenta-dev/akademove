import { m } from "@repo/i18n";
import { createORPCRouter } from "@/core/router/orpc";
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
				throw new Error("Recipient wallet not found");
			}

			// Prevent self-transfer
			if (senderWallet.id === recipientWallet.id) {
				throw new Error("Cannot transfer to your own wallet");
			}

			// Check sufficient balance
			if (senderWallet.balance < body.amount) {
				throw new Error("Insufficient balance");
			}

			// Minimum transfer check (10,000 IDR)
			if (body.amount < 10000) {
				throw new Error("Minimum transfer amount is 10,000 IDR");
			}

			const senderBalanceBefore = senderWallet.balance;
			const senderBalanceAfter = senderBalanceBefore - body.amount;
			const recipientBalanceBefore = Number(recipientWallet.balance);
			const recipientBalanceAfter = recipientBalanceBefore + body.amount;

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

			// Update wallet balances
			await Promise.all([
				context.repo.wallet.update(
					senderWallet.id,
					{ balance: senderBalanceAfter },
					opts,
					context,
				),
				context.repo.wallet.update(
					recipientWallet.id,
					{ balance: recipientBalanceAfter },
					opts,
					context,
				),
			]);

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
			const wallet = await context.repo.wallet.getByUserId(context.user.id, {
				tx,
			});

			// Check sufficient balance
			if (wallet.balance < body.amount) {
				throw new Error("Insufficient balance");
			}

			// Minimum withdrawal check (50,000 IDR)
			if (body.amount < 50000) {
				throw new Error("Minimum withdrawal amount is 50,000 IDR");
			}

			const balanceBefore = wallet.balance;
			const balanceAfter = balanceBefore - body.amount;

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
				{ tx },
			);

			// Update wallet balance
			await context.repo.wallet.update(
				wallet.id,
				{ balance: balanceAfter },
				{ tx },
				context,
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

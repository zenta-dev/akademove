import { m } from "@repo/i18n";
import type { BankProvider } from "@repo/schema/common";
import { trimObjectValues } from "@repo/shared";
import { AuthError, RepositoryError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { logger } from "@/utils/logger";
import { MerchantWalletSpec } from "./merchant-wallet-spec";

const { priv } = createORPCRouter(MerchantWalletSpec);

export const MerchantWalletHandler = priv.router({
	getWallet: priv.getWallet.handler(async ({ context, input: { params } }) => {
		// Get merchant to find userId
		const merchant = await context.repo.merchant.main.get(params.merchantId);

		// IDOR Protection: Merchants can only access their own wallet
		if (
			context.user.role === "MERCHANT" &&
			merchant.userId !== context.user.id
		) {
			throw new AuthError("You can only access your own wallet", {
				code: "FORBIDDEN",
			});
		}

		const res = await context.repo.wallet.getByUserId(merchant.userId);

		return {
			status: 200,
			body: { message: m.server_wallet_retrieved(), data: res },
		};
	}),

	getMonthlySummary: priv.getMonthlySummary.handler(
		async ({ context, input: { params, query } }) => {
			// Get merchant to find userId
			const merchant = await context.repo.merchant.main.get(params.merchantId);

			// IDOR Protection: Merchants can only access their own wallet
			if (
				context.user.role === "MERCHANT" &&
				merchant.userId !== context.user.id
			) {
				throw new AuthError("You can only access your own wallet summary", {
					code: "FORBIDDEN",
				});
			}

			const res = await context.repo.wallet.getMonthlySummary({
				...query,
				userId: merchant.userId,
			});

			return {
				status: 200,
				body: { message: m.server_wallet_summary_retrieved(), data: res },
			};
		},
	),

	getTransactions: priv.getTransactions.handler(
		async ({ context, input: { params, query } }) => {
			// Get merchant to find userId
			const merchant = await context.repo.merchant.main.get(params.merchantId);

			// IDOR Protection: Merchants can only access their own transactions
			if (
				context.user.role === "MERCHANT" &&
				merchant.userId !== context.user.id
			) {
				throw new AuthError("You can only access your own transactions", {
					code: "FORBIDDEN",
				});
			}

			const { rows, totalPages } = await context.repo.transaction.list({
				...query,
				userId: merchant.userId,
			});

			return {
				status: 200,
				body: {
					message: m.server_transactions_retrieved(),
					data: rows,
					totalPages,
				},
			};
		},
	),

	topUp: priv.topUp.handler(async ({ context, input: { params, body } }) => {
		// Get merchant to find userId
		const merchant = await context.repo.merchant.main.get(params.merchantId);

		// IDOR Protection: Merchants can only top up their own wallet
		if (
			context.user.role === "MERCHANT" &&
			merchant.userId !== context.user.id
		) {
			throw new AuthError("You can only top up your own wallet", {
				code: "FORBIDDEN",
			});
		}

		return await context.svc.db.transaction(async (tx) => {
			const res = await context.repo.payment.charge(
				{
					...body,
					transactionType: "TOPUP",
					userId: merchant.userId,
					orderType: "TOPUP",
					bank: body.bankProvider,
				},
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_wallet_retrieved(), data: res.payment },
			};
		});
	}),

	transfer: priv.transfer.handler(
		async ({ context, input: { params, body } }) => {
			// Get merchant to find userId
			const merchant = await context.repo.merchant.main.get(params.merchantId);

			// IDOR Protection: Merchants can only transfer from their own wallet
			if (
				context.user.role === "MERCHANT" &&
				merchant.userId !== context.user.id
			) {
				throw new AuthError("You can only transfer from your own wallet", {
					code: "FORBIDDEN",
				});
			}

			return await context.svc.db.transaction(async (tx) => {
				const opts = { tx };
				const data = trimObjectValues(body);

				// Prevent self-transfer
				if (merchant.userId === data.recipientUserId) {
					throw new RepositoryError("Cannot transfer to your own wallet", {
						code: "BAD_REQUEST",
					});
				}

				// Get sender wallet
				const senderWallet = await context.repo.wallet.getByUserId(
					merchant.userId,
					opts,
				);

				// Get sender user info for description
				const senderUser = await tx.query.user.findFirst({
					where: (f, op) => op.eq(f.id, merchant.userId),
					columns: { id: true, name: true },
				});

				if (!senderUser) {
					throw new RepositoryError("Sender user not found", {
						code: "NOT_FOUND",
					});
				}

				// Get recipient user and wallet
				const recipientUser = await tx.query.user.findFirst({
					where: (f, op) => op.eq(f.id, data.recipientUserId),
					columns: { id: true, name: true },
				});

				if (!recipientUser) {
					throw new RepositoryError("Recipient user not found", {
						code: "NOT_FOUND",
					});
				}

				// Get or create recipient wallet
				const recipientWallet = await context.repo.wallet.getByUserId(
					data.recipientUserId,
					opts,
				);

				// Get minimum transfer amount from configuration
				const businessConfig = await BusinessConfigurationService.getConfig(
					context.svc.db,
					context.svc.kv,
				);
				if (data.amount < businessConfig.minTransferAmount) {
					throw new RepositoryError(
						`Minimum transfer amount is ${businessConfig.minTransferAmount.toLocaleString("id-ID")} IDR`,
						{ code: "BAD_REQUEST" },
					);
				}

				// Use atomic transfer to prevent race conditions
				const {
					senderBalanceBefore,
					senderBalanceAfter,
					recipientBalanceBefore,
					recipientBalanceAfter,
				} = await context.repo.wallet.transfer(
					{
						senderWalletId: senderWallet.id,
						recipientWalletId: recipientWallet.id,
						amount: data.amount,
					},
					opts,
				);

				// Build description with optional note
				const senderDescription = data.note
					? `Transfer to ${recipientUser.name}: ${data.note}`
					: `Transfer to ${recipientUser.name}`;
				const recipientDescription = data.note
					? `Transfer from ${senderUser.name}: ${data.note}`
					: `Transfer from ${senderUser.name}`;

				// Create transfer transactions (using ADJUSTMENT type)
				const [senderTransaction] = await Promise.all([
					// Deduct from sender
					context.repo.transaction.insert(
						{
							walletId: senderWallet.id,
							type: "ADJUSTMENT",
							amount: -data.amount,
							balanceBefore: senderBalanceBefore,
							balanceAfter: senderBalanceAfter,
							status: "SUCCESS",
							description: senderDescription,
							referenceId: recipientWallet.id,
							metadata: {
								recipientUserId: data.recipientUserId,
								recipientName: recipientUser.name,
								note: data.note,
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
							amount: data.amount,
							balanceBefore: recipientBalanceBefore,
							balanceAfter: recipientBalanceAfter,
							status: "SUCCESS",
							description: recipientDescription,
							referenceId: senderWallet.id,
							metadata: {
								senderUserId: merchant.userId,
								senderName: senderUser.name,
								note: data.note,
								transferType: "in",
							},
						},
						opts,
					),
				]);

				logger.info(
					{
						merchantId: params.merchantId,
						userId: merchant.userId,
						senderWalletId: senderWallet.id,
						recipientUserId: data.recipientUserId,
						recipientWalletId: recipientWallet.id,
						amount: data.amount,
					},
					"[MerchantWalletHandler] Transfer completed",
				);

				return {
					status: 200,
					body: {
						message: m.server_transfer_completed(),
						data: {
							transactionId: senderTransaction.id,
							amount: data.amount,
							status: senderTransaction.status,
							recipientName: recipientUser.name,
							recipientUserId: data.recipientUserId,
							note: data.note,
							createdAt: senderTransaction.createdAt,
						},
					},
				};
			});
		},
	),

	withdraw: priv.withdraw.handler(
		async ({ context, input: { params, body } }) => {
			// Get merchant to find userId
			const merchant = await context.repo.merchant.main.get(params.merchantId);

			// IDOR Protection: Merchants can only withdraw from their own wallet
			if (
				context.user.role === "MERCHANT" &&
				merchant.userId !== context.user.id
			) {
				throw new AuthError("You can only withdraw from your own wallet", {
					code: "FORBIDDEN",
				});
			}

			return await context.svc.db.transaction(async (tx) => {
				const opts = { tx };
				const data = trimObjectValues(body);

				// Get user's wallet
				const wallet = await context.repo.wallet.getByUserId(
					merchant.userId,
					opts,
				);

				// Get user details for beneficiary name
				const user = await tx.query.user.findFirst({
					where: (f, op) => op.eq(f.id, merchant.userId),
					columns: { id: true, name: true, email: true },
				});

				if (!user) {
					throw new RepositoryError("User not found", {
						code: "NOT_FOUND",
					});
				}

				// Get minimum withdrawal amount from configuration
				const businessConfig = await BusinessConfigurationService.getConfig(
					context.svc.db,
					context.svc.kv,
				);
				if (data.amount < businessConfig.minWithdrawalAmount) {
					throw new RepositoryError(
						`Minimum withdrawal amount is ${businessConfig.minWithdrawalAmount.toLocaleString("id-ID")} IDR`,
						{ code: "BAD_REQUEST" },
					);
				}

				// Save bank details to merchant profile if requested
				if (data.saveBank) {
					const bankDetails = {
						provider: data.bankProvider,
						number: Number(data.accountNumber),
						accountName: data.accountName,
					};

					await context.repo.merchant.main.update(
						params.merchantId,
						{ bank: bankDetails },
						opts,
					);
					logger.info(
						{ userId: merchant.userId, merchantId: params.merchantId },
						"[MerchantWalletHandler] Saved bank details to merchant profile",
					);
				}

				// Use atomic balance deduction to prevent race conditions
				const { balanceBefore, balanceAfter } =
					await context.repo.wallet.atomicDeduct(
						{ walletId: wallet.id, amount: data.amount },
						opts,
					);

				// Create withdrawal transaction (PENDING status initially)
				const transaction = await context.repo.transaction.insert(
					{
						walletId: wallet.id,
						type: "WITHDRAW",
						amount: data.amount,
						balanceBefore,
						balanceAfter,
						status: "PENDING",
						description: `Withdrawal to ${data.bankProvider} ${data.accountNumber}`,
						metadata: {
							bankProvider: data.bankProvider,
							accountNumber: data.accountNumber,
							accountName: data.accountName ?? user.name,
						},
					},
					opts,
				);

				// Trigger Midtrans Iris payout/disbursement
				const payoutResult = await context.svc.payout.createPayout({
					referenceNo: transaction.id,
					beneficiaryName: data.accountName ?? user.name,
					beneficiaryAccount: data.accountNumber,
					beneficiaryBank: data.bankProvider,
					beneficiaryEmail: user.email ?? undefined,
					amount: data.amount,
					notes: `AkadeMove merchant withdrawal - ${transaction.id}`,
				});

				// Update transaction with payout result
				let finalStatus: "PENDING" | "SUCCESS" | "FAILED" = "PENDING";
				if (payoutResult.status === "completed") {
					finalStatus = "SUCCESS";
				} else if (payoutResult.status === "failed") {
					finalStatus = "FAILED";
					// Refund the balance if payout failed immediately
					await context.repo.wallet.atomicAdd(
						{ walletId: wallet.id, amount: data.amount },
						opts,
					);
				}

				// Update transaction with payout reference and status
				await context.repo.transaction.update(
					transaction.id,
					{
						status: finalStatus,
						referenceId: payoutResult.referenceNo,
						metadata: {
							...transaction.metadata,
							payoutReferenceNo: payoutResult.referenceNo,
							payoutStatus: payoutResult.status,
							payoutErrorMessage: payoutResult.errorMessage,
						},
					},
					opts,
				);

				logger.info(
					{
						merchantId: params.merchantId,
						userId: merchant.userId,
						walletId: wallet.id,
						transactionId: transaction.id,
						amount: data.amount,
						payoutStatus: payoutResult.status,
						payoutReferenceNo: payoutResult.referenceNo,
					},
					"[MerchantWalletHandler] Withdrawal payout initiated",
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
							amount: data.amount,
							status: finalStatus,
							bankProvider: data.bankProvider,
							metadata: {
								...transaction.metadata,
								payoutReferenceNo: payoutResult.referenceNo,
								payoutStatus: payoutResult.status,
							},
							createdAt: transaction.createdAt,
							updatedAt: transaction.updatedAt,
						},
					},
				};
			});
		},
	),

	getSavedBankAccount: priv.getSavedBankAccount.handler(
		async ({ context, input: { params } }) => {
			// Get merchant to find userId and bank details
			const merchant = await context.repo.merchant.main.get(params.merchantId);

			// IDOR Protection: Merchants can only access their own bank details
			if (
				context.user.role === "MERCHANT" &&
				merchant.userId !== context.user.id
			) {
				throw new AuthError("You can only access your own bank details", {
					code: "FORBIDDEN",
				});
			}

			const bankData = merchant.bank;

			if (!bankData) {
				return {
					status: 200,
					body: {
						message: m.server_wallet_retrieved(),
						data: {
							hasSavedBank: false,
							bankProvider: undefined,
							accountNumber: undefined,
							accountName: undefined,
						},
					},
				};
			}

			return {
				status: 200,
				body: {
					message: m.server_wallet_retrieved(),
					data: {
						hasSavedBank: true,
						bankProvider: bankData.provider as BankProvider,
						accountNumber: String(bankData.number),
						accountName: bankData.accountName ?? undefined,
					},
				},
			};
		},
	),
});

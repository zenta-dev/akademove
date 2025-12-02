import { createORPCRouter } from "@/core/router/orpc";
import { walletSpec } from "./wallet-spec";

const { pub, priv } = createORPCRouter(walletSpec);

export const walletHandler = pub.router({
	get: priv.get.handler(async ({ context }) => {
		const res = await context.repo.wallet.getByUserId(context.user.id);

		return {
			status: 200,
			body: { message: "Get wallet success", data: res },
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
				body: { message: "Get monthly summary success", data: res },
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
				body: { message: "Get wallet success", data: res.payment },
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
				body: { message: "Get wallet success", data: res },
			};
		});
	}),
	transfer: priv.transfer.handler(async () => {
		throw new Error("Unimplemented");
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
			);

			return {
				status: 200,
				body: {
					message:
						"Withdrawal request submitted successfully. It will be processed within 1-3 business days.",
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

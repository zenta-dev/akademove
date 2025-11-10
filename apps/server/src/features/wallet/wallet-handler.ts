import { createORPCRouter } from "@/core/router/orpc";
import { WalletSpec } from "./wallet-spec";

const { pub, priv } = createORPCRouter(WalletSpec);

export const WalletHandler = pub.router({
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
					transactionType: "topup",
					userId: context.user.id,
					orderType: "top-up",
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
});

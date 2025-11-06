import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import {
	orpcAuthMiddleware,
	orpcRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { WalletSpec } from "./wallet-spec";

const pub = implement(WalletSpec).$context<ORPCContext>();
const priv = pub.use(orpcAuthMiddleware).use(orpcRequireAuthMiddleware);

export const WalletHandler = pub.router({
	get: priv.get.handler(async ({ context }) => {
		return await context.svc.db.transaction(async (tx) => {
			const res = await context.repo.wallet.get({
				userId: context.user.id,
				tx,
			});

			return {
				status: 200,
				body: { message: "Get wallet success", data: res },
			};
		});
	}),
	getMonthlySummary: priv.getMonthlySummary.handler(
		async ({ context, input: { query } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const res = await context.repo.wallet.getMonthlySummary({
					...query,
					userId: context.user.id,
					tx,
				});

				return {
					status: 200,
					body: { message: "Get monthly summary success", data: res },
				};
			});
		},
	),
	transactions: priv.transactions.handler(async ({ context }) => {
		return await context.svc.db.transaction(async (tx) => {
			const res = await context.repo.wallet.getTransactions({
				userId: context.user.id,
				tx,
			});

			return {
				status: 200,
				body: { message: "Get wallet success", data: res },
			};
		});
	}),
	topUp: priv.topUp.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const res = await context.repo.wallet.topUp({
				...body,
				userId: context.user.id,
				tx,
			});

			return {
				status: 200,
				body: { message: "Get wallet success", data: res },
			};
		});
	}),
	pay: priv.pay.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const res = await context.repo.wallet.pay({
				...body,
				userId: context.user.id,
				tx,
			});

			return {
				status: 200,
				body: { message: "Get wallet success", data: res },
			};
		});
	}),
	transfer: priv.transfer.handler(async ({ context, input: { body } }) => {
		throw new Error("Unimplemented");
	}),
	webhookMidtrans: pub.webhookMidtrans.handler(
		async ({ context, input: { body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				await context.repo.wallet.handleWebhookMidtrans({
					body,
					tx,
				});

				return {
					status: 200,
					body: { message: "Get wallet success", data: null },
				};
			});
		},
	),
});

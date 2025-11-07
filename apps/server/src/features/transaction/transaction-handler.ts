import { createORPCRouter } from "@/core/router/orpc";
import { TransactionSpec } from "./transaction-spec";

const { priv } = createORPCRouter(TransactionSpec);

export const TransactionHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const res = await context.repo.transaction.list({
			...query,
			userId: context.user.id,
		});

		return {
			status: 200,
			body: { message: "Get transaction success", data: res },
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const res = await context.repo.transaction.get(params.id);

		return {
			status: 200,
			body: { message: "Get transaction success", data: res },
		};
	}),
});

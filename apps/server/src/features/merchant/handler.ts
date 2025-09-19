import { implement } from "@orpc/server";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import type { ORPCCOntext } from "@/core/orpc";
import { MerchantSpec } from "./spec";

const os = implement(MerchantSpec).$context<ORPCCOntext>().use(authMiddleware);

export const MerchantHandler = os.router({
	list: os.list
		.use(hasPermission({ merchant: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.merchant.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchants data",
					data: result,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ merchant: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.merchant.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved merchant data", data: result },
			};
		}),
	create: os.create
		.use(hasPermission({ merchant: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.merchant.create({
				...body,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: { message: "Merchant created successfully", data: result },
			};
		}),
	update: os.update
		.use(hasPermission({ merchant: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.merchant.update(params.id, body);

			return {
				status: 200,
				body: { message: "Merchant updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ merchant: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.merchant.remove(params.id);

			return {
				status: 200,
				body: { message: "Merchant deleted successfully", data: null },
			};
		}),
});

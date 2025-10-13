import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import { MerchantMainSpec } from "./spec";

const os = implement(MerchantMainSpec)
	.$context<ORPCContext>()
	.use(authMiddleware);

export const MerchantMainHandler = os.router({
	getMine: os.getMine
		.use(hasPermission({ merchant: ["get"] }))
		.handler(async ({ context }) => {
			const result = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);

			return {
				status: 200,
				body: { message: "Successfully retrieved merchant data", data: result },
			};
		}),
	list: os.list
		.use(hasPermission({ merchant: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.merchant.main.list(query);

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
			const result = await context.repo.merchant.main.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved merchant data", data: result },
			};
		}),
	// create: os.create
	// 	.use(hasPermission({ merchant: ["create"] }))
	// 	.handler(async ({ context, input: { body } }) => {
	// 		const result = await context.repo.merchant.main.create({
	// 			...body,
	// 			userId: context.user.id,
	// 		});

	// 		return {
	// 			status: 200,
	// 			body: { message: "Merchant created successfully", data: result },
	// 		};
	// 	}),
	update: os.update
		.use(hasPermission({ merchant: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.merchant.main.update(params.id, body);

			return {
				status: 200,
				body: { message: "Merchant updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ merchant: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.merchant.main.remove(params.id);

			return {
				status: 200,
				body: { message: "Merchant deleted successfully", data: null },
			};
		}),
});

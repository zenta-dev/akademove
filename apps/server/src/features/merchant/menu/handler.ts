import { implement } from "@orpc/server";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import type { ORPCCOntext } from "@/core/orpc";
import { MerchantMenuSpec } from "./spec";

const os = implement(MerchantMenuSpec)
	.$context<ORPCCOntext>()
	.use(authMiddleware);

export const MerchantMenuHandler = os.router({
	list: os.list
		.use(hasPermission({ merchant: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.merchant.menu.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchantmenus data",
					data: result,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ merchant: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.merchant.menu.get(params.id);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchantmenu data",
					data: result,
				},
			};
		}),
	create: os.create
		.use(hasPermission({ merchant: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.merchant.menu.create({
				...body,
			});

			return {
				status: 200,
				body: { message: "MerchantMenu created successfully", data: result },
			};
		}),
	update: os.update
		.use(hasPermission({ merchant: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.merchant.menu.update(params.id, body);

			return {
				status: 200,
				body: { message: "MerchantMenu updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ merchant: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.merchant.menu.remove(params.id);

			return {
				status: 200,
				body: { message: "MerchantMenu deleted successfully", data: null },
			};
		}),
});

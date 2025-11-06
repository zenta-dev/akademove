import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import {
	hasPermission,
	orpcAuthMiddleware,
	orpcRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { MerchantMenuSpec } from "./spec";

const os = implement(MerchantMenuSpec)
	.$context<ORPCContext>()
	.use(orpcAuthMiddleware)
	.use(orpcRequireAuthMiddleware);

export const MerchantMenuHandler = os.router({
	list: os.list
		.use(hasPermission({ merchantMenu: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.merchant.menu.list(query);
			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchantmenus data",
					data: rows,
					totalPages,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ merchantMenu: ["get"] }))
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
		.use(hasPermission({ merchantMenu: ["create"] }))
		.handler(async ({ context, input: { body, params } }) => {
			const result = await context.repo.merchant.menu.create({
				...body,
				...params,
			});

			return {
				status: 200,
				body: { message: "MerchantMenu created successfully", data: result },
			};
		}),
	update: os.update
		.use(hasPermission({ merchantMenu: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.merchant.menu.update(params.id, {
				...body,
				merchantId: params.merchantId,
			});

			return {
				status: 200,
				body: { message: "MerchantMenu updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ merchantMenu: ["delete"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.merchant.menu.remove(params.id);

			return {
				status: 200,
				body: { message: "MerchantMenu deleted successfully", data: null },
			};
		}),
});

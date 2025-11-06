import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { MerchantMenuSpec } from "./merchant-menu-spec";

const { priv } = createORPCRouter(MerchantMenuSpec);

export const MerchantMenuHandler = priv.router({
	list: priv.list
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
	get: priv.get
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
	create: priv.create
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
	update: priv.update
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
	remove: priv.remove
		.use(hasPermission({ merchantMenu: ["delete"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.merchant.menu.remove(params.id);

			return {
				status: 200,
				body: { message: "MerchantMenu deleted successfully", data: null },
			};
		}),
});

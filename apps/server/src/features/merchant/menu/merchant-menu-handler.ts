import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { MerchantMenuSpec } from "./merchant-menu-spec";

const { priv } = createORPCRouter(MerchantMenuSpec);

export const MerchantMenuHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query, params } }) => {
		const { rows, totalPages } = await context.repo.merchant.menu.list({
			...query,
			merchantId: params.merchantId,
		});
		return {
			status: 200,
			body: {
				message: m.server_merchant_menus_retrieved(),
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.merchant.menu.get(params.id);

		return {
			status: 200,
			body: {
				message: m.server_merchant_menu_retrieved(),
				data: result,
			},
		};
	}),
	create: priv.create.handler(async ({ context, input: { body, params } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.merchant.menu.create({
			...data,
			...params,
		});

		return {
			status: 200,
			body: { message: m.server_menu_created(), data: result },
		};
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.merchant.menu.update(params.id, {
			...data,
			merchantId: params.merchantId,
		});

		return {
			status: 200,
			body: { message: m.server_menu_updated(), data: result },
		};
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		await context.repo.merchant.menu.remove(params.id);

		return {
			status: 200,
			body: { message: m.server_menu_deleted(), data: null },
		};
	}),
});

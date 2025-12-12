import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { shouldBypassAuthorization } from "@/core/middlewares/auth";
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
		// Only MERCHANT, ADMIN, and OPERATOR can create menu items
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can create menu items",
				{
					code: "FORBIDDEN",
				},
			);
		}

		// IDOR protection: Merchants can only create menu items for their own merchant
		if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);
			if (merchant.id !== params.merchantId) {
				throw new AuthError(
					"Access denied: Cannot create menu items for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.merchant.menu.create(
				{
					...data,
					...params,
				},
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_menu_created(), data: result },
			};
		});
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can update menu items
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can update menu items",
				{
					code: "FORBIDDEN",
				},
			);
		}

		// IDOR protection: Merchants can only update menu items for their own merchant
		if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);
			if (merchant.id !== params.merchantId) {
				throw new AuthError(
					"Access denied: Cannot update menu items for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.merchant.menu.update(
				params.id,
				{
					...data,
					merchantId: params.merchantId,
				},
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_menu_updated(), data: result },
			};
		});
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can delete menu items
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can delete menu items",
				{
					code: "FORBIDDEN",
				},
			);
		}

		// IDOR protection: Merchants can only delete menu items for their own merchant
		if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
			const menu = await context.repo.merchant.menu.get(params.id);
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);
			if (menu.merchantId !== merchant.id) {
				throw new AuthError(
					"Access denied: Cannot delete menu items for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			await context.repo.merchant.menu.remove(params.id, { tx });

			return {
				status: 200,
				body: { message: m.server_menu_deleted(), data: null },
			};
		});
	}),
});

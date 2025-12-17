import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { shouldBypassAuthorization } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { MerchantMenuCategorySpec } from "./merchant-menu-category-spec";

const { priv } = createORPCRouter(MerchantMenuCategorySpec);

export const MerchantMenuCategoryHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query, params } }) => {
		const { rows, totalPages } = await context.repo.merchant.menuCategory.list({
			...query,
			merchantId: params.merchantId,
		});
		return {
			status: 200,
			body: {
				message: "Menu categories retrieved successfully",
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.merchant.menuCategory.get(params.id);

		return {
			status: 200,
			body: {
				message: "Menu category retrieved successfully",
				data: result,
			},
		};
	}),
	create: priv.create.handler(async ({ context, input: { body, params } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can create menu categories
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can create menu categories",
				{
					code: "FORBIDDEN",
				},
			);
		}

		// IDOR protection: Merchants can only create categories for their own merchant
		if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);
			if (merchant.id !== params.merchantId) {
				throw new AuthError(
					"Access denied: Cannot create menu categories for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.merchant.menuCategory.create(
				{
					...data,
					merchantId: params.merchantId,
				},
				{ tx },
			);

			return {
				status: 200,
				body: { message: "Menu category created successfully", data: result },
			};
		});
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can update menu categories
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can update menu categories",
				{
					code: "FORBIDDEN",
				},
			);
		}

		// IDOR protection: Merchants can only update categories for their own merchant
		if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);
			if (merchant.id !== params.merchantId) {
				throw new AuthError(
					"Access denied: Cannot update menu categories for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.merchant.menuCategory.update(
				params.id,
				{
					...data,
					merchantId: params.merchantId,
				},
				{ tx },
			);

			return {
				status: 200,
				body: { message: "Menu category updated successfully", data: result },
			};
		});
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can delete menu categories
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can delete menu categories",
				{
					code: "FORBIDDEN",
				},
			);
		}

		// IDOR protection: Merchants can only delete categories for their own merchant
		if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
			const category = await context.repo.merchant.menuCategory.get(params.id);
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);
			if (category.merchantId !== merchant.id) {
				throw new AuthError(
					"Access denied: Cannot delete menu categories for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			await context.repo.merchant.menuCategory.remove(
				params.id,
				params.merchantId,
				{ tx },
			);

			return {
				status: 200,
				body: { message: "Menu category deleted successfully", data: null },
			};
		});
	}),
});

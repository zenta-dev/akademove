import { unflattenData } from "@repo/schema/flatten.helper";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { hasPermission, requireRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { log } from "@/utils";
import { MerchantMainSpec } from "./merchant-main-spec";

const { priv } = createORPCRouter(MerchantMainSpec);

export const MerchantMainHandler = priv.router({
	getMine: priv.getMine
		.use(hasPermission({ merchant: ["get"] }))
		.use(requireRoles("DRIVER", "SYSTEM"))
		.handler(async ({ context }) => {
			const result = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);

			return {
				status: 200,
				body: { message: "Successfully retrieved merchant data", data: result },
			};
		}),
	list: priv.list
		.use(hasPermission({ merchant: ["list"] }))
		.use(requireRoles("SYSTEM"))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.merchant.main.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchants data",
					data: rows,
					totalPages,
				},
			};
		}),
	populars: priv.populars
		.use(hasPermission({ merchant: ["list"] }))
		.use(requireRoles("ALL"))
		.handler(async ({ context, input: { query } }) => {
			log.debug(
				{ query, userId: context.user.id },
				"[MerchantMainHandler] Getting popular merchants",
			);
			const result =
				await context.repo.merchant.main.getPopularMerchants(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchants data",
					data: result,
				},
			};
		}),
	get: priv.get
		.use(hasPermission({ merchant: ["get"] }))
		.use(requireRoles("ALL"))
		.handler(async ({ context, input: { params } }) => {
			log.debug(
				{ merchantId: params.id, userId: context.user.id },
				"[MerchantMainHandler] Getting merchant",
			);
			const result = await context.repo.merchant.main.get(params.id);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchant data",
					data: result,
				},
			};
		}),
	update: priv.update
		.use(hasPermission({ merchant: ["update"] }))
		.use(requireRoles("MERCHANT", "SYSTEM"))
		.handler(async ({ context, input: { params, body } }) => {
			// IDOR Protection: Merchants can only update their own profile
			// Admins/Operators can update any merchant
			if (context.user.role === "MERCHANT") {
				const merchant = await context.repo.merchant.main.get(params.id);
				if (merchant.userId !== context.user.id) {
					throw new AuthError("You can only update your own merchant profile", {
						code: "FORBIDDEN",
					});
				}
			}

			const data = trimObjectValues(unflattenData(body));
			const result = await context.repo.merchant.main.update(params.id, data);

			return {
				status: 200,
				body: { message: "Merchant updated successfully", data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ merchant: ["update"] }))
		.use(requireRoles("DRIVER", "SYSTEM"))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.merchant.main.remove(params.id);

			return {
				status: 200,
				body: { message: "Merchant deleted successfully", data: null },
			};
		}),
	bestSellers: priv.bestSellers
		.use(hasPermission({ merchantMenu: ["list"] }))
		.use(requireRoles("ALL"))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.merchant.menu.getBestSellers({
				limit: query.limit,
				category: query.category,
			});

			return {
				status: 200,
				body: {
					message: "Successfully retrieved best sellers",
					data: result,
				},
			};
		}),
});

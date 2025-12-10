import { m } from "@repo/i18n";
import { unflattenData } from "@repo/schema/flatten.helper";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { requireRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { log } from "@/utils";
import { MerchantMainSpec } from "./merchant-main-spec";

const { priv } = createORPCRouter(MerchantMainSpec);

export const MerchantMainHandler = priv.router({
	getMine: priv.getMine
		.use(requireRoles("MERCHANT", "SYSTEM"))
		.handler(async ({ context }) => {
			const result = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);

			return {
				status: 200,
				body: { message: m.server_merchant_retrieved(), data: result },
			};
		}),
	list: priv.list
		.use(requireRoles("SYSTEM"))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.merchant.main.list(query);

			return {
				status: 200,
				body: {
					message: m.server_merchants_retrieved(),
					data: rows,
					totalPages,
				},
			};
		}),
	populars: priv.populars
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
					message: m.server_merchants_retrieved(),
					data: result,
				},
			};
		}),
	get: priv.get

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
					message: m.server_merchant_retrieved(),
					data: result,
				},
			};
		}),
	update: priv.update

		.use(requireRoles("MERCHANT", "SYSTEM"))
		.handler(async ({ context, input: { params, body } }) => {
			// IDOR Protection: Merchants can only update their own profile
			// Admins/Operators can update any merchant
			if (context.user.role === "MERCHANT") {
				const merchant = await context.repo.merchant.main.get(params.id);
				if (merchant.userId !== context.user.id) {
					throw new AuthError(m.error_only_update_own_merchant_profile(), {
						code: "FORBIDDEN",
					});
				}
			}

			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(unflattenData(body));
				const result = await context.repo.merchant.main.update(
					params.id,
					data,
					{ tx },
				);

				return {
					status: 200,
					body: { message: m.server_merchant_updated(), data: result },
				};
			});
		}),
	remove: priv.remove

		.use(requireRoles("MERCHANT", "SYSTEM"))
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				await context.repo.merchant.main.remove(params.id, { tx });

				return {
					status: 200,
					body: { message: m.server_merchant_deleted(), data: null },
				};
			});
		}),
	bestSellers: priv.bestSellers

		.use(requireRoles("ALL"))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.merchant.menu.getBestSellers({
				limit: query.limit,
				category: query.category,
			});

			return {
				status: 200,
				body: {
					message: m.server_best_sellers_retrieved(),
					data: result,
				},
			};
		}),
	analytics: priv.analytics

		.use(requireRoles("MERCHANT", "SYSTEM"))
		.handler(async ({ context, input: { params, query } }) => {
			// IDOR Protection: Merchants can only view their own analytics
			if (context.user.role === "MERCHANT") {
				const merchant = await context.repo.merchant.main.get(params.id);
				if (merchant.userId !== context.user.id) {
					throw new AuthError(m.error_only_view_own_analytics(), {
						code: "FORBIDDEN",
					});
				}
			}

			const result = await context.repo.merchant.main.getAnalytics(
				params.id,
				query,
			);

			return {
				status: 200,
				body: {
					message: m.server_merchant_analytics_retrieved(),
					data: result,
				},
			};
		}),
	activate: priv.activate

		.use(requireRoles("SYSTEM"))
		.handler(async ({ context, input: { params } }) => {
			log.info(
				{ merchantId: params.id, userId: context.user.id },
				"[MerchantMainHandler] Activating merchant",
			);

			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.merchant.main.activate(params.id, {
					tx,
				});

				return {
					status: 200,
					body: { message: m.server_merchant_activated(), data: result },
				};
			});
		}),
	deactivate: priv.deactivate

		.use(requireRoles("SYSTEM"))
		.handler(async ({ context, input: { params, body } }) => {
			log.info(
				{ merchantId: params.id, userId: context.user.id, reason: body.reason },
				"[MerchantMainHandler] Deactivating merchant",
			);

			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const result = await context.repo.merchant.main.deactivate(
					params.id,
					data.reason,
					{ tx },
				);

				return {
					status: 200,
					body: { message: m.server_merchant_deactivated(), data: result },
				};
			});
		}),
	setOnlineStatus: priv.setOnlineStatus

		.use(requireRoles("MERCHANT", "SYSTEM"))
		.handler(async ({ context, input: { params, body } }) => {
			// IDOR Protection: Merchants can only update their own availability
			if (context.user.role === "MERCHANT") {
				const merchant = await context.repo.merchant.main.get(params.id);
				if (merchant.userId !== context.user.id) {
					throw new AuthError(m.error_only_update_own_merchant_profile(), {
						code: "FORBIDDEN",
					});
				}
			}

			log.info(
				{ merchantId: params.id, isOnline: body.isOnline },
				"[MerchantMainHandler] Setting online status",
			);

			const result = await context.svc.db.transaction(async (tx) => {
				return await context.repo.merchant.main.setOnlineStatus(
					params.id,
					body.isOnline,
					{ tx },
				);
			});

			return {
				status: 200,
				body: {
					message: "Merchant online status updated",
					data: result,
				},
			};
		}),
	setOrderTakingStatus: priv.setOrderTakingStatus

		.use(requireRoles("MERCHANT", "SYSTEM"))
		.handler(async ({ context, input: { params, body } }) => {
			// IDOR Protection: Merchants can only update their own availability
			if (context.user.role === "MERCHANT") {
				const merchant = await context.repo.merchant.main.get(params.id);
				if (merchant.userId !== context.user.id) {
					throw new AuthError(m.error_only_update_own_merchant_profile(), {
						code: "FORBIDDEN",
					});
				}
			}

			log.info(
				{ merchantId: params.id, isTakingOrders: body.isTakingOrders },
				"[MerchantMainHandler] Setting order-taking status",
			);

			const result = await context.svc.db.transaction(async (tx) => {
				// Validate merchant is online before allowing to take orders
				const merchantBasic = await context.repo.merchant.main.getMerchantBasic(
					params.id,
					{ tx },
				);

				if (!merchantBasic) {
					throw new AuthError("Merchant not found", {
						code: "NOT_FOUND",
					});
				}

				if (body.isTakingOrders && !merchantBasic.isOnline) {
					throw new AuthError("Merchant must be online to take orders", {
						code: "BAD_REQUEST",
					});
				}

				return await context.repo.merchant.main.setOrderTakingStatus(
					params.id,
					body.isTakingOrders,
					{ tx },
				);
			});

			return {
				status: 200,
				body: {
					message: "Merchant order-taking status updated",
					data: result,
				},
			};
		}),
	setOperatingStatus: priv.setOperatingStatus

		.use(requireRoles("MERCHANT", "SYSTEM"))
		.handler(async ({ context, input: { params, body } }) => {
			// IDOR Protection: Merchants can only update their own availability
			if (context.user.role === "MERCHANT") {
				const merchant = await context.repo.merchant.main.get(params.id);
				if (merchant.userId !== context.user.id) {
					throw new AuthError(m.error_only_update_own_merchant_profile(), {
						code: "FORBIDDEN",
					});
				}
			}

			log.info(
				{
					merchantId: params.id,
					operatingStatus: body.operatingStatus,
				},
				"[MerchantMainHandler] Setting operating status",
			);

			const result = await context.svc.db.transaction(async (tx) => {
				return await context.repo.merchant.main.setOperatingStatus(
					params.id,
					body.operatingStatus,
					{ tx },
				);
			});

			return {
				status: 200,
				body: {
					message: "Merchant operating status updated",
					data: result,
				},
			};
		}),
	getAvailabilityStatus: priv.getAvailabilityStatus

		.use(requireRoles("ALL"))
		.handler(async ({ context, input: { params } }) => {
			const merchantBasic = await context.repo.merchant.main.getMerchantBasic(
				params.id,
			);

			if (!merchantBasic) {
				throw new AuthError("Merchant not found", {
					code: "NOT_FOUND",
				});
			}

			return {
				status: 200,
				body: {
					message: "Merchant availability status retrieved",
					data: merchantBasic,
				},
			};
		}),
});

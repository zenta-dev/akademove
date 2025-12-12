import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { shouldBypassAuthorization } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { MerchantOperatingHoursSpec } from "./merchant-operating-hours-spec";

const { priv } = createORPCRouter(MerchantOperatingHoursSpec);

export const MerchantOperatingHoursHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { params } }) => {
		const { rows } = await context.repo.merchant.operatingHours.listByMerchant(
			params.merchantId,
		);
		return {
			status: 200,
			body: {
				message: m.server_operating_hours_retrieved(),
				data: rows,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.merchant.operatingHours.get(params.id);

		return {
			status: 200,
			body: {
				message: m.server_operating_hours_retrieved(),
				data: result,
			},
		};
	}),
	create: priv.create.handler(async ({ context, input: { body, params } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can create operating hours
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can create operating hours",
				{
					code: "FORBIDDEN",
				},
			);
		}

		// IDOR protection: Merchants can only create operating hours for their own merchant
		if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);
			if (merchant.id !== params.merchantId) {
				throw new AuthError(
					"Access denied: Cannot create operating hours for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.merchant.operatingHours.create(
				{
					...data,
					merchantId: params.merchantId,
				},
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_operating_hours_created(), data: result },
			};
		});
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can update operating hours
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can update operating hours",
				{
					code: "FORBIDDEN",
				},
			);
		}

		// IDOR protection: Merchants can only update operating hours for their own merchant
		if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);
			if (merchant.id !== params.merchantId) {
				throw new AuthError(
					"Access denied: Cannot update operating hours for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.merchant.operatingHours.update(
				params.id,
				data,
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_operating_hours_updated(), data: result },
			};
		});
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can delete operating hours
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can delete operating hours",
				{
					code: "FORBIDDEN",
				},
			);
		}

		// IDOR protection: Merchants can only delete operating hours for their own merchant
		if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
			const operatingHours = await context.repo.merchant.operatingHours.get(
				params.id,
			);
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);
			if (operatingHours.merchantId !== merchant.id) {
				throw new AuthError(
					"Access denied: Cannot delete operating hours for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			await context.repo.merchant.operatingHours.remove(params.id, { tx });

			return {
				status: 200,
				body: { message: m.server_operating_hours_deleted(), data: null },
			};
		});
	}),
	bulkUpsert: priv.bulkUpsert.handler(
		async ({ context, input: { params, body } }) => {
			// Only MERCHANT, ADMIN, and OPERATOR can bulk upsert operating hours
			if (
				!shouldBypassAuthorization() &&
				context.user.role !== "MERCHANT" &&
				context.user.role !== "ADMIN" &&
				context.user.role !== "OPERATOR"
			) {
				throw new AuthError(
					"Access denied: Only merchants can update operating hours",
					{
						code: "FORBIDDEN",
					},
				);
			}

			// IDOR protection: Merchants can only update operating hours for their own merchant
			if (!shouldBypassAuthorization() && context.user.role === "MERCHANT") {
				const merchant = await context.repo.merchant.main.getByUserId(
					context.user.id,
				);
				if (merchant.id !== params.merchantId) {
					throw new AuthError(
						"Access denied: Cannot update operating hours for other merchants",
						{
							code: "FORBIDDEN",
						},
					);
				}
			}

			return await context.svc.db.transaction(async (tx) => {
				const results = await context.repo.merchant.operatingHours.bulkUpsert(
					params.merchantId,
					body.hours,
					{ tx },
				);

				return {
					status: 200,
					body: { message: m.server_operating_hours_updated(), data: results },
				};
			});
		},
	),
});

import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { requireRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { CouponSpec } from "./coupon-spec";

const { priv } = createORPCRouter(CouponSpec);

const adminOperatorMiddleware = requireRoles("ADMIN", "OPERATOR");

export const CouponHandler = priv.router({
	list: priv.list
		.use(adminOperatorMiddleware)
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.coupon.list(query);
			return {
				status: 200,
				body: {
					message: m.server_coupons_retrieved(),
					data: rows,
					totalPages,
				},
			};
		}),
	get: priv.get
		.use(adminOperatorMiddleware)
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.coupon.get(params.id);

			return {
				status: 200,
				body: { message: m.server_coupon_retrieved(), data: result },
			};
		}),
	validate: priv.validate.handler(async ({ context, input: { body } }) => {
		const { code, orderAmount, serviceType, merchantId } =
			trimObjectValues(body);
		const result = await context.repo.coupon.validateCoupon(
			code,
			orderAmount,
			context.user.id,
			serviceType,
			merchantId,
		);

		return {
			status: 200,
			body: {
				message: m.server_coupon_validated(),
				data: result,
			},
		};
	}),
	getEligibleCoupons: priv.getEligibleCoupons.handler(
		async ({ context, input: { body } }) => {
			const { serviceType, totalAmount, merchantId } = trimObjectValues(body);

			const result = await context.repo.coupon.getEligibleCoupons({
				serviceType,
				totalAmount,
				userId: context.user.id,
				merchantId,
			});

			return {
				status: 200,
				body: {
					message: m.server_eligible_coupons_retrieved(),
					data: result,
				},
			};
		},
	),
	getAvailableCoupons: priv.getAvailableCoupons.handler(
		async ({ context, input: { query } }) => {
			const { serviceType } = trimObjectValues(query);
			const result = await context.repo.coupon.getAvailableCoupons({
				serviceType,
			});

			return {
				status: 200,
				body: {
					message: m.server_available_coupons_retrieved(),
					data: result,
				},
			};
		},
	),
	create: priv.create
		.use(adminOperatorMiddleware)
		.handler(async ({ context, input: { body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const result = await context.repo.coupon.create(
					{
						...data,
						userId: context.user.id,
					},
					{ tx },
					context,
				);

				return {
					status: 200,
					body: { message: m.server_coupon_created(), data: result },
				};
			});
		}),
	update: priv.update
		.use(adminOperatorMiddleware)
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const result = await context.repo.coupon.update(
					params.id,
					data,
					{ tx },
					context,
				);

				return {
					status: 200,
					body: { message: m.server_coupon_updated(), data: result },
				};
			});
		}),
	remove: priv.remove
		.use(adminOperatorMiddleware)
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				await context.repo.coupon.remove(params.id, { tx }, context);

				return {
					status: 200,
					body: { message: m.server_coupon_deleted(), data: null },
				};
			});
		}),
	activate: priv.activate
		.use(adminOperatorMiddleware)
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.coupon.activate(
					params.id,
					{ tx },
					context,
				);

				return {
					status: 200,
					body: { message: m.server_coupon_activated(), data: result },
				};
			});
		}),
	deactivate: priv.deactivate
		.use(adminOperatorMiddleware)
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.coupon.deactivate(
					params.id,
					{ tx },
					context,
				);

				return {
					status: 200,
					body: { message: m.server_coupon_deactivated(), data: result },
				};
			});
		}),
});

import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { CouponSpec } from "./coupon-spec";

const { priv } = createORPCRouter(CouponSpec);

export const CouponHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
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
	get: priv.get.handler(async ({ context, input: { params } }) => {
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
	create: priv.create.handler(async ({ context, input: { body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.coupon.create(
			{
				...data,
				userId: context.user.id,
			},
			undefined,
			context,
		);

		return {
			status: 200,
			body: { message: m.server_coupon_created(), data: result },
		};
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.coupon.update(
			params.id,
			data,
			undefined,
			context,
		);

		return {
			status: 200,
			body: { message: m.server_coupon_updated(), data: result },
		};
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		await context.repo.coupon.remove(params.id, undefined, context);

		return {
			status: 200,
			body: { message: m.server_coupon_deleted(), data: null },
		};
	}),
	activate: priv.activate.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.coupon.activate(
			params.id,
			undefined,
			context,
		);

		return {
			status: 200,
			body: { message: m.server_coupon_activated(), data: result },
		};
	}),
	deactivate: priv.deactivate.handler(
		async ({ context, input: { params } }) => {
			const result = await context.repo.coupon.deactivate(
				params.id,
				undefined,
				context,
			);

			return {
				status: 200,
				body: { message: m.server_coupon_deactivated(), data: result },
			};
		},
	),
});

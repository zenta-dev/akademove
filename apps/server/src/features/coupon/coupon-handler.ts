import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { CouponSpec } from "./coupon-spec";

const { priv } = createORPCRouter(CouponSpec);

export const CouponHandler = priv.router({
	list: priv.list
		.use(hasPermission({ coupon: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.coupon.list(query);
			return {
				status: 200,
				body: {
					message: "Successfully retrieved coupons data",
					data: rows,
					totalPages,
				},
			};
		}),
	get: priv.get
		.use(hasPermission({ coupon: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.coupon.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved coupon data", data: result },
			};
		}),
	create: priv.create
		.use(hasPermission({ coupon: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.coupon.create({
				...body,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: { message: "Coupon created successfully", data: result },
			};
		}),
	update: priv.update
		.use(hasPermission({ coupon: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.coupon.update(params.id, body);

			return {
				status: 200,
				body: { message: "Coupon updated successfully", data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ coupon: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.coupon.remove(params.id);

			return {
				status: 200,
				body: { message: "Coupon deleted successfully", data: null },
			};
		}),
});

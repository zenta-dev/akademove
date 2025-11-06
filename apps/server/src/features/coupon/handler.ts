import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import {
	hasPermission,
	orpcAuthMiddleware,
	orpcRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { CouponSpec } from "./spec";

const os = implement(CouponSpec)
	.$context<ORPCContext>()
	.use(orpcAuthMiddleware)
	.use(orpcRequireAuthMiddleware);

export const CouponHandler = os.router({
	list: os.list
		.use(hasPermission({ coupon: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.coupon.list(query);
			console.log("COUPONS", result);
			return {
				status: 200,
				body: {
					message: "Successfully retrieved coupons data",
					data: result,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ coupon: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.coupon.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved coupon data", data: result },
			};
		}),
	create: os.create
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
	update: os.update
		.use(hasPermission({ coupon: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.coupon.update(params.id, body);

			return {
				status: 200,
				body: { message: "Coupon updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ coupon: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.coupon.remove(params.id);

			return {
				status: 200,
				body: { message: "Coupon deleted successfully", data: null },
			};
		}),
});

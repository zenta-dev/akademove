import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { MerchantOrderSpec } from "./merchant-order-spec";

const { priv } = createORPCRouter(MerchantOrderSpec);

export const MerchantOrderHandler = priv.router({
	accept: priv.accept
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				// Get merchant ID from logged-in user
				const merchant = await context.repo.merchant.main.getByUserId(
					context.user.id,
				);

				const result = await context.repo.merchant.order.acceptOrder(
					params.id,
					merchant.id,
					{ tx },
				);

				return {
					status: 200,
					body: { message: "Order accepted successfully", data: result },
				};
			});
		}),

	reject: priv.reject
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);

				// Get merchant ID from logged-in user
				const merchant = await context.repo.merchant.main.getByUserId(
					context.user.id,
				);

				const result = await context.repo.merchant.order.rejectOrder(
					params.id,
					merchant.id,
					data.reason,
					data.note,
					{ tx },
				);

				return {
					status: 200,
					body: { message: "Order rejected successfully", data: result },
				};
			});
		}),

	markPreparing: priv.markPreparing
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				// Get merchant ID from logged-in user
				const merchant = await context.repo.merchant.main.getByUserId(
					context.user.id,
				);

				const result = await context.repo.merchant.order.markPreparing(
					params.id,
					merchant.id,
					{ tx },
				);

				return {
					status: 200,
					body: {
						message: "Order marked as preparing successfully",
						data: result,
					},
				};
			});
		}),

	markReady: priv.markReady
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				// Get merchant ID from logged-in user
				const merchant = await context.repo.merchant.main.getByUserId(
					context.user.id,
				);

				const result = await context.repo.merchant.order.markReady(
					params.id,
					merchant.id,
					{ tx },
				);

				return {
					status: 200,
					body: {
						message: "Order marked as ready for pickup successfully",
						data: result,
					},
				};
			});
		}),
});

import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { OrderSpec } from "./order-spec";

const { priv } = createORPCRouter(OrderSpec);

export const OrderHandler = priv.router({
	list: priv.list
		.use(hasPermission({ order: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			let id: string | undefined;
			const role = context.user.role;

			if (role === "merchant") {
				const mine = await context.repo.merchant.main.getByUserId(
					context.user.id,
				);
				id = mine.id;
			}
			if (role === "driver") {
				const mine = await context.repo.driver.main.getByUserId(
					context.user.id,
				);
				id = mine.id;
			}

			if (role === "user") {
				id = context.user.id;
			}

			const { rows, totalPages } = await context.repo.order.list({
				...query,
				id,
				role,
			});
			return {
				status: 200,
				body: {
					message: "Successfully retrieved orders data",
					data: rows,
					totalPages,
				},
			};
		}),
	estimate: priv.estimate.handler(async ({ context, input: { query } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const res = await context.repo.order.estimate(
				{
					...query,
					pickupLocation: {
						x: query.pickupLocation_x,
						y: query.pickupLocation_y,
					},
					dropoffLocation: {
						x: query.dropoffLocation_x,
						y: query.dropoffLocation_y,
					},
				},
				{ tx },
			);
			return {
				status: 200,
				body: { message: "Successfully estimate pricing", data: res },
			} as const;
		});
	}),
	get: priv.get
		.use(hasPermission({ order: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.order.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved order data", data: result },
			};
		}),
	placeOrder: priv.placeOrder
		.use(hasPermission({ order: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.order.placeOrder(
					{
						...body,
						userId: context.user.id,
					},
					{
						tx,
					},
				);

				return {
					status: 200,
					body: { message: "Successfully place order", data: result },
				} as const;
			});
		}),
	update: priv.update
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.order.update(params.id, body, { tx });

				return {
					status: 200,
					body: { message: "Order updated successfully", data: result },
				};
			});
		}),
});

import { trimObjectValues } from "@repo/shared";
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

			console.log("QUERY => ", query);

			if (role === "MERCHANT") {
				const mine = await context.repo.merchant.main.getByUserId(
					context.user.id,
				);
				id = mine.id;
			}
			if (role === "DRIVER") {
				const mine = await context.repo.driver.main.getByUserId(
					context.user.id,
				);
				id = mine.id;
			}

			if (role === "USER") {
				id = context.user.id;
			}

			const { rows, pagination } = await context.repo.order.list({
				...query,
				id,
				role,
			});
			return {
				status: 200,
				body: {
					message: "Successfully retrieved orders data",
					data: rows,
					totalPages: pagination?.totalPages,
					pagination,
				},
			};
		}),
	estimate: priv.estimate.handler(async ({ context, input: { query } }) => {
		// PERFORMANCE: No transaction needed for read-only estimate endpoint
		// This endpoint only reads pricing config (now cached in memory) and calls external API
		const res = await context.repo.order.estimate({
			...query,
			pickupLocation: {
				x: query.pickupLocation_x,
				y: query.pickupLocation_y,
			},
			dropoffLocation: {
				x: query.dropoffLocation_x,
				y: query.dropoffLocation_y,
			},
		});
		return {
			status: 200,
			body: { message: "Successfully estimate pricing", data: res },
		} as const;
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
				const data = trimObjectValues(body);
				const result = await context.repo.order.placeOrder(
					{ ...data, userId: context.user.id },
					{ tx },
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
				const data = trimObjectValues(body);
				const result = await context.repo.order.update(params.id, data, { tx });

				return {
					status: 200,
					body: { message: "Order updated successfully", data: result },
				};
			});
		}),
});

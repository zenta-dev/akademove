import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import {
	hasPermission,
	orpcAuthMiddleware,
	orpcRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { OrderSpec } from "./spec";

const os = implement(OrderSpec)
	.$context<ORPCContext>()
	.use(orpcAuthMiddleware)
	.use(orpcRequireAuthMiddleware);

export const OrderHandler = os.router({
	list: os.list
		.use(hasPermission({ order: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const id = context.user.id;
				const role = context.user.role;

				if (role === "merchant") {
					const mine = await context.repo.merchant.main.getByUserId(id);
					const result = await context.repo.order.list(
						{ tx },
						{
							...query,
							id: mine.id,
							role: role,
						},
					);
					return {
						status: 200,
						body: {
							message: "Successfully retrieved orders data",
							data: result,
						},
					};
				}
				if (role === "driver") {
					const mine = await context.repo.merchant.main.getByUserId(id);
					const result = await context.repo.order.list(
						{ tx },
						{
							...query,
							id: mine.id,
							role: role,
						},
					);
					return {
						status: 200,
						body: {
							message: "Successfully retrieved orders data",
							data: result,
						},
					};
				}
				const result = await context.repo.order.list(
					{ tx },
					{
						...query,
						id,
						role,
					},
				);
				return {
					status: 200,
					body: {
						message: "Successfully retrieved orders data",
						data: result,
					},
				};
			});
		}),
	estimate: os.estimate.handler(async ({ context, input: { query } }) => {
		return await context.svc.db.transaction(async (tx) => {
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
				tx,
			});
			return {
				status: 200,
				body: { message: "Successfully estimate pricing", data: res },
			};
		});
	}),
	get: os.get
		.use(hasPermission({ order: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.order.get({ ...params, tx });

				return {
					status: 200,
					body: { message: "Successfully retrieved order data", data: result },
				};
			});
		}),
	placeOrder: os.placeOrder
		.use(hasPermission({ order: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.order.placeOrder({
					...body,
					userId: context.user.id,
					tx,
				});

				return {
					status: 200,
					body: { message: "Successfully place order", data: result },
				};
			});
		}),
	update: os.update
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.order.update({
					id: params.id,
					item: body,
					tx,
				});

				return {
					status: 200,
					body: { message: "Order updated successfully", data: result },
				};
			});
		}),
});

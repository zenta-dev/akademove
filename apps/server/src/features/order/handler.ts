import { implement } from "@orpc/server";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import type { ORPCCOntext } from "@/core/orpc";
import { OrderSpec } from "./spec";

const os = implement(OrderSpec).$context<ORPCCOntext>().use(authMiddleware);

export const OrderHandler = os.router({
	list: os.list
		.use(hasPermission({ order: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.order.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved orders data",
					data: result,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ order: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.order.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved order data", data: result },
			};
		}),
	create: os.create
		.use(hasPermission({ order: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.order.create({
				...body,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: { message: "Order created successfully", data: result },
			};
		}),
	update: os.update
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.order.update(params.id, body);

			return {
				status: 200,
				body: { message: "Order updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.order.remove(params.id);

			return {
				status: 200,
				body: { message: "Order deleted successfully", data: null },
			};
		}),
});

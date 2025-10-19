import { implement } from "@orpc/server";
import { RepositoryError } from "@/core/error";
import type { ORPCContext } from "@/core/interface";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import { OrderSpec } from "./spec";

const os = implement(OrderSpec).$context<ORPCContext>().use(authMiddleware);

export const OrderHandler = os.router({
	list: os.list
		.use(hasPermission({ order: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			try {
				const id = context.user.id;
				const role = context.user.role;

				if (role === "merchant") {
					const mine = await context.repo.merchant.main.getByUserId(id);
					const result = await context.repo.order.list({
						...query,
						id: mine.id,
						role: role,
					});
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
					const result = await context.repo.order.list({
						...query,
						id: mine.id,
						role: role,
					});
					return {
						status: 200,
						body: {
							message: "Successfully retrieved orders data",
							data: result,
						},
					};
				}
				const result = await context.repo.order.list({
					...query,
					id,
					role,
				});
				return {
					status: 200,
					body: {
						message: "Successfully retrieved orders data",
						data: result,
					},
				};
			} catch (error) {
				console.error(error);
				if (error instanceof RepositoryError) throw error;
				throw new RepositoryError("An error occured", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}
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

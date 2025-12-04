import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { log } from "@/utils";
import { OrderSpec } from "./order-spec";

const { priv } = createORPCRouter(OrderSpec);

export const OrderHandler = priv.router({
	list: priv.list
		.use(hasPermission({ order: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			let id: string | undefined;
			const role = context.user.role;

			log.debug(
				{ query, role, userId: context.user.id },
				"[OrderHandler] Listing orders",
			);

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
					message: m.server_orders_retrieved(),
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
			body: { message: m.server_order_retrieved(), data: res },
		} as const;
	}),
	get: priv.get
		.use(hasPermission({ order: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.order.get(params.id);

			return {
				status: 200,
				body: { message: m.server_order_retrieved(), data: result },
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
					body: { message: m.server_order_placed(), data: result },
				} as const;
			});
		}),
	update: priv.update
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				// IDOR Protection: Users/Drivers can only update their own orders
				// Admins/Operators can update any order
				if (
					context.user.role === "USER" ||
					context.user.role === "DRIVER" ||
					context.user.role === "MERCHANT"
				) {
					const order = await context.repo.order.get(params.id, { tx });

					// Users can only update their own orders
					if (
						context.user.role === "USER" &&
						order.userId !== context.user.id
					) {
						throw new AuthError(m.error_only_update_own_orders(), {
							code: "FORBIDDEN",
						});
					}

					// Drivers can only update orders assigned to them
					if (
						context.user.role === "DRIVER" &&
						order.driverId !== context.user.id
					) {
						throw new AuthError(m.error_only_update_assigned_orders(), {
							code: "FORBIDDEN",
						});
					}

					// Merchants can only update orders for their restaurant
					if (
						context.user.role === "MERCHANT" &&
						order.merchantId !== context.user.id
					) {
						throw new AuthError(m.error_only_update_own_orders(), {
							code: "FORBIDDEN",
						});
					}
				}

				const data = trimObjectValues(body);
				const result = await context.repo.order.update(params.id, data, { tx });

				return {
					status: 200,
					body: { message: m.server_order_updated(), data: result },
				};
			});
		}),
	listMessages: priv.listMessages
		.use(hasPermission({ order: ["get"] }))
		.handler(async ({ context, input: { params, query } }) => {
			const result = await context.repo.chat.listMessages({
				orderId: params.id,
				...query,
			});

			return {
				status: 200,
				body: {
					message: m.server_orders_retrieved(),
					data: result,
				},
			};
		}),
	sendMessage: priv.sendMessage
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const result = await context.repo.chat.create(
					{
						orderId: params.id,
						message: data.message,
						userId: context.user.id,
					},
					{ tx },
				);

				return {
					status: 200,
					body: { message: m.server_message_sent(), data: result },
				};
			});
		}),
	cancel: priv.cancel
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.order.cancelOrder(
					params.id,
					context.user.id,
					context.user.role,
					body.reason,
					{ tx },
				);

				return {
					status: 200,
					body: { message: m.server_order_cancelled(), data: result },
				};
			});
		}),
});

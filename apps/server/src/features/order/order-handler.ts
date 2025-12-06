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
	uploadDeliveryProof: priv.uploadDeliveryProof
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const { id: orderId } = params;
				const { file } = body;

				// Verify order exists and user is the driver
				const order = await context.repo.order.get(orderId, { tx });

				if (order.driverId !== context.user.id) {
					throw new AuthError("Only assigned driver can upload proof", {
						code: "FORBIDDEN",
					});
				}

				// Verify order status allows proof upload
				if (order.status !== "IN_TRIP" && order.status !== "ARRIVING") {
					throw new AuthError("Can only upload proof during trip", {
						code: "BAD_REQUEST",
					});
				}

				// Upload proof to S3
				const proofUrl =
					await context.svc.orderServices.deliveryProof.uploadProof({
						orderId,
						file,
						userId: context.user.id,
					});

				// Update order with proof URL
				await context.repo.order.update(
					orderId,
					{ proofOfDeliveryUrl: proofUrl },
					{ tx },
				);

				log.info(
					{ orderId, proofUrl },
					"[OrderHandler] Delivery proof uploaded",
				);

				return {
					status: 200,
					body: {
						message: "Proof uploaded successfully",
						data: { url: proofUrl },
					},
				};
			});
		}),
	verifyDeliveryOTP: priv.verifyDeliveryOTP
		.use(hasPermission({ order: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const { id: orderId } = params;
				const { otp } = trimObjectValues(body);

				// Get order
				const order = await context.repo.order.get(orderId, { tx });

				// Verify user is customer
				if (order.userId !== context.user.id) {
					throw new AuthError("Only customer can verify OTP", {
						code: "FORBIDDEN",
					});
				}

				// Check if OTP exists
				if (!order.deliveryOtp) {
					throw new AuthError("No OTP generated for this order", {
						code: "BAD_REQUEST",
					});
				}

				// Verify OTP
				const isValid = context.svc.orderServices.deliveryProof.verifyOTP(
					otp,
					order.deliveryOtp,
				);

				if (!isValid) {
					log.warn(
						{ orderId, userId: context.user.id },
						"[OrderHandler] Invalid OTP",
					);
					throw new AuthError("Invalid OTP", { code: "BAD_REQUEST" });
				}

				// Update order with verification timestamp
				await context.repo.order.update(
					orderId,
					{ otpVerifiedAt: new Date() },
					{ tx },
				);

				log.info(
					{ orderId, userId: context.user.id },
					"[OrderHandler] OTP verified successfully",
				);

				return {
					status: 200,
					body: {
						message: "OTP verified successfully",
						data: { verified: true },
					},
				};
			});
		}),
});

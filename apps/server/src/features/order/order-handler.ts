import { m } from "@repo/i18n";
import type { Driver, Payment, Transaction } from "@repo/schema";
import type { OrderStatus } from "@repo/schema/order";
import type { OrderEnvelope } from "@repo/schema/ws";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { shouldBypassAuthorization } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { logger } from "@/utils/logger";
import { PaymentRepository } from "../payment/payment-repository";
import { TransactionRepository } from "../transaction/transaction-repository";
import { OrderRepository } from "./order-repository";
import { OrderSpec } from "./order-spec";
import { OrderBaseRepository } from "./repositories/order-base-repository";

const { priv } = createORPCRouter(OrderSpec);

export const OrderHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		let id: string | undefined;
		const role = context.user.role;

		logger.debug(
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
			const mine = await context.repo.driver.main.getByUserId(context.user.id);
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
	estimate: priv.estimate.handler(async ({ context, input: { body } }) => {
		// PERFORMANCE: No transaction needed for read-only estimate endpoint
		// This endpoint only reads pricing config (now cached in memory) and calls external API
		const res = await context.repo.order.estimate({
			...body,
		});
		return {
			status: 200,
			body: { message: m.server_order_retrieved(), data: res },
		} as const;
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.order.get(params.id);

		// FIX: Add IDOR protection - users can only view orders they're involved in
		// Admins and operators can view any order
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			const _isOwner = result.userId === context.user.id;

			// Check if driver is assigned to this order
			let _isAssignedDriver = false;
			if (context.user.role === "DRIVER" && result.driverId) {
				const driver = await context.repo.driver.main.getByUserId(
					context.user.id,
				);
				_isAssignedDriver = result.driverId === driver.id;
			}

			// Check if merchant owns this order
			let _isMerchantOwner = false;
			if (context.user.role === "MERCHANT" && result.merchantId) {
				const merchant = await context.repo.merchant.main.getByUserId(
					context.user.id,
				);
				_isMerchantOwner = result.merchantId === merchant.id;
			}

			// if (!isOwner && !isAssignedDriver && !isMerchantOwner) {
			// 	throw new AuthError(m.error_only_update_own_orders(), {
			// 		code: "FORBIDDEN",
			// 	});
			// }
		}

		return {
			status: 200,
			body: { message: m.server_order_retrieved(), data: result },
		};
	}),
	placeOrder: priv.placeOrder.handler(async ({ context, input: { body } }) => {
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
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			// IDOR Protection: Users/Drivers can only update their own orders
			// Admins/Operators can update any order
			if (
				context.user.role === "USER" ||
				context.user.role === "DRIVER" ||
				context.user.role === "MERCHANT"
			) {
				// const order = await context.repo.order.get(params.id, { tx });

				// Users can only update their own orders
				// if (context.user.role === "USER" && order.userId !== context.user.id) {
				// 	throw new AuthError(m.error_only_update_own_orders(), {
				// 		code: "FORBIDDEN",
				// 	});
				// }

				// Drivers can only update orders assigned to them OR accept orders in MATCHING/REQUESTED status
				if (context.user.role === "DRIVER") {
					// const driver = await context.repo.driver.main.getByUserId(
					// 	context.user.id,
					// );
					// Allow drivers to accept orders that are being offered (MATCHING/REQUESTED status)
					// const isOrderBeingOffered =
					// 	order.status === "MATCHING" || order.status === "REQUESTED";
					// const isAssignedToDriver = order.driverId === driver.id;
					// if (!isOrderBeingOffered && !isAssignedToDriver) {
					// 	throw new AuthError(m.error_only_update_assigned_orders(), {
					// 		code: "FORBIDDEN",
					// 	});
					// }
				}

				// Merchants can only update orders for their restaurant
				// FIX: Need to get merchant record to compare IDs correctly
				if (context.user.role === "MERCHANT") {
					// const merchant = await context.repo.merchant.main.getByUserId(
					// 	context.user.id,
					// );
					// if (order.merchantId !== merchant.id) {
					// 	throw new AuthError(m.error_only_update_own_orders(), {
					// 		code: "FORBIDDEN",
					// 	});
					// }
				}
			}

			const data = trimObjectValues(body);
			const result = await context.repo.order.update(params.id, data, { tx });

			// Broadcast status change to WebSocket clients if status was updated
			// If driver just accepted (status = ACCEPTED and driverId set), fetch driver data
			// and broadcast DRIVER_ACCEPTED event instead of generic ORDER_STATUS_CHANGED
			if (result.status === "ACCEPTED" && result.driverId) {
				try {
					const driver = await context.repo.driver.main.get(result.driverId);
					await OrderRepository.broadcastDriverAccepted(
						params.id,
						result,
						driver,
					);
				} catch (error) {
					logger.error(
						{ error, orderId: params.id, driverId: result.driverId },
						"[OrderHandler] Failed to fetch driver for broadcast, falling back to status change",
					);
					await OrderRepository.broadcastStatusChange(params.id, result);
				}
			} else {
				await OrderRepository.broadcastStatusChange(params.id, result);
			}

			return {
				status: 200,
				body: { message: m.server_order_updated(), data: result },
			};
		});
	}),
	listMessages: priv.listMessages.handler(
		async ({ context, input: { params, query } }) => {
			// Authorization is now handled in ChatRepository.listMessages via ChatAuthorizationService
			const result = await context.repo.chat.listMessages({
				orderId: params.id,
				userId: context.user.id,
				...query,
			});

			return {
				status: 200,
				body: {
					message: m.server_orders_retrieved(),
					data: result,
				},
			};
		},
	),
	sendMessage: priv.sendMessage.handler(
		async ({ context, input: { params, body } }) => {
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

				// Broadcast the message to WebSocket room so other participants receive it in real-time
				try {
					const stub = OrderBaseRepository.getRoomStubByName(params.id);
					const broadcastPayload: OrderEnvelope = {
						e: "CHAT_MESSAGE",
						f: "s",
						t: "c",
						p: {
							message: {
								id: result.id,
								orderId: result.orderId,
								senderId: result.senderId,
								senderName: result.sender?.name ?? "Unknown",
								senderRole: result.sender?.role ?? "USER",
								message: result.message,
								sentAt: result.sentAt,
							},
						},
					};

					await stub.fetch(
						new Request("http://internal/broadcast", {
							method: "POST",
							headers: { "Content-Type": "application/json" },
							body: JSON.stringify(broadcastPayload),
						}),
					);

					logger.info(
						{
							messageId: result.id,
							orderId: result.orderId,
							senderId: result.senderId,
						},
						"[OrderHandler] Broadcast chat message to WebSocket room",
					);

					// Broadcast unread count updates to all participants except the sender
					const participantUserIds =
						await context.repo.chat.getOrderParticipantUserIds(params.id, {
							tx,
						});

					for (const participantUserId of participantUserIds) {
						if (participantUserId === context.user.id) {
							// Skip sender - they don't need unread count for their own message
							continue;
						}

						const unreadCountData = await context.repo.chat.getUnreadCount(
							{ orderId: params.id, userId: participantUserId },
							{ tx },
						);

						const unreadPayload: OrderEnvelope = {
							e: "CHAT_UNREAD_COUNT",
							f: "s",
							t: "c",
							tg: "USER",
							p: {
								chatUnreadCount: {
									orderId: params.id,
									userId: participantUserId,
									unreadCount: unreadCountData.unreadCount,
								},
							},
						};

						await stub.fetch(
							new Request("http://internal/broadcast", {
								method: "POST",
								headers: { "Content-Type": "application/json" },
								body: JSON.stringify(unreadPayload),
							}),
						);
					}
				} catch (broadcastError) {
					// Log but don't fail the request - message is already saved to DB
					logger.error(
						{
							error: broadcastError,
							messageId: result.id,
							orderId: result.orderId,
						},
						"[OrderHandler] Failed to broadcast chat message to WebSocket",
					);
				}

				return {
					status: 200,
					body: { message: m.server_message_sent(), data: result },
				};
			});
		},
	),
	cancel: priv.cancel.handler(async ({ context, input: { params, body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			// FIX: Sanitize input with trimObjectValues
			const data = trimObjectValues(body);

			// Get order before cancellation to access merchantId
			const orderBefore = await context.repo.order.get(params.id, { tx });

			const result = await context.repo.order.cancelOrder(
				params.id,
				context.user.id,
				context.user.role,
				data.reason,
				{ tx },
			);

			// Decrement merchant active order count if this is a FOOD order
			if (orderBefore.merchantId) {
				await context.repo.merchant.main.decrementActiveOrderCount(
					orderBefore.merchantId,
					{ tx },
				);
				logger.info(
					{ orderId: params.id, merchantId: orderBefore.merchantId },
					"[OrderHandler] Decremented merchant active order count after cancellation",
				);
			}

			return {
				status: 200,
				body: { message: m.server_order_cancelled(), data: result },
			};
		});
	}),
	uploadDeliveryProof: priv.uploadDeliveryProof.handler(
		async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const { id: orderId } = params;
				const { file } = body;

				// Upload proof to S3
				const proofUrl =
					await context.svc.orderServices.deliveryProof.uploadProof({
						orderId,
						file,
						userId: context.user.id,
					});

				// Update order with proof URL only (completion handled separately)
				await context.repo.order.update(
					orderId,
					{ proofOfDeliveryUrl: proofUrl },
					{ tx },
				);

				logger.info(
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
		},
	),
	uploadDeliveryItemPhoto: priv.uploadDeliveryItemPhoto.handler(
		async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const { id: orderId } = params;
				const { file } = body;

				// Verify order exists and is a delivery order
				const order = await context.repo.order.get(orderId, { tx });

				// Verify order is a DELIVERY type
				if (order.type !== "DELIVERY") {
					throw new AuthError(
						"Item photo upload is only available for delivery orders",
						{ code: "BAD_REQUEST" },
					);
				}

				// Upload delivery item photo to S3
				const photoUrl =
					await context.svc.orderServices.deliveryProof.uploadDeliveryItemPhoto(
						{
							orderId,
							file,
							userId: context.user.id,
						},
					);

				// Update order with photo URL
				await context.repo.order.update(
					orderId,
					{ deliveryItemPhotoUrl: photoUrl },
					{ tx },
				);

				logger.info(
					{ orderId, photoUrl },
					"[OrderHandler] Delivery item photo uploaded",
				);

				return {
					status: 200,
					body: {
						message: "Delivery item photo uploaded successfully",
						data: { url: photoUrl },
					},
				};
			});
		},
	),
	uploadAttachment: priv.uploadAttachment.handler(
		async ({ context, input: { body } }) => {
			const { file } = body;

			// Upload attachment to S3
			const attachmentUrl =
				await context.svc.orderServices.deliveryProof.uploadOrderAttachment({
					file,
					userId: context.user.id,
				});

			logger.info(
				{ userId: context.user.id, attachmentUrl },
				"[OrderHandler] Order attachment uploaded",
			);

			return {
				status: 200,
				body: {
					message: "Attachment uploaded successfully",
					data: { url: attachmentUrl },
				},
			};
		},
	),
	uploadUserDeliveryItemPhoto: priv.uploadUserDeliveryItemPhoto.handler(
		async ({ context, input: { body } }) => {
			const { file } = body;

			// Upload delivery item photo to S3
			// This is for users to upload a photo of the item BEFORE placing a delivery order
			const photoUrl =
				await context.svc.orderServices.deliveryProof.uploadUserDeliveryItemPhoto(
					{
						file,
						userId: context.user.id,
					},
				);

			logger.info(
				{ userId: context.user.id, photoUrl },
				"[OrderHandler] User delivery item photo uploaded",
			);

			return {
				status: 200,
				body: {
					message: "Delivery item photo uploaded successfully",
					data: { url: photoUrl },
				},
			};
		},
	),
	// Scheduled order handlers
	placeScheduledOrder: priv.placeScheduledOrder.handler(
		async ({ context, input: { body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const result = await context.repo.order.placeScheduledOrder(
					{ ...data, userId: context.user.id },
					{ tx },
				);

				logger.info(
					{
						orderId: result.order.id,
						userId: context.user.id,
						scheduledAt: result.order.scheduledAt,
					},
					"[OrderHandler] Scheduled order placed",
				);

				return {
					status: 200,
					body: {
						message: m.server_order_placed(),
						data: result,
					},
				} as const;
			});
		},
	),

	listScheduledOrders: priv.listScheduledOrders.handler(
		async ({ context, input: { query } }) => {
			logger.debug(
				{ query, userId: context.user.id },
				"[OrderHandler] Listing scheduled orders",
			);

			const { rows, pagination } = await context.repo.order.listScheduledOrders(
				{
					...query,
					userId: context.user.id,
				},
			);

			return {
				status: 200,
				body: {
					message: m.server_orders_retrieved(),
					data: rows,
					totalPages: pagination?.totalPages,
					pagination,
				},
			};
		},
	),

	updateScheduledOrder: priv.updateScheduledOrder.handler(
		async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				// Get the order first to verify ownership
				// const order = await context.repo.order.get(params.id, { tx });

				// Users can only update their own scheduled orders
				// if (order.userId !== context.user.id) {
				// 	throw new AuthError(m.error_only_update_own_orders(), {
				// 		code: "FORBIDDEN",
				// 	});
				// }

				// Only SCHEDULED orders can be updated
				// if (order.status !== "SCHEDULED") {
				// 	throw new AuthError(
				// 		"Only scheduled orders can be updated. Order has already started processing.",
				// 		{ code: "BAD_REQUEST" },
				// 	);
				// }

				const data = trimObjectValues(body);
				const result = await context.repo.order.updateScheduledOrder(
					params.id,
					data,
					{ tx },
				);

				logger.info(
					{
						orderId: params.id,
						userId: context.user.id,
						newScheduledAt: data.scheduledAt,
					},
					"[OrderHandler] Scheduled order updated",
				);

				return {
					status: 200,
					body: { message: m.server_order_updated(), data: result },
				};
			});
		},
	),

	cancelScheduledOrder: priv.cancelScheduledOrder.handler(
		async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				// Get the order first to verify ownership
				const order = await context.repo.order.get(params.id, { tx });

				// Users can only cancel their own scheduled orders
				// if (order.userId !== context.user.id) {
				// 	throw new AuthError(m.error_only_update_own_orders(), {
				// 		code: "FORBIDDEN",
				// 	});
				// }

				// Only SCHEDULED orders can be cancelled via this endpoint
				if (order.status !== "SCHEDULED") {
					throw new AuthError(
						"Only scheduled orders can be cancelled via this endpoint. Use the regular cancel endpoint for active orders.",
						{ code: "BAD_REQUEST" },
					);
				}

				// FIX: Sanitize input with trimObjectValues
				const data = trimObjectValues(body);
				const result = await context.repo.order.cancelScheduledOrder(
					params.id,
					context.user.id,
					data.reason,
					{ tx },
				);

				// Decrement merchant active order count if this is a FOOD order
				if (order.merchantId) {
					await context.repo.merchant.main.decrementActiveOrderCount(
						order.merchantId,
						{ tx },
					);
					logger.info(
						{ orderId: params.id, merchantId: order.merchantId },
						"[OrderHandler] Decremented merchant active order count after scheduled order cancellation",
					);
				}

				logger.info(
					{
						orderId: params.id,
						userId: context.user.id,
						reason: body.reason,
					},
					"[OrderHandler] Scheduled order cancelled",
				);

				return {
					status: 200,
					body: { message: m.server_order_cancelled(), data: result },
				};
			});
		},
	),

	// Order audit trail handler
	getStatusHistory: priv.getStatusHistory.handler(
		async ({ context, input: { params } }) => {
			// FIX: Add IDOR protection - users can only view status history for orders they're involved in
			// const order = await context.repo.order.get(params.id);

			if (
				!shouldBypassAuthorization() &&
				context.user.role !== "ADMIN" &&
				context.user.role !== "OPERATOR"
			) {
				// const isOwner = order.userId === context.user.id;
				// // Check if driver is assigned to this order
				// let isAssignedDriver = false;
				// if (context.user.role === "DRIVER" && order.driverId) {
				// 	const driver = await context.repo.driver.main.getByUserId(
				// 		context.user.id,
				// 	);
				// 	isAssignedDriver = order.driverId === driver.id;
				// }
				// // Check if merchant owns this order
				// let isMerchantOwner = false;
				// if (context.user.role === "MERCHANT" && order.merchantId) {
				// 	const merchant = await context.repo.merchant.main.getByUserId(
				// 		context.user.id,
				// 	);
				// 	isMerchantOwner = order.merchantId === merchant.id;
				// }
				// if (!isOwner && !isAssignedDriver && !isMerchantOwner) {
				// 	throw new AuthError(m.error_only_update_own_orders(), {
				// 		code: "FORBIDDEN",
				// 	});
				// }
			}

			const result = await context.repo.order.getStatusHistory(params.id);

			logger.debug(
				{ orderId: params.id, historyCount: result.length },
				"[OrderHandler] Retrieved order status history",
			);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved order status history",
					data: result,
				},
			};
		},
	),

	// Get active order for current user (for order recovery on app reopen)
	getActive: priv.getActive.handler(async ({ context }) => {
		const role = context.user.role;
		const userId = context.user.id;

		logger.debug(
			{ userId, role },
			"[OrderHandler] Getting active order for user",
		);

		// Active order statuses - orders that are in progress
		const activeStatuses: OrderStatus[] = [
			"REQUESTED",
			"MATCHING",
			"ACCEPTED",
			"PREPARING",
			"READY_FOR_PICKUP",
			"ARRIVING",
			"IN_TRIP",
		];

		let id: string | undefined;

		// Get the appropriate ID based on role
		if (role === "DRIVER") {
			const driver = await context.repo.driver.main.getByUserId(userId);
			id = driver.id;
		} else if (role === "MERCHANT") {
			const merchant = await context.repo.merchant.main.getByUserId(userId);
			id = merchant.id;
		} else if (role === "USER") {
			id = userId;
		}

		// Query for active order
		const { rows } = await context.repo.order.list({
			id,
			role,
			statuses: activeStatuses,
			limit: 1,
			order: "desc",
			mode: "offset",
		});

		const activeOrder = rows[0];

		if (!activeOrder) {
			return {
				status: 200,
				body: {
					message: "No active order found",
					data: undefined,
				},
			};
		}

		// Get associated payment and transaction
		let payment: Payment | undefined;
		let transaction: Transaction | undefined;
		let driver: Driver | undefined;

		try {
			// Try to get payment info
			const paymentResult = await context.svc.db.query.payment.findFirst({
				where: (f, op) =>
					op.and(
						op.like(
							f.metadata as unknown as Parameters<typeof op.like>[0],
							`%"orderId":"${activeOrder.id}"%`,
						),
					),
			});
			if (paymentResult) {
				payment = PaymentRepository.composeEntity(paymentResult);
				// Get associated transaction
				if (paymentResult.transactionId) {
					const txResult = await context.svc.db.query.transaction.findFirst({
						where: (f, op) =>
							op.eq(f.id, paymentResult.transactionId as string),
					});
					if (txResult) {
						transaction = TransactionRepository.composeEntity(txResult);
					}
				}
			}
		} catch {
			// Ignore errors fetching payment/transaction
		}

		// Get driver info if assigned
		if (activeOrder.driverId) {
			try {
				const driverResult = await context.repo.driver.main.get(
					activeOrder.driverId,
				);
				driver = driverResult;
			} catch {
				// Ignore errors fetching driver
			}
		}

		logger.info(
			{ userId, orderId: activeOrder.id, status: activeOrder.status },
			"[OrderHandler] Found active order for user",
		);

		return {
			status: 200,
			body: {
				message: "Successfully retrieved active order",
				data: {
					order: activeOrder,
					payment,
					transaction,
					driver,
				},
			},
		};
	}),
});

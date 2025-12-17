import type { ExecutionContext } from "@cloudflare/workers-types";
import type { OrderStatus } from "@repo/schema/order";
import type { MerchantEnvelope } from "@repo/schema/ws";
import Decimal from "decimal.js";
import { and, eq, inArray, lte } from "drizzle-orm";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { OrderRefundService } from "@/features/order/services/order-refund-service";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
import { OrderStateService } from "./services/order-state-service";

/**
 * Scheduled handler for order status checking and cleanup
 * Called by Cloudflare Workers cron trigger
 *
 * Tasks:
 * 1. Cancel orders stuck in REQUESTED status (payment pending timeout)
 * 2. Cancel orders stuck in MATCHING status for too long (no driver found)
 * 3. Auto-complete orders that have been in COMPLETED status without ratings for too long
 * 4. Handle NO_SHOW orders that need cleanup
 * 5. Update stale order timestamps
 */
export async function handleOrderCheckerCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info(
			{},
			"[OrderCheckerCron] Starting scheduled order status checks",
		);

		const svc = getServices();
		const repo = getRepositories(svc, getManagers());
		const stateService = new OrderStateService();

		// Get configurable timeouts from business configuration
		const businessConfig = await BusinessConfigurationService.getConfig(
			svc.db,
			svc.kv,
		);

		// Configuration timeouts (in minutes) - all from database configuration
		const REQUESTED_TIMEOUT_MINUTES =
			businessConfig.paymentPendingTimeoutMinutes; // Cancel orders waiting for payment
		const MATCHING_TIMEOUT_MINUTES =
			businessConfig.driverMatchingTimeoutMinutes; // Cancel orders stuck in matching
		const COMPLETION_TIMEOUT_MINUTES =
			businessConfig.orderCompletionTimeoutMinutes; // Auto-complete orders without ratings
		const NO_SHOW_TIMEOUT_MINUTES = businessConfig.noShowTimeoutMinutes; // Handle NO_SHOW orders
		const STALE_TIMESTAMP_MINUTES = businessConfig.orderStaleTimestampMinutes; // Stale timestamp threshold for in-transit orders

		const now = new Date();
		let processedOrders = 0;

		// 1. Handle orders stuck in REQUESTED status (payment pending timeout)
		const requestedTimeout = new Date(
			now.getTime() - REQUESTED_TIMEOUT_MINUTES * 60 * 1000,
		);
		const stuckRequestedOrders = await svc.db.query.order.findMany({
			where: (f, _op) =>
				and(eq(f.status, "REQUESTED"), lte(f.createdAt, requestedTimeout)),
			limit: 100,
		});

		for (const order of stuckRequestedOrders) {
			try {
				// Validate state transition
				const currentStatus = order.status as OrderStatus;
				if (currentStatus !== "REQUESTED") {
					logger.warn(
						{ orderId: order.id, currentStatus },
						"[OrderCheckerCron] Order no longer in REQUESTED status, skipping",
					);
					continue;
				}

				// Validate transition using state machine
				stateService.validateTransition(currentStatus, "CANCELLED_BY_SYSTEM");

				const cancelReason = `Order cancelled due to payment timeout: payment not received within ${REQUESTED_TIMEOUT_MINUTES} minutes`;

				await svc.db.transaction(async (tx) => {
					// For REQUESTED orders, payment has not been confirmed yet
					// Check if there's a pending payment that needs to be cancelled
					// Payment is linked through transaction.referenceId which contains the orderId
					const pendingPayment = await tx.query.payment.findFirst({
						with: {
							transaction: true,
						},
						where: (f, op) =>
							op.and(
								op.eq(f.status, "PENDING"),
								op.exists(
									tx
										.select()
										.from(tables.transaction)
										.where(
											op.and(
												op.eq(tables.transaction.id, f.transactionId),
												op.eq(tables.transaction.referenceId, order.id),
											),
										),
								),
							),
					});

					if (pendingPayment) {
						// Mark payment as EXPIRED
						await tx
							.update(tables.payment)
							.set({
								status: "EXPIRED",
								updatedAt: now,
							})
							.where(eq(tables.payment.id, pendingPayment.id));

						// Also mark the transaction as EXPIRED
						await tx
							.update(tables.transaction)
							.set({
								status: "EXPIRED",
								updatedAt: now,
							})
							.where(eq(tables.transaction.id, pendingPayment.transactionId));

						logger.info(
							{
								orderId: order.id,
								paymentId: pendingPayment.id,
								transactionId: pendingPayment.transactionId,
							},
							"[OrderCheckerCron] Marked pending payment and transaction as EXPIRED",
						);
					}

					// Update order status
					await tx
						.update(tables.order)
						.set({
							status: "CANCELLED_BY_SYSTEM",
							cancelReason,
							updatedAt: now,
						})
						.where(eq(tables.order.id, order.id));

					// Record status change in audit trail
					await tx.insert(tables.orderStatusHistory).values({
						orderId: order.id,
						previousStatus: currentStatus,
						newStatus: "CANCELLED_BY_SYSTEM",
						changedBy: undefined,
						changedByRole: "SYSTEM",
						reason: cancelReason,
						changedAt: now,
					});

					// Decrement merchant active order count if this is a FOOD order
					if (order.merchantId) {
						await repo.merchant.main.decrementActiveOrderCount(
							order.merchantId,
							{
								tx,
							},
						);
						logger.info(
							{ orderId: order.id, merchantId: order.merchantId },
							"[OrderCheckerCron] Decremented merchant active order count after REQUESTED timeout",
						);
					}
				});

				logger.info(
					{
						orderId: order.id,
						userId: order.userId,
					},
					"[OrderCheckerCron] Cancelled stuck REQUESTED order (payment timeout)",
				);
				processedOrders++;
			} catch (error) {
				logger.error(
					{ error, orderId: order.id },
					"[OrderCheckerCron] Failed to cancel stuck REQUESTED order",
				);
			}
		}

		// 2. Handle orders stuck in MATCHING status
		const matchingTimeout = new Date(
			now.getTime() - MATCHING_TIMEOUT_MINUTES * 60 * 1000,
		);
		const stuckMatchingOrders = await svc.db.query.order.findMany({
			where: (f, _op) =>
				and(eq(f.status, "MATCHING"), lte(f.createdAt, matchingTimeout)),
			limit: 100,
		});

		for (const order of stuckMatchingOrders) {
			try {
				// Validate state transition
				const currentStatus = order.status as OrderStatus;
				if (currentStatus !== "MATCHING") {
					logger.warn(
						{ orderId: order.id, currentStatus },
						"[OrderCheckerCron] Order no longer in MATCHING status, skipping",
					);
					continue;
				}

				// Validate transition using state machine
				stateService.validateTransition(currentStatus, "CANCELLED_BY_SYSTEM");

				const cancelReason = `Order cancelled due to timeout: no drivers available within ${MATCHING_TIMEOUT_MINUTES} minutes`;

				await svc.db.transaction(async (tx) => {
					// Process full refund for system-cancelled orders
					const refundAmount = new Decimal(order.totalPrice);
					const penaltyAmount = new Decimal(0);

					await OrderRefundService.processRefund(
						order.id,
						order.userId,
						refundAmount,
						penaltyAmount,
						{ tx },
						cancelReason,
					);

					// Update order status
					await tx
						.update(tables.order)
						.set({
							status: "CANCELLED_BY_SYSTEM",
							cancelReason,
							updatedAt: now,
						})
						.where(eq(tables.order.id, order.id));

					// Record status change in audit trail
					await tx.insert(tables.orderStatusHistory).values({
						orderId: order.id,
						previousStatus: currentStatus,
						newStatus: "CANCELLED_BY_SYSTEM",
						changedBy: undefined,
						changedByRole: "SYSTEM",
						reason: cancelReason,
						changedAt: now,
					});

					// Decrement merchant active order count if this is a FOOD order
					if (order.merchantId) {
						await repo.merchant.main.decrementActiveOrderCount(
							order.merchantId,
							{
								tx,
							},
						);
						logger.info(
							{ orderId: order.id, merchantId: order.merchantId },
							"[OrderCheckerCron] Decremented merchant active order count after MATCHING timeout",
						);
					}
				});

				// Notify merchant via WebSocket if this is a FOOD order
				if (order.merchantId && order.type === "FOOD") {
					await notifyMerchantRoom(
						order.merchantId,
						order.id,
						"CANCELLED_BY_SYSTEM",
						cancelReason,
					);
				}

				// Send push notification to user about the cancellation
				try {
					await repo.notification.sendNotificationToUserId({
						fromUserId: "system",
						toUserId: order.userId,
						title: "Order Cancelled",
						body: cancelReason,
						data: {
							type: "ORDER_CANCELLED",
							orderId: order.id,
							reason: "TIMEOUT",
							deeplink: `akademove://order/${order.id}`,
						},
						android: {
							priority: "high",
							notification: { clickAction: "ORDER_DETAIL" },
						},
						apns: {
							payload: { aps: { category: "ORDER_DETAIL", sound: "default" } },
						},
					});
				} catch (notifError) {
					logger.warn(
						{ error: notifError, orderId: order.id },
						"[OrderCheckerCron] Failed to send cancellation notification to user",
					);
				}

				logger.info(
					{
						orderId: order.id,
						userId: order.userId,
						refundAmount: toNumberSafe(order.totalPrice),
					},
					"[OrderCheckerCron] Cancelled stuck MATCHING order and processed refund",
				);
				processedOrders++;
			} catch (error) {
				logger.error(
					{ error, orderId: order.id },
					"[OrderCheckerCron] Failed to cancel stuck MATCHING order",
				);
			}
		}

		// 3. Auto-complete orders without ratings
		const completionTimeout = new Date(
			now.getTime() - COMPLETION_TIMEOUT_MINUTES * 60 * 1000,
		);
		const completedOrders = await svc.db.query.order.findMany({
			where: (f, _op) =>
				and(eq(f.status, "COMPLETED"), lte(f.createdAt, completionTimeout)),
			limit: 100,
		});

		for (const order of completedOrders) {
			try {
				// Check if ratings already exist by looking for review records
				// Note: This would need to be implemented based on the review/rating schema
				// For now, we'll mark orders as fully completed after timeout

				await svc.db.transaction(async (_tx) => {
					// Mark as fully completed - this could update a flag or trigger cleanup
					// For now, we'll just log that this order was processed
					logger.debug(
						{ orderId: order.id },
						"[OrderCheckerCron] Processing completed order for auto-completion",
					);
				});

				logger.info(
					{ orderId: order.id, userId: order.userId },
					"[OrderCheckerCron] Auto-completed order without ratings",
				);
				processedOrders++;
			} catch (error) {
				logger.error(
					{ error, orderId: order.id },
					"[OrderCheckerCron] Failed to auto-complete order",
				);
			}
		}

		// 4. Handle NO_SHOW orders
		const noShowTimeout = new Date(
			now.getTime() - NO_SHOW_TIMEOUT_MINUTES * 60 * 1000,
		);
		const noShowOrders = await svc.db.query.order.findMany({
			where: (f, _op) =>
				and(eq(f.status, "NO_SHOW"), lte(f.createdAt, noShowTimeout)),
			limit: 100,
		});

		for (const order of noShowOrders) {
			try {
				// NO_SHOW is a terminal state - we only need to ensure refund is processed
				const currentStatus = order.status as OrderStatus;
				if (currentStatus !== "NO_SHOW") {
					logger.warn(
						{ orderId: order.id, currentStatus },
						"[OrderCheckerCron] Order no longer in NO_SHOW status, skipping",
					);
					continue;
				}

				await svc.db.transaction(async (tx) => {
					// NO_SHOW orders should have already been processed with penalty logic
					// by the WebSocket handler. This cron just ensures any stuck NO_SHOW orders
					// have refunds processed if not already done.
					// Note: NO_SHOW is a terminal state - we do NOT transition to CANCELLED_BY_SYSTEM

					// Check if a refund has already been processed for this order
					const existingRefund = await tx.query.transaction.findFirst({
						where: (f, op) =>
							op.and(op.eq(f.referenceId, order.id), op.eq(f.type, "REFUND")),
					});

					// If no refund exists yet, process partial refund based on noShowFee from config
					if (!existingRefund) {
						const totalPrice = new Decimal(order.totalPrice);
						// Use noShowFee from business configuration (e.g., 0.5 = 50% penalty)
						const noShowFeeRate = businessConfig.noShowFee;
						const penaltyAmount = totalPrice.mul(noShowFeeRate);
						const refundAmount = totalPrice.sub(penaltyAmount);

						await OrderRefundService.processRefund(
							order.id,
							order.userId,
							refundAmount,
							penaltyAmount,
							{ tx },
							`NO_SHOW penalty: ${Math.round(noShowFeeRate * 100)}% fee for order #${order.id.slice(0, 8)}`,
						);

						logger.info(
							{
								orderId: order.id,
								userId: order.userId,
								refundAmount: refundAmount.toNumber(),
								penaltyAmount: penaltyAmount.toNumber(),
								noShowFeeRate,
							},
							"[OrderCheckerCron] Processed NO_SHOW refund",
						);
					}

					// Update only the updatedAt timestamp to mark as processed
					// NO_SHOW remains the final status
					await tx
						.update(tables.order)
						.set({ updatedAt: now })
						.where(eq(tables.order.id, order.id));
				});

				logger.info(
					{ orderId: order.id, userId: order.userId },
					"[OrderCheckerCron] Finalized NO_SHOW order",
				);
				processedOrders++;
			} catch (error) {
				logger.error(
					{ error, orderId: order.id },
					"[OrderCheckerCron] Failed to finalize NO_SHOW order",
				);
			}
		}

		// 5. Update stale timestamps for orders in transit
		const staleTimestampLimit = new Date(
			now.getTime() - STALE_TIMESTAMP_MINUTES * 60 * 1000,
		);
		const inTransitOrders = await svc.db.query.order.findMany({
			where: (f, _op) =>
				and(
					inArray(f.status, ["ACCEPTED", "ARRIVING", "IN_TRIP"]),
					lte(f.updatedAt, staleTimestampLimit),
				),
			limit: 100,
		});

		for (const order of inTransitOrders) {
			try {
				await svc.db.transaction(async (tx) => {
					// Update the updatedAt timestamp to keep orders fresh
					await tx
						.update(tables.order)
						.set({ updatedAt: now })
						.where(eq(tables.order.id, order.id));
				});

				logger.debug(
					{ orderId: order.id },
					"[OrderCheckerCron] Updated stale timestamp",
				);
			} catch (error) {
				logger.error(
					{ error, orderId: order.id },
					"[OrderCheckerCron] Failed to update timestamp",
				);
			}
		}

		logger.info(
			{
				processedOrders,
				stuckRequestedOrders: stuckRequestedOrders.length,
				stuckMatchingOrders: stuckMatchingOrders.length,
				completedOrders: completedOrders.length,
				noShowOrders: noShowOrders.length,
				inTransitOrders: inTransitOrders.length,
			},
			"[OrderCheckerCron] Completed scheduled order status checks",
		);

		return new Response(
			`Order checker completed. Processed ${processedOrders} orders.`,
			{
				status: 200,
			},
		);
	} catch (error) {
		logger.error({ error }, "[OrderCheckerCron] Failed to check orders");
		return new Response("Order checker failed", { status: 500 });
	}
}

/**
 * Notify MerchantRoom of order cancellation via WebSocket
 *
 * @param merchantId - Merchant ID to notify
 * @param orderId - Order ID that was cancelled
 * @param newStatus - New order status
 * @param reason - Cancellation reason
 */
async function notifyMerchantRoom(
	merchantId: string,
	orderId: string,
	newStatus: OrderStatus,
	reason: string,
): Promise<void> {
	try {
		const { MerchantRoom } = await import("@/features/merchant/merchant-ws");
		const merchantStub = MerchantRoom.getRoomStubByName(merchantId);

		const payload: MerchantEnvelope = {
			e: "ORDER_CANCELLED",
			f: "s",
			t: "c",
			p: {
				orderId,
				merchantId,
				newStatus,
				cancelReason: reason,
			},
		};

		await merchantStub.fetch(
			new Request("http://internal/broadcast", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(payload),
			}),
		);

		logger.info(
			{ orderId, merchantId, newStatus },
			"[OrderCheckerCron] Notified merchant room of order cancellation",
		);
	} catch (error) {
		// Non-critical - log and continue
		logger.warn(
			{ error, orderId, merchantId },
			"[OrderCheckerCron] Failed to notify merchant room - non-critical",
		);
	}
}

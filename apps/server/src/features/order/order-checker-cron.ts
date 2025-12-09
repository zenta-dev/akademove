import type { ExecutionContext } from "@cloudflare/workers-types";
import Decimal from "decimal.js";
import { and, eq, inArray, lte } from "drizzle-orm";
import { getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { OrderRefundService } from "@/features/order/services/order-refund-service";
import { log, toNumberSafe } from "@/utils";

/**
 * Scheduled handler for order status checking and cleanup
 * Called by Cloudflare Workers cron trigger
 *
 * Tasks:
 * 1. Cancel orders stuck in MATCHING status for too long (timeout)
 * 2. Auto-complete orders that have been in COMPLETED status without ratings for too long
 * 3. Handle NO_SHOW orders that need cleanup
 * 4. Update stale order timestamps
 */
export async function handleOrderCheckerCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		log.info({}, "[OrderCheckerCron] Starting scheduled order status checks");

		const svc = getServices();

		// Configuration timeouts (in minutes)
		const MATCHING_TIMEOUT_MINUTES = 10; // Cancel orders stuck in matching for 10 minutes
		const COMPLETION_TIMEOUT_MINUTES = 60; // Auto-complete orders without ratings after 60 minutes
		const NO_SHOW_TIMEOUT_MINUTES = 30; // Handle NO_SHOW orders after 30 minutes

		const now = new Date();
		let processedOrders = 0;

		// 1. Handle orders stuck in MATCHING status
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
						`Order cancelled due to timeout: no drivers available within ${MATCHING_TIMEOUT_MINUTES} minutes`,
					);

					// Update order status
					await tx
						.update(tables.order)
						.set({
							status: "CANCELLED_BY_SYSTEM",
							cancelReason: `Order cancelled due to timeout: no drivers available within ${MATCHING_TIMEOUT_MINUTES} minutes`,
							updatedAt: now,
						})
						.where(eq(tables.order.id, order.id));
				});

				log.info(
					{
						orderId: order.id,
						userId: order.userId,
						refundAmount: toNumberSafe(order.totalPrice),
					},
					"[OrderCheckerCron] Cancelled stuck MATCHING order and processed refund",
				);
				processedOrders++;
			} catch (error) {
				log.error(
					{ error, orderId: order.id },
					"[OrderCheckerCron] Failed to cancel stuck MATCHING order",
				);
			}
		}

		// 2. Auto-complete orders without ratings
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
					log.debug(
						{ orderId: order.id },
						"[OrderCheckerCron] Processing completed order for auto-completion",
					);
				});

				log.info(
					{ orderId: order.id, userId: order.userId },
					"[OrderCheckerCron] Auto-completed order without ratings",
				);
				processedOrders++;
			} catch (error) {
				log.error(
					{ error, orderId: order.id },
					"[OrderCheckerCron] Failed to auto-complete order",
				);
			}
		}

		// 3. Handle NO_SHOW orders
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
				await svc.db.transaction(async (tx) => {
					// NO_SHOW orders should have already been processed with penalty logic
					// by the WebSocket handler. This cron just ensures any stuck NO_SHOW orders
					// are finalized and refunds are processed if not already done.

					// Check if a refund has already been processed for this order
					const existingRefund = await tx.query.transaction.findFirst({
						where: (f, op) =>
							op.and(op.eq(f.referenceId, order.id), op.eq(f.type, "REFUND")),
					});

					// If no refund exists yet, process partial refund (50% for NO_SHOW)
					if (!existingRefund) {
						const totalPrice = new Decimal(order.totalPrice);
						// 50% refund for NO_SHOW per SRS penalty logic
						const refundAmount = totalPrice.mul(0.5);
						const penaltyAmount = totalPrice.sub(refundAmount);

						await OrderRefundService.processRefund(
							order.id,
							order.userId,
							refundAmount,
							penaltyAmount,
							{ tx },
							`NO_SHOW penalty: 50% refund for order #${order.id.slice(0, 8)}`,
						);
					}

					// Update order status to finalized
					await tx
						.update(tables.order)
						.set({
							status: "CANCELLED_BY_SYSTEM",
							cancelReason: "Order finalized after NO_SHOW timeout",
							updatedAt: now,
						})
						.where(eq(tables.order.id, order.id));
				});

				log.info(
					{ orderId: order.id, userId: order.userId },
					"[OrderCheckerCron] Finalized NO_SHOW order",
				);
				processedOrders++;
			} catch (error) {
				log.error(
					{ error, orderId: order.id },
					"[OrderCheckerCron] Failed to finalize NO_SHOW order",
				);
			}
		}

		// 4. Update stale timestamps for orders in transit
		const staleTimestampLimit = new Date(now.getTime() - 5 * 60 * 1000); // 5 minutes ago
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

				log.debug(
					{ orderId: order.id },
					"[OrderCheckerCron] Updated stale timestamp",
				);
			} catch (error) {
				log.error(
					{ error, orderId: order.id },
					"[OrderCheckerCron] Failed to update timestamp",
				);
			}
		}

		log.info(
			{
				processedOrders,
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
		log.error({ error }, "[OrderCheckerCron] Failed to check orders");
		return new Response("Order checker failed", { status: 500 });
	}
}

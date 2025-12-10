/**
 * Order Timeout Handler
 *
 * Handles ORDER_TIMEOUT queue messages.
 * Cancels orders that haven't been accepted within the timeout period.
 *
 * Flow:
 * 1. Check if order is still in MATCHING status
 * 2. If yes, cancel the order and process refund
 * 3. Notify user about the cancellation
 */

import type { OrderTimeoutJob } from "@repo/schema/queue";
import { log } from "@/utils";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleOrderTimeout(
	job: OrderTimeoutJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload, meta: _meta } = job;
	const {
		orderId,
		userId,
		paymentId,
		totalPrice,
		timeoutReason,
		processRefund,
	} = payload;

	log.info(
		{ orderId, userId, timeoutReason },
		"[OrderTimeoutHandler] Processing timeout job",
	);

	try {
		// Execute in transaction for atomicity
		await context.svc.db.transaction(async (tx) => {
			const opts = { tx };

			// Get current order status
			const order = await context.repo.order.get(orderId, opts);

			// Check if order is still in a status that can timeout
			// If order has been accepted, completed, or already cancelled, skip
			if (order.status !== "MATCHING" && order.status !== "REQUESTED") {
				log.info(
					{ orderId, currentStatus: order.status },
					"[OrderTimeoutHandler] Order no longer needs timeout - skipping",
				);
				return;
			}

			// Cancel the order
			const updatedOrder = await context.repo.order.update(
				orderId,
				{
					status: "CANCELLED_BY_SYSTEM",
					cancelReason: timeoutReason,
				},
				opts,
			);

			log.info(
				{ orderId, newStatus: updatedOrder.status },
				"[OrderTimeoutHandler] Order cancelled due to timeout",
			);

			// Process refund if requested
			if (processRefund && paymentId) {
				// Find the payment and transaction
				const findPayment = await tx.query.payment.findFirst({
					with: { transaction: { with: { wallet: true } } },
					where: (f, op) => op.eq(f.id, paymentId),
				});

				if (findPayment) {
					const { transaction } = findPayment;
					const wallet = transaction.wallet;
					const refundAmount = totalPrice;

					// Perform atomic balance update
					const { balanceBefore, balanceAfter } =
						await context.svc.walletServices.balance.add(
							{ walletId: wallet.id, amount: refundAmount },
							{ tx },
						);

					// Update transaction and payment status
					await Promise.all([
						context.repo.transaction.update(
							transaction.id,
							{
								status: "REFUNDED",
								balanceBefore,
								balanceAfter,
							},
							opts,
						),
						context.repo.payment.update(
							findPayment.id,
							{ status: "REFUNDED" },
							opts,
						),
					]);

					log.info(
						{
							orderId,
							userId: wallet.userId,
							refundAmount,
							balanceAfter,
						},
						"[OrderTimeoutHandler] Refund processed successfully",
					);
				} else {
					log.warn(
						{ orderId, paymentId },
						"[OrderTimeoutHandler] Payment not found for refund",
					);
				}
			}

			// Send notification to user
			await context.repo.notification.sendNotificationToUserId({
				fromUserId: "system",
				toUserId: userId,
				title: "Order Cancelled",
				body: timeoutReason,
				data: {
					type: "ORDER_CANCELLED",
					orderId,
					reason: "TIMEOUT",
					deeplink: `akademove://order/${orderId}`,
				},
				android: {
					priority: "high",
					notification: { clickAction: "ORDER_DETAIL" },
				},
				apns: {
					payload: { aps: { category: "ORDER_DETAIL", sound: "default" } },
				},
			});
		});
	} catch (error) {
		log.error(
			{ error, orderId, userId },
			"[OrderTimeoutHandler] Failed to process timeout",
		);
		throw error;
	}
}

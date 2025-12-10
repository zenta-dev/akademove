/**
 * Refund Handler
 *
 * Handles REFUND queue messages.
 * Processes wallet refunds for cancelled orders.
 *
 * Flow:
 * 1. Find the original payment transaction
 * 2. Calculate refund amount (full or partial based on type)
 * 3. Credit user wallet
 * 4. Update payment and transaction status
 */

import type { RefundJob } from "@repo/schema/queue";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleRefund(
	job: RefundJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload, meta: _meta } = job;
	const {
		orderId,
		userId,
		walletId,
		paymentId,
		transactionId,
		refundAmount,
		penaltyAmount,
		reason,
		refundType,
	} = payload;

	logger.info(
		{ orderId, userId, refundAmount, refundType },
		"[RefundHandler] Processing refund job",
	);

	try {
		await context.svc.db.transaction(async (tx) => {
			const opts = { tx };

			// Check idempotency - if transaction already refunded, skip
			const existingTransaction = await tx.query.transaction.findFirst({
				where: (f, op) => op.eq(f.id, transactionId),
			});

			if (existingTransaction?.status === "REFUNDED") {
				logger.info(
					{ orderId, transactionId },
					"[RefundHandler] Transaction already refunded - skipping",
				);
				return;
			}

			// Validate order status - only process refund for cancelled/no-show orders
			const order = await context.repo.order.get(orderId, opts);
			const validRefundStatuses = [
				"CANCELLED_BY_SYSTEM",
				"CANCELLED_BY_USER",
				"CANCELLED_BY_DRIVER",
				"CANCELLED_BY_MERCHANT",
				"NO_SHOW",
			];

			if (!validRefundStatuses.includes(order.status)) {
				logger.warn(
					{ orderId, currentStatus: order.status },
					"[RefundHandler] Order not in a refundable state - skipping",
				);
				return;
			}

			// Perform atomic balance update
			const { balanceBefore, balanceAfter } =
				await context.svc.walletServices.balance.add(
					{ walletId, amount: refundAmount },
					{ tx },
				);

			// Update original transaction status
			await context.repo.transaction.update(
				transactionId,
				{
					status: "REFUNDED",
					balanceBefore,
					balanceAfter,
				},
				opts,
			);

			// Update payment status
			await context.repo.payment.update(
				paymentId,
				{ status: "REFUNDED" },
				opts,
			);

			// If there's a penalty, record it separately for audit
			if (penaltyAmount > 0) {
				await context.repo.transaction.insert(
					{
						walletId,
						type: "COMMISSION",
						amount: toNumberSafe(penaltyAmount),
						status: "SUCCESS",
						description: `Penalty for order #${orderId.slice(0, 8)} - ${reason}`,
						referenceId: orderId,
						metadata: {
							orderId,
							refundType,
							penaltyAmount: toNumberSafe(penaltyAmount),
							reason,
						},
					},
					opts,
				);
			}

			logger.info(
				{
					orderId,
					userId,
					refundAmount,
					penaltyAmount,
					balanceAfter,
					refundType,
				},
				"[RefundHandler] Refund processed successfully",
			);
		});

		// Send notification to user
		const notificationBody =
			penaltyAmount > 0
				? `Refund of ${refundAmount} processed (${penaltyAmount} penalty applied)`
				: `Full refund of ${refundAmount} processed`;

		await context.repo.notification.sendNotificationToUserId({
			fromUserId: "system",
			toUserId: userId,
			title: "Refund Processed",
			body: notificationBody,
			data: {
				type: "REFUND_PROCESSED",
				orderId,
				refundAmount: String(refundAmount),
				refundType,
				deeplink: "akademove://wallet",
			},
		});
	} catch (error) {
		logger.error(
			{ error, orderId, userId, refundType },
			"[RefundHandler] Failed to process refund",
		);
		throw error;
	}
}

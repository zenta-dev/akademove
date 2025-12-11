/**
 * Payment Webhook Handler
 *
 * Handles PAYMENT_WEBHOOK queue messages.
 * Processes Midtrans webhook notifications asynchronously.
 *
 * Benefits of async processing:
 * - Fast webhook response times (Midtrans expects < 5s response)
 * - Automatic retry on failure
 * - Better reliability for critical payment operations
 *
 * Flow:
 * 1. Verify webhook signature (already done in HTTP handler)
 * 2. Look up payment by external ID
 * 3. Process based on transaction status (expire, settlement, success)
 * 4. Update payment, transaction, and wallet records
 * 5. Send notifications via WebSocket and push
 */

import type { PaymentWebhookJob } from "@repo/schema/queue";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handlePaymentWebhook(
	job: PaymentWebhookJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload, meta } = job;
	const { webhookBody, provider } = payload;
	// receivedAt is serialized as ISO string when passing through the queue
	const receivedAt = new Date(payload.receivedAt);

	const orderId = webhookBody.order_id as string | undefined;
	const transactionStatus = webhookBody.transaction_status as
		| string
		| undefined;

	logger.info(
		{
			orderId,
			transactionStatus,
			provider,
			receivedAt,
			messageId: meta.messageId,
		},
		"[PaymentWebhookHandler] Processing payment webhook job",
	);

	try {
		// Skip pending status (no action needed)
		if (transactionStatus === "pending") {
			logger.debug(
				{ orderId },
				"[PaymentWebhookHandler] Skipping pending status - no action needed",
			);
			return;
		}

		await context.svc.db.transaction(async (tx) => {
			// Delegate to payment repository for processing
			// This reuses the existing webhook processing logic
			await context.repo.payment.handleWebhookMidtrans({
				body: webhookBody as Record<string, unknown>,
				tx,
			});

			logger.info(
				{
					orderId,
					transactionStatus,
					processingTime: Date.now() - receivedAt.getTime(),
				},
				"[PaymentWebhookHandler] Payment webhook processed successfully",
			);
		});
	} catch (error) {
		logger.error(
			{
				error,
				orderId,
				transactionStatus,
				messageId: meta.messageId,
				retryCount: meta.retryCount,
			},
			"[PaymentWebhookHandler] Failed to process payment webhook",
		);
		throw error;
	}
}

/**
 * Queue Handler - Cloudflare Queue Consumer
 *
 * Processes messages from all queues:
 * - ORDER_QUEUE: Critical order operations (matching, timeout, completion, refunds)
 * - NOTIFICATION_QUEUE: Push notifications to users/drivers
 * - PROCESSING_QUEUE: Background tasks (badges, metrics, audit logs)
 *
 * Architecture:
 * - Each message type has a dedicated handler
 * - Idempotency is enforced via messageId/idempotencyKey
 * - Failed messages are retried by the queue system
 * - After max retries, messages go to DLQ for manual review
 */

import type {
	NotificationQueueMessage,
	OrderQueueMessage,
	ProcessingQueueMessage,
	QueueMessage,
} from "@repo/schema/queue";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type { RepositoryContext, ServiceContext } from "@/core/interface";
import { logger } from "@/utils/logger";
import { handleAuditLog } from "./handlers/audit-log-handler";
import { handleBadgeEvaluation } from "./handlers/badge-evaluation-handler";
import { handleBatchNotification } from "./handlers/batch-notification-handler";
import { handleCouponUsage } from "./handlers/coupon-usage-handler";
import { handleDriverMatching } from "./handlers/driver-matching-handler";
import { handleDriverMetrics } from "./handlers/driver-metrics-handler";
import { handleOrderCompletion } from "./handlers/order-completion-handler";
import { handleOrderStatusHistory } from "./handlers/order-status-history-handler";
import { handleOrderTimeout } from "./handlers/order-timeout-handler";
import { handlePaymentWebhook } from "./handlers/payment-webhook-handler";
import { handlePushNotification } from "./handlers/push-notification-handler";
import { handleRefund } from "./handlers/refund-handler";
import { handleWebSocketBroadcast } from "./handlers/websocket-broadcast-handler";

/**
 * Context passed to all queue handlers
 */
export interface QueueHandlerContext {
	svc: ServiceContext;
	repo: RepositoryContext;
	env: Env;
}

/**
 * Initialize handler context
 */
function getHandlerContext(env: Env): QueueHandlerContext {
	const svc = getServices();
	const repo = getRepositories(svc, getManagers());
	return { svc, repo, env };
}

/**
 * Process a batch of ORDER_QUEUE messages
 */
export async function handleOrderQueue(
	batch: MessageBatch<OrderQueueMessage>,
	env: Env,
	ctx: ExecutionContext,
): Promise<void> {
	const context = getHandlerContext(env);

	logger.info(
		{ batchSize: batch.messages.length, queue: batch.queue },
		"[QueueHandler] Processing ORDER_QUEUE batch",
	);

	for (const message of batch.messages) {
		const startTime = Date.now();
		const { body } = message;

		try {
			logger.debug(
				{
					type: body.type,
					messageId: body.meta.messageId,
					idempotencyKey: body.meta.idempotencyKey,
					orderId: body.meta.orderId,
				},
				"[QueueHandler] Processing order queue message",
			);

			switch (body.type) {
				case "DRIVER_MATCHING":
					await handleDriverMatching(body, context, ctx);
					break;
				case "ORDER_TIMEOUT":
					await handleOrderTimeout(body, context);
					break;
				case "ORDER_COMPLETION":
					await handleOrderCompletion(body, context);
					break;
				case "REFUND":
					await handleRefund(body, context);
					break;
				case "PAYMENT_WEBHOOK":
					await handlePaymentWebhook(body, context);
					break;
				default: {
					// TypeScript exhaustive check
					const _exhaustive: never = body;
					logger.error(
						{ body: _exhaustive },
						"[QueueHandler] Unknown message type",
					);
				}
			}

			message.ack();

			logger.info(
				{
					type: body.type,
					messageId: body.meta.messageId,
					durationMs: Date.now() - startTime,
				},
				"[QueueHandler] Order message processed successfully",
			);
		} catch (error) {
			logger.error(
				{
					error,
					type: body.type,
					messageId: body.meta.messageId,
					retryCount: body.meta.retryCount,
					durationMs: Date.now() - startTime,
				},
				"[QueueHandler] Failed to process order message - will retry",
			);

			// Let the queue system handle retries
			message.retry();
		}
	}
}

/**
 * Process a batch of NOTIFICATION_QUEUE messages
 */
export async function handleNotificationQueue(
	batch: MessageBatch<NotificationQueueMessage>,
	env: Env,
	_ctx: ExecutionContext,
): Promise<void> {
	const context = getHandlerContext(env);

	logger.info(
		{ batchSize: batch.messages.length, queue: batch.queue },
		"[QueueHandler] Processing NOTIFICATION_QUEUE batch",
	);

	// Process notifications in parallel for high throughput
	const results = await Promise.allSettled(
		batch.messages.map(async (message) => {
			const { body } = message;

			try {
				logger.debug(
					{
						type: body.type,
						messageId: body.meta.messageId,
					},
					"[QueueHandler] Processing notification message",
				);

				switch (body.type) {
					case "PUSH_NOTIFICATION":
						await handlePushNotification(body, context);
						break;
					case "BATCH_NOTIFICATION":
						await handleBatchNotification(body, context);
						break;
					default: {
						const _exhaustive: never = body;
						logger.error(
							{ body: _exhaustive },
							"[QueueHandler] Unknown notification type",
						);
					}
				}

				message.ack();
				return { success: true, messageId: body.meta.messageId };
			} catch (error) {
				logger.error(
					{
						error,
						type: body.type,
						messageId: body.meta.messageId,
					},
					"[QueueHandler] Failed to process notification - will retry",
				);

				message.retry();
				return { success: false, messageId: body.meta.messageId, error };
			}
		}),
	);

	const successful = results.filter(
		(r) => r.status === "fulfilled" && r.value.success,
	).length;
	const failed = results.length - successful;

	logger.info(
		{ successful, failed, total: results.length },
		"[QueueHandler] Notification batch completed",
	);
}

/**
 * Process a batch of PROCESSING_QUEUE messages
 */
export async function handleProcessingQueue(
	batch: MessageBatch<ProcessingQueueMessage>,
	env: Env,
	_ctx: ExecutionContext,
): Promise<void> {
	const context = getHandlerContext(env);

	logger.info(
		{ batchSize: batch.messages.length, queue: batch.queue },
		"[QueueHandler] Processing PROCESSING_QUEUE batch",
	);

	for (const message of batch.messages) {
		const { body } = message;

		try {
			logger.debug(
				{
					type: body.type,
					messageId: body.meta.messageId,
				},
				"[QueueHandler] Processing background task message",
			);

			switch (body.type) {
				case "BADGE_EVALUATION":
					await handleBadgeEvaluation(body, context);
					break;
				case "COUPON_USAGE":
					await handleCouponUsage(body, context);
					break;
				case "AUDIT_LOG":
					await handleAuditLog(body, context);
					break;
				case "ORDER_STATUS_HISTORY":
					await handleOrderStatusHistory(body, context);
					break;
				case "DRIVER_METRICS":
					await handleDriverMetrics(body, context);
					break;
				case "WEBSOCKET_BROADCAST":
					await handleWebSocketBroadcast(body, context);
					break;
				default: {
					const _exhaustive: never = body;
					logger.error(
						{ body: _exhaustive },
						"[QueueHandler] Unknown processing type",
					);
				}
			}

			message.ack();

			logger.debug(
				{
					type: body.type,
					messageId: body.meta.messageId,
				},
				"[QueueHandler] Background task completed",
			);
		} catch (error) {
			logger.error(
				{
					error,
					type: body.type,
					messageId: body.meta.messageId,
				},
				"[QueueHandler] Failed to process background task - will retry",
			);

			message.retry();
		}
	}
}

/**
 * Process DLQ messages (dead letter queue)
 *
 * Messages here have failed all retries and need manual review.
 * This handler logs them for investigation.
 */
export async function handleDeadLetterQueue(
	batch: MessageBatch<QueueMessage>,
	_env: Env,
	_ctx: ExecutionContext,
): Promise<void> {
	logger.warn(
		{ batchSize: batch.messages.length },
		"[QueueHandler] Processing DLQ messages - these require manual review",
	);

	for (const message of batch.messages) {
		const { body } = message;

		logger.error(
			{
				type: body.type,
				messageId: body.meta.messageId,
				idempotencyKey: body.meta.idempotencyKey,
				orderId: body.meta.orderId,
				userId: body.meta.userId,
				createdAt: body.meta.createdAt,
				retryCount: body.meta.retryCount,
				payload: body.payload,
			},
			"[QueueHandler] DLQ message - failed after max retries",
		);

		// Acknowledge to remove from DLQ
		// In production, you might want to:
		// 1. Store in a persistent error log table
		// 2. Send alert to ops team
		// 3. Create an incident ticket
		message.ack();
	}
}

/**
 * Main queue handler entry point
 *
 * Routes messages to appropriate handlers based on queue name.
 * This is exported and called from apps/server/src/index.ts
 */
export async function handleQueue(
	batch: MessageBatch<QueueMessage>,
	env: Env,
	ctx: ExecutionContext,
): Promise<void> {
	const queueName = batch.queue;

	logger.info(
		{ queue: queueName, messageCount: batch.messages.length },
		"[QueueHandler] Received queue batch",
	);

	// Route to appropriate handler based on queue name
	if (queueName.includes("order-queue")) {
		await handleOrderQueue(batch as MessageBatch<OrderQueueMessage>, env, ctx);
	} else if (queueName.includes("notification-queue")) {
		await handleNotificationQueue(
			batch as MessageBatch<NotificationQueueMessage>,
			env,
			ctx,
		);
	} else if (queueName.includes("processing-queue")) {
		await handleProcessingQueue(
			batch as MessageBatch<ProcessingQueueMessage>,
			env,
			ctx,
		);
	} else if (queueName.includes("order-dlq")) {
		await handleDeadLetterQueue(batch, env, ctx);
	} else {
		logger.warn({ queue: queueName }, "[QueueHandler] Unknown queue");
		// Acknowledge all messages to prevent infinite loop
		for (const message of batch.messages) {
			message.ack();
		}
	}
}

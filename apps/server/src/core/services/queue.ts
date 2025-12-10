/**
 * Queue Service - Producer for Cloudflare Queues
 *
 * Provides type-safe methods for enqueueing jobs to different queues.
 * All queue operations are designed for resilience - orders can't fail, only timeout.
 *
 * Architecture:
 * - ORDER_QUEUE: Critical order operations (matching, refunds, completion)
 * - NOTIFICATION_QUEUE: Push notifications to drivers/users
 * - PROCESSING_QUEUE: Background tasks (badges, metrics, audit logs)
 */

import { env } from "cloudflare:workers";
import type {
	AuditLogJob,
	BadgeEvaluationJob,
	BatchNotificationJob,
	CouponUsageJob,
	DriverMatchingJob,
	DriverMetricsJob,
	OrderCompletionJob,
	OrderStatusHistoryJob,
	OrderTimeoutJob,
	PaymentWebhookJob,
	PushNotificationJob,
	QueueMessageMeta,
	RefundJob,
	WebSocketBroadcastJob,
} from "@repo/schema/queue";
import { v7 as uuid } from "uuid";
import { logger } from "@/utils/logger";

/**
 * Creates queue message metadata with idempotency support
 */
function createMeta(
	idempotencyKey: string,
	opts?: { orderId?: string; userId?: string },
): QueueMessageMeta {
	return {
		messageId: uuid(),
		idempotencyKey,
		createdAt: new Date(),
		retryCount: 0,
		orderId: opts?.orderId,
		userId: opts?.userId,
	};
}

/**
 * Queue Service for Order Operations
 *
 * Handles critical order lifecycle events with high reliability.
 * Messages in this queue have aggressive retry policies.
 */
export const OrderQueueService = {
	/**
	 * Enqueue a driver matching job
	 *
	 * This is the core matching flow:
	 * 1. Search for drivers within initial radius
	 * 2. If no drivers found, wait for interval and expand radius
	 * 3. Continue until driver accepts or timeout reached
	 * 4. On timeout, cancel order and process refund
	 *
	 * @param payload - Matching criteria and configuration
	 * @param opts - Delay options for scheduled processing
	 */
	async enqueueDriverMatching(
		payload: DriverMatchingJob["payload"],
		opts?: { delaySeconds?: number },
	): Promise<void> {
		const idempotencyKey = `matching-${payload.orderId}-${payload.currentAttempt ?? 1}`;

		const message: DriverMatchingJob = {
			type: "DRIVER_MATCHING",
			meta: createMeta(idempotencyKey, {
				orderId: payload.orderId,
			}),
			payload,
		};

		logger.info(
			{
				orderId: payload.orderId,
				attempt: payload.currentAttempt ?? 1,
				radiusKm: payload.initialRadiusKm,
				delaySeconds: opts?.delaySeconds,
			},
			"[QueueService] Enqueueing driver matching job",
		);

		await env.ORDER_QUEUE.send(message, {
			delaySeconds: opts?.delaySeconds,
		});
	},

	/**
	 * Enqueue an order timeout job
	 *
	 * Scheduled when matching starts. If not cancelled (by driver acceptance),
	 * this job will execute after the configured timeout and cancel the order.
	 *
	 * @param payload - Order details for timeout handling
	 * @param delaySeconds - Delay before timeout (default: from config)
	 */
	async enqueueOrderTimeout(
		payload: OrderTimeoutJob["payload"],
		delaySeconds: number,
	): Promise<void> {
		const idempotencyKey = `timeout-${payload.orderId}`;

		const message: OrderTimeoutJob = {
			type: "ORDER_TIMEOUT",
			meta: createMeta(idempotencyKey, {
				orderId: payload.orderId,
				userId: payload.userId,
			}),
			payload,
		};

		logger.info(
			{
				orderId: payload.orderId,
				userId: payload.userId,
				delaySeconds,
			},
			"[QueueService] Enqueueing order timeout job",
		);

		await env.ORDER_QUEUE.send(message, {
			delaySeconds,
		});
	},

	/**
	 * Enqueue an order completion job
	 *
	 * Processes commission calculation and driver earnings after order completion.
	 * This is triggered when driver marks order as done.
	 *
	 * @param payload - Order completion details
	 */
	async enqueueOrderCompletion(
		payload: OrderCompletionJob["payload"],
	): Promise<void> {
		const idempotencyKey = `completion-${payload.orderId}`;

		const message: OrderCompletionJob = {
			type: "ORDER_COMPLETION",
			meta: createMeta(idempotencyKey, {
				orderId: payload.orderId,
			}),
			payload,
		};

		logger.info(
			{
				orderId: payload.orderId,
				driverId: payload.driverId,
				totalPrice: payload.totalPrice,
			},
			"[QueueService] Enqueueing order completion job",
		);

		await env.ORDER_QUEUE.send(message);
	},

	/**
	 * Enqueue a refund job
	 *
	 * Processes wallet refund for cancelled orders.
	 * Supports both full and partial refunds.
	 *
	 * @param payload - Refund details
	 */
	async enqueueRefund(payload: RefundJob["payload"]): Promise<void> {
		const idempotencyKey = `refund-${payload.orderId}-${payload.refundType}`;

		const message: RefundJob = {
			type: "REFUND",
			meta: createMeta(idempotencyKey, {
				orderId: payload.orderId,
				userId: payload.userId,
			}),
			payload,
		};

		logger.info(
			{
				orderId: payload.orderId,
				userId: payload.userId,
				refundAmount: payload.refundAmount,
				refundType: payload.refundType,
			},
			"[QueueService] Enqueueing refund job",
		);

		await env.ORDER_QUEUE.send(message);
	},

	/**
	 * Enqueue a payment webhook job
	 *
	 * Processes Midtrans webhook notifications asynchronously.
	 * This allows the webhook endpoint to respond quickly while
	 * processing happens in the background with retry support.
	 *
	 * @param payload - Payment webhook payload
	 */
	async enqueuePaymentWebhook(
		payload: PaymentWebhookJob["payload"],
	): Promise<void> {
		const orderId =
			(payload.webhookBody.order_id as string) ?? `webhook-${Date.now()}`;
		const idempotencyKey = `payment-webhook-${orderId}-${payload.receivedAt.getTime()}`;

		const message: PaymentWebhookJob = {
			type: "PAYMENT_WEBHOOK",
			meta: createMeta(idempotencyKey),
			payload,
		};

		logger.info(
			{
				orderId,
				provider: payload.provider,
				receivedAt: payload.receivedAt,
			},
			"[QueueService] Enqueueing payment webhook job",
		);

		await env.ORDER_QUEUE.send(message);
	},
};

/**
 * Queue Service for Notifications
 *
 * Handles push notifications with high throughput.
 * Notifications are fire-and-forget with retries for reliability.
 */
export const NotificationQueueService = {
	/**
	 * Enqueue a single push notification
	 *
	 * @param payload - Notification content and target
	 */
	async enqueuePushNotification(
		payload: PushNotificationJob["payload"],
	): Promise<void> {
		const idempotencyKey = `notif-${payload.toUserId}-${Date.now()}`;

		const message: PushNotificationJob = {
			type: "PUSH_NOTIFICATION",
			meta: createMeta(idempotencyKey, {
				userId: payload.toUserId,
			}),
			payload,
		};

		logger.debug(
			{
				toUserId: payload.toUserId,
				title: payload.title,
			},
			"[QueueService] Enqueueing push notification",
		);

		await env.NOTIFICATION_QUEUE.send(message);
	},

	/**
	 * Enqueue batch notifications to multiple drivers
	 *
	 * Used for broadcasting new orders to nearby drivers.
	 *
	 * @param payload - Batch notification details
	 */
	async enqueueBatchNotification(
		payload: BatchNotificationJob["payload"],
	): Promise<void> {
		const idempotencyKey = `batch-${payload.orderId}-${Date.now()}`;

		const message: BatchNotificationJob = {
			type: "BATCH_NOTIFICATION",
			meta: createMeta(idempotencyKey, {
				orderId: payload.orderId,
			}),
			payload,
		};

		logger.info(
			{
				orderId: payload.orderId,
				driverCount: payload.driverUserIds.length,
			},
			"[QueueService] Enqueueing batch notification",
		);

		await env.NOTIFICATION_QUEUE.send(message);
	},
};

/**
 * Queue Service for Background Processing
 *
 * Handles non-critical background tasks with eventual consistency.
 */
export const ProcessingQueueService = {
	/**
	 * Enqueue badge evaluation after order completion
	 *
	 * @param payload - Badge evaluation criteria
	 */
	async enqueueBadgeEvaluation(
		payload: BadgeEvaluationJob["payload"],
	): Promise<void> {
		const idempotencyKey = `badge-${payload.orderId}-${payload.driverId}`;

		const message: BadgeEvaluationJob = {
			type: "BADGE_EVALUATION",
			meta: createMeta(idempotencyKey, {
				orderId: payload.orderId,
				userId: payload.userId,
			}),
			payload,
		};

		logger.debug(
			{
				driverId: payload.driverId,
				orderId: payload.orderId,
			},
			"[QueueService] Enqueueing badge evaluation",
		);

		await env.PROCESSING_QUEUE.send(message);
	},

	/**
	 * Enqueue coupon usage recording
	 *
	 * @param payload - Coupon usage details
	 */
	async enqueueCouponUsage(payload: CouponUsageJob["payload"]): Promise<void> {
		const idempotencyKey = `coupon-${payload.orderId}-${payload.couponId}`;

		const message: CouponUsageJob = {
			type: "COUPON_USAGE",
			meta: createMeta(idempotencyKey, {
				orderId: payload.orderId,
				userId: payload.userId,
			}),
			payload,
		};

		logger.debug(
			{
				couponId: payload.couponId,
				orderId: payload.orderId,
			},
			"[QueueService] Enqueueing coupon usage",
		);

		await env.PROCESSING_QUEUE.send(message);
	},

	/**
	 * Enqueue audit log entry
	 *
	 * @param payload - Audit log details
	 */
	async enqueueAuditLog(payload: AuditLogJob["payload"]): Promise<void> {
		const idempotencyKey = `audit-${payload.entityType}-${payload.entityId}-${payload.action}-${Date.now()}`;

		const message: AuditLogJob = {
			type: "AUDIT_LOG",
			meta: createMeta(idempotencyKey, {
				userId: payload.actorId,
			}),
			payload,
		};

		logger.debug(
			{
				action: payload.action,
				entityType: payload.entityType,
				entityId: payload.entityId,
			},
			"[QueueService] Enqueueing audit log",
		);

		await env.PROCESSING_QUEUE.send(message);
	},

	/**
	 * Enqueue order status history record
	 *
	 * @param payload - Status transition details
	 */
	async enqueueOrderStatusHistory(
		payload: OrderStatusHistoryJob["payload"],
	): Promise<void> {
		const idempotencyKey = `history-${payload.orderId}-${payload.toStatus}-${Date.now()}`;

		const message: OrderStatusHistoryJob = {
			type: "ORDER_STATUS_HISTORY",
			meta: createMeta(idempotencyKey, {
				orderId: payload.orderId,
				userId: payload.changedBy,
			}),
			payload,
		};

		logger.debug(
			{
				orderId: payload.orderId,
				fromStatus: payload.fromStatus,
				toStatus: payload.toStatus,
			},
			"[QueueService] Enqueueing order status history",
		);

		await env.PROCESSING_QUEUE.send(message);
	},

	/**
	 * Enqueue driver metrics update
	 *
	 * @param payload - Metrics update details
	 */
	async enqueueDriverMetrics(
		payload: DriverMetricsJob["payload"],
	): Promise<void> {
		const idempotencyKey = `metrics-${payload.driverId}-${payload.orderId}-${payload.metricsType}`;

		const message: DriverMetricsJob = {
			type: "DRIVER_METRICS",
			meta: createMeta(idempotencyKey, {
				orderId: payload.orderId,
			}),
			payload,
		};

		logger.debug(
			{
				driverId: payload.driverId,
				metricsType: payload.metricsType,
			},
			"[QueueService] Enqueueing driver metrics",
		);

		await env.PROCESSING_QUEUE.send(message);
	},

	/**
	 * Enqueue WebSocket broadcast
	 *
	 * Used when queue worker needs to notify clients after processing.
	 *
	 * @param payload - Broadcast details
	 */
	async enqueueWebSocketBroadcast(
		payload: WebSocketBroadcastJob["payload"],
	): Promise<void> {
		const idempotencyKey = `ws-${payload.roomName}-${payload.event}-${Date.now()}`;

		const message: WebSocketBroadcastJob = {
			type: "WEBSOCKET_BROADCAST",
			meta: createMeta(idempotencyKey),
			payload,
		};

		logger.debug(
			{
				roomName: payload.roomName,
				event: payload.event,
			},
			"[QueueService] Enqueueing WebSocket broadcast",
		);

		await env.PROCESSING_QUEUE.send(message);
	},
};

/**
 * Combined Queue Service
 *
 * Exports all queue services for convenient access.
 */
export const QueueService = {
	order: OrderQueueService,
	notification: NotificationQueueService,
	processing: ProcessingQueueService,
};

export type QueueServiceType = typeof QueueService;

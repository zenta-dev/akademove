import * as z from "zod";
import type { SchemaRegistries } from "./common.js";

/**
 * Queue Message Types for Cloudflare Queues
 *
 * These schemas define the message formats for async job processing.
 * All queue operations are designed for resilience - orders can't fail, only timeout.
 *
 * Queue Architecture:
 * - ORDER_QUEUE: Critical order operations (matching, refunds, completion)
 * - NOTIFICATION_QUEUE: Push notifications to drivers/users
 * - PROCESSING_QUEUE: Background tasks (badge awards, metrics, audit logs)
 */

// ============================================================================
// Base Queue Message Schema
// ============================================================================

export const QueueMessageMetaSchema = z.object({
	/** Unique message ID for deduplication */
	messageId: z.uuid(),
	/** Idempotency key to prevent duplicate processing */
	idempotencyKey: z.string(),
	/** Timestamp when message was created */
	createdAt: z.coerce.date(),
	/** Number of retry attempts (set by queue system) */
	retryCount: z.coerce.number().int().min(0).default(0),
	/** Original order ID for tracing */
	orderId: z.string().optional(),
	/** User ID for audit trail */
	userId: z.string().optional(),
});
export type QueueMessageMeta = z.infer<typeof QueueMessageMetaSchema>;

// ============================================================================
// Order Queue Messages (Critical - Must Not Fail)
// ============================================================================

/**
 * Driver matching job - finds and broadcasts order to nearby drivers
 * This is the core matching logic that runs with configurable timeout
 * All configuration values come from database (BusinessConfiguration)
 */
export const DriverMatchingJobSchema = z.object({
	type: z.literal("DRIVER_MATCHING"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		orderId: z.string(),
		pickupLocation: z.object({
			x: z.coerce.number(),
			y: z.coerce.number(),
		}),
		orderType: z.enum(["RIDE", "DELIVERY", "FOOD"]),
		genderPreference: z.enum(["SAME", "ANY"]).optional(),
		userGender: z.enum(["MALE", "FEMALE"]).optional(),
		/** Initial search radius in km (from database config) */
		initialRadiusKm: z.coerce.number().positive().default(5),
		/** Maximum search radius in km - hard limit (from database config) */
		maxRadiusKm: z.coerce.number().positive().default(20),
		/** Maximum matching duration in minutes (from database config) */
		maxMatchingDurationMinutes: z.coerce.number().positive().default(15),
		/** Current matching attempt (for radius expansion) */
		currentAttempt: z.coerce.number().int().min(1).default(1),
		/** Maximum expansion attempts before timeout */
		maxExpansionAttempts: z.coerce.number().int().positive().default(10),
		/** Radius expansion rate per attempt (e.g., 0.2 = 20%) (from database config) */
		expansionRate: z.coerce.number().positive().default(0.2),
		/** Interval between matching attempts in seconds (from database config) */
		matchingIntervalSeconds: z.coerce.number().positive().default(30),
		/** Maximum drivers to broadcast to (from database config) */
		broadcastLimit: z.coerce.number().int().positive().default(10),
		/** Maximum driver cancellations per day (from database config) */
		maxCancellationsPerDay: z.coerce.number().int().positive().default(3),
		/** Payment ID for refund if matching times out */
		paymentId: z.string().optional(),
		/** WebSocket room ID for real-time updates */
		wsRoomId: z.string().optional(),
		/** Driver IDs to exclude from matching (e.g., drivers who already cancelled this order) */
		excludedDriverIds: z.array(z.string()).optional(),
		/** Whether this is a retry after driver cancellation */
		isRetry: z.boolean().optional(),
	}),
});
export type DriverMatchingJob = z.infer<typeof DriverMatchingJobSchema>;

/**
 * Order timeout job - cancels order if no driver accepts within timeout
 * Scheduled when matching starts, cancelled if driver accepts
 */
export const OrderTimeoutJobSchema = z.object({
	type: z.literal("ORDER_TIMEOUT"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		orderId: z.string(),
		userId: z.string(),
		paymentId: z.string().optional(),
		totalPrice: z.coerce.number(),
		/** Reason for timeout (for user notification) */
		timeoutReason: z
			.string()
			.default("No driver available within timeout period"),
		/** Whether to process full refund */
		processRefund: z.boolean().default(true),
	}),
});
export type OrderTimeoutJob = z.infer<typeof OrderTimeoutJobSchema>;

/**
 * Order completion job - processes commission and driver earnings
 */
export const OrderCompletionJobSchema = z.object({
	type: z.literal("ORDER_COMPLETION"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		orderId: z.string(),
		driverId: z.string(),
		driverUserId: z.string(),
		totalPrice: z.coerce.number(),
		orderType: z.enum(["RIDE", "DELIVERY", "FOOD"]),
		/** Pre-calculated commission rate (after badge reduction) */
		commissionRate: z.coerce.number().min(0).max(1),
		/** Driver's current location for availability update */
		driverCurrentLocation: z
			.object({
				x: z.coerce.number(),
				y: z.coerce.number(),
			})
			.optional(),
	}),
});
export type OrderCompletionJob = z.infer<typeof OrderCompletionJobSchema>;

/**
 * Refund processing job - handles wallet refunds for cancelled orders
 */
export const RefundJobSchema = z.object({
	type: z.literal("REFUND"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		orderId: z.string(),
		userId: z.string(),
		walletId: z.string(),
		paymentId: z.string(),
		transactionId: z.string(),
		refundAmount: z.coerce.number().positive(),
		penaltyAmount: z.coerce.number().min(0).default(0),
		reason: z.string(),
		/** Refund type for audit */
		refundType: z.enum([
			"FULL_REFUND",
			"PARTIAL_REFUND",
			"NO_SHOW_REFUND",
			"SYSTEM_CANCEL_REFUND",
			"USER_CANCEL_REFUND",
			"DRIVER_CANCEL_REFUND",
		]),
	}),
});
export type RefundJob = z.infer<typeof RefundJobSchema>;

/**
 * Payment webhook processing job - handles Midtrans webhook notifications asynchronously
 * Offloads webhook processing to queue for reliability and faster response times
 */
export const PaymentWebhookJobSchema = z.object({
	type: z.literal("PAYMENT_WEBHOOK"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		/** Raw webhook body from Midtrans */
		webhookBody: z.record(z.string(), z.unknown()),
		/** Webhook provider for future extensibility */
		provider: z.enum(["MIDTRANS"]).default("MIDTRANS"),
		/** Timestamp when webhook was received */
		receivedAt: z.coerce.date(),
	}),
});
export type PaymentWebhookJob = z.infer<typeof PaymentWebhookJobSchema>;

// ============================================================================
// Notification Queue Messages
// ============================================================================

/**
 * Push notification job - sends FCM notifications to users/drivers
 */
export const PushNotificationJobSchema = z.object({
	type: z.literal("PUSH_NOTIFICATION"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		/** Target user ID to send notification to */
		toUserId: z.string(),
		/** Sender user ID (for audit) */
		fromUserId: z.string().optional(),
		/** Notification title */
		title: z.string(),
		/** Notification body */
		body: z.string(),
		/** Custom data payload */
		data: z.record(z.string(), z.string()).optional(),
		/** Android-specific options */
		android: z
			.object({
				priority: z.enum(["high", "normal"]).optional(),
				notification: z
					.object({
						clickAction: z.string().optional(),
						channelId: z.string().optional(),
					})
					.optional(),
			})
			.optional(),
		/** iOS-specific options */
		apns: z
			.object({
				payload: z
					.object({
						aps: z
							.object({
								category: z.string().optional(),
								sound: z.string().optional(),
								badge: z.coerce.number().optional(),
							})
							.optional(),
					})
					.optional(),
			})
			.optional(),
		/** Web push options */
		webpush: z
			.object({
				fcmOptions: z
					.object({
						link: z.string().optional(),
					})
					.optional(),
			})
			.optional(),
	}),
});
export type PushNotificationJob = z.infer<typeof PushNotificationJobSchema>;

/**
 * Batch notification job - sends notifications to multiple drivers
 * Used for order broadcasting to nearby drivers
 */
export const BatchNotificationJobSchema = z.object({
	type: z.literal("BATCH_NOTIFICATION"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		/** Order ID being broadcasted */
		orderId: z.string(),
		/** List of driver user IDs to notify */
		driverUserIds: z.array(z.string()),
		/** Notification content */
		notification: z.object({
			title: z.string(),
			body: z.string(),
			data: z.record(z.string(), z.string()).optional(),
		}),
		/** Whether to also send WebSocket message */
		sendWebSocket: z.boolean().default(true),
	}),
});
export type BatchNotificationJob = z.infer<typeof BatchNotificationJobSchema>;

// ============================================================================
// Processing Queue Messages (Background Tasks)
// ============================================================================

/**
 * Badge evaluation job - checks and awards badges after order completion
 */
export const BadgeEvaluationJobSchema = z.object({
	type: z.literal("BADGE_EVALUATION"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		driverId: z.string(),
		userId: z.string(),
		orderId: z.string(),
		orderType: z.enum(["RIDE", "DELIVERY", "FOOD"]),
	}),
});
export type BadgeEvaluationJob = z.infer<typeof BadgeEvaluationJobSchema>;

/**
 * Coupon usage recording job - records coupon usage after order placement
 */
export const CouponUsageJobSchema = z.object({
	type: z.literal("COUPON_USAGE"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		couponId: z.string(),
		userId: z.string(),
		orderId: z.string(),
		discountAmount: z.coerce.number(),
	}),
});
export type CouponUsageJob = z.infer<typeof CouponUsageJobSchema>;

/**
 * Audit log job - records important events for compliance
 */
export const AuditLogJobSchema = z.object({
	type: z.literal("AUDIT_LOG"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		action: z.string(),
		entityType: z.string(),
		entityId: z.string(),
		actorId: z.string(),
		actorRole: z.string(),
		changes: z.record(z.string(), z.unknown()).optional(),
		ipAddress: z.string().optional(),
		userAgent: z.string().optional(),
	}),
});
export type AuditLogJob = z.infer<typeof AuditLogJobSchema>;

/**
 * Order status history job - records order state transitions
 */
export const OrderStatusHistoryJobSchema = z.object({
	type: z.literal("ORDER_STATUS_HISTORY"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		orderId: z.string(),
		fromStatus: z.string().nullable(),
		toStatus: z.string(),
		changedBy: z.string(),
		changedByRole: z.enum([
			"USER",
			"DRIVER",
			"MERCHANT",
			"OPERATOR",
			"ADMIN",
			"SYSTEM",
		]),
		reason: z.string().optional(),
	}),
});
export type OrderStatusHistoryJob = z.infer<typeof OrderStatusHistoryJobSchema>;

/**
 * Driver metrics update job - updates driver statistics
 */
export const DriverMetricsJobSchema = z.object({
	type: z.literal("DRIVER_METRICS"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		driverId: z.string(),
		orderId: z.string(),
		metricsType: z.enum([
			"ORDER_COMPLETED",
			"ORDER_CANCELLED",
			"RATING_RECEIVED",
			"NO_SHOW_REPORTED",
		]),
		value: z.coerce.number().optional(),
	}),
});
export type DriverMetricsJob = z.infer<typeof DriverMetricsJobSchema>;

/**
 * WebSocket broadcast job - broadcasts messages to connected clients
 * Used when queue worker needs to notify clients after processing
 *
 * Supports two message formats:
 * 1. Event-based (e field): { e: "COMPLETED", f: "s", t: "c", ... }
 * 2. Action-based (a field): { a: "MATCHING", f: "s", t: "s", ... }
 */
export const WebSocketBroadcastJobSchema = z.object({
	type: z.literal("WEBSOCKET_BROADCAST"),
	meta: QueueMessageMetaSchema,
	payload: z.object({
		/** Durable Object room name (orderId or "driver-pool") */
		roomName: z.string(),
		/**
		 * Event type to broadcast (for event-based messages)
		 * Used with 'e' field in WebSocket envelope
		 */
		event: z.string().optional(),
		/**
		 * Action type to broadcast (for action-based messages like MATCHING)
		 * Used with 'a' field in WebSocket envelope
		 */
		action: z.string().optional(),
		/** Target audience */
		target: z.enum(["USER", "DRIVER", "MERCHANT", "SYSTEM", "ALL"]).optional(),
		/** Message payload */
		data: z.record(z.string(), z.unknown()),
		/** User IDs to exclude from broadcast */
		excludeUserIds: z.array(z.string()).optional(),
	}),
});
export type WebSocketBroadcastJob = z.infer<typeof WebSocketBroadcastJobSchema>;

// ============================================================================
// Union Types for Queue Handlers
// ============================================================================

export const OrderQueueMessageSchema = z.discriminatedUnion("type", [
	DriverMatchingJobSchema,
	OrderTimeoutJobSchema,
	OrderCompletionJobSchema,
	RefundJobSchema,
	PaymentWebhookJobSchema,
]);
export type OrderQueueMessage = z.infer<typeof OrderQueueMessageSchema>;

export const NotificationQueueMessageSchema = z.union([
	PushNotificationJobSchema,
	BatchNotificationJobSchema,
]);
export type NotificationQueueMessage = z.infer<
	typeof NotificationQueueMessageSchema
>;

export const ProcessingQueueMessageSchema = z.discriminatedUnion("type", [
	BadgeEvaluationJobSchema,
	CouponUsageJobSchema,
	AuditLogJobSchema,
	OrderStatusHistoryJobSchema,
	DriverMetricsJobSchema,
	WebSocketBroadcastJobSchema,
]);
export type ProcessingQueueMessage = z.infer<
	typeof ProcessingQueueMessageSchema
>;

/** All possible queue messages */
export const QueueMessageSchema = z.discriminatedUnion("type", [
	// Order queue
	DriverMatchingJobSchema,
	OrderTimeoutJobSchema,
	OrderCompletionJobSchema,
	RefundJobSchema,
	PaymentWebhookJobSchema,
	// Notification queue
	PushNotificationJobSchema,
	BatchNotificationJobSchema,
	// Processing queue
	BadgeEvaluationJobSchema,
	CouponUsageJobSchema,
	AuditLogJobSchema,
	OrderStatusHistoryJobSchema,
	DriverMetricsJobSchema,
	WebSocketBroadcastJobSchema,
]);
export type QueueMessage = z.infer<typeof QueueMessageSchema>;

// ============================================================================
// Helper Types
// ============================================================================

export type QueueMessageType = QueueMessage["type"];

/** Extract payload type for a specific message type */
export type QueuePayload<T extends QueueMessageType> = Extract<
	QueueMessage,
	{ type: T }
>["payload"];

// ============================================================================
// Schema Registries for OpenAPI
// ============================================================================

export const QueueSchemaRegistries = {
	// QueueMessageMeta: { schema: QueueMessageMetaSchema, strategy: "output" },
	// DriverMatchingJob: { schema: DriverMatchingJobSchema, strategy: "output" },
	// OrderTimeoutJob: { schema: OrderTimeoutJobSchema, strategy: "output" },
	// OrderCompletionJob: { schema: OrderCompletionJobSchema, strategy: "output" },
	// RefundJob: { schema: RefundJobSchema, strategy: "output" },
	// PaymentWebhookJob: { schema: PaymentWebhookJobSchema, strategy: "output" },
	// PushNotificationJob: {
	// 	schema: PushNotificationJobSchema,
	// 	strategy: "output",
	// },
	// BatchNotificationJob: {
	// 	schema: BatchNotificationJobSchema,
	// 	strategy: "output",
	// },
	// BadgeEvaluationJob: { schema: BadgeEvaluationJobSchema, strategy: "output" },
	// CouponUsageJob: { schema: CouponUsageJobSchema, strategy: "output" },
	// AuditLogJob: { schema: AuditLogJobSchema, strategy: "output" },
	// OrderStatusHistoryJob: {
	// 	schema: OrderStatusHistoryJobSchema,
	// 	strategy: "output",
	// },
	// DriverMetricsJob: { schema: DriverMetricsJobSchema, strategy: "output" },
	// WebSocketBroadcastJob: {
	// 	schema: WebSocketBroadcastJobSchema,
	// 	strategy: "output",
	// },
	// QueueMessage: { schema: QueueMessageSchema, strategy: "output" },
} satisfies SchemaRegistries;

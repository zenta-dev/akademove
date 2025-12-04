import { env } from "cloudflare:workers";
import { PaginationResultSchema } from "@repo/schema/pagination";
import * as z from "zod";

export const FEATURE_TAGS = Object.freeze({
	ADMIN: "Admin",
	AUTH: "Auth",
	BADGE: "Badge",
	CHAT: "Chat",
	CONFIGURATION: "Configuration",
	CONTACT: "Contact",
	DRIVER: "Driver",
	EMERGENCY: "Emergency",
	LEADERBOARD: "Leaderboard",
	DRIVER_SCHEDULE: "DriverSchedule",
	NOTIFICATION: "Notification",
	MERCHANT: "Merchant",
	MERCHANT_MENU: "MerchantMenu",
	ORDER: "Order",
	PAYMENT: "Payment",
	COUPON: "Coupon",
	REPORT: "Report",
	REVIEW: "Review",
	TRANSACTION: "Transaction",
	USER: "User",
	wallet: "wallet",
} as const);

export const CACHE_TTLS = Object.freeze({
	"5m": 5 * 60,
	"1h": 1 * 3600,
	"24h": 24 * 3600,
	"7d": 7 * 24 * 3600,
} as const);

export const TRUSTED_ORIGINS = [env.AUTH_URL, env.CORS_ORIGIN];

export const STORAGE_BUCKETS = [
	"badges",
	"driver",
	"merchant",
	"merchant-priv",
	"user",
	"merchant-menu",
] as const;
export type StorageBucket = (typeof STORAGE_BUCKETS)[number];

export const CONFIGURATION_KEYS = {
	RIDE_SERVICE_PRICING: "ride-service-pricing",
	DELIVERY_SERVICE_PRICING: "delivery-service-pricing",
	FOOD_SERVICE_PRICING: "food-service-pricing",
	COMMISSION_RATES: "commission-rates",
} as const;
export const createSuccesSchema = <
	TSchema,
	TDesc extends string,
	TStatus extends number = 200 | 201 | 202,
>(
	schema: TSchema,
	description: TDesc,
	opts: { status: TStatus } = { status: 200 as TStatus },
) =>
	z.object({
		status: z.literal(opts.status).describe(description),
		body: z.object({
			message: z.string(),
			data: schema,
			pagination: PaginationResultSchema.optional(),
			totalPages: z.int().min(0).optional(),
		}),
	});

export const PAYMENT_EXPIRY_MINUTE = 15;

export const DRIVER_POOL_KEY = "driver-pool";

/**
 * Business Constants
 * These values define core business rules and should be configurable via admin panel
 */
export const BUSINESS_CONSTANTS = Object.freeze({
	// Order matching
	DRIVER_MATCHING_TIMEOUT_MS: 30_000, // 30 seconds
	DRIVER_MATCHING_RADIUS_KM: 5, // Initial radius in kilometers
	DRIVER_MATCHING_RADIUS_EXPANSION: 0.2, // Expand by 20% on timeout
	DRIVER_MAX_CANCELLATIONS_PER_DAY: 3,

	// Order pricing
	DEFAULT_TIP_PERCENTAGE: 0.1, // 10%
	MINIMUM_ORDER_VALUE: 5000, // IDR
	MAXIMUM_ORDER_VALUE: 1_000_000, // IDR

	// Commission rates (should be loaded from configuration)
	RIDE_COMMISSION_RATE: 0.15, // 15%
	DELIVERY_COMMISSION_RATE: 0.15, // 15%
	FOOD_COMMISSION_RATE: 0.2, // 20%
	MERCHANT_FOOD_COMMISSION_RATE: 0.1, // 10%

	// Cancellation fees
	USER_CANCELLATION_FEE_BEFORE_ACCEPT: 0, // 0%
	USER_CANCELLATION_FEE_AFTER_ACCEPT: 0.1, // 10%
	NO_SHOW_FEE: 0.5, // 50%

	// Location tracking
	LOCATION_UPDATE_INTERVAL_MS: 5000, // 5 seconds
	LOCATION_STALE_THRESHOLD_MS: 60_000, // 1 minute

	// Cache TTLs
	PRICING_CONFIG_CACHE_TTL_MS: 3_600_000, // 1 hour
	DRIVER_POOL_CACHE_TTL_MS: 300_000, // 5 minutes

	// Pagination
	DEFAULT_PAGE_SIZE: 20,
	MAX_PAGE_SIZE: 100,

	// Rating
	MINIMUM_RATING: 1,
	MAXIMUM_RATING: 5,
	DEFAULT_RATING: 5,

	// WebSocket
	WEBSOCKET_HEARTBEAT_INTERVAL_MS: 30_000, // 30 seconds
	WEBSOCKET_MESSAGE_MAX_SIZE: 65_536, // 64 KB

	// File Upload
	MAX_FILE_SIZE_MB: 5,
	ALLOWED_IMAGE_TYPES: ["image/jpeg", "image/png", "image/webp"] as const,
	ALLOWED_DOCUMENT_TYPES: [
		"application/pdf",
		"image/jpeg",
		"image/png",
	] as const,

	// Session
	JWT_EXPIRY_HOURS: 1,
	REFRESH_TOKEN_EXPIRY_DAYS: 30,
	SESSION_CACHE_TTL_SECONDS: 3600,

	// Rate Limiting
	RATE_LIMIT_WINDOW_MS: 60_000, // 1 minute
	RATE_LIMIT_MAX_REQUESTS: 100,
} as const);

/**
 * HTTP Status Codes
 */
export const HTTP_STATUS = Object.freeze({
	OK: 200,
	CREATED: 201,
	ACCEPTED: 202,
	NO_CONTENT: 204,
	BAD_REQUEST: 400,
	UNAUTHORIZED: 401,
	FORBIDDEN: 403,
	NOT_FOUND: 404,
	CONFLICT: 409,
	UNPROCESSABLE_ENTITY: 422,
	TOO_MANY_REQUESTS: 429,
	INTERNAL_SERVER_ERROR: 500,
	SERVICE_UNAVAILABLE: 503,
} as const);

/**
 * Error Messages
 */
export const ERROR_MESSAGES = Object.freeze({
	UNAUTHORIZED: "Unauthorized access",
	FORBIDDEN: "Access forbidden",
	NOT_FOUND: "Resource not found",
	INVALID_INPUT: "Invalid input data",
	INTERNAL_ERROR: "Internal server error",
	DRIVER_NOT_AVAILABLE: "No drivers available in your area",
	INSUFFICIENT_BALANCE: "Insufficient wallet balance",
	ORDER_ALREADY_ACCEPTED: "Order has already been accepted",
	ORDER_CANCELLED: "Order has been cancelled",
	INVALID_ORDER_STATUS: "Invalid order status transition",
} as const);

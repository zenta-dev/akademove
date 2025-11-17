import { env } from "cloudflare:workers";
import * as z from "zod";

export const FEATURE_TAGS = Object.freeze({
	ADMIN: "Admin",
	AUTH: "Auth",
	BADGE: "Badge",
	CONFIGURATION: "Configuration",
	DRIVER: "Driver",
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
	WALLET: "Wallet",
} as const);

export const CACHE_TTLS = Object.freeze({
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
			totalPages: z.int().optional(),
		}),
	});

export const PAYMENT_EXPIRY_MINUTE = 15;

export const DRIVER_POOL_KEY = "driver-pool";

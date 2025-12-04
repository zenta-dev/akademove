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

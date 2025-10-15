import { env } from "cloudflare:workers";
import * as z from "zod";

export const FEATURE_TAGS = Object.freeze({
	AUTH: "Auth",
	CONFIGURATION: "Configuration",
	DRIVER: "Driver",
	MERCHANT: "Merchant",
	MERCHANT_MENU: "MerchantMenu",
	ORDER: "Order",
	SCHEDULE: "Schedule",
	COUPON: "Coupon",
	REPORT: "Report",
	REVIEW: "Review",
	USER: "User",
} as const);

export const CACHE_TTLS = Object.freeze({
	"1h": 1 * 3600,
	"24h": 24 * 3600,
} as const);

export const CACHE_PREFIXES = Object.freeze({
	AUTH: `${FEATURE_TAGS.AUTH.toLowerCase()}:`,
	CONFIGURATION: `${FEATURE_TAGS.CONFIGURATION.toLowerCase()}:`,
	DRIVER: `${FEATURE_TAGS.DRIVER.toLowerCase()}:`,
	MERCHANT: `${FEATURE_TAGS.MERCHANT.toLowerCase()}:`,
	MERCHANT_MENU: `${FEATURE_TAGS.MERCHANT_MENU.toLowerCase()}:`,
	ORDER: `${FEATURE_TAGS.ORDER.toLowerCase()}:`,
	SCHEDULE: `${FEATURE_TAGS.SCHEDULE.toLowerCase()}:`,
	COUPON: `${FEATURE_TAGS.COUPON.toLowerCase()}:`,
	REPORT: `${FEATURE_TAGS.REPORT.toLowerCase()}:`,
	REVIEW: `${FEATURE_TAGS.REVIEW.toLowerCase()}:`,
	USER: `${FEATURE_TAGS.USER.toLowerCase()}:`,
} as const);
export const TRUSTED_ORIGINS = [env.AUTH_URL, env.CORS_ORIGIN];

export const STORAGE_BUCKETS = [
	"driver",
	"merchant",
	"user",
	"merchant-menu",
] as const;
export type StorageBucket = (typeof STORAGE_BUCKETS)[number];

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
			totalPages: z.number().optional(),
		}),
	});

import { env } from "cloudflare:workers";
import * as z from "zod";

export const FEATURE_TAGS = Object.freeze({
	CONFIGURATION: "Configuration",
	DRIVER: "Driver",
	MERCHANT: "Merchant",
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
	CONFIGURATION: `${FEATURE_TAGS.CONFIGURATION.toLowerCase()}:`,
	DRIVER: `${FEATURE_TAGS.DRIVER.toLowerCase()}:`,
	MERCHANT: `${FEATURE_TAGS.MERCHANT.toLowerCase()}:`,
	ORDER: `${FEATURE_TAGS.ORDER.toLowerCase()}:`,
	SCHEDULE: `${FEATURE_TAGS.SCHEDULE.toLowerCase()}:`,
	COUPON: `${FEATURE_TAGS.COUPON.toLowerCase()}:`,
	REPORT: `${FEATURE_TAGS.REPORT.toLowerCase()}:`,
	REVIEW: `${FEATURE_TAGS.REVIEW.toLowerCase()}:`,
	USER: `${FEATURE_TAGS.USER.toLowerCase()}:`,
} as const);
export const TRUSTED_ORIGINS = [env.AUTH_URL, env.CORS_ORIGIN];

export const createSuccesSchema = <TSchema, TDesc extends string>(
	schema: TSchema,
	description: TDesc,
) =>
	z.object({
		status: z.literal(200).describe(description),
		body: z.object({
			message: z.string(),
			data: schema,
		}),
	});

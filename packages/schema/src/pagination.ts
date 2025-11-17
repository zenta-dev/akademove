import * as z from "zod";
import { ConfigurationKeySchema } from "./configuration.ts";
import { CouponKeySchema } from "./coupon.ts";
import { DriverKeySchema, DriverScheduleKeySchema } from "./driver.ts";
import { mergeEnums } from "./enum.helper.ts";
import { MerchantKeySchema, MerchantMenuKeySchema } from "./merchant.ts";
import { OrderKeySchema } from "./order.ts";
import { PaymentKeySchema } from "./payment.ts";
import { ReportKeySchema } from "./report.ts";
import { ReviewKeySchema } from "./review.ts";
import { TransactionKeySchema } from "./transaction.ts";
import { UserKeySchema } from "./user.ts";
import { WalletKeySchema } from "./wallet.ts";

const MAX_LIMIT = 100;

export const OffsetPaginationQuerySchema = z.object({
	page: z
		.preprocess((v) => {
			if (v === undefined || v === null || v === "") return 1;
			const n = Number(v);
			return Number.isFinite(n) ? Math.floor(n) : Number.NaN;
		}, z.number().int().min(1).optional().default(1))
		.optional(),
	limit: z.preprocess((v) => {
		if (v === undefined || v === null || v === "") return 10;
		const n = Number(v);
		return Number.isFinite(n) ? Math.floor(n) : Number.NaN;
	}, z.number().int().min(1).max(MAX_LIMIT).optional().default(10)),
});
export type OffsetPaginationQuery = z.infer<typeof OffsetPaginationQuerySchema>;

export const CursorPaginationQuerySchema = z.object({
	cursor: z.string().optional(),
	limit: z.preprocess((v) => {
		if (v === undefined || v === null || v === "") return 10;
		const n = Number(v);
		return Number.isFinite(n) ? Math.floor(n) : Number.NaN;
	}, z.number().int().min(1).max(MAX_LIMIT).optional().default(10)),
});
export type CursorPaginationQuery = z.infer<typeof CursorPaginationQuerySchema>;

export const SortBySchema = mergeEnums(
	ConfigurationKeySchema,
	CouponKeySchema,
	DriverKeySchema,
	DriverScheduleKeySchema,
	MerchantKeySchema,
	MerchantMenuKeySchema,
	OrderKeySchema,
	PaymentKeySchema,
	ReportKeySchema,
	ReviewKeySchema,
	TransactionKeySchema,
	UserKeySchema,
	WalletKeySchema,
);
export const UnifiedPaginationQuerySchema = z
	.object({
		...CursorPaginationQuerySchema.shape,
		...OffsetPaginationQuerySchema.shape,
		query: z.string().optional(),
		sortBy: SortBySchema.optional(),
		order: z.enum(["asc", "desc"]).optional().default("desc"),
	})
	.refine((data) => !(data.cursor && data.page), {
		message: "Cannot use both cursor and page at the same time.",
	});
export type UnifiedPaginationQuery = z.infer<
	typeof UnifiedPaginationQuerySchema
>;

export const PaginationSchemaRegistries = {};

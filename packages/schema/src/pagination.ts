import * as z from "zod";
import type { SchemaRegistries } from "./common.js";
import { ConfigurationKeySchema } from "./configuration.js";
import { CouponKeySchema } from "./coupon.js";
import { DriverKeySchema, DriverScheduleKeySchema } from "./driver.js";
import { mergeEnums } from "./enum.helper.js";
import { MerchantKeySchema, MerchantMenuKeySchema } from "./merchant.js";
import { OrderKeySchema } from "./order.js";
import { PaymentKeySchema } from "./payment.js";
import { ReportKeySchema } from "./report.js";
import { ReviewKeySchema } from "./review.js";
import { TransactionKeySchema } from "./transaction.js";
import { UserKeySchema } from "./user.js";
import { WalletKeySchema } from "./wallet.js";

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
	direction: z.enum(["next", "prev"]).optional(),
});
export type CursorPaginationQuery = z.infer<typeof CursorPaginationQuerySchema>;

export const PaginationResultSchema = z
	.object({
		// offset based
		totalPages: z.int().min(0).describe("offset"),

		// cursor based
		nextCursor: z.string().describe("cursor"),
		hasMore: z.boolean().describe("cursor"),
	})
	.refine((data) => !(data.totalPages && data.nextCursor), {
		message: "Cannot use both cursor and page at the same time.",
	})
	.partial();
export type PaginationResult = z.infer<typeof PaginationResultSchema>;

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

export const PaginationOrderSchema = z.enum(["asc", "desc"]);
export const PaginationModeSchema = z.enum(["offset", "cursor"]);

export const UnifiedPaginationQuerySchema = z
	.object({
		...CursorPaginationQuerySchema.shape,
		...OffsetPaginationQuerySchema.shape,
		query: z.string().optional(),
		sortBy: SortBySchema.optional(),
		order: PaginationOrderSchema.optional().default("desc"),
		mode: PaginationModeSchema.optional().default("offset"),
	})
	.refine((data) => !(data.cursor && data.page), {
		message: "Cannot use both cursor and page at the same time.",
	});
export type UnifiedPaginationQuery = z.infer<
	typeof UnifiedPaginationQuerySchema
>;

export const PaginationSchemaRegistries = {
	PaginationOrder: { schema: PaginationOrderSchema, strategy: "output" },
	PaginationMode: { schema: PaginationModeSchema, strategy: "output" },
	PaginationResult: { schema: PaginationResultSchema, strategy: "output" },
} satisfies SchemaRegistries;

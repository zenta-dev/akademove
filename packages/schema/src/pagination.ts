import * as z from "zod";

const MAX_LIMIT = 100;

export const OffsetPaginationQuerySchema = z.object({
	page: z.preprocess((v) => {
		if (v === undefined || v === null || v === "") return 1;
		const n = Number(v);
		return Number.isFinite(n) ? Math.floor(n) : Number.NaN;
	}, z.number().int().min(1).default(1)),
	limit: z.preprocess((v) => {
		if (v === undefined || v === null || v === "") return 10;
		const n = Number(v);
		return Number.isFinite(n) ? Math.floor(n) : Number.NaN;
	}, z.number().int().min(1).max(MAX_LIMIT).default(10)),
});

export const CursorPaginationQuerySchema = z.object({
	cursor: z.string().optional(),
	limit: z.preprocess((v) => {
		if (v === undefined || v === null || v === "") return 10;
		const n = Number(v);
		return Number.isFinite(n) ? Math.floor(n) : Number.NaN;
	}, z.number().int().min(1).max(MAX_LIMIT).default(10)),
});

export const UnifiedPaginationQuerySchema = z
	.object({
		cursor: z.string().optional(),
		page: z
			.preprocess(
				(v) => (v ? Number(v) : undefined),
				z.number().int().min(1).optional(),
			)
			.optional(),
		limit: z
			.preprocess(
				(v) => (v === undefined || v === "" ? 10 : Number(v)),
				z.number().int().min(1).max(MAX_LIMIT).default(10),
			)
			.optional()
			.default(10),
	})
	.refine((data) => !(data.cursor && data.page), {
		message: "Cannot use both cursor and page at the same time.",
	});

export type OffsetPaginationQuery = z.infer<typeof OffsetPaginationQuerySchema>;
export type CursorPaginationQuery = z.infer<typeof CursorPaginationQuerySchema>;
export type UnifiedPaginationQuery = z.infer<
	typeof UnifiedPaginationQuerySchema
>;

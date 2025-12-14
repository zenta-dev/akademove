import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { CONSTANTS } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const ReviewCategorySchema = z.enum(CONSTANTS.REVIEW_CATEGORIES);
export type ReviewCategory = z.infer<typeof ReviewCategorySchema>;

export const ReviewSchema = z.object({
	id: z.uuid(),
	orderId: z.uuid(),
	fromUserId: z.string(),
	toUserId: z.string(),
	/** Multi-select categories (e.g., ["CLEANLINESS", "PUNCTUALITY", "SAFETY"]) */
	categories: z.array(ReviewCategorySchema).min(1),
	/** Overall rating score for the entire review (1-5) */
	score: z.number().int().min(1).max(5),
	/** Optional comment/notes about the review */
	comment: z.string().default(""),
	createdAt: DateSchema,
});
export type Review = z.infer<typeof ReviewSchema>;

export const ReviewKeySchema = extractSchemaKeysAsEnum(ReviewSchema);

export const InsertReviewSchema = ReviewSchema.omit({
	id: true,
	createdAt: true,
});
export type InsertReview = z.infer<typeof InsertReviewSchema>;

export const UpdateReviewSchema = ReviewSchema.omit({
	id: true,
	createdAt: true,
	orderId: true,
	fromUserId: true,
	toUserId: true,
}).partial();
export type UpdateReview = z.infer<typeof UpdateReviewSchema>;

export const ReviewSchemaRegistries = {
	ReviewCategory: { schema: ReviewCategorySchema, strategy: "output" },
	Review: { schema: ReviewSchema, strategy: "output" },
	InsertReview: { schema: InsertReviewSchema, strategy: "input" },
	UpdateReview: { schema: UpdateReviewSchema, strategy: "input" },
	ReviewKeySchema: { schema: ReviewKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

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
	category: ReviewCategorySchema,
	score: z.number(),
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
}).partial();
export type UpdateReview = z.infer<typeof UpdateReviewSchema>;

export const ReviewSchemaRegistries = {
	ReviewCategory: { schema: ReviewCategorySchema, strategy: "output" },
	Review: { schema: ReviewSchema, strategy: "output" },
	InsertReview: { schema: InsertReviewSchema, strategy: "input" },
	UpdateReview: { schema: UpdateReviewSchema, strategy: "input" },
	ReviewKeySchema: { schema: ReviewKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

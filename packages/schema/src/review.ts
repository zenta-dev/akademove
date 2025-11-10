import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.ts";
import { CONSTANTS } from "./constants.ts";
import { extractSchemaKeysAsEnum } from "./enum.helper.ts";

export const ReviewCategorySchema = z
	.enum(CONSTANTS.REVIEW_CATEGORIES)
	.meta({ title: "ReviewCategory" });

export const ReviewSchema = z
	.object({
		id: z.uuid(),
		orderId: z.uuid(),
		fromUserId: z.string(),
		toUserId: z.string(),
		category: ReviewCategorySchema,
		score: z.number(),
		comment: z.string().default(""),
		createdAt: DateSchema,
	})
	.meta({ title: "Review" });

export const ReviewKeySchema = extractSchemaKeysAsEnum(ReviewSchema);

export const InsertReviewSchema = ReviewSchema.omit({
	id: true,
	createdAt: true,
}).meta({ title: "InsertReviewRequest" });

export const UpdateReviewSchema = ReviewSchema.omit({
	id: true,
	createdAt: true,
})
	.partial()
	.meta({ title: "UpdateReviewRequest" });

export type ReviewCategory = z.infer<typeof ReviewCategorySchema>;
export type Review = z.infer<typeof ReviewSchema>;
export type InsertReview = z.infer<typeof InsertReviewSchema>;
export type UpdateReview = z.infer<typeof UpdateReviewSchema>;

export const ReviewSchemaRegistries = {
	ReviewCategory: { schema: ReviewCategorySchema, strategy: "output" },
	Review: { schema: ReviewSchema, strategy: "output" },
	InsertReview: { schema: InsertReviewSchema, strategy: "input" },
	UpdateReview: { schema: UpdateReviewSchema, strategy: "input" },
	ReviewKeySchema: { schema: ReviewKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

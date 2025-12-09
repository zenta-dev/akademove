import * as z from "zod";
import type { SchemaRegistries } from "./common.js";
import { DateSchema } from "./common.js";
import {
	DRIVER_QUIZ_QUESTION_CATEGORIES,
	DRIVER_QUIZ_QUESTION_TYPES,
} from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";
import { UnifiedPaginationQuerySchema } from "./pagination.js";

export const DriverQuizQuestionTypeSchema = z.enum(DRIVER_QUIZ_QUESTION_TYPES);
export type DriverQuizQuestionType = z.infer<
	typeof DriverQuizQuestionTypeSchema
>;

export const DriverQuizQuestionCategorySchema = z.enum(
	DRIVER_QUIZ_QUESTION_CATEGORIES,
);
export type DriverQuizQuestionCategory = z.infer<
	typeof DriverQuizQuestionCategorySchema
>;

export const DriverQuizQuestionOptionSchema = z.object({
	id: z.string(),
	text: z.string().min(1),
	isCorrect: z.boolean(),
});
export type DriverQuizQuestionOption = z.infer<
	typeof DriverQuizQuestionOptionSchema
>;

export const DriverQuizQuestionSchema = z.object({
	id: z.string(),
	question: z.string().min(1).max(1000),
	type: DriverQuizQuestionTypeSchema,
	category: DriverQuizQuestionCategorySchema,
	options: z.array(DriverQuizQuestionOptionSchema).min(2).max(6),
	explanation: z.string().max(2000).nullable(),
	points: z.number().int().min(1).max(1000).default(10),
	isActive: z.boolean().default(true),
	displayOrder: z.number().int().default(0),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type DriverQuizQuestion = z.infer<typeof DriverQuizQuestionSchema>;

export const DriverMinQuizQuestionSchema = z.object({
	id: z.string(),
	question: z.string(),
	type: z.string(),
	category: z.string(),
	points: z.number(),
	displayOrder: z.number(),
	options: z.array(
		z.object({
			id: z.string(),
			text: z.string(),
		}),
	),
});
export type DriverMinQuizQuestion = z.infer<typeof DriverMinQuizQuestionSchema>;

export const DriverQuizQuestionKeySchema = extractSchemaKeysAsEnum(
	DriverQuizQuestionSchema,
);

export const InsertDriverQuizQuestionSchema = DriverQuizQuestionSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
});
export type InsertDriverQuizQuestion = z.infer<
	typeof InsertDriverQuizQuestionSchema
>;

export const UpdateDriverQuizQuestionSchema =
	InsertDriverQuizQuestionSchema.partial();
export type UpdateDriverQuizQuestion = z.infer<
	typeof UpdateDriverQuizQuestionSchema
>;

export const ListDriverQuizQuestionQuerySchema =
	UnifiedPaginationQuerySchema.safeExtend({
		category: DriverQuizQuestionCategorySchema.optional(),
		type: DriverQuizQuestionTypeSchema.optional(),
		isActive: z.boolean().optional(),
	});
export type ListDriverQuizQuestionQuery = z.infer<
	typeof ListDriverQuizQuestionQuerySchema
>;

export const DriverQuizQuestionSchemaRegistries = {
	DriverQuizQuestionType: {
		schema: DriverQuizQuestionTypeSchema,
		strategy: "output",
	},
	DriverQuizQuestionCategory: {
		schema: DriverQuizQuestionCategorySchema,
		strategy: "output",
	},
	DriverQuizQuestionOption: {
		schema: DriverQuizQuestionOptionSchema,
		strategy: "output",
	},
	DriverQuizQuestion: {
		schema: DriverQuizQuestionSchema,
		strategy: "output",
	},
	InsertDriverQuizQuestion: {
		schema: InsertDriverQuizQuestionSchema,
		strategy: "input",
	},
	UpdateDriverQuizQuestion: {
		schema: UpdateDriverQuizQuestionSchema,
		strategy: "input",
	},
	ListDriverQuizQuestionQuery: {
		schema: ListDriverQuizQuestionQuerySchema,
		strategy: "input",
	},
	DriverMinQuizQuestion: {
		schema: DriverMinQuizQuestionSchema,
		strategy: "output",
	},
} satisfies SchemaRegistries;

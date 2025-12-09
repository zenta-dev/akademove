import * as z from "zod";
import type { SchemaRegistries } from "./common.js";
import { DateSchema } from "./common.js";
import {
	DRIVER_QUIZ_ANSWER_STATUSES,
	DRIVER_QUIZ_QUESTION_CATEGORIES,
} from "./constants.js";
import { DriverMinQuizQuestionSchema } from "./driver-quiz-question.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const DriverQuizAnswerStatusSchema = z.enum(DRIVER_QUIZ_ANSWER_STATUSES);
export type DriverQuizAnswerStatus = z.infer<
	typeof DriverQuizAnswerStatusSchema
>;

export const DriverQuizAttemptSchema = z.object({
	attemptId: z.string(),
	questions: z.array(DriverMinQuizQuestionSchema),
	totalQuestions: z.number(),
	totalPoints: z.number(),
	passingScore: z.number(),
});
export type DriverQuizAttempt = z.infer<typeof DriverQuizAttemptSchema>;

/**
 * Individual answer to a quiz question
 */
export const DriverQuizQuestionAnswerSchema = z.object({
	questionId: z.string(),
	selectedOptionId: z.string(),
	isCorrect: z.boolean(),
	pointsEarned: z.number().int().min(0),
	answeredAt: DateSchema,
});
export type DriverQuizQuestionAnswer = z.infer<
	typeof DriverQuizQuestionAnswerSchema
>;

/**
 * Driver Quiz Answer (Quiz Attempt) Schema
 * Tracks a driver's quiz attempt including all answers
 */
export const DriverQuizAnswerSchema = z.object({
	id: z.string(),
	driverId: z.uuid(),
	status: DriverQuizAnswerStatusSchema,
	totalQuestions: z.number().int().min(1),
	correctAnswers: z.number().int().min(0),
	totalPoints: z.number().int().min(0),
	earnedPoints: z.number().int().min(0),
	passingScore: z.number().int().min(0).max(1000).default(70),
	scorePercentage: z.number().min(0).max(1000),
	answers: z.array(DriverQuizQuestionAnswerSchema),
	startedAt: DateSchema,
	completedAt: DateSchema.nullable(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type DriverQuizAnswer = z.infer<typeof DriverQuizAnswerSchema>;

export const DriverQuizAnswerKeySchema = extractSchemaKeysAsEnum(
	DriverQuizAnswerSchema,
);

/**
 * Schema for starting a new quiz attempt
 */
export const StartDriverQuizSchema = z.object({
	questionIds: z.array(z.string()).min(1).max(50).optional(),
	category: z.enum(DRIVER_QUIZ_QUESTION_CATEGORIES).optional(),
});
export type StartDriverQuiz = z.infer<typeof StartDriverQuizSchema>;

/**
 * Schema for submitting an answer to a question
 */
export const SubmitDriverQuizAnswerSchema = z.object({
	attemptId: z.string(),
	questionId: z.string(),
	selectedOptionId: z.string(),
});
export type SubmitDriverQuizAnswer = z.infer<
	typeof SubmitDriverQuizAnswerSchema
>;

export const SubmitDriverQuizAnswerResponseSchema = z.object({
	isCorrect: z.boolean(),
	pointsEarned: z.number(),
	correctOptionId: z.string().optional(),
	explanation: z.string().nullable(),
});

/**
 * Schema for completing a quiz attempt
 */
export const CompleteDriverQuizSchema = z.object({
	attemptId: z.string(),
});
export type CompleteDriverQuiz = z.infer<typeof CompleteDriverQuizSchema>;

/**
 * Schema for listing driver quiz answers (quiz attempts)
 */
export const ListDriverQuizAnswerQuerySchema = z.object({
	driverId: z.string().optional(),
	status: DriverQuizAnswerStatusSchema.optional(),
	page: z.coerce.number().int().min(1).optional(),
	limit: z.coerce.number().int().min(1).max(1000).optional(),
});
export type ListDriverQuizAnswerQuery = z.infer<
	typeof ListDriverQuizAnswerQuerySchema
>;

/**
 * Quiz result summary
 */
export const DriverQuizResultSchema = z.object({
	attemptId: z.string(),
	status: DriverQuizAnswerStatusSchema,
	totalQuestions: z.number().int(),
	correctAnswers: z.number().int(),
	scorePercentage: z.number(),
	passed: z.boolean(),
	earnedPoints: z.number().int(),
	totalPoints: z.number().int(),
	completedAt: DateSchema.nullable(),
});
export type DriverQuizResult = z.infer<typeof DriverQuizResultSchema>;

export const DriverQuizAnswerSchemaRegistries = {
	DriverQuizAttempt: {
		schema: DriverQuizAttemptSchema,
		strategy: "output",
	},
	DriverQuizAnswerStatus: {
		schema: DriverQuizAnswerStatusSchema,
		strategy: "output",
	},
	DriverQuizQuestionAnswer: {
		schema: DriverQuizQuestionAnswerSchema,
		strategy: "output",
	},
	DriverQuizAnswer: {
		schema: DriverQuizAnswerSchema,
		strategy: "output",
	},
	StartDriverQuiz: {
		schema: StartDriverQuizSchema,
		strategy: "input",
	},
	SubmitDriverQuizAnswer: {
		schema: SubmitDriverQuizAnswerSchema,
		strategy: "input",
	},
	SubmitDriverQuizAnswerResponse: {
		schema: SubmitDriverQuizAnswerResponseSchema,
		strategy: "output",
	},
	CompleteDriverQuiz: {
		schema: CompleteDriverQuizSchema,
		strategy: "input",
	},
	ListDriverQuizAnswerQuery: {
		schema: ListDriverQuizAnswerQuerySchema,
		strategy: "input",
	},
	DriverQuizResult: {
		schema: DriverQuizResultSchema,
		strategy: "output",
	},
} satisfies SchemaRegistries;

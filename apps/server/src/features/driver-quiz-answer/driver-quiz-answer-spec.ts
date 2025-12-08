import { oc } from "@orpc/contract";
import {
	CompleteDriverQuizSchema,
	DriverQuizAnswerSchema,
	DriverQuizAttemptSchema,
	DriverQuizResultSchema,
	ListDriverQuizAnswerQuerySchema,
	StartDriverQuizSchema,
	SubmitDriverQuizAnswerResponseSchema,
	SubmitDriverQuizAnswerSchema,
} from "@repo/schema/driver-quiz-answer";
import * as z from "zod/v4";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const DriverQuizAnswerSpec = {
	// Start a new quiz attempt
	startQuiz: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_ANSWER],
			method: "POST",
			path: "/start",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: StartDriverQuizSchema }))
		.output(
			z.union([
				createSuccesSchema(
					DriverQuizAttemptSchema,
					"Quiz started successfully",
					{ status: 201 },
				),
			]),
		),

	// Submit an answer to a question
	submitAnswer: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_ANSWER],
			method: "POST",
			path: "/answer",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: SubmitDriverQuizAnswerSchema }))
		.output(
			z.union([
				createSuccesSchema(
					SubmitDriverQuizAnswerResponseSchema,
					"Answer submitted successfully",
				),
			]),
		),

	// Complete a quiz attempt
	completeQuiz: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_ANSWER],
			method: "POST",
			path: "/complete",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: CompleteDriverQuizSchema }))
		.output(
			z.union([
				createSuccesSchema(
					DriverQuizResultSchema,
					"Quiz completed successfully",
				),
			]),
		),

	// Get current quiz attempt status
	getAttempt: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_ANSWER],
			method: "GET",
			path: "/{attemptId}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ attemptId: z.string() }) }))
		.output(
			z.union([
				createSuccesSchema(
					DriverQuizAnswerSchema,
					"Quiz attempt retrieved successfully",
				),
			]),
		),

	// Get quiz result
	getResult: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_ANSWER],
			method: "GET",
			path: "/{attemptId}/result",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ attemptId: z.string() }) }))
		.output(
			z.union([
				createSuccesSchema(
					DriverQuizResultSchema,
					"Quiz result retrieved successfully",
				),
			]),
		),

	// List quiz attempts (for admin or driver viewing their own)
	list: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_ANSWER],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: ListDriverQuizAnswerQuerySchema }))
		.output(
			z.union([
				createSuccesSchema(
					z.object({
						rows: z.array(DriverQuizAnswerSchema),
					}),
					"Quiz attempts retrieved successfully",
				),
			]),
		),

	// Get my latest quiz attempt/status (for driver to check their quiz status)
	getMyLatestAttempt: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_ANSWER],
			method: "GET",
			path: "/me/latest",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({}))
		.output(
			z.union([
				createSuccesSchema(
					DriverQuizAnswerSchema.nullable(),
					"Latest quiz attempt retrieved successfully",
				),
			]),
		),
};

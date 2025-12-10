import { oc } from "@orpc/contract";
import {
	DriverQuizQuestionSchema,
	InsertDriverQuizQuestionSchema,
	ListDriverQuizQuestionQuerySchema,
	UpdateDriverQuizQuestionSchema,
} from "@repo/schema/driver-quiz-question";
import * as z from "zod/v4";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const DriverQuizQuestionSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_QUESTION],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: ListDriverQuizQuestionQuerySchema }))
		.output(
			z.union([
				createSuccesSchema(
					z.object({
						rows: z.array(DriverQuizQuestionSchema),
					}),
					"Driver quiz questions retrieved successfully",
				),
			]),
		),

	get: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_QUESTION],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			z.union([
				createSuccesSchema(
					DriverQuizQuestionSchema,
					"Driver quiz question retrieved successfully",
				),
			]),
		),

	create: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_QUESTION],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertDriverQuizQuestionSchema }))
		.output(
			z.union([
				createSuccesSchema(
					DriverQuizQuestionSchema,
					"Driver quiz question created successfully",
					{ status: 201 },
				),
			]),
		),

	update: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_QUESTION],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateDriverQuizQuestionSchema,
			}),
		)
		.output(
			z.union([
				createSuccesSchema(
					DriverQuizQuestionSchema,
					"Driver quiz question updated successfully",
				),
			]),
		),

	remove: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_QUESTION],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			z.union([
				createSuccesSchema(
					z.null(),
					"Driver quiz question deleted successfully",
				),
			]),
		),

	// Public endpoint to get questions for quiz taking (hides correct answers)
	getQuizQuestions: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER_QUIZ_QUESTION],
			method: "GET",
			path: "/quiz",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				query: z.object({
					category: z.string().optional(),
					limit: z.coerce.number().int().min(1).max(50).optional(),
				}),
			}),
		)
		.output(
			z.union([
				createSuccesSchema(
					z.array(
						z.object({
							id: z.string(),
							question: z.string(),
							type: z.string(),
							category: z.string(),
							points: z.coerce.number(),
							displayOrder: z.coerce.number(),
							options: z.array(
								z.object({
									id: z.string(),
									text: z.string(),
								}),
							),
						}),
					),
					"Quiz questions retrieved successfully",
				),
			]),
		),
};

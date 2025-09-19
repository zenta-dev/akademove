import { oc } from "@orpc/contract";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import {
	InsertReviewSchema,
	ReviewSchema,
	UpdateReviewSchema,
} from "@repo/schema/review";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const ReviewSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.REVIEW],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(ReviewSchema),
				"Successfully retrieved reviews data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.REVIEW],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(ReviewSchema, "Successfully retrieved review data"),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.REVIEW],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertReviewSchema }))
		.output(createSuccesSchema(ReviewSchema, "Review created successfully")),
	update: oc
		.route({
			tags: [FEATURE_TAGS.REVIEW],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateReviewSchema,
			}),
		)
		.output(createSuccesSchema(ReviewSchema, "Review updated successfully")),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.REVIEW],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Review deleted successfully")),
};

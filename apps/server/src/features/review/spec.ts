import {
	createSuccessResponseSchema,
	EmptySchema,
	listifySchema,
} from "@repo/schema/common";
import { ReviewSchema } from "@repo/schema/review";
import { describeRoute, resolver } from "hono-openapi";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const ReviewSpec = Object.freeze({
	list: describeRoute({
		tags: [FEATURE_TAGS.REVIEW],
		responses: {
			200: {
				description: "List of review",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(ReviewSchema)),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REVIEW),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		tags: [FEATURE_TAGS.REVIEW],
		responses: {
			200: {
				description: "Get review by id success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(ReviewSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REVIEW),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		tags: [FEATURE_TAGS.REVIEW],
		responses: {
			200: {
				description: "Create review success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(ReviewSchema)),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		tags: [FEATURE_TAGS.REVIEW],
		responses: {
			200: {
				description: "Update review success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(ReviewSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REVIEW),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		tags: [FEATURE_TAGS.REVIEW],
		responses: {
			200: {
				description: "Delete review success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(EmptySchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REVIEW),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

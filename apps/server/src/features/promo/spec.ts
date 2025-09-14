import {
	createSuccessResponseSchema,
	EmptySchema,
	listifySchema,
} from "@repo/schema/common";
import { PromoSchema } from "@repo/schema/promo";
import { describeRoute, resolver } from "hono-openapi";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const PromoSpec = Object.freeze({
	list: describeRoute({
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "List of promo",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(PromoSchema)),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.PROMO),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "Get promo by id success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(PromoSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.PROMO),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "Create promo success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(PromoSchema)),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "Update promo success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(PromoSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.PROMO),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "Delete promo success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(EmptySchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.PROMO),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

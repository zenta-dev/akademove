import {
	createSuccessResponseSchema,
	EmptySchema,
	listifySchema,
} from "@repo/schema/common";
import { OrderSchema } from "@repo/schema/order";
import { describeRoute, resolver } from "hono-openapi";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const OrderSpec = Object.freeze({
	list: describeRoute({
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "List of order",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(OrderSchema)),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.ORDER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "Get order by id success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(OrderSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.ORDER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "Create order success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(OrderSchema)),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "Update order success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(OrderSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.ORDER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "Delete order success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(EmptySchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.ORDER),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

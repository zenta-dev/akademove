import { createSuccessResponseSchema, EmptySchema } from "@repo/schema/common";
import { MerchantSchema } from "@repo/schema/merchant";
import { describeRoute, resolver } from "hono-openapi";
import z from "zod";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const MerchantSpec = Object.freeze({
	list: describeRoute({
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "List of merchant",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(z.array(MerchantSchema)),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"]("Merchant"),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "Get merchant by id success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(MerchantSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"]("Merchant"),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "Create merchant success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(MerchantSchema)),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "Update merchant success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(MerchantSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"]("Merchant"),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "Delete merchant success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(EmptySchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"]("Merchant"),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

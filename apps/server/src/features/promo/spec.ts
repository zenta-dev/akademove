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
		operationId: "getAllPromo",
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "List of promo",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(PromoSchema)).meta({
								title: "GetAllPromoSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.PROMO),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		operationId: "getPromoById",
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "Get promo by id success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(PromoSchema).meta({
								title: "GetPromoByIdSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.PROMO),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		operationId: "createPromo",
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "Create promo success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(PromoSchema).meta({
								title: "CreatePromoSuccessResponse",
							}),
						),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		operationId: "updatePromo",
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "Update promo success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(PromoSchema).meta({
								title: "UpdatePromoSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.PROMO),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		operationId: "deletePromo",
		tags: [FEATURE_TAGS.PROMO],
		responses: {
			200: {
				description: "Delete promo success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(EmptySchema).meta({
								title: "DeletePromoSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.PROMO),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

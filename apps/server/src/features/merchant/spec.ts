import {
	createSuccessResponseSchema,
	EmptySchema,
	listifySchema,
} from "@repo/schema/common";
import { MerchantSchema } from "@repo/schema/merchant";
import { describeRoute, resolver } from "hono-openapi";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const MerchantSpec = Object.freeze({
	list: describeRoute({
		operationId: "getAllMerchant",
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "List of merchant",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(MerchantSchema)).meta({
								title: "GetAllMerchantSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.MERCHANT),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		operationId: "getMerchantById",
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "Get merchant by id success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(MerchantSchema).meta({
								title: "GetMerchantByIdSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.MERCHANT),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		operationId: "createMerchant",
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "Create merchant success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(MerchantSchema).meta({
								title: "CreateMerchantSuccessResponse",
							}),
						),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		operationId: "updateMerchant",
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "Update merchant success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(MerchantSchema).meta({
								title: "UpdateMerchantSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.MERCHANT),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		operationId: "deleteMerchant",
		tags: [FEATURE_TAGS.MERCHANT],
		responses: {
			200: {
				description: "Delete merchant success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(EmptySchema).meta({
								title: "DeleteMerchantSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.MERCHANT),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

import {
	createSuccessResponseSchema,
	EmptySchema,
	listifySchema,
} from "@repo/schema/common";
import { DriverSchema } from "@repo/schema/driver";
import { describeRoute, resolver } from "hono-openapi";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const DriverSpec = Object.freeze({
	list: describeRoute({
		operationId: "getAllDriver",
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "List of driver",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(DriverSchema)).meta({
								title: "GetAllDriverSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.DRIVER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		operationId: "getDriverById",
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "Get driver by id success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(DriverSchema).meta({
								title: "GetDriverByIdSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.DRIVER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		operationId: "createDriver",
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "Create driver success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(DriverSchema).meta({
								title: "CreateDriverSuccessResponse",
							}),
						),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		operationId: "updateDriver",
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "Update driver success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(DriverSchema).meta({
								title: "UpdateDriverSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.DRIVER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		operationId: "deleteDriver",
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "Delete driver success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(EmptySchema).meta({
								title: "DeleteDriverSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.DRIVER),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

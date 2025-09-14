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
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "List of driver",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(DriverSchema)),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.DRIVER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "Get driver by id success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(DriverSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.DRIVER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "Create driver success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(DriverSchema)),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "Update driver success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(DriverSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.DRIVER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		tags: [FEATURE_TAGS.DRIVER],
		responses: {
			200: {
				description: "Delete driver success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(EmptySchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.DRIVER),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

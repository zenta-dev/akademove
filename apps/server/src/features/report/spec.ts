import {
	createSuccessResponseSchema,
	EmptySchema,
	listifySchema,
} from "@repo/schema/common";
import { ReportSchema } from "@repo/schema/report";
import { describeRoute, resolver } from "hono-openapi";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const ReportSpec = Object.freeze({
	list: describeRoute({
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "List of report",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(ReportSchema)),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REPORT),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "Get report by id success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(ReportSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REPORT),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "Create report success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(ReportSchema)),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "Update report success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(ReportSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REPORT),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "Delete report success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(EmptySchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REPORT),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

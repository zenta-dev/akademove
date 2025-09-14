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
		operationId: "getAllReport",
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "List of report",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(ReportSchema)).meta({
								title: "GetAllReportSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REPORT),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		operationId: "getReportById",
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "Get report by id success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(ReportSchema).meta({
								title: "GetReportByIdSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REPORT),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		operationId: "createReport",
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "Create report success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(ReportSchema).meta({
								title: "CreateReportSuccessResponse",
							}),
						),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		operationId: "updateReport",
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "Update report success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(ReportSchema).meta({
								title: "UpdateReportSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REPORT),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		operationId: "deleteReport",
		tags: [FEATURE_TAGS.REPORT],
		responses: {
			200: {
				description: "Delete report success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(EmptySchema).meta({
								title: "DeleteReportSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.REPORT),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

import {
	createSuccessResponseSchema,
	EmptySchema,
	listifySchema,
} from "@repo/schema/common";
import { ScheduleSchema } from "@repo/schema/schedule";
import { describeRoute, resolver } from "hono-openapi";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const ScheduleSpec = Object.freeze({
	list: describeRoute({
		operationId: "getAllSchedule",
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "List of schedule",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(ScheduleSchema)).meta({
								title: "GetAllScheduleSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.SCHEDULE),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		operationId: "getScheduleById",
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "Get schedule by id success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(ScheduleSchema).meta({
								title: "GetScheduleByIdSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.SCHEDULE),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		operationId: "createSchedule",
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "Create schedule success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(ScheduleSchema).meta({
								title: "CreateScheduleSuccessResponse",
							}),
						),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		operationId: "updateSchedule",
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "Update schedule success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(ScheduleSchema).meta({
								title: "UpdateScheduleSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.SCHEDULE),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		operationId: "deleteSchedule",
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "Delete schedule success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(EmptySchema).meta({
								title: "DeleteScheduleSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.SCHEDULE),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

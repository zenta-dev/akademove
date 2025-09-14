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
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "List of schedule",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(ScheduleSchema)),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.SCHEDULE),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "Get schedule by id success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(ScheduleSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.SCHEDULE),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "Create schedule success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(ScheduleSchema)),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "Update schedule success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(ScheduleSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.SCHEDULE),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		tags: [FEATURE_TAGS.SCHEDULE],
		responses: {
			200: {
				description: "Delete schedule success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(EmptySchema)),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.SCHEDULE),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

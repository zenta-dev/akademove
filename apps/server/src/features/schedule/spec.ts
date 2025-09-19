import { oc } from "@orpc/contract";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import {
	InsertScheduleSchema,
	ScheduleSchema,
	UpdateScheduleSchema,
} from "@repo/schema/schedule";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const ScheduleSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.SCHEDULE],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(ScheduleSchema),
				"Successfully retrieved schedules data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.SCHEDULE],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(
				ScheduleSchema,
				"Successfully retrieved schedule data",
			),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.SCHEDULE],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertScheduleSchema }))
		.output(
			createSuccesSchema(ScheduleSchema, "Schedule created successfully"),
		),
	update: oc
		.route({
			tags: [FEATURE_TAGS.SCHEDULE],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateScheduleSchema,
			}),
		)
		.output(
			createSuccesSchema(ScheduleSchema, "Schedule updated successfully"),
		),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.SCHEDULE],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Schedule deleted successfully")),
};

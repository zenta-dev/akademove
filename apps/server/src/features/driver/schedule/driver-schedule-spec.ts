import { oc } from "@orpc/contract";
import {
	DriverScheduleSchema,
	InsertDriverScheduleSchema,
	UpdateDriverScheduleSchema,
} from "@repo/schema/driver";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const DriverScheduleSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(DriverScheduleSchema),
				"Successfully retrieved schedules data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(
				DriverScheduleSchema,
				"Successfully retrieved schedule data",
			),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertDriverScheduleSchema }))
		.output(
			createSuccesSchema(DriverScheduleSchema, "Schedule created successfully"),
		),
	update: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateDriverScheduleSchema,
			}),
		)
		.output(
			createSuccesSchema(DriverScheduleSchema, "Schedule updated successfully"),
		),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Schedule deleted successfully")),
};

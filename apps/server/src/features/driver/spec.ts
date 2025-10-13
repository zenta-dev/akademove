import { oc } from "@orpc/contract";
import { DriverSchema, UpdateDriverSchema } from "@repo/schema/driver";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const DriverSpec = {
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
				z.array(DriverSchema),
				"Successfully retrieved drivers data",
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
			createSuccesSchema(DriverSchema, "Successfully retrieved driver data"),
		),
	// create: oc
	// 	.route({
	// 		tags: [FEATURE_TAGS.DRIVER],
	// 		method: "POST",
	// 		path: "/",
	// 		inputStructure: "detailed",
	// 		outputStructure: "detailed",
	// 	})
	// 	.input(z.object({ body: InsertDriverSchema }))
	// 	.output(createSuccesSchema(DriverSchema, "Driver created successfully")),
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
				body: UpdateDriverSchema,
			}),
		)
		.output(createSuccesSchema(DriverSchema, "Driver updated successfully")),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Driver deleted successfully")),
};

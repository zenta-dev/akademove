import { oc } from "@orpc/contract";
import {
	BadgeSchema,
	InsertBadgeSchema,
	UpdateBadgeSchema,
} from "@repo/schema/badge";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const BadgeSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.BADGE],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(BadgeSchema),
				"Successfully retrieved badges data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.BADGE],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(BadgeSchema, "Successfully retrieved badge data"),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.BADGE],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertBadgeSchema }))
		.output(createSuccesSchema(BadgeSchema, "Badge created successfully")),
	update: oc
		.route({
			tags: [FEATURE_TAGS.BADGE],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateBadgeSchema,
			}),
		)
		.output(createSuccesSchema(BadgeSchema, "Badge updated successfully")),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.BADGE],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Badge deleted successfully")),
};

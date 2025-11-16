import { oc } from "@orpc/contract";
import {
	InsertUserBadgeSchema,
	UpdateUserBadgeSchema,
	UserBadgeSchema,
} from "@repo/schema/badge";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const UserBadgeSpec = {
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
				z.array(UserBadgeSchema),
				"Successfully retrieved user badges data",
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
			createSuccesSchema(
				UserBadgeSchema,
				"Successfully retrieved user badge data",
			),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.BADGE],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertUserBadgeSchema }))
		.output(
			createSuccesSchema(UserBadgeSchema, "User badge created successfully"),
		),
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
				body: UpdateUserBadgeSchema,
			}),
		)
		.output(
			createSuccesSchema(UserBadgeSchema, "User badge updated successfully"),
		),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.BADGE],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "User badge deleted successfully")),
};

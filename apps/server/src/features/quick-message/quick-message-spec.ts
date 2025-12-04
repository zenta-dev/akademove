import { oc } from "@orpc/contract";
import {
	InsertQuickMessageTemplateSchema,
	ListQuickMessageQuerySchema,
	QuickMessageTemplateSchema,
	UpdateQuickMessageTemplateSchema,
} from "@repo/schema/quick-message";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const QuickMessageSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.CHAT],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: ListQuickMessageQuerySchema }))
		.output(
			createSuccesSchema(
				z.object({
					rows: z.array(QuickMessageTemplateSchema),
				}),
				"Successfully retrieved quick message templates",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.CHAT],
			method: "GET",
			path: "/:id",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(
				QuickMessageTemplateSchema,
				"Successfully retrieved quick message template",
			),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.CHAT],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertQuickMessageTemplateSchema }))
		.output(
			createSuccesSchema(
				QuickMessageTemplateSchema,
				"Quick message template created successfully",
			),
		),
	update: oc
		.route({
			tags: [FEATURE_TAGS.CHAT],
			method: "PATCH",
			path: "/:id",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateQuickMessageTemplateSchema,
			}),
		)
		.output(
			createSuccesSchema(
				QuickMessageTemplateSchema,
				"Quick message template updated successfully",
			),
		),
	delete: oc
		.route({
			tags: [FEATURE_TAGS.CHAT],
			method: "DELETE",
			path: "/:id",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(
				z.object({ success: z.boolean() }),
				"Quick message template deleted successfully",
			),
		),
};

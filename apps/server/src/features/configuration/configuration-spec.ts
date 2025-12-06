import { oc } from "@orpc/contract";
import {
	BusinessConfigurationSchema,
	ConfigurationSchema,
	UpdateConfigurationSchema,
} from "@repo/schema/configuration";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const ConfigurationSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			z.union([
				createSuccesSchema(
					z.array(ConfigurationSchema),
					"Successfully retrieved configurations",
				),
			]),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "GET",
			path: "/{key}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ key: z.string() }) }))
		.output(
			z.union([
				createSuccesSchema(
					ConfigurationSchema,
					"Successfully retrieved configuration",
				),
			]),
		),
	update: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "PUT",
			path: "/{key}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ key: z.string() }),
				body: UpdateConfigurationSchema,
			}),
		)
		.output(
			z.union([
				createSuccesSchema(
					ConfigurationSchema,
					"Configuration updated successfully",
				),
			]),
		),
	/**
	 * Public endpoint to get business configuration.
	 * Returns wallet limits, fee rates, and other business rules
	 * that frontends need to display to users.
	 */
	getBusinessConfig: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "GET",
			path: "/business",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({}))
		.output(
			z.union([
				createSuccesSchema(
					BusinessConfigurationSchema,
					"Successfully retrieved business configuration",
				),
			]),
		),
};

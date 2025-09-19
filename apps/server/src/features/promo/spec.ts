import { oc } from "@orpc/contract";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import {
	InsertPromoSchema,
	PromoSchema,
	UpdatePromoSchema,
} from "@repo/schema/promo";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const PromoSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.PROMO],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(PromoSchema),
				"Successfully retrieved promos data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.PROMO],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(PromoSchema, "Successfully retrieved promo data"),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.PROMO],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertPromoSchema }))
		.output(createSuccesSchema(PromoSchema, "Promo created successfully")),
	update: oc
		.route({
			tags: [FEATURE_TAGS.PROMO],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdatePromoSchema,
			}),
		)
		.output(createSuccesSchema(PromoSchema, "Promo updated successfully")),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.PROMO],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Promo deleted successfully")),
};

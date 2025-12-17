import { oc } from "@orpc/contract";
import {
	InsertMerchantMenuCategorySchema,
	MerchantMenuCategorySchema,
	UpdateMerchantMenuCategorySchema,
} from "@repo/schema/merchant";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const MerchantMenuCategorySpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
				query: UnifiedPaginationQuerySchema,
			}),
		)
		.output(
			createSuccesSchema(
				z.array(MerchantMenuCategorySchema),
				"Successfully retrieved merchant menu categories",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string(), id: z.string() }),
			}),
		)
		.output(
			createSuccesSchema(
				MerchantMenuCategorySchema,
				"Successfully retrieved merchant menu category",
			),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
				body: InsertMerchantMenuCategorySchema,
			}),
		)
		.output(
			createSuccesSchema(
				MerchantMenuCategorySchema,
				"Menu category created successfully",
			),
		),
	update: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string(), id: z.string() }),
				body: UpdateMerchantMenuCategorySchema,
			}),
		)
		.output(
			createSuccesSchema(
				MerchantMenuCategorySchema,
				"Menu category updated successfully",
			),
		),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string(), id: z.string() }),
			}),
		)
		.output(createSuccesSchema(z.null(), "Menu category deleted successfully")),
};

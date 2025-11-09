import { oc } from "@orpc/contract";
import {
	InsertMerchantMenuSchema,
	MerchantMenuSchema,
	UpdateMerchantMenuSchema,
} from "@repo/schema/merchant";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";
import { toOAPIRequestBody } from "@/utils/oapi";

export const MerchantMenuSpec = {
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
				z.array(MerchantMenuSchema),
				"Successfully retrieved merchant menus data",
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
				MerchantMenuSchema,
				"Successfully retrieved merchant menu data",
			),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
			spec: (spec) => ({
				...spec,
				...toOAPIRequestBody(InsertMerchantMenuSchema),
			}),
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
				body: InsertMerchantMenuSchema,
			}),
		)
		.output(
			createSuccesSchema(
				MerchantMenuSchema,
				"Merchant menu created successfully",
			),
		),
	update: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
			spec: (spec) => ({
				...spec,
				...toOAPIRequestBody(UpdateMerchantMenuSchema),
			}),
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string(), id: z.string() }),
				body: UpdateMerchantMenuSchema,
			}),
		)
		.output(
			createSuccesSchema(
				MerchantMenuSchema,
				"Merchant menu updated successfully",
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
		.output(createSuccesSchema(z.null(), "Merchant menu deleted successfully")),
};

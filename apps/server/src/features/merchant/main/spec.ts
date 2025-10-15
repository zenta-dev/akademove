import { oc } from "@orpc/contract";
import {
	FlatUpdateMerchantSchema,
	MerchantSchema,
} from "@repo/schema/merchant";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";
import { toOAPIRequestBody } from "@/utils/oapi";

export const MerchantMainSpec = {
	getMine: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/mine",
		})
		.output(
			createSuccesSchema(
				MerchantSchema,
				"Successfully retrieved my merchant data",
			),
		),
	list: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(MerchantSchema),
				"Successfully retrieved merchants data",
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
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(
				MerchantSchema,
				"Successfully retrieved merchant data",
			),
		),
	// create: oc
	// 	.route({
	// 		tags: [FEATURE_TAGS.MERCHANT],
	// 		method: "POST",
	// 		path: "/",
	// 		inputStructure: "detailed",
	// 		outputStructure: "detailed",
	// 	})
	// 	.input(z.object({ body: InsertMerchantSchema }))
	// 	.output(
	// 		createSuccesSchema(MerchantSchema, "Merchant created successfully"),
	// 	),
	update: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
			spec: (spec) => ({
				...spec,
				...toOAPIRequestBody(FlatUpdateMerchantSchema),
			}),
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: FlatUpdateMerchantSchema,
			}),
		)
		.output(
			createSuccesSchema(MerchantSchema, "Merchant updated successfully"),
		),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Merchant deleted successfully")),
};

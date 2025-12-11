import { oc } from "@orpc/contract";
import {
	BulkUpsertMerchantOperatingHoursSchema,
	InsertMerchantOperatingHoursSchema,
	MerchantOperatingHoursSchema,
	UpdateMerchantOperatingHoursSchema,
} from "@repo/schema/merchant";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const MerchantOperatingHoursSpec = {
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
			}),
		)
		.output(
			createSuccesSchema(
				z.array(MerchantOperatingHoursSchema),
				"Successfully retrieved merchant operating hours",
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
				MerchantOperatingHoursSchema,
				"Successfully retrieved merchant operating hours",
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
				body: InsertMerchantOperatingHoursSchema,
			}),
		)
		.output(
			createSuccesSchema(
				MerchantOperatingHoursSchema,
				"Merchant operating hours created successfully",
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
				body: UpdateMerchantOperatingHoursSchema,
			}),
		)
		.output(
			createSuccesSchema(
				MerchantOperatingHoursSchema,
				"Merchant operating hours updated successfully",
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
		.output(
			createSuccesSchema(
				z.null(),
				"Merchant operating hours deleted successfully",
			),
		),
	bulkUpsert: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/bulk",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
				body: BulkUpsertMerchantOperatingHoursSchema,
			}),
		)
		.output(
			createSuccesSchema(
				z.array(MerchantOperatingHoursSchema),
				"Merchant operating hours updated successfully",
			),
		),
};

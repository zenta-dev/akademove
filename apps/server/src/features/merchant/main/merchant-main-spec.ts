import { oc } from "@orpc/contract";
import {
	DeactivateMerchantSchema,
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
	populars: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/populars",
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
				query: UnifiedPaginationQuerySchema.safeExtend({
					category: z.string().optional(),
				}),
			}),
		)
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
	bestSellers: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/best-sellers",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				query: z.object({
					limit: z.coerce.number(),
					category: z.string().optional(),
				}),
			}),
		)
		.output(
			createSuccesSchema(
				z.array(
					z.object({
						menu: z.object({
							id: z.string(),
							merchantId: z.string(),
							name: z.string(),
							image: z.string().optional(),
							category: z.string().optional(),
							price: z.number(),
							stock: z.number(),
							createdAt: z.date(),
							updatedAt: z.date(),
						}),
						merchant: z.object({
							id: z.string(),
							name: z.string(),
							image: z.string().optional(),
							rating: z.number(),
						}),
						orderCount: z.number(),
					}),
				),
				"Successfully retrieved best sellers",
			),
		),
	analytics: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/{id}/analytics",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				query: z.object({
					period: z.enum(["today", "week", "month", "year"]).optional(),
					startDate: z.coerce.date().optional(),
					endDate: z.coerce.date().optional(),
				}),
			}),
		)
		.output(
			createSuccesSchema(
				z.object({
					totalOrders: z.number(),
					totalRevenue: z.number(),
					totalCommission: z.number(),
					completedOrders: z.number(),
					cancelledOrders: z.number(),
					averageOrderValue: z.number(),
					topSellingItems: z.array(
						z.object({
							menuId: z.string(),
							menuName: z.string(),
							menuImage: z.string().optional(),
							totalOrders: z.number(),
							totalRevenue: z.number(),
						}),
					),
					revenueByDay: z.array(
						z.object({
							date: z.string(),
							revenue: z.number(),
							orders: z.number(),
						}),
					),
				}),
				"Successfully retrieved merchant analytics",
			),
		),
	activate: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/{id}/activate",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(MerchantSchema, "Merchant activated successfully"),
		),
	deactivate: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/{id}/deactivate",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: DeactivateMerchantSchema.omit({ id: true }),
			}),
		)
		.output(
			createSuccesSchema(MerchantSchema, "Merchant deactivated successfully"),
		),
};

import { oc } from "@orpc/contract";
import {
	DeactivateMerchantSchema,
	FlatUpdateMerchantSchema,
	MerchantOperatingStatusSchema,
	MerchantSchema,
	MerchantStatusSchema,
} from "@repo/schema/merchant";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";
import { toOAPIRequestBody } from "@/utils/oapi";

const MerchantListQuerySchema = UnifiedPaginationQuerySchema.safeExtend({
	categories: z
		.preprocess((val) => {
			if (val === undefined) return undefined;
			if (Array.isArray(val)) return val;
			if (typeof val === "string") {
				try {
					const parsed = JSON.parse(val);
					if (Array.isArray(parsed)) return parsed;
				} catch (_) {}
				return [val];
			}
			return val;
		}, z.array(z.string()).optional())
		.optional(),
	isActive: z
		.preprocess((val) => {
			if (val === undefined) return undefined;
			if (typeof val === "boolean") return val;
			if (val === "true") return true;
			if (val === "false") return false;
			return undefined;
		}, z.boolean().optional())
		.optional(),
	status: MerchantStatusSchema.optional().describe(
		"Filter by merchant approval status (e.g., APPROVED)",
	),
	operatingStatus: MerchantOperatingStatusSchema.optional().describe(
		"Filter by merchant operating status (e.g., OPEN)",
	),
	minRating: z.coerce.number().min(0).max(5).optional(),
	maxRating: z.coerce.number().min(0).max(5).optional(),
	sortBy: z
		.enum([
			"rating",
			"distance",
			"popularity",
			"name",
			"createdAt",
			"updatedAt",
		])
		.optional()
		.describe(
			"Sort merchants by rating (bestsellers), distance (nearby), or other fields",
		),
	cursor: z
		.string()
		.optional()
		.describe("Cursor for pagination (ISO 8601 timestamp)"),
	maxDistance: z.coerce
		.number()
		.positive()
		.optional()
		.describe(
			"Filter merchants within max distance in meters (requires lat/lon)",
		),
	latitude: z.coerce
		.number()
		.optional()
		.describe("User latitude for distance calculation (WGS84)"),
	longitude: z.coerce
		.number()
		.optional()
		.describe("User longitude for distance calculation (WGS84)"),
});

export type MerchantListQuery = z.infer<typeof MerchantListQuerySchema>;

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
		.input(z.object({ query: MerchantListQuerySchema }))
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
							price: z.coerce.number(),
							stock: z.coerce.number(),
							createdAt: z.coerce.date(),
							updatedAt: z.coerce.date(),
						}),
						merchant: z.object({
							id: z.string(),
							name: z.string(),
							image: z.string().optional(),
							rating: z.coerce.number(),
						}),
						orderCount: z.coerce.number(),
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
					totalOrders: z.coerce.number(),
					totalRevenue: z.coerce.number(),
					totalCommission: z.coerce.number(),
					completedOrders: z.coerce.number(),
					cancelledOrders: z.coerce.number(),
					averageOrderValue: z.coerce.number(),
					topSellingItems: z.array(
						z.object({
							menuId: z.string(),
							menuName: z.string(),
							menuImage: z.string().optional(),
							totalOrders: z.coerce.number(),
							totalRevenue: z.coerce.number(),
						}),
					),
					revenueByDay: z.array(
						z.object({
							date: z.string(),
							revenue: z.coerce.number(),
							orders: z.coerce.number(),
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
			method: "PATCH",
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

	setOnlineStatus: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "PATCH",
			path: "/{id}/availability/online",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: z.object({ isOnline: z.boolean() }),
			}),
		)
		.output(
			createSuccesSchema(
				MerchantSchema,
				"Merchant online status updated successfully",
			),
		),

	setOperatingStatus: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "PATCH",
			path: "/{id}/availability/operating-status",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: z.object({ operatingStatus: MerchantOperatingStatusSchema }),
			}),
		)
		.output(
			createSuccesSchema(
				MerchantSchema,
				"Merchant operating status updated successfully",
			),
		),

	getAvailabilityStatus: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/{id}/availability/status",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
			}),
		)
		.output(
			createSuccesSchema(
				z.object({
					id: z.string(),
					isOnline: z.boolean(),
					operatingStatus: MerchantOperatingStatusSchema,
					activeOrderCount: z.coerce.number().int().nonnegative(),
				}),
				"Merchant availability status retrieved successfully",
			),
		),
};

import { oc } from "@orpc/contract";
import {
	DriverSchema,
	DriverStatusSchema,
	FlatUpdateDriverSchema,
} from "@repo/schema/driver";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import {
	CoordinateSchema,
	CoordinateWithMetaSchema,
} from "@repo/schema/position";
import { UserGenderSchema } from "@repo/schema/user";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";
import { toOAPIRequestBody } from "@/utils/oapi";

export const NearbyQuerySchema = z.object({
	...CoordinateSchema.shape,
	radiusKm: z.coerce.number(),
	limit: z.coerce.number(),
	gender: UserGenderSchema.optional(),
});

export type NearbyQuery = z.infer<typeof NearbyQuerySchema>;

const DriverListQuerySchema = UnifiedPaginationQuerySchema.safeExtend({
	statuses: z
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
		}, z.array(DriverStatusSchema).optional())
		.optional(),
	isOnline: z
		.preprocess((val) => {
			if (val === undefined) return undefined;
			if (typeof val === "boolean") return val;
			if (val === "true") return true;
			if (val === "false") return false;
			return undefined;
		}, z.boolean().optional())
		.optional(),
	minRating: z.coerce.number().min(0).max(5).optional(),
	maxRating: z.coerce.number().min(0).max(5).optional(),
});

export type DriverListQuery = z.infer<typeof DriverListQuerySchema>;

export const DriverMainSpec = {
	getMine: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "GET",
			path: "/mine",
		})
		.output(
			createSuccesSchema(DriverSchema, "Successfully retrieved my driver data"),
		),
	list: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: DriverListQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(DriverSchema),
				"Successfully retrieved drivers data",
			),
		),
	nearby: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "GET",
			path: "/nearby",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				query: NearbyQuerySchema,
			}),
		)
		.output(
			createSuccesSchema(
				z.array(DriverSchema),
				"Successfully retrieved drivers data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(DriverSchema, "Successfully retrieved driver data"),
		),
	update: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
			spec: (spec) => ({
				...spec,
				...toOAPIRequestBody(FlatUpdateDriverSchema),
			}),
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: FlatUpdateDriverSchema,
			}),
		)
		.output(createSuccesSchema(DriverSchema, "Driver updated successfully")),
	updateLocation: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "PUT",
			path: "/{id}/location",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: CoordinateWithMetaSchema,
			}),
		)
		.output(createSuccesSchema(DriverSchema, "Driver updated successfully")),
	updateOnlineStatus: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "POST",
			path: "/{id}/update-online-status",
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
				DriverSchema,
				"Driver online status updated successfully",
			),
		),
	updateTakingOrderStatus: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "POST",
			path: "/{id}/update-taking-order-status",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: z.object({ isTakingOrder: z.boolean() }),
			}),
		)
		.output(
			createSuccesSchema(
				DriverSchema,
				"Driver taking order status updated successfully",
			),
		),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Driver deleted successfully")),
	getAnalytics: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
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
					totalEarnings: z.coerce.number(),
					totalCommission: z.coerce.number(),
					netEarnings: z.coerce.number(),
					totalOrders: z.coerce.number(),
					completedOrders: z.coerce.number(),
					cancelledOrders: z.coerce.number(),
					completionRate: z.coerce.number(),
					averageRating: z.coerce.number(),
					earningsByType: z.array(
						z.object({
							type: z.enum(["RIDE", "DELIVERY", "FOOD"]),
							orders: z.coerce.number(),
							earnings: z.coerce.number(),
							commission: z.coerce.number(),
						}),
					),
					earningsByDay: z.array(
						z.object({
							date: z.string(),
							earnings: z.coerce.number(),
							orders: z.coerce.number(),
							commission: z.coerce.number(),
						}),
					),
					topEarningDays: z.array(
						z.object({
							date: z.string(),
							earnings: z.coerce.number(),
							orders: z.coerce.number(),
						}),
					),
				}),
				"Successfully retrieved driver analytics",
			),
		),
	approve: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "POST",
			path: "/{id}/approve",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(DriverSchema, "Driver approved successfully")),
	reject: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "POST",
			path: "/{id}/reject",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: z.object({ reason: z.string() }),
			}),
		)
		.output(createSuccesSchema(DriverSchema, "Driver rejected successfully")),
	suspend: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "POST",
			path: "/{id}/suspend",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: z.object({
					reason: z.string(),
					suspendUntil: z.coerce.date().optional(),
				}),
			}),
		)
		.output(createSuccesSchema(DriverSchema, "Driver suspended successfully")),
	activate: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "POST",
			path: "/{id}/activate",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(DriverSchema, "Driver activated successfully")),
};

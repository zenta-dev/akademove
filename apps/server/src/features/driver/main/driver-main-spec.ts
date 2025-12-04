import { oc } from "@orpc/contract";
import { DriverSchema, UpdateDriverSchema } from "@repo/schema/driver";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { CoordinateSchema } from "@repo/schema/position";
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
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
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
				...toOAPIRequestBody(UpdateDriverSchema),
			}),
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateDriverSchema,
			}),
		)
		.output(createSuccesSchema(DriverSchema, "Driver updated successfully")),
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
					totalEarnings: z.number(),
					totalCommission: z.number(),
					netEarnings: z.number(),
					totalOrders: z.number(),
					completedOrders: z.number(),
					cancelledOrders: z.number(),
					completionRate: z.number(),
					averageRating: z.number(),
					earningsByType: z.array(
						z.object({
							type: z.enum(["RIDE", "DELIVERY", "FOOD"]),
							orders: z.number(),
							earnings: z.number(),
							commission: z.number(),
						}),
					),
					earningsByDay: z.array(
						z.object({
							date: z.string(),
							earnings: z.number(),
							orders: z.number(),
							commission: z.number(),
						}),
					),
					topEarningDays: z.array(
						z.object({
							date: z.string(),
							earnings: z.number(),
							orders: z.number(),
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

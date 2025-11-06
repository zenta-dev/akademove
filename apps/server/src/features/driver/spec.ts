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

export const DriverSpec = {
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
};

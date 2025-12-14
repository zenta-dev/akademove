import { oc } from "@orpc/contract";
import {
	EmergencyContactSchema,
	InsertEmergencyContactSchema,
	UpdateEmergencyContactSchema,
} from "@repo/schema/emergency-contact";
import {
	CursorPaginationQuerySchema,
	OffsetPaginationQuerySchema,
	PaginationModeSchema,
	PaginationOrderSchema,
	SortBySchema,
} from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

// Query schema for listing emergency contacts
export const EmergencyContactListQuerySchema = z.object({
	...CursorPaginationQuerySchema.shape,
	...OffsetPaginationQuerySchema.shape,
	query: z.string().optional(),
	sortBy: SortBySchema.optional(),
	order: PaginationOrderSchema.optional().default("desc"),
	mode: PaginationModeSchema.optional().default("offset"),
	isActive: z.coerce.boolean().optional(),
});
export type EmergencyContactListQuery = z.infer<
	typeof EmergencyContactListQuerySchema
>;

// Spec contract
export const EmergencyContactSpec = {
	// List active contacts (for mobile app during emergency)
	listActive: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "GET",
			path: "/active",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({}))
		.output(
			createSuccesSchema(
				z.array(EmergencyContactSchema),
				"Successfully retrieved active emergency contacts",
			),
		),

	// Admin/Operator endpoints
	list: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: EmergencyContactListQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(EmergencyContactSchema),
				"Successfully retrieved emergency contacts",
			),
		),

	get: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.uuid() }) }))
		.output(
			createSuccesSchema(
				EmergencyContactSchema,
				"Successfully retrieved emergency contact",
			),
		),

	create: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertEmergencyContactSchema }))
		.output(
			createSuccesSchema(
				EmergencyContactSchema,
				"Emergency contact created successfully",
				{
					status: 201,
				},
			),
		),

	update: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: UpdateEmergencyContactSchema,
			}),
		)
		.output(
			createSuccesSchema(
				EmergencyContactSchema,
				"Emergency contact updated successfully",
			),
		),

	delete: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.uuid() }) }))
		.output(
			createSuccesSchema(
				z.object({ ok: z.boolean() }),
				"Emergency contact deleted",
			),
		),

	// Toggle active status
	toggleActive: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "PATCH",
			path: "/{id}/toggle",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.uuid() }) }))
		.output(
			createSuccesSchema(
				EmergencyContactSchema,
				"Emergency contact status toggled",
			),
		),
};

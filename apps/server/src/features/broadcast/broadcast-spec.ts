import { oc } from "@orpc/contract";
import {
	CursorPaginationQuerySchema,
	OffsetPaginationQuerySchema,
	PaginationModeSchema,
	PaginationOrderSchema,
	SortBySchema,
} from "@repo/schema/pagination";
import * as z from "zod/v4";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";
import {
	BroadcastSchema,
	BroadcastStatusSchema,
	BroadcastTypeSchema,
	TargetAudienceSchema,
} from "@/core/tables/broadcast";

// Query schemas - manually compose to avoid extending refined schema
export const BroadcastListQuerySchema = z.object({
	...CursorPaginationQuerySchema.shape,
	...OffsetPaginationQuerySchema.shape,
	query: z.string().optional(),
	sortBy: SortBySchema.optional(),
	order: PaginationOrderSchema.optional().default("desc"),
	mode: PaginationModeSchema.optional().default("offset"),
	status: BroadcastStatusSchema.optional(),
	type: BroadcastTypeSchema.optional(),
	targetAudience: TargetAudienceSchema.optional(),
	search: z.string().optional(),
});

// Body schemas
export const CreateBroadcastBodySchema = z.object({
	title: z.string().min(1, "Title is required").max(255, "Title too long"),
	message: z.string().min(1, "Message is required"),
	type: BroadcastTypeSchema,
	targetAudience: TargetAudienceSchema,
	targetIds: z.array(z.uuid()).optional(),
	scheduledAt: z.coerce.date().optional(),
});

export const UpdateBroadcastBodySchema = CreateBroadcastBodySchema.partial();

// Response schemas
export const BroadcastStatsResponseSchema = z.object({
	total: z.number().int(),
	pending: z.number().int(),
	sending: z.number().int(),
	sent: z.number().int(),
	failed: z.number().int(),
});

// Contract
export const BroadcastSpec = {
	// List broadcasts with filtering and pagination
	list: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: BroadcastListQuerySchema }))
		.output(
			createSuccesSchema(z.array(BroadcastSchema), "List broadcasts success"),
		),

	// Get broadcast by ID
	get: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.uuid() }) }))
		.output(createSuccesSchema(BroadcastSchema, "Get broadcast success")),

	// Create new broadcast
	create: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: CreateBroadcastBodySchema }))
		.output(
			createSuccesSchema(BroadcastSchema, "Broadcast created successfully", {
				status: 201,
			}),
		),

	// Update broadcast
	update: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: UpdateBroadcastBodySchema,
			}),
		)
		.output(
			createSuccesSchema(BroadcastSchema, "Broadcast updated successfully"),
		),

	// Delete broadcast
	delete: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.uuid() }) }))
		.output(
			createSuccesSchema(z.object({ ok: z.boolean() }), "Broadcast deleted"),
		),

	// Send broadcast immediately
	send: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "POST",
			path: "/{id}/send",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.uuid() }) }))
		.output(createSuccesSchema(BroadcastSchema, "Broadcast sent successfully")),

	// Get broadcast statistics
	stats: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "GET",
			path: "/stats",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({}))
		.output(
			createSuccesSchema(
				BroadcastStatsResponseSchema,
				"Broadcast stats retrieved",
			),
		),
};

// Types
export type BroadcastListQuery = z.infer<typeof BroadcastListQuerySchema>;
export type CreateBroadcastBody = z.infer<typeof CreateBroadcastBodySchema>;
export type UpdateBroadcastBody = z.infer<typeof UpdateBroadcastBodySchema>;

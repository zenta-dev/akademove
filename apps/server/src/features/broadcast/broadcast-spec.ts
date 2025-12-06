import { oc } from "@orpc/contract";
import {
	BroadcastStatusSchema,
	BroadcastTypeSchema,
	TargetAudienceSchema,
} from "@repo/schema/broadcast";
import { z } from "zod";

// Query schemas
export const BroadcastListQuerySchema = z.object({
	page: z.coerce.number().int().min(1).default(1),
	limit: z.coerce.number().int().min(1).max(100).default(20),
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
	targetUserIds: z.array(z.string().uuid()).optional(),
	scheduledAt: z.coerce.date().optional(),
});

export const UpdateBroadcastBodySchema = CreateBroadcastBodySchema.partial();

// Response schemas
export const BroadcastResponseSchema = z.object({
	id: z.string().uuid(),
	title: z.string(),
	message: z.string(),
	type: BroadcastTypeSchema,
	status: BroadcastStatusSchema,
	targetAudience: TargetAudienceSchema,
	targetUserIds: z.array(z.string().uuid()).optional(),
	scheduledAt: z.date().nullable(),
	sentAt: z.date().nullable(),
	totalRecipients: z.number().int(),
	sentCount: z.number().int(),
	failedCount: z.number().int(),
	createdBy: z.string().uuid(),
	createdAt: z.date(),
	updatedAt: z.date(),
});

export const BroadcastListResponseSchema = z.object({
	data: z.array(BroadcastResponseSchema),
	pagination: z.object({
		page: z.number().int(),
		limit: z.number().int(),
		total: z.number().int(),
		totalPages: z.number().int(),
	}),
});

export const BroadcastStatsResponseSchema = z.object({
	total: z.number().int(),
	pending: z.number().int(),
	sending: z.number().int(),
	sent: z.number().int(),
	failed: z.number().int(),
});

// Contract
export const BroadcastSpec = oc.router({
	// Public endpoints (if needed)
	pub: {
		// No public endpoints for broadcast
	},

	// Private endpoints (require authentication)
	priv: {
		// List broadcasts with filtering and pagination
		list: oc
			.route({
				method: "GET",
				path: "/",
				query: BroadcastListQuerySchema,
			})
			.response(BroadcastListResponseSchema),

		// Get broadcast by ID
		get: oc
			.route({
				method: "GET",
				path: "/:id",
			})
			.response(BroadcastResponseSchema),

		// Create new broadcast
		create: oc
			.route({
				method: "POST",
				path: "/",
				body: CreateBroadcastBodySchema,
			})
			.response(BroadcastResponseSchema),

		// Update broadcast
		update: oc
			.route({
				method: "PUT",
				path: "/:id",
				body: UpdateBroadcastBodySchema,
			})
			.response(BroadcastResponseSchema),

		// Delete broadcast
		delete: oc
			.route({
				method: "DELETE",
				path: "/:id",
			})
			.response(z.void()),

		// Send broadcast immediately
		send: oc
			.route({
				method: "POST",
				path: "/:id/send",
			})
			.response(BroadcastResponseSchema),

		// Get broadcast statistics
		stats: oc
			.route({
				method: "GET",
				path: "/stats",
			})
			.response(BroadcastStatsResponseSchema),
	},
});

// Types
export type BroadcastListQuery = z.infer<typeof BroadcastListQuerySchema>;
export type CreateBroadcastBody = z.infer<typeof CreateBroadcastBodySchema>;
export type UpdateBroadcastBody = z.infer<typeof UpdateBroadcastBodySchema>;
export type BroadcastResponse = z.infer<typeof BroadcastResponseSchema>;
export type BroadcastListResponse = z.infer<typeof BroadcastListResponseSchema>;
export type BroadcastStatsResponse = z.infer<
	typeof BroadcastStatsResponseSchema
>;

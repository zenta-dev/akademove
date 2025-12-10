import { oc } from "@orpc/contract";
import {
	BannerPlacementSchema,
	BannerSchema,
	BannerTargetAudienceSchema,
	InsertBannerSchema,
	PublicBannerSchema,
	UpdateBannerSchema,
} from "@repo/schema/banner";
import {
	CursorPaginationQuerySchema,
	OffsetPaginationQuerySchema,
	PaginationModeSchema,
	PaginationOrderSchema,
	SortBySchema,
} from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

// Query schema for listing banners (admin/operator)
export const BannerListQuerySchema = z.object({
	...CursorPaginationQuerySchema.shape,
	...OffsetPaginationQuerySchema.shape,
	query: z.string().optional(),
	sortBy: SortBySchema.optional(),
	order: PaginationOrderSchema.optional().default("desc"),
	mode: PaginationModeSchema.optional().default("offset"),
	placement: BannerPlacementSchema.optional(),
	targetAudience: BannerTargetAudienceSchema.optional(),
	isActive: z.coerce.boolean().optional(),
	search: z.string().optional(),
});
export type BannerListQuery = z.infer<typeof BannerListQuerySchema>;

// Query schema for public banner listing (mobile app)
export const PublicBannerListQuerySchema = z.object({
	placement: BannerPlacementSchema.optional(),
});
export type PublicBannerListQuery = z.infer<typeof PublicBannerListQuerySchema>;

// Spec contract
export const BannerSpec = {
	// Public endpoint - list active banners for mobile app (no auth required)
	listPublic: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "GET",
			path: "/public",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: PublicBannerListQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(PublicBannerSchema),
				"Successfully retrieved banners",
			),
		),

	// Admin/Operator endpoints
	list: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: BannerListQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(BannerSchema),
				"Successfully retrieved banners",
			),
		),

	get: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string().uuid() }) }))
		.output(createSuccesSchema(BannerSchema, "Successfully retrieved banner")),

	create: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertBannerSchema }))
		.output(
			createSuccesSchema(BannerSchema, "Banner created successfully", {
				status: 201,
			}),
		),

	update: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string().uuid() }),
				body: UpdateBannerSchema,
			}),
		)
		.output(createSuccesSchema(BannerSchema, "Banner updated successfully")),

	delete: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string().uuid() }) }))
		.output(
			createSuccesSchema(z.object({ ok: z.boolean() }), "Banner deleted"),
		),

	// Toggle active status
	toggleActive: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "PATCH",
			path: "/{id}/toggle",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string().uuid() }) }))
		.output(createSuccesSchema(BannerSchema, "Banner status toggled")),
};

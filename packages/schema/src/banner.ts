import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";

// Banner Action Type Enum
export const BANNER_ACTION_TYPE = {
	NONE: "NONE",
	LINK: "LINK",
	ROUTE: "ROUTE",
} as const;
export const BannerActionTypeSchema = z.enum(["NONE", "LINK", "ROUTE"]);
export type BannerActionType = z.infer<typeof BannerActionTypeSchema>;

// Banner Target Audience Enum
export const BANNER_TARGET_AUDIENCE = {
	ALL: "ALL",
	USERS: "USERS",
	DRIVERS: "DRIVERS",
	MERCHANTS: "MERCHANTS",
} as const;
export const BannerTargetAudienceSchema = z.enum([
	"ALL",
	"USERS",
	"DRIVERS",
	"MERCHANTS",
]);
export type BannerTargetAudience = z.infer<typeof BannerTargetAudienceSchema>;

// Banner Placement Enum
export const BANNER_PLACEMENT = {
	USER_HOME: "USER_HOME",
	DRIVER_HOME: "DRIVER_HOME",
	MERCHANT_HOME: "MERCHANT_HOME",
} as const;
export const BannerPlacementSchema = z.enum([
	"USER_HOME",
	"DRIVER_HOME",
	"MERCHANT_HOME",
]);
export type BannerPlacement = z.infer<typeof BannerPlacementSchema>;

// Full Banner Schema (for admin/operator)
export const BannerSchema = z.object({
	id: z.uuid(),
	title: z.string().min(1, "Title is required").max(255, "Title too long"),
	description: z.string().nullable().optional(),
	imageUrl: z.string().url("Invalid image URL").max(512),

	actionType: BannerActionTypeSchema,
	actionValue: z.string().nullable().optional(),

	placement: BannerPlacementSchema,
	targetAudience: BannerTargetAudienceSchema,

	isActive: z.boolean(),
	priority: z.coerce.number().int().min(0).default(0),
	startAt: DateSchema.nullable().optional(),
	endAt: DateSchema.nullable().optional(),

	createdById: z.string(),
	updatedById: z.string().nullable().optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Banner = z.infer<typeof BannerSchema>;

// Insert Banner Schema (for creating)
export const InsertBannerSchema = BannerSchema.omit({
	id: true,
	createdById: true,
	updatedById: true,
	createdAt: true,
	updatedAt: true,
});
export type InsertBanner = z.infer<typeof InsertBannerSchema>;

// Update Banner Schema (for updating)
export const UpdateBannerSchema = InsertBannerSchema.partial();
export type UpdateBanner = z.infer<typeof UpdateBannerSchema>;

// Public Banner Schema (for mobile app - without audit fields)
export const PublicBannerSchema = z.object({
	id: z.uuid(),
	title: z.string(),
	description: z.string().nullable().optional(),
	imageUrl: z.string(),

	actionType: BannerActionTypeSchema,
	actionValue: z.string().nullable().optional(),

	placement: BannerPlacementSchema,
	targetAudience: BannerTargetAudienceSchema,

	isActive: z.boolean(),
	priority: z.coerce.number().int(),
	startAt: DateSchema.nullable().optional(),
	endAt: DateSchema.nullable().optional(),
});
export type PublicBanner = z.infer<typeof PublicBannerSchema>;

// Schema Registries for OpenAPI generation
export const BannerSchemaRegistries = {
	Banner: { schema: BannerSchema, strategy: "output" },
	InsertBanner: { schema: InsertBannerSchema, strategy: "input" },
	UpdateBanner: { schema: UpdateBannerSchema, strategy: "input" },
	PublicBanner: { schema: PublicBannerSchema, strategy: "output" },
	BannerActionType: { schema: BannerActionTypeSchema, strategy: "input" },
	BannerTargetAudience: {
		schema: BannerTargetAudienceSchema,
		strategy: "input",
	},
	BannerPlacement: { schema: BannerPlacementSchema, strategy: "input" },
} satisfies SchemaRegistries;

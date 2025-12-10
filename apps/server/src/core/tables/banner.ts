import { relations } from "drizzle-orm";
import {
	boolean,
	index,
	integer,
	pgTable,
	text,
	timestamp,
	uuid,
	varchar,
} from "drizzle-orm/pg-core";
import { z } from "zod";
import { user } from "./auth";
import { DateModifier } from "./common";

// Banner Action Type Enum
export const BANNER_ACTION_TYPE = {
	NONE: "NONE",
	LINK: "LINK",
	ROUTE: "ROUTE",
} as const;
export const BannerActionTypeSchema = z.enum(["NONE", "LINK", "ROUTE"]);

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

// Banner Table
export const banner = pgTable(
	"am_banner",
	{
		id: uuid("id").primaryKey().defaultRandom(),
		title: varchar("title", { length: 255 }).notNull(),
		description: text("description"),
		imageUrl: varchar("image_url", { length: 512 }).notNull(),

		// Action configuration
		actionType: varchar("action_type", { length: 20 })
			.notNull()
			.default("NONE")
			.$type<BannerActionType>(),
		actionValue: text("action_value"), // URL for LINK, route name for ROUTE

		// Targeting
		placement: varchar("placement", { length: 20 })
			.notNull()
			.default("USER_HOME")
			.$type<BannerPlacement>(),
		targetAudience: varchar("target_audience", { length: 20 })
			.notNull()
			.default("ALL")
			.$type<BannerTargetAudience>(),

		// Display control
		isActive: boolean("is_active").notNull().default(true),
		priority: integer("priority").notNull().default(0), // Higher = shown first
		startAt: timestamp("start_at", { withTimezone: true }),
		endAt: timestamp("end_at", { withTimezone: true }),

		// Audit
		createdById: uuid("created_by_id").notNull(),
		updatedById: uuid("updated_by_id"),
		...DateModifier,
	},
	(table) => [
		index("banner_is_active_idx").on(table.isActive),
		index("banner_placement_idx").on(table.placement),
		index("banner_target_audience_idx").on(table.targetAudience),
		index("banner_priority_idx").on(table.priority),
		index("banner_start_at_idx").on(table.startAt),
		index("banner_end_at_idx").on(table.endAt),
		index("banner_active_placement_idx").on(table.isActive, table.placement),
		index("banner_created_at_idx").on(table.createdAt),
	],
);

// Relations
export const bannerRelations = relations(banner, ({ one }) => ({
	createdBy: one(user, {
		fields: [banner.createdById],
		references: [user.id],
		relationName: "bannerCreatedBy",
	}),
	updatedBy: one(user, {
		fields: [banner.updatedById],
		references: [user.id],
		relationName: "bannerUpdatedBy",
	}),
}));

// Zod Schemas
export const BannerSchema = z.object({
	id: z.string().uuid(),
	title: z.string().min(1, "Title is required").max(255, "Title too long"),
	description: z.string().nullable().optional(),
	imageUrl: z.string().url("Invalid image URL").max(512),

	actionType: BannerActionTypeSchema,
	actionValue: z.string().nullable().optional(),

	placement: BannerPlacementSchema,
	targetAudience: BannerTargetAudienceSchema,

	isActive: z.boolean(),
	priority: z.number().int().min(0).default(0),
	startAt: z.coerce.date().nullable().optional(),
	endAt: z.coerce.date().nullable().optional(),

	createdById: z.string().uuid(),
	updatedById: z.string().uuid().nullable().optional(),
	createdAt: z.coerce.date(),
	updatedAt: z.coerce.date(),
});

export const InsertBannerSchema = BannerSchema.omit({
	id: true,
	createdById: true,
	updatedById: true,
	createdAt: true,
	updatedAt: true,
});

export const UpdateBannerSchema = InsertBannerSchema.partial();

// Public banner schema (for mobile app - without audit fields)
export const PublicBannerSchema = BannerSchema.omit({
	createdById: true,
	updatedById: true,
	createdAt: true,
	updatedAt: true,
});

// Types
export type Banner = z.infer<typeof BannerSchema>;
export type InsertBanner = z.infer<typeof InsertBannerSchema>;
export type UpdateBanner = z.infer<typeof UpdateBannerSchema>;
export type PublicBanner = z.infer<typeof PublicBannerSchema>;
export type BannerActionType = z.infer<typeof BannerActionTypeSchema>;
export type BannerTargetAudience = z.infer<typeof BannerTargetAudienceSchema>;
export type BannerPlacement = z.infer<typeof BannerPlacementSchema>;
export type BannerDatabase = typeof banner.$inferSelect;

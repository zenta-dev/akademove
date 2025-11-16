import type {
	BadgeBenefits,
	BadgeCriteria,
	UserBadgeMetadata,
} from "@repo/schema/badge";
import {
	BADGE_LEVELS,
	BADGE_TARGET_ROLES,
	BADGE_TYPES,
} from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import {
	boolean,
	integer,
	jsonb,
	text,
	uuid,
	varchar,
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import {
	DateModifier,
	index,
	nowFn,
	pgEnum,
	pgTable,
	timestamp,
	uniqueIndex,
} from "./common";

export const badgeType = pgEnum("badge_type", BADGE_TYPES);
export const badgeLevel = pgEnum("badge_level", BADGE_LEVELS);
export const badgeTargetRole = pgEnum("badge_target_role", BADGE_TARGET_ROLES);

export const badge = pgTable(
	"badges",
	{
		id: uuid().primaryKey(),
		code: varchar({ length: 100 }).notNull().unique(),
		name: varchar({ length: 255 }).notNull(),
		description: text().notNull(),
		type: badgeType().notNull(),
		level: badgeLevel().notNull(),
		targetRole: badgeTargetRole("target_role").notNull(),
		icon: text(),

		criteria: jsonb().$type<BadgeCriteria>().notNull(),
		benefits: jsonb().$type<BadgeBenefits>(),

		isActive: boolean("is_active").notNull().default(true),
		displayOrder: integer("display_order").notNull().default(0),

		...DateModifier,
	},
	(t) => [
		uniqueIndex("badge_code_idx").on(t.code),
		index("badge_type_idx").on(t.type),
		index("badge_level_idx").on(t.level),
		index("badge_target_role_idx").on(t.targetRole),
		index("badge_is_active_idx").on(t.isActive),
	],
);
export type BadgeDatabase = typeof badge.$inferSelect;

export const userBadge = pgTable(
	"user_badges",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		badgeId: uuid("badge_id")
			.notNull()
			.references(() => badge.id, { onDelete: "cascade" }),
		earnedAt: timestamp("earned_at").notNull().$defaultFn(nowFn),
		metadata: jsonb().$type<UserBadgeMetadata>(),
		...DateModifier,
	},
	(t) => [
		uniqueIndex("user_badge_unique_idx").on(t.userId, t.badgeId),
		index("user_badge_user_id_idx").on(t.userId),
		index("user_badge_badge_id_idx").on(t.badgeId),
		index("user_badge_earned_at_idx").on(t.earnedAt),
	],
);
export type UserBadgeDatabase = typeof userBadge.$inferSelect;

export const badgeRelations = relations(badge, ({ many }) => ({
	userBadges: many(userBadge),
}));

export const userBadgeRelations = relations(userBadge, ({ one }) => ({
	user: one(user, {
		fields: [userBadge.userId],
		references: [user.id],
	}),
	badge: one(badge, {
		fields: [userBadge.badgeId],
		references: [badge.id],
	}),
}));

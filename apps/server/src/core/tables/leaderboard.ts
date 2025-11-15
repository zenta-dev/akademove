import {
	LEADERBOARD_CATEGORIES,
	LEADERBOARD_PERIODS,
} from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import { integer, text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import {
	DateModifier,
	index,
	pgEnum,
	pgTable,
	timestamp,
	uniqueIndex,
} from "./common";
import { driver } from "./driver";
import { merchant } from "./merchant";

export const leaderboardPeriod = pgEnum(
	"leaderboard_period",
	LEADERBOARD_PERIODS,
);
export const leaderboardCategory = pgEnum(
	"leaderboard_category",
	LEADERBOARD_CATEGORIES,
);

export const leaderboard = pgTable(
	"leaderboards",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		driverId: uuid("driver_id").references(() => driver.id, {
			onDelete: "cascade",
		}),
		merchantId: uuid("merchant_id").references(() => merchant.id, {
			onDelete: "cascade",
		}),
		category: leaderboardCategory().notNull(),
		period: leaderboardPeriod().notNull(),
		rank: integer().notNull(),
		score: integer().notNull(),
		periodStart: timestamp("period_start").notNull(),
		periodEnd: timestamp("period_end").notNull(),

		...DateModifier,
	},
	(t) => [
		uniqueIndex("leaderboard_unique_idx").on(
			t.userId,
			t.category,
			t.period,
			t.periodStart,
		),
		index("leaderboard_category_period_idx").on(t.category, t.period),
		index("leaderboard_rank_idx").on(t.rank),
		index("leaderboard_period_dates_idx").on(t.periodStart, t.periodEnd),
	],
);

export type LeaderboardDatabase = typeof leaderboard.$inferSelect;

export const leaderboardRelations = relations(leaderboard, ({ one }) => ({
	user: one(user, {
		fields: [leaderboard.userId],
		references: [user.id],
	}),
	driver: one(driver, {
		fields: [leaderboard.driverId],
		references: [driver.id],
	}),
	merchant: one(merchant, {
		fields: [leaderboard.merchantId],
		references: [merchant.id],
	}),
}));

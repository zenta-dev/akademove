import type { CouponRules } from "@repo/schema/coupon";
import { relations } from "drizzle-orm";
import {
	boolean,
	decimal,
	integer,
	jsonb,
	pgTable,
	text,
	timestamp,
	uuid,
	index,
	uniqueIndex,
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import { order } from "./order";

export const coupon = pgTable(
	"coupons",
	{
		id: uuid().primaryKey().defaultRandom(),
		name: text().notNull(),
		code: text().notNull(),
		rules: jsonb().$type<CouponRules>().notNull(),
		discountAmount: decimal("discount_amount", {
			precision: 12,
			scale: 2,
			mode: "number",
		}),
		discountPercentage: decimal("discount_percentage", {
			precision: 5,
			scale: 2,
			mode: "number",
		}),
		usageLimit: integer("usage_limit").notNull(),
		usedCount: integer("used_count").notNull(),
		periodStart: timestamp("period_start").notNull(),
		periodEnd: timestamp("period_end").notNull(),
		isActive: boolean("is_active").notNull().default(false),
		createdById: text("created_by_id")
			.notNull()
			.references(() => user.id, { onDelete: "no action" }),
		createdAt: timestamp("created_at").notNull().defaultNow(),
	},
	(t) => [
		uniqueIndex("coupon_code_idx").on(t.code),
		index("coupon_is_active_idx").on(t.isActive),
		index("coupon_period_start_idx").on(t.periodStart),
		index("coupon_period_end_idx").on(t.periodEnd),
		index("coupon_active_period_idx").on(
			t.isActive,
			t.periodStart,
			t.periodEnd,
		),
		index("coupon_created_by_id_idx").on(t.createdById),
		index("coupon_used_count_idx").on(t.usedCount),
		index("coupon_created_at_idx").on(t.createdAt),
	],
);

export const couponUsage = pgTable(
	"coupon_usages",
	{
		id: uuid().primaryKey().defaultRandom(),
		couponId: uuid("coupon_id")
			.notNull()
			.references(() => coupon.id, { onDelete: "cascade" }),
		orderId: uuid("order_id")
			.notNull()
			.references(() => order.id, { onDelete: "no action" }),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "no action" }),
		discountApplied: decimal("discount_applied", {
			precision: 10,
			scale: 2,
			mode: "number",
		}).notNull(),
		usedAt: timestamp("used_at").notNull().defaultNow(),
	},
	(t) => [
		index("coupon_usage_order_idx").on(t.orderId),
		index("coupon_usage_coupon_id_idx").on(t.couponId),
		index("coupon_usage_user_id_idx").on(t.userId),
		index("coupon_usage_coupon_user_idx").on(t.couponId, t.userId),
		index("coupon_usage_used_at_idx").on(t.usedAt),
		index("coupon_usage_user_used_at_idx").on(t.userId, t.usedAt),
	],
);

///
/// --- Relations --- ///
///
export const couponRelations = relations(coupon, ({ one }) => ({
	createdBy: one(user, {
		fields: [coupon.createdById],
		references: [user.id],
	}),
}));

export const couponUsageRelations = relations(couponUsage, ({ one }) => ({
	coupon: one(coupon, {
		fields: [couponUsage.couponId],
		references: [coupon.id],
	}),
	order: one(order, {
		fields: [couponUsage.orderId],
		references: [order.id],
	}),
	user: one(user, {
		fields: [couponUsage.userId],
		references: [user.id],
	}),
}));

export type CouponDatabase = typeof coupon.$inferSelect;

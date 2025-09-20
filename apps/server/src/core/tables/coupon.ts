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
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import { order } from "./order";

export const coupon = pgTable("coupons", {
	id: uuid().primaryKey().defaultRandom(),
	name: text().notNull(),
	code: text().notNull(),
	rules: jsonb().notNull(),
	discountAmount: decimal("discount_amount", {
		precision: 10,
		scale: 2,
		mode: "number",
	}).notNull(),
	discountPercentage: decimal("discount_percentage", {
		precision: 3,
		scale: 2,
		mode: "number",
	}).notNull(),
	minOrderAmount: decimal("min_order_amount", {
		precision: 10,
		scale: 2,
		mode: "number",
	}).notNull(),
	maxOrderAmount: decimal("max_order_amount", {
		precision: 10,
		scale: 2,
		mode: "number",
	}).notNull(),
	usageLimit: integer("usage_limit").notNull(),
	usedCount: integer("used_count").notNull(),
	periodStart: timestamp("period_start").notNull(),
	periodEnd: timestamp("period_end").notNull(),
	isActive: boolean("is_active").notNull().default(false),
	createdById: text("created_by_id")
		.notNull()
		.references(() => user.id, { onDelete: "no action" }),
	createdAt: timestamp("created_at").notNull().defaultNow(),
});

export const couponUsage = pgTable("coupon_usages", {
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
});

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

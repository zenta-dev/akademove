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

export const promo = pgTable("promos", {
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
	used_count: integer("used_count").notNull(),
	periodStart: timestamp("period_start").notNull(),
	periodEnd: timestamp("period_end").notNull(),
	isActive: boolean("is_active").notNull().default(false),
	createdById: text("created_by_id")
		.notNull()
		.references(() => user.id, { onDelete: "no action" }),
	createdAt: timestamp("created_at").notNull().defaultNow(),
});

export const promoUsage = pgTable("promo_usages", {
	id: uuid().primaryKey().defaultRandom(),
	promoId: uuid("promo_id")
		.notNull()
		.references(() => promo.id, { onDelete: "cascade" }),
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
export const promoRelations = relations(promo, ({ one }) => ({
	createdBy: one(user, {
		fields: [promo.createdById],
		references: [user.id],
	}),
}));

export const promoUsageRelations = relations(promoUsage, ({ one }) => ({
	promo: one(promo, {
		fields: [promoUsage.promoId],
		references: [promo.id],
	}),
	order: one(order, {
		fields: [promoUsage.orderId],
		references: [order.id],
	}),
	user: one(user, {
		fields: [promoUsage.userId],
		references: [user.id],
	}),
}));

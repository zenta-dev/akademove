import type { CouponRules, CouponType } from "@repo/schema/coupon";
import type { OrderType } from "@repo/schema/order";
import { relations } from "drizzle-orm";
import {
	boolean,
	integer,
	jsonb,
	numeric,
	text,
	uuid,
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import {
	createAuditLogTable,
	DateModifier,
	index,
	nowFn,
	pgTable,
	timestamp,
	uniqueIndex,
} from "./common";
import { merchant } from "./merchant";
import { order } from "./order";

export const coupon = pgTable(
	"coupons",
	{
		id: uuid().primaryKey(),
		name: text().notNull(),
		code: text().notNull(),
		couponType: text("coupon_type")
			.$type<CouponType>()
			.notNull()
			.default("GENERAL"),
		rules: jsonb().$type<CouponRules>().notNull(),
		discountAmount: numeric("discount_amount", {
			precision: 18,
			scale: 2,
		}),
		discountPercentage: numeric("discount_percentage", {
			precision: 5,
			scale: 2,
			mode: "number",
		}),
		usageLimit: integer("usage_limit").notNull(),
		usedCount: integer("used_count").notNull(),
		periodStart: timestamp("period_start").notNull(),
		periodEnd: timestamp("period_end").notNull(),
		isActive: boolean("is_active").notNull().default(false),
		merchantId: uuid("merchant_id").references(() => merchant.id, {
			onDelete: "cascade",
		}), // Nullable - if null, coupon is platform-wide
		// Service types this coupon is valid for (empty/null = all services)
		serviceTypes: jsonb("service_types").$type<OrderType[]>(),
		// Event-specific fields (for EVENT type coupons)
		eventName: text("event_name"),
		eventDescription: text("event_description"),
		createdById: text("created_by_id")
			.notNull()
			.references(() => user.id, { onDelete: "no action" }),
		...DateModifier,
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
		index("coupon_merchant_id_idx").on(t.merchantId),
		index("coupon_created_by_id_idx").on(t.createdById),
		index("coupon_used_count_idx").on(t.usedCount),
		index("coupon_created_at_idx").on(t.createdAt),
		index("coupon_type_idx").on(t.couponType),
		index("coupon_type_active_idx").on(t.couponType, t.isActive),
	],
);

export const couponAuditLog = createAuditLogTable("coupon");

export const couponUsage = pgTable(
	"coupon_usages",
	{
		id: uuid().primaryKey(),
		couponId: uuid("coupon_id")
			.notNull()
			.references(() => coupon.id, { onDelete: "cascade" }),
		orderId: uuid("order_id")
			.notNull()
			.references(() => order.id, { onDelete: "no action" }),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "no action" }),
		discountApplied: numeric("discount_applied", {
			precision: 18,
			scale: 2,
		}).notNull(),
		usedAt: timestamp("used_at").notNull().$defaultFn(nowFn),
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
	merchant: one(merchant, {
		fields: [coupon.merchantId],
		references: [merchant.id],
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

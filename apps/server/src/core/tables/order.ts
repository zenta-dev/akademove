import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import {
	geometry,
	integer,
	jsonb,
	numeric,
	serial,
	text,
	uuid,
} from "drizzle-orm/pg-core";
import { user, userGender } from "./auth";
import {
	DateModifier,
	index,
	nowFn,
	pgEnum,
	pgTable,
	timestamp,
} from "./common";
import { driver } from "./driver";
import { merchant, merchantMenu } from "./merchant";

export const orderStatus = pgEnum("order_status", CONSTANTS.ORDER_STATUSES);
export const orderType = pgEnum("order_type", CONSTANTS.ORDER_TYPES);

export interface OrderNote {
	pickup?: string;
	dropoff?: string;
}
export const order = pgTable(
	"orders",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		driverId: uuid("driver_id").references(() => driver.id, {
			onDelete: "set null",
		}),
		merchantId: uuid("merchant_id").references(() => merchant.id, {
			onDelete: "set null",
		}),
		type: orderType().notNull(),
		status: orderStatus().notNull().default("REQUESTED"),
		pickupLocation: geometry("pickup_location", {
			type: "point",
			mode: "xy",
			srid: 4326,
		}).notNull(),
		dropoffLocation: geometry("dropoff_location", {
			type: "point",
			mode: "xy",
			srid: 4326,
		}).notNull(),
		distanceKm: numeric("distance_km", {
			precision: 10,
			scale: 2,
			mode: "number",
		}).notNull(),
		basePrice: numeric("base_price", {
			precision: 18,
			scale: 2,
		}).notNull(),
		tip: numeric({
			precision: 18,
			scale: 2,
		}),
		totalPrice: numeric("total_price", {
			precision: 18,
			scale: 2,
		}).notNull(),
		platformCommission: numeric("platform_commission", {
			precision: 18,
			scale: 2,
		}),
		driverEarning: numeric("driver_earning", {
			precision: 18,
			scale: 2,
		}),
		merchantCommission: numeric("merchant_commission", {
			precision: 18,
			scale: 2,
		}),
		couponId: uuid("coupon_id"),
		couponCode: text("coupon_code"),
		discountAmount: numeric("discount_amount", {
			precision: 18,
			scale: 2,
		}),
		note: jsonb().$type<OrderNote>(),
		requestedAt: timestamp("requested_at").notNull().$defaultFn(nowFn),
		acceptedAt: timestamp("accepted_at"),
		preparedAt: timestamp("prepared_at"),
		readyAt: timestamp("ready_at"),
		arrivedAt: timestamp("arrived_at"),
		cancelReason: text(),
		...DateModifier,

		gender: userGender(),
		genderPreference: text("gender_preference").$type<"SAME" | "ANY">(),

		// Proof of delivery fields
		proofOfDeliveryUrl: text("proof_of_delivery_url"),
		deliveryOtp: text("delivery_otp"),
		otpVerifiedAt: timestamp("otp_verified_at"),
	},
	(t) => [
		// Foreign key indexes for filtering by user/driver/merchant
		index("order_user_id_idx").on(t.userId),
		index("order_driver_id_idx").on(t.driverId),
		index("order_merchant_id_idx").on(t.merchantId),

		// Status index for filtering by order status
		index("order_status_idx").on(t.status),

		// Composite indexes for common query patterns
		index("order_user_status_idx").on(t.userId, t.status),
		index("order_driver_status_idx").on(t.driverId, t.status),
		index("order_merchant_status_idx").on(t.merchantId, t.status),

		// Sorting indexes for common sort fields
		index("order_created_at_idx").on(t.createdAt),
		index("order_requested_at_idx").on(t.requestedAt),
		index("order_type_idx").on(t.type),

		// Composite index for cursor pagination (id + createdAt for efficient ordering)
		index("order_id_created_at_idx").on(t.id, t.createdAt),

		// Coupon index for analytics
		index("order_coupon_id_idx").on(t.couponId),
	],
);

export const orderItem = pgTable("order_items", {
	id: serial().primaryKey(),
	orderId: uuid()
		.notNull()
		.references(() => order.id),
	menuId: uuid()
		.notNull()
		.references(() => merchantMenu.id),
	quantity: integer().notNull(),
	unitPrice: numeric("unit_price", {
		precision: 18,
		scale: 2,
	}).notNull(),
});

///
/// --- Relations --- ///
///
export const orderRelations = relations(order, ({ one, many }) => ({
	user: one(user, {
		fields: [order.userId],
		references: [user.id],
	}),
	driver: one(driver, {
		fields: [order.driverId],
		references: [driver.id],
	}),
	merchant: one(merchant, {
		fields: [order.merchantId],
		references: [merchant.id],
	}),
	items: many(orderItem),
}));

export const orderItemRelations = relations(orderItem, ({ one }) => ({
	order: one(order, {
		fields: [orderItem.orderId],
		references: [order.id],
	}),
}));

export type OrderDatabase = typeof order.$inferSelect;

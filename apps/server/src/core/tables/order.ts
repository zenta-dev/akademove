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
export const deliveryItemType = pgEnum(
	"delivery_item_type",
	CONSTANTS.DELIVERY_ITEM_TYPES,
);

export interface OrderNote {
	pickup?: string;
	senderName?: string;
	senderPhone?: string;
	dropoff?: string;
	recevierName?: string;
	recevierPhone?: string;
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
		/** Stores the driver ID when order is completed, for review purposes even if driverId is later cleared */
		completedDriverId: uuid("completed_driver_id").references(() => driver.id, {
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
		pickupAddress: text("pickup_address"),
		dropoffAddress: text("dropoff_address"),
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
		merchantEarning: numeric("merchant_earning", {
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

		// Scheduled order fields
		scheduledAt: timestamp("scheduled_at"),
		scheduledMatchingAt: timestamp("scheduled_matching_at"),

		// Proof of delivery fields
		proofOfDeliveryUrl: text("proof_of_delivery_url"),
		deliveryOtp: text("delivery_otp"),
		otpVerifiedAt: timestamp("otp_verified_at"),

		// Delivery item photo (driver uploads photo of picked up item for verification)
		deliveryItemPhotoUrl: text("delivery_item_photo_url"),

		// Attachment for mart orders (e.g., document files for Printing merchants)
		attachmentUrl: text("attachment_url"),

		deliveryItemType: deliveryItemType(),
	},
	(t) => [
		// Foreign key indexes for filtering by user/driver/merchant
		index("order_user_id_idx").on(t.userId),
		index("order_driver_id_idx").on(t.driverId),
		index("order_completed_driver_id_idx").on(t.completedDriverId),
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

		// Scheduled orders indexes
		index("order_scheduled_at_idx").on(t.scheduledAt),
		index("order_scheduled_status_idx").on(t.status, t.scheduledAt),

		// Index for scheduled order cron query (finds orders where scheduledMatchingAt <= now)
		index("order_scheduled_matching_at_idx").on(
			t.status,
			t.scheduledMatchingAt,
		),

		// Composite index for date range queries with status filter
		index("order_status_requested_at_idx").on(t.status, t.requestedAt),
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

/**
 * Order Status History - Audit trail for order status changes
 *
 * Tracks all status transitions for debugging, analytics, and auditing:
 * - Previous and new status
 * - Who made the change (user, driver, system, merchant)
 * - Timestamp of change
 * - Optional metadata (reason, context)
 */
export const orderStatusHistory = pgTable(
	"order_status_history",
	{
		id: serial().primaryKey(),
		orderId: uuid("order_id")
			.notNull()
			.references(() => order.id, { onDelete: "cascade" }),
		previousStatus: orderStatus("previous_status"),
		newStatus: orderStatus("new_status").notNull(),
		changedBy: text("changed_by").references(() => user.id, {
			onDelete: "set null",
		}),
		changedByRole: text("changed_by_role").$type<
			"USER" | "DRIVER" | "MERCHANT" | "OPERATOR" | "ADMIN" | "SYSTEM"
		>(),
		reason: text(),
		metadata: jsonb().$type<Record<string, unknown>>(),
		changedAt: timestamp("changed_at").notNull().$defaultFn(nowFn),
	},
	(t) => [
		// Index for querying history by order
		index("order_status_history_order_id_idx").on(t.orderId),
		// Index for querying by timestamp (analytics)
		index("order_status_history_changed_at_idx").on(t.changedAt),
		// Composite index for querying by order and timestamp
		index("order_status_history_order_changed_at_idx").on(
			t.orderId,
			t.changedAt,
		),
	],
);

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
		relationName: "currentDriver",
	}),
	completedDriver: one(driver, {
		fields: [order.completedDriverId],
		references: [driver.id],
		relationName: "completedDriver",
	}),
	merchant: one(merchant, {
		fields: [order.merchantId],
		references: [merchant.id],
	}),
	items: many(orderItem),
	statusHistory: many(orderStatusHistory),
}));

export const orderItemRelations = relations(orderItem, ({ one }) => ({
	order: one(order, {
		fields: [orderItem.orderId],
		references: [order.id],
	}),
	menu: one(merchantMenu, {
		fields: [orderItem.menuId],
		references: [merchantMenu.id],
	}),
}));

export const orderStatusHistoryRelations = relations(
	orderStatusHistory,
	({ one }) => ({
		order: one(order, {
			fields: [orderStatusHistory.orderId],
			references: [order.id],
		}),
		changedByUser: one(user, {
			fields: [orderStatusHistory.changedBy],
			references: [user.id],
		}),
	}),
);

export type OrderDatabase = typeof order.$inferSelect;
export type OrderStatusHistoryDatabase = typeof orderStatusHistory.$inferSelect;

import type { Location } from "@repo/schema/common";
import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import {
	decimal,
	jsonb,
	pgEnum,
	pgTable,
	text,
	timestamp,
	uuid,
	index,
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import { driver } from "./driver";
import { merchant } from "./merchant";

export const orderStatus = pgEnum("order_status", CONSTANTS.ORDER_STATUSES);
export const orderType = pgEnum("order_type", CONSTANTS.ORDER_TYPES);

export interface OrderNote {
	pickup?: string;
	dropoff?: string;
}
export const order = pgTable(
	"orders",
	{
		id: uuid().primaryKey().defaultRandom(),
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
		status: orderStatus().notNull().default("requested"),
		pickupLocation: jsonb("pickup_location").$type<Location>().notNull(),
		dropoffLocation: jsonb("dropoff_location").$type<Location>().notNull(),
		distanceKm: decimal("distance_km", {
			precision: 10,
			scale: 2,
			mode: "number",
		}).notNull(),
		basePrice: decimal("base_price", {
			precision: 10,
			scale: 2,
			mode: "number",
		}).notNull(),
		tip: decimal({
			precision: 10,
			scale: 2,
			mode: "number",
		}),
		totalPrice: decimal("total_price", {
			precision: 10,
			scale: 2,
			mode: "number",
		}).notNull(),
		note: jsonb().$type<OrderNote>(),
		requestedAt: timestamp("requested_at").notNull().defaultNow(),
		acceptedAt: timestamp("accepted_at"),
		arrivedAt: timestamp("arrived_at"),
		createdAt: timestamp("created_at").notNull().defaultNow(),
		updatedAt: timestamp("updated_at").notNull().defaultNow(),
	},
	(t) => [
		index("order_user_id_idx").on(t.userId),
		index("order_driver_id_idx").on(t.driverId),
		index("order_merchant_id_idx").on(t.merchantId),
		index("order_type_idx").on(t.type),
		index("order_status_idx").on(t.status),
		index("order_status_driver_idx").on(t.status, t.driverId),
		index("order_user_status_idx").on(t.userId, t.status),
		index("order_driver_status_idx").on(t.driverId, t.status),
		index("order_merchant_status_idx").on(t.merchantId, t.status),
		index("order_type_status_idx").on(t.type, t.status),
		index("order_requested_at_idx").on(t.requestedAt),
		index("order_created_at_idx").on(t.createdAt),
		index("order_status_requested_at_idx").on(t.status, t.requestedAt),
	],
);

///
/// --- Relations --- ///
///
export const orderRelations = relations(order, ({ one }) => ({
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
}));

export type OrderDatabase = typeof order.$inferSelect;

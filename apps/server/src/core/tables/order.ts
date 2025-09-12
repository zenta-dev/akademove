import {
	boolean,
	decimal,
	jsonb,
	pgEnum,
	pgTable,
	text,
	timestamp,
	uuid,
} from "drizzle-orm/pg-core";
import type { Location } from "../interface";
import { user } from "./auth";
import { driver } from "./driver";
import { merchant } from "./merchant";

export const orderStatus = pgEnum("order_status", [
	"requested",
	"matching",
	"accepted",
	"arriving",
	"in_trip",
	"completed",
	"cancelled_by_user",
	"cancelled_by_driver",
	"cancelled_by_system",
]);
export const orderType = pgEnum("order_type", ["ride", "delivery", "food"]);

interface OrderNote {
	pickup?: string;
	dropoff?: string;
}
export const order = pgTable("orders", {
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
	})
		.notNull()
		.default(0.0),
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
});

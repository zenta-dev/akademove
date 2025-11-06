import type { Bank, Time } from "@repo/schema/common";
import { CONSTANTS } from "@repo/schema/constants";
import { relations, sql } from "drizzle-orm";
import {
	boolean,
	geometry,
	integer,
	jsonb,
	numeric,
	text,
	uuid,
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import { DateModifier, index, pgEnum, pgTable, timestamp } from "./common";

export const driverStatus = pgEnum("driver_status", CONSTANTS.DRIVER_STATUSES);

export const driver = pgTable(
	"drivers",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.unique()
			.references(() => user.id, { onDelete: "cascade" }),
		studentId: integer("student_id").notNull().unique(),
		licensePlate: text("license_plate").notNull().unique(),
		status: driverStatus().notNull().default("pending"),
		rating: numeric({ precision: 2, scale: 1, mode: "number" })
			.notNull()
			.default(0.0),
		isOnline: boolean("is_online").notNull().default(false),
		currentLocation: geometry("current_location", {
			type: "point",
			mode: "xy",
			srid: 4326,
		}),
		bank: jsonb().$type<Bank>().notNull(),
		lastLocationUpdate: timestamp("last_location_update"),
		studentCard: text("student_card").notNull(),
		driverLicense: text("driver_license").notNull(),
		vehicleCertificate: text("vehicle_certificate").notNull(),
		...DateModifier,
	},
	(t) => [
		index("driver_status_idx").on(t.status),
		index("driver_is_online_idx").on(t.isOnline),
		index("driver_rating_idx").on(t.rating),
		index("driver_status_online_idx").on(t.status, t.isOnline),
		index("driver_current_location_idx").using("gist", t.currentLocation),
		index("driver_online_location_idx")
			.using("gist", t.currentLocation)
			.where(sql`is_online = true`),
	],
);

///
/// --- Relations --- ///
///
export const driverRelations = relations(driver, ({ one }) => ({
	user: one(user, {
		fields: [driver.userId],
		references: [user.id],
	}),
}));

export type DriverDatabase = typeof driver.$inferSelect;
export const dayOfWeek = pgEnum("day_of_week", CONSTANTS.DAY_OF_WEEK);

export const driverSchedule = pgTable(
	"driver_schedules",
	{
		id: uuid().primaryKey(),
		driverId: uuid("driver_id")
			.notNull()
			.references(() => driver.id, { onDelete: "cascade" }),
		dayOfWeek: dayOfWeek().notNull(),
		startTime: jsonb("start_time").$type<Time>().notNull(),
		endTime: jsonb("end_time").$type<Time>().notNull(),
		isRecurring: boolean("is_recurring").notNull().default(true),
		specificDate: timestamp("specific_date"),
		isActive: boolean("is_active").notNull().default(true),
		...DateModifier,
	},
	(t) => [
		index("schedule_driver_id_idx").on(t.driverId),
		index("schedule_day_of_week_idx").on(t.dayOfWeek),
		index("schedule_is_active_idx").on(t.isActive),
		index("schedule_is_recurring_idx").on(t.isRecurring),
		index("schedule_specific_date_idx").on(t.specificDate),
		index("schedule_driver_active_idx").on(t.driverId, t.isActive),
		index("schedule_driver_day_idx").on(t.driverId, t.dayOfWeek),
		index("schedule_driver_day_active_idx").on(
			t.driverId,
			t.dayOfWeek,
			t.isActive,
		),
		index("schedule_driver_recurring_idx").on(t.driverId, t.isRecurring),
		index("schedule_created_at_idx").on(t.createdAt),
	],
);
///
/// --- Relations --- ///
///

export const driverScheduleRelations = relations(driverSchedule, ({ one }) => ({
	driver: one(driver, {
		fields: [driverSchedule.driverId],
		references: [driver.id],
	}),
}));

export type DriverScheduleDatabase = typeof driverSchedule.$inferSelect;

import type { Time } from "@repo/schema/common";
import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import {
	boolean,
	jsonb,
	pgEnum,
	pgTable,
	timestamp,
	uuid,
} from "drizzle-orm/pg-core";
import { driver } from "./driver";

export const dayOfWeek = pgEnum("day_of_week", CONSTANTS.DAY_OF_WEEK);

export const schedule = pgTable("schedules", {
	id: uuid().primaryKey().defaultRandom(),
	driverId: uuid("driver_id")
		.notNull()
		.references(() => driver.id, { onDelete: "cascade" }),
	dayOfWeek: dayOfWeek().notNull(),
	startTime: jsonb("start_time").$type<Time>().notNull(),
	endTime: jsonb("end_time").$type<Time>().notNull(),
	isRecurring: boolean("is_recurring").notNull().default(true),
	specificDate: timestamp("specific_date"),
	isActive: boolean("is_active").notNull().default(true),
	createdAt: timestamp("created_at").notNull().defaultNow(),
	updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

///
/// --- Relations --- ///
///
export const scheduleRelations = relations(schedule, ({ one }) => ({
	driver: one(driver, {
		fields: [schedule.driverId],
		references: [driver.id],
	}),
}));

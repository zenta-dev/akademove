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
	index,
} from "drizzle-orm/pg-core";
import { driver } from "./driver";

export const dayOfWeek = pgEnum("day_of_week", CONSTANTS.DAY_OF_WEEK);

export const schedule = pgTable(
	"schedules",
	{
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
export const scheduleRelations = relations(schedule, ({ one }) => ({
	driver: one(driver, {
		fields: [schedule.driverId],
		references: [driver.id],
	}),
}));

export type ScheduleDatabase = typeof schedule.$inferSelect;

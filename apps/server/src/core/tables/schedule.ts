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
import type { Time } from "../interface";
import { driver } from "./driver";

export const dayOfWeek = pgEnum("day_of_week", [
	"sunday",
	"monday",
	"tuesday",
	"wednesday",
	"thursday",
	"friday",
	"saturday",
]);

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

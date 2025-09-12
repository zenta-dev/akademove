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

export const driverStatus = pgEnum("driver_status", [
	"pending",
	"approved",
	"rejected",
	"active",
	"inactive",
	"suspended",
]);

export const driver = pgTable("drivers", {
	id: uuid().primaryKey().defaultRandom(),
	userId: text("user_id")
		.notNull()
		.references(() => user.id, { onDelete: "cascade" }),
	studentId: text("student_id").notNull().unique(),
	licenseNumber: text("license_number").notNull().unique(),
	status: driverStatus().notNull().default("pending"),
	rating: decimal({ precision: 2, scale: 1, mode: "number" })
		.notNull()
		.default(0.0),
	isOnline: boolean("is_online").notNull().default(false),
	currentLocation: jsonb("current_location").$type<Location>(),
	lastLocationUpdate: timestamp("last_location_update"),
	createdAt: timestamp("created_at").notNull().defaultNow(),
});

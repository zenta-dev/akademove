import type { Bank, Location } from "@repo/schema/common";
import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import {
	boolean,
	decimal,
	jsonb,
	numeric,
	pgEnum,
	pgTable,
	text,
	timestamp,
	uuid,
} from "drizzle-orm/pg-core";
import { user } from "./auth";

export const driverStatus = pgEnum("driver_status", CONSTANTS.DRIVER_STATUSES);

export const driver = pgTable("drivers", {
	id: uuid().primaryKey().defaultRandom(),
	userId: text("user_id")
		.notNull()
		.references(() => user.id, { onDelete: "cascade" }),
	studentId: numeric("student_id", { precision: 20, scale: 0 })
		.notNull()
		.unique(),
	licensePlate: text("license_plate").notNull().unique(),
	status: driverStatus().notNull().default("pending"),
	rating: decimal({ precision: 2, scale: 1, mode: "number" })
		.notNull()
		.default(0.0),
	isOnline: boolean("is_online").notNull().default(false),
	currentLocation: jsonb("current_location").$type<Location>(),
	bank: jsonb().$type<Bank>().notNull(),
	lastLocationUpdate: timestamp("last_location_update"),
	studentCard: text("student_card").notNull(),
	driverLicense: text("driver_license").notNull(),
	vehicleCertificate: text("vehicle_certificate").notNull(),
	createdAt: timestamp("created_at").notNull().defaultNow(),
});

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

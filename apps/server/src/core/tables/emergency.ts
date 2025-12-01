import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import { geometry, jsonb, text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import { index, nowFn, pgEnum, pgTable, timestamp } from "./common";
import { driver } from "./driver";
import { order } from "./order";

export const emergencyType = pgEnum(
	"emergency_type",
	CONSTANTS.EMERGENCY_TYPES,
);

export const emergencyStatus = pgEnum(
	"emergency_status",
	CONSTANTS.EMERGENCY_STATUS,
);

export const emergency = pgTable(
	"emergencies",
	{
		id: uuid().primaryKey(),
		orderId: uuid("order_id")
			.notNull()
			.references(() => order.id, {
				onDelete: "cascade",
			}),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, {
				onDelete: "no action",
			}),
		driverId: uuid("driver_id").references(() => driver.id, {
			onDelete: "set null",
		}),
		type: emergencyType().notNull().default("OTHER"),
		status: emergencyStatus().notNull().default("REPORTED"),
		description: text().notNull(),
		location: geometry("location", { type: "point", mode: "xy", srid: 4326 }),
		contactedAuthorities: jsonb("contacted_authorities")
			.$type<string[]>()
			.default([]),
		respondedById: text("responded_by_id").references(() => user.id, {
			onDelete: "set null",
		}),
		resolution: text(),
		reportedAt: timestamp("reported_at").notNull().$defaultFn(nowFn),
		acknowledgedAt: timestamp("acknowledged_at"),
		respondingAt: timestamp("responding_at"),
		resolvedAt: timestamp("resolved_at"),
	},
	(t) => [
		index("emergency_order_id_idx").on(t.orderId),
		index("emergency_user_id_idx").on(t.userId),
		index("emergency_driver_id_idx").on(t.driverId),
		index("emergency_type_idx").on(t.type),
		index("emergency_status_idx").on(t.status),
		index("emergency_responded_by_id_idx").on(t.respondedById),
		index("emergency_status_type_idx").on(t.status, t.type),
		index("emergency_reported_at_idx").on(t.reportedAt),
		index("emergency_status_reported_at_idx").on(t.status, t.reportedAt),
		// Spatial index for location-based queries
		index("emergency_location_idx").using("gist", t.location),
	],
);

///
/// --- Relations --- ///
///
export const emergencyRelations = relations(emergency, ({ one }) => ({
	order: one(order, {
		fields: [emergency.orderId],
		references: [order.id],
	}),
	user: one(user, {
		fields: [emergency.userId],
		references: [user.id],
	}),
	driver: one(driver, {
		fields: [emergency.driverId],
		references: [driver.id],
	}),
	respondedBy: one(user, {
		fields: [emergency.respondedById],
		references: [user.id],
	}),
}));

export type EmergencyDatabase = typeof emergency.$inferSelect;

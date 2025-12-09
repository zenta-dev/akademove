import {
	FRAUD_EVENT_TYPES,
	FRAUD_SEVERITY_LEVELS,
	FRAUD_STATUSES,
} from "@repo/schema/constants";
import type { FraudSignal } from "@repo/schema/fraud";
import { relations } from "drizzle-orm";
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
import {
	createAuditLogTable,
	DateModifier,
	index,
	pgEnum,
	pgTable,
	timestamp,
} from "./common";
import { driver } from "./driver";

export const fraudEventType = pgEnum("fraud_event_type", FRAUD_EVENT_TYPES);
export const fraudSeverity = pgEnum("fraud_severity", FRAUD_SEVERITY_LEVELS);
export const fraudStatus = pgEnum("fraud_status", FRAUD_STATUSES);

export const fraudEvent = pgTable(
	"fraud_events",
	{
		id: uuid().primaryKey(),
		eventType: fraudEventType("event_type").notNull(),
		severity: fraudSeverity().notNull(),
		status: fraudStatus().notNull().default("PENDING"),
		userId: text("user_id").references(() => user.id, { onDelete: "set null" }),
		driverId: uuid("driver_id").references(() => driver.id, {
			onDelete: "set null",
		}),

		// Detection details
		signals: jsonb().notNull().$type<FraudSignal[]>(),
		score: numeric({ precision: 5, scale: 2 }).notNull().default("0"),

		// Location context (GPS spoofing)
		location: geometry("location", { type: "point", mode: "xy", srid: 4326 }),
		previousLocation: geometry("previous_location", {
			type: "point",
			mode: "xy",
			srid: 4326,
		}),
		distanceKm: numeric("distance_km", { precision: 10, scale: 3 }),
		timeDeltaSeconds: integer("time_delta_seconds"),
		velocityKmh: numeric("velocity_kmh", { precision: 10, scale: 2 }),

		// Request context
		ipAddress: text("ip_address"),
		userAgent: text("user_agent"),

		// Resolution
		handledById: text("handled_by_id").references(() => user.id, {
			onDelete: "set null",
		}),
		resolution: text(),
		actionTaken: text("action_taken"),

		detectedAt: timestamp("detected_at").notNull(),
		resolvedAt: timestamp("resolved_at"),
		...DateModifier,
	},
	(t) => [
		index("fraud_event_type_idx").on(t.eventType),
		index("fraud_event_severity_idx").on(t.severity),
		index("fraud_event_status_idx").on(t.status),
		index("fraud_event_user_id_idx").on(t.userId),
		index("fraud_event_driver_id_idx").on(t.driverId),
		index("fraud_event_detected_at_idx").on(t.detectedAt),
		index("fraud_event_ip_address_idx").on(t.ipAddress),
		index("fraud_event_status_severity_idx").on(t.status, t.severity),
		index("fraud_event_created_at_idx").on(t.createdAt),
	],
);

export const userFraudProfile = pgTable(
	"user_fraud_profiles",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.unique()
			.references(() => user.id, { onDelete: "cascade" }),
		riskScore: numeric("risk_score", { precision: 5, scale: 2 })
			.notNull()
			.default("0"),
		totalEvents: integer("total_events").notNull().default(0),
		confirmedEvents: integer("confirmed_events").notNull().default(0),
		isHighRisk: boolean("is_high_risk").notNull().default(false),
		knownIps: jsonb("known_ips").$type<string[]>().notNull().default([]),
		lastEventAt: timestamp("last_event_at"),
		...DateModifier,
	},
	(t) => [
		index("fraud_profile_user_id_idx").on(t.userId),
		index("fraud_profile_risk_score_idx").on(t.riskScore),
		index("fraud_profile_is_high_risk_idx").on(t.isHighRisk),
		index("fraud_profile_last_event_idx").on(t.lastEventAt),
	],
);

// Relations
export const fraudEventRelations = relations(fraudEvent, ({ one }) => ({
	user: one(user, { fields: [fraudEvent.userId], references: [user.id] }),
	driver: one(driver, {
		fields: [fraudEvent.driverId],
		references: [driver.id],
	}),
	handledBy: one(user, {
		fields: [fraudEvent.handledById],
		references: [user.id],
	}),
}));

export const userFraudProfileRelations = relations(
	userFraudProfile,
	({ one }) => ({
		user: one(user, {
			fields: [userFraudProfile.userId],
			references: [user.id],
		}),
	}),
);

// Types
export type FraudEventDatabase = typeof fraudEvent.$inferSelect;
export type UserFraudProfileDatabase = typeof userFraudProfile.$inferSelect;

// Audit log
export const fraudEventAuditLog = createAuditLogTable("fraud_event");

import { relations } from "drizzle-orm";
import { boolean, integer, text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import { DateModifier, index, nowFn, pgTable, timestamp } from "./common";

export const emergencyContact = pgTable(
	"emergency_contacts",
	{
		id: uuid().primaryKey(),
		name: text().notNull(),
		phone: text().notNull(),
		description: text(),
		isActive: boolean("is_active").notNull().default(true),
		priority: integer().notNull().default(0),
		createdAt: timestamp("created_at").notNull().$defaultFn(nowFn),
		updatedAt: DateModifier.updatedAt,
		createdById: text("created_by_id").references(() => user.id, {
			onDelete: "set null",
		}),
		updatedById: text("updated_by_id").references(() => user.id, {
			onDelete: "set null",
		}),
	},
	(t) => [
		index("emergency_contact_is_active_idx").on(t.isActive),
		index("emergency_contact_priority_idx").on(t.priority),
		index("emergency_contact_created_at_idx").on(t.createdAt),
	],
);

///
/// --- Relations --- ///
///
export const emergencyContactRelations = relations(
	emergencyContact,
	({ one }) => ({
		createdBy: one(user, {
			fields: [emergencyContact.createdById],
			references: [user.id],
			relationName: "emergencyContactCreatedBy",
		}),
		updatedBy: one(user, {
			fields: [emergencyContact.updatedById],
			references: [user.id],
			relationName: "emergencyContactUpdatedBy",
		}),
	}),
);

export type EmergencyContactDatabase = typeof emergencyContact.$inferSelect;

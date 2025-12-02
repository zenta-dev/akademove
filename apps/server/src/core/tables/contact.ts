import { relations } from "drizzle-orm";
import { text, uuid, varchar } from "drizzle-orm/pg-core";
import { user } from "./auth";
import {
	createAuditLogTable,
	index,
	nowFn,
	pgEnum,
	pgTable,
	timestamp,
} from "./common";

export const contactStatus = pgEnum("contact_status", [
	"PENDING",
	"REVIEWING",
	"RESOLVED",
	"CLOSED",
]);

export const contact = pgTable(
	"contacts",
	{
		id: uuid().primaryKey(),
		name: varchar({ length: 255 }).notNull(),
		email: varchar({ length: 255 }).notNull(),
		subject: varchar({ length: 500 }).notNull(),
		message: text().notNull(),
		status: contactStatus().notNull().default("PENDING"),
		userId: text("user_id").references(() => user.id, {
			onDelete: "set null",
		}),
		respondedById: text("responded_by_id").references(() => user.id, {
			onDelete: "set null",
		}),
		response: text(),
		createdAt: timestamp("created_at").notNull().$defaultFn(nowFn),
		updatedAt: timestamp("updated_at")
			.notNull()
			.$defaultFn(nowFn)
			.$onUpdate(nowFn),
		respondedAt: timestamp("responded_at"),
	},
	(t) => [
		index("contact_email_idx").on(t.email),
		index("contact_user_id_idx").on(t.userId),
		index("contact_status_idx").on(t.status),
		index("contact_responded_by_id_idx").on(t.respondedById),
		index("contact_created_at_idx").on(t.createdAt),
		index("contact_status_created_at_idx").on(t.status, t.createdAt),
		index("contact_user_status_idx").on(t.userId, t.status),
	],
);

export const contactAuditLog = createAuditLogTable("contact");

///
/// --- Relations --- ///
///
export const contactRelations = relations(contact, ({ one }) => ({
	user: one(user, {
		fields: [contact.userId],
		references: [user.id],
	}),
	respondedBy: one(user, {
		fields: [contact.respondedById],
		references: [user.id],
	}),
}));

export type ContactDatabase = typeof contact.$inferSelect;

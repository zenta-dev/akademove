import type { ConfigurationValue } from "@repo/schema/configuration";
import { relations } from "drizzle-orm";
import { jsonb, text, varchar } from "drizzle-orm/pg-core";
import { user } from "./auth";
import { createAuditLogTable, DateModifier, pgTable } from "./common";

export const configuration = pgTable("configurations", {
	key: varchar({ length: 255 }).primaryKey(),
	name: varchar({ length: 255 }).notNull(),
	value: jsonb().$type<ConfigurationValue>().notNull(),
	description: text(),
	updatedById: text("updated_by_id")
		.notNull()
		.references(() => user.id, { onDelete: "no action" }),
	...DateModifier,
});
export type ConfigurationTable = typeof configuration;

export const configurationAuditLog = createAuditLogTable("configurations");
export type ConfigurationAuditLogTable = typeof configurationAuditLog;

///
/// --- Relations --- ///
///
export const configurationRelations = relations(configuration, ({ one }) => ({
	updater: one(user, {
		fields: [configuration.updatedById],
		references: [user.id],
	}),
}));

export type ConfigurationDatabase = typeof configuration.$inferSelect;

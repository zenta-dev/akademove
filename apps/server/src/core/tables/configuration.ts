import { relations } from "drizzle-orm";
import { jsonb, pgTable, text, timestamp, varchar } from "drizzle-orm/pg-core";
import { user } from "./auth";

export const configuration = pgTable("configurations", {
	key: varchar({ length: 255 }).primaryKey(),
	name: varchar({ length: 255 }).notNull(),
	value: jsonb().notNull(),
	description: text(),
	updatedById: text()
		.notNull()
		.references(() => user.id, { onDelete: "no action" }),
	updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

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

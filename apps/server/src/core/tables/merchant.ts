import type { Location } from "@repo/schema/common";
import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
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
import { user } from "./auth";

export const merchantType = pgEnum("merchant_type", CONSTANTS.MERCHANT_TYPES);

export const merchant = pgTable("merchants", {
	id: uuid().primaryKey().defaultRandom(),
	userId: text("user_id")
		.notNull()
		.references(() => user.id, { onDelete: "cascade" }),
	type: merchantType().notNull(),
	name: text().notNull(),
	address: text().notNull(),
	location: jsonb().$type<Location>(),
	isActive: boolean("is_active").notNull().default(true),
	rating: decimal({ precision: 2, scale: 1, mode: "number" }),
	createdAt: timestamp("created_at").notNull().defaultNow(),
	updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

///
/// --- Relations --- ///
///
export const merchantRelations = relations(merchant, ({ one }) => ({
	user: one(user, {
		fields: [merchant.userId],
		references: [user.id],
	}),
}));

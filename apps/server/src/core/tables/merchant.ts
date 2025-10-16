import type { Bank, Location } from "@repo/schema/common";
import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import {
	boolean,
	decimal,
	integer,
	jsonb,
	pgEnum,
	pgTable,
	text,
	timestamp,
	uuid,
	varchar,
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
	email: text().notNull().unique(),
	phone: text().notNull().unique(),
	address: text().notNull(),
	location: jsonb().$type<Location>(),
	bank: jsonb().$type<Bank>().notNull(),
	isActive: boolean("is_active").notNull().default(true),
	rating: decimal({ precision: 2, scale: 1, mode: "number" })
		.notNull()
		.default(0),
	document: text(),
	createdAt: timestamp("created_at").notNull().defaultNow(),
	updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const merchantMenu = pgTable("merchant_menus", {
	id: uuid().primaryKey().defaultRandom(),
	merchantId: uuid()
		.notNull()
		.references(() => merchant.id, { onDelete: "cascade" }),
	name: varchar({ length: 255 }).notNull(),
	category: varchar({ length: 255 }),
	price: decimal("base_price", {
		precision: 10,
		scale: 2,
		mode: "number",
	}).notNull(),
	stock: integer().notNull(),
	image: text(),
	createdAt: timestamp("created_at").notNull().defaultNow(),
	updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

///
/// --- Relations --- ///
///
export const merchantRelations = relations(merchant, ({ one, many }) => ({
	user: one(user, {
		fields: [merchant.userId],
		references: [user.id],
	}),
	menus: many(merchantMenu),
}));

export const merchantMenuRelations = relations(merchantMenu, ({ one }) => ({
	merchant: one(merchant, {
		fields: [merchantMenu.merchantId],
		references: [merchant.id],
	}),
}));

export type MerchantDatabase = typeof merchant.$inferSelect;
export type MerchantMenuDatabase = typeof merchantMenu.$inferSelect;

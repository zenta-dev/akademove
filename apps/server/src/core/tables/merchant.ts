import type { Bank, Location, Phone } from "@repo/schema/common";
import { relations } from "drizzle-orm";
import {
	boolean,
	decimal,
	index,
	integer,
	jsonb,
	pgTable,
	text,
	uniqueIndex,
	uuid,
	varchar,
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import { DateModifier } from "./common";

// export const merchantType = pgEnum("merchant_type", CONSTANTS.MERCHANT_TYPES);

export const merchant = pgTable(
	"merchants",
	{
		id: uuid().primaryKey().defaultRandom(),
		userId: text("user_id")
			.notNull()
			.unique()
			.references(() => user.id, { onDelete: "cascade" }),
		// type: merchantType().notNull(),
		name: text().notNull(),
		email: text().notNull().unique(),
		phone: jsonb().$type<Phone>().notNull().unique(),
		address: text().notNull(),
		location: jsonb().$type<Location>(),
		bank: jsonb().$type<Bank>().notNull(),
		isActive: boolean("is_active").notNull().default(true),
		rating: decimal({ precision: 2, scale: 1, mode: "number" })
			.notNull()
			.default(0),
		document: text(),
		...DateModifier,
	},
	(t) => [
		uniqueIndex("merchant_user_id_idx").on(t.userId),
		uniqueIndex("merchant_email_idx").on(t.email),
		uniqueIndex("merchant_phone_idx").on(t.phone),
		// index("merchant_type_idx").on(t.type),
		index("merchant_is_active_idx").on(t.isActive),
		index("merchant_rating_idx").on(t.rating),
		// index("merchant_type_active_idx").on(t.type, t.isActive),
		index("merchant_created_at_idx").on(t.createdAt),
	],
);

export const merchantMenu = pgTable(
	"merchant_menus",
	{
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
		...DateModifier,
	},
	(t) => [
		index("merchant_menu_merchant_id_idx").on(t.merchantId),
		index("merchant_menu_category_idx").on(t.category),
		index("merchant_menu_stock_idx").on(t.stock),
		index("merchant_menu_merchant_category_idx").on(t.merchantId, t.category),
		index("merchant_menu_price_idx").on(t.price),
		index("merchant_menu_created_at_idx").on(t.createdAt),
	],
);

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

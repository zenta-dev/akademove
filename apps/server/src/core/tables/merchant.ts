import type { Bank, Phone, Time } from "@repo/schema/common";
import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import {
	boolean,
	geometry,
	integer,
	jsonb,
	numeric,
	text,
	uuid,
	varchar,
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import { DateModifier, index, pgEnum, pgTable, uniqueIndex } from "./common";
import { dayOfWeek } from "./driver";

export const merchantCategory = pgEnum(
	"merchant_category",
	CONSTANTS.MERCHANT_CATEGORIES,
);

export const merchantOperatingStatus = pgEnum(
	"merchant_operating_status",
	CONSTANTS.MERCHANT_OPERATING_STATUSES,
);

export const merchantStatus = pgEnum(
	"merchant_status",
	CONSTANTS.MERCHANT_STATUSES,
);

export const merchant = pgTable(
	"merchants",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.unique()
			.references(() => user.id, { onDelete: "cascade" }),
		name: text().notNull(),
		email: text().notNull().unique(),
		phone: jsonb().$type<Phone>().unique(),
		address: text().notNull(),
		location: geometry("location", { type: "point", mode: "xy", srid: 4326 }),
		bank: jsonb().$type<Bank>().notNull(),
		category: merchantCategory().notNull(),
		categories: text().array(),
		status: merchantStatus().notNull().default("PENDING"),
		isActive: boolean("is_active").notNull().default(false),
		isOnline: boolean("is_online").notNull().default(false),
		operatingStatus: merchantOperatingStatus("operating_status")
			.notNull()
			.default("CLOSED"),
		activeOrderCount: integer("active_order_count").notNull().default(0),
		rating: numeric({ precision: 2, scale: 1, mode: "number" })
			.notNull()
			.default(0.0),
		document: text(),
		image: text(),
		...DateModifier,
	},
	(t) => [
		uniqueIndex("merchant_user_id_idx").on(t.userId),
		uniqueIndex("merchant_email_idx").on(t.email),
		uniqueIndex("merchant_phone_idx").on(t.phone),
		// Text search index for name field (used in order list searches)
		index("merchant_name_text_idx").on(t.name.op("text_pattern_ops")),
		// Index for category enum filtering
		index("merchant_category_idx").on(t.category),
		index("merchant_status_idx").on(t.status),
		index("merchant_is_active_idx").on(t.isActive),
		index("merchant_is_online_idx").on(t.isOnline),
		index("merchant_operating_status_idx").on(t.operatingStatus),
		index("merchant_rating_idx").on(t.rating),
		index("merchant_active_order_count_idx").on(t.activeOrderCount),
		// Composite index for status + active filtering
		index("merchant_status_active_idx").on(t.status, t.isActive),
		index("merchant_created_at_idx").on(t.createdAt),
		index("merchant_location_idx").using("gist", t.location),
		// GIN index for categories array filtering
		index("merchant_categories_idx").using("gin", t.categories),
	],
);

export const merchantMenu = pgTable(
	"merchant_menus",
	{
		id: uuid().primaryKey(),
		merchantId: uuid()
			.notNull()
			.references(() => merchant.id, { onDelete: "cascade" }),
		name: varchar({ length: 255 }).notNull(),
		category: varchar({ length: 255 }),
		price: numeric("base_price", {
			precision: 10,
			scale: 2,
		}).notNull(),
		stock: integer().notNull(),
		soldStock: integer("sold_stock").notNull().default(0),
		image: text(),
		...DateModifier,
	},
	(t) => [
		index("merchant_menu_merchant_id_idx").on(t.merchantId),
		index("merchant_menu_category_idx").on(t.category),
		index("merchant_menu_stock_idx").on(t.stock),
		index("merchant_menu_sold_stock_idx").on(t.soldStock),
		index("merchant_menu_merchant_category_idx").on(t.merchantId, t.category),
		index("merchant_menu_price_idx").on(t.price),
		index("merchant_menu_created_at_idx").on(t.createdAt),
	],
);

export const merchantOperatingHours = pgTable(
	"merchant_operating_hours",
	{
		id: uuid().primaryKey(),
		merchantId: uuid("merchant_id")
			.notNull()
			.references(() => merchant.id, { onDelete: "cascade" }),
		dayOfWeek: dayOfWeek("day_of_week").notNull(),
		isOpen: boolean("is_open").notNull().default(true),
		is24Hours: boolean("is_24_hours").notNull().default(false),
		openTime: jsonb("open_time").$type<Time>(),
		closeTime: jsonb("close_time").$type<Time>(),
		...DateModifier,
	},
	(t) => [
		index("merchant_operating_hours_merchant_id_idx").on(t.merchantId),
		index("merchant_operating_hours_day_idx").on(t.dayOfWeek),
		index("merchant_operating_hours_is_open_idx").on(t.isOpen),
		// Composite index for merchant + day lookup (most common query)
		uniqueIndex("merchant_operating_hours_merchant_day_idx").on(
			t.merchantId,
			t.dayOfWeek,
		),
		index("merchant_operating_hours_created_at_idx").on(t.createdAt),
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
	operatingHours: many(merchantOperatingHours),
}));

export const merchantMenuRelations = relations(merchantMenu, ({ one }) => ({
	merchant: one(merchant, {
		fields: [merchantMenu.merchantId],
		references: [merchant.id],
	}),
}));

export const merchantOperatingHoursRelations = relations(
	merchantOperatingHours,
	({ one }) => ({
		merchant: one(merchant, {
			fields: [merchantOperatingHours.merchantId],
			references: [merchant.id],
		}),
	}),
);

export type MerchantDatabase = typeof merchant.$inferSelect;
export type MerchantMenuDatabase = typeof merchantMenu.$inferSelect;
export type MerchantOperatingHoursDatabase =
	typeof merchantOperatingHours.$inferSelect;

import type { Phone } from "@repo/schema/common";
import { CONSTANTS } from "@repo/schema/constants";
import type { UserRole } from "@repo/schema/user";
import { relations } from "drizzle-orm";
import {
	boolean,
	jsonb,
	pgEnum,
	pgTable,
	text,
	timestamp,
	uniqueIndex,
	index,
} from "drizzle-orm/pg-core";

export const userGender = pgEnum("user_gender", CONSTANTS.USER_GENDERS);

export const user = pgTable(
	"users",
	{
		id: text("id").primaryKey(),
		name: text("name").notNull(),
		email: text("email").notNull().unique(),
		emailVerified: boolean("email_verified").notNull().default(false),
		image: text("image"),
		role: text().notNull().$type<UserRole>().default("user"),
		banned: boolean().notNull().default(false),
		banReason: text("ban_reason"),
		gender: userGender().notNull(),
		phone: jsonb().$type<Phone>().notNull().unique(),
		banExpires: timestamp("ban_expires", { mode: "date" }),
		createdAt: timestamp("created_at", { mode: "date" })
			.notNull()
			.$defaultFn(() => new Date()),
		updatedAt: timestamp("updated_at", { mode: "date" })
			.notNull()
			.$defaultFn(() => new Date())
			.$onUpdateFn(() => new Date()),
	},
	(t) => [
		uniqueIndex("user_email_idx").on(t.email),
		uniqueIndex("user_phone_idx").on(t.phone),
		index("user_role_idx").on(t.role),
	],
);

export const account = pgTable(
	"accounts",
	{
		id: text("id").primaryKey(),
		accountId: text("account_id").notNull(),
		providerId: text("provider_id").notNull(),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		accessToken: text("access_token"),
		refreshToken: text("refresh_token"),
		idToken: text("id_token"),
		accessTokenExpiresAt: timestamp("access_token_expires_at", {
			mode: "date",
		}),
		refreshTokenExpiresAt: timestamp("refresh_token_expires_at", {
			mode: "date",
		}),
		scope: text("scope"),
		password: text("password"),
		createdAt: timestamp("created_at", { mode: "date" })
			.notNull()
			.$defaultFn(() => new Date()),
		updatedAt: timestamp("updated_at", { mode: "date" })
			.notNull()
			.$defaultFn(() => new Date())
			.$onUpdateFn(() => new Date()),
	},
	(t) => [
		index("account_user_id_idx").on(t.userId),
		index("account_provider_idx").on(t.providerId, t.accountId),
	],
);

export const verification = pgTable(
	"verifications",
	{
		id: text("id").primaryKey(),
		identifier: text("identifier").notNull().unique(),
		value: text("value").notNull(),
		expiresAt: timestamp("expires_at", { mode: "date" }).notNull(),
		createdAt: timestamp("created_at", { mode: "date" }),
		updatedAt: timestamp("updated_at", { mode: "date" }),
	},
	(t) => [
		uniqueIndex("verification_identifier_idx").on(t.identifier),
		index("verification_expires_at_idx").on(t.expiresAt),
	],
);

///
/// --- Relations --- ///
///
export const userRelations = relations(user, ({ many }) => ({
	accounts: many(account),
}));

export const accountRelations = relations(account, ({ one }) => ({
	user: one(user, {
		fields: [account.userId],
		references: [user.id],
	}),
}));

export type UserDatabase = typeof user.$inferSelect;

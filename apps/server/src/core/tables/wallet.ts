import { CURRENCY } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import { boolean, numeric, text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import { DateModifier, pgEnum, pgTable } from "./common";
import { transaction } from "./transaction";

export const walletCurrencyEnum = pgEnum("wallet_currency", CURRENCY);

export const wallet = pgTable("wallets", {
	id: uuid().primaryKey(),
	userId: text("user_id")
		.notNull()
		.references(() => user.id, { onDelete: "cascade" }),
	balance: numeric({ precision: 18, scale: 2 }).default("0").notNull(),
	currency: walletCurrencyEnum().default("IDR").notNull(),
	isActive: boolean("is_active").default(true).notNull(),
	...DateModifier,
});

export const walletRelations = relations(wallet, ({ one, many }) => ({
	user: one(user, {
		fields: [wallet.userId],
		references: [user.id],
	}),
	transactions: many(transaction),
}));

export type walletDatabase = typeof wallet.$inferSelect;

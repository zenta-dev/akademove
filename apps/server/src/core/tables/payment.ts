import {
	CONSTANTS,
	PAYMENT_METHOD,
	PAYMENT_PROVIDER,
} from "@repo/schema/constants";
import type { VANumber } from "@repo/schema/payment";
import { relations } from "drizzle-orm";
import { jsonb, numeric, text, uuid, varchar } from "drizzle-orm/pg-core";
import { DateModifier, index, pgEnum, pgTable, timestamp } from "./common";
import { transaction, transactionStatusEnum } from "./transaction";

export const paymentProviderEnum = pgEnum("payment_provider", PAYMENT_PROVIDER);
export const paymentMethodEnum = pgEnum("payment_method", PAYMENT_METHOD);
export const bankProviderEnum = pgEnum(
	"bank_provider",
	CONSTANTS.BANK_PROVIDERS,
);

export const payment = pgTable(
	"payments",
	{
		id: uuid().primaryKey(),
		transactionId: uuid("transaction_id")
			.notNull()
			.references(() => transaction.id, {
				onDelete: "cascade",
			}),
		provider: paymentProviderEnum().notNull(),
		method: paymentMethodEnum().notNull(),
		bankProvider: bankProviderEnum(),
		amount: numeric("amount", { precision: 18, scale: 2 }).notNull(),
		status: transactionStatusEnum().notNull().default("PENDING"),
		externalId: varchar("external_id", { length: 100 }).unique(),
		paymentUrl: text("payment_url"),
		va_number: jsonb("va_number").$type<VANumber>(),
		metadata: jsonb(),
		expiresAt: timestamp("expires_at"),
		payload: jsonb(),
		response: jsonb(),
		...DateModifier,
	},
	(t) => [index("payment_external_id_idx").on(t.externalId)],
);

export type PaymentDatabase = typeof payment.$inferSelect;

///
/// --- Relations --- ///
///
export const paymentRelations = relations(payment, ({ one }) => ({
	transaction: one(transaction, {
		fields: [payment.transactionId],
		references: [transaction.id],
	}),
}));

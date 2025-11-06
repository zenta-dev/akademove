import { PAYMENT_METHOD, PAYMENT_PROVIDER } from "@repo/schema/constants";
import { jsonb, numeric, text, uuid, varchar } from "drizzle-orm/pg-core";
import { DateModifier, index, pgEnum, pgTable, timestamp } from "./common";
import { transaction, transactionStatusEnum } from "./transaction";

export const paymentProviderEnum = pgEnum("payment_provider", PAYMENT_PROVIDER);
export const paymentMethodEnum = pgEnum("payment_method", PAYMENT_METHOD);

export const payment = pgTable(
	"payments",
	{
		id: uuid().primaryKey(),
		transactionId: uuid("transaction_id").references(() => transaction.id, {
			onDelete: "cascade",
		}),
		provider: paymentProviderEnum().notNull(),
		method: paymentMethodEnum().notNull(),
		amount: numeric("amount", { precision: 18, scale: 2 }).notNull(),
		status: transactionStatusEnum().notNull().default("pending"),
		externalId: varchar("external_id", { length: 100 }).unique(),
		paymentUrl: text("payment_url"),
		metadata: jsonb(),
		expiresAt: timestamp("expires_at"),
		payload: jsonb(),
		response: jsonb(),
		...DateModifier,
	},
	(t) => [index("payment_external_id_idx").on(t.externalId)],
);

export type PaymentDatabase = typeof payment.$inferSelect;

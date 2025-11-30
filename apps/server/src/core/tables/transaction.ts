import { TRANSACTION_STATUS, TRANSACTION_TYPE } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import { jsonb, numeric, text, uuid } from "drizzle-orm/pg-core";
import { DateModifier, index, pgEnum, pgTable } from "./common";
import { wallet } from "./wallet";

export const transactionTypeEnum = pgEnum("transaction_type", TRANSACTION_TYPE);

export const transactionStatusEnum = pgEnum(
	"transaction_status",
	TRANSACTION_STATUS,
);

export const transaction = pgTable(
	"transactions",
	{
		id: uuid().primaryKey(),
		walletId: uuid("wallet_id")
			.notNull()
			.references(() => wallet.id, { onDelete: "cascade" }),
		type: transactionTypeEnum().notNull(),
		amount: numeric({ precision: 18, scale: 2 }).notNull(),
		balanceBefore: numeric("balance_before", { precision: 18, scale: 2 }),
		balanceAfter: numeric("balance_after", { precision: 18, scale: 2 }),
		status: transactionStatusEnum().default("PENDING").notNull(),
		description: text(),
		referenceId: text("reference_id"),
		metadata: jsonb(),
		...DateModifier,
	},
	(t) => [
		// Existing index
		index("transaction_wallet_id_idx").on(t.walletId),

		// OPTIMIZATION: Add indexes for common query patterns
		index("transaction_status_idx").on(t.status),
		index("transaction_wallet_status_idx").on(t.walletId, t.status),
		index("transaction_wallet_status_date_idx").on(
			t.walletId,
			t.status,
			t.createdAt,
		),
		index("transaction_created_at_idx").on(t.createdAt),
		index("transaction_reference_id_idx").on(t.referenceId),
	],
);

export const transactionRelations = relations(transaction, ({ one }) => ({
	wallet: one(wallet, {
		fields: [transaction.walletId],
		references: [wallet.id],
	}),
}));
export type TransactionDatabase = typeof transaction.$inferSelect;

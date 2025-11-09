import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.ts";
import { TRANSACTION_STATUS, TRANSACTION_TYPE } from "./constants.ts";
import { extractSchemaKeysAsEnum } from "./enum.helper.ts";

export const TransactionTypeSchema = z.enum(TRANSACTION_TYPE);
export const TransactionStatusSchema = z.enum(TRANSACTION_STATUS);

export const TransactionSchema = z
	.object({
		id: z.uuid(),
		walletId: z.uuid(),
		type: TransactionTypeSchema,
		amount: z.number(),
		balanceBefore: z.number().optional(),
		balanceAfter: z.number().optional(),
		status: TransactionStatusSchema,
		description: z.string().optional(),
		referenceId: z.string().optional(),
		metadata: z.any().optional(),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({
		title: "WalletTransaction",
	});

export const TransactionKeySchema = extractSchemaKeysAsEnum(TransactionSchema);

export const InsertTransactionSchema = TransactionSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
}).meta({ title: "InsertTransaction" });

export const UpdateTransactionSchema = InsertTransactionSchema.partial().meta({
	title: "UpdateTransaction",
});

export type TransactionType = z.infer<typeof TransactionTypeSchema>;
export type TransactionStatus = z.infer<typeof TransactionStatusSchema>;
export type Transaction = z.infer<typeof TransactionSchema>;
export type InsertTransaction = z.infer<typeof InsertTransactionSchema>;
export type UpdateTransaction = z.infer<typeof UpdateTransactionSchema>;

export const TransactionSchemaRegistries = {
	TransactionType: { schema: TransactionTypeSchema, strategy: "output" },
	TransactionStatus: { schema: TransactionStatusSchema, strategy: "output" },
	Transaction: { schema: TransactionSchema, strategy: "output" },
	InsertTransaction: { schema: InsertTransactionSchema, strategy: "input" },
	UpdateTransaction: { schema: UpdateTransactionSchema, strategy: "input" },
	TransactionKey: { schema: TransactionKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

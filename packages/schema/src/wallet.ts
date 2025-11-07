import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.ts";
import { CURRENCY } from "./constants.ts";

export const CurrencySchema = z.enum(CURRENCY);

export const WalletSchema = z
	.object({
		id: z.uuid(),
		userId: z.string(),
		balance: z.number(),
		currency: CurrencySchema,
		isActive: z.boolean(),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({ title: "Wallet" });

export const UpdateWalletSchema = WalletSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
})
	.partial()
	.meta({ title: "UpdateWallet" });

export const WalletMonthlySummaryQuerySchema = z
	.object({
		year: z.coerce.number(),
		month: z.coerce.number(),
	})
	.meta({ title: "WalletMonthlySummaryQuery" });

export const WalletMonthlySummaryResponseSchema = z
	.object({
		month: z.string().describe("YYYY-MM"),
		totalIncome: z.coerce.number(),
		totalExpense: z.coerce.number(),
		net: z.coerce.number(),
	})
	.meta({ title: "WalletMonthlySummaryResponse" });

export type WalletCurrency = z.infer<typeof CurrencySchema>;
export type Wallet = z.infer<typeof WalletSchema>;
export type UpdateWallet = z.infer<typeof UpdateWalletSchema>;
export type WalletMonthlySummaryRequest = z.infer<
	typeof WalletMonthlySummaryQuerySchema
>;
export type WalletMonthlySummaryResponse = z.infer<
	typeof WalletMonthlySummaryResponseSchema
>;

export const WalletSchemaRegistries = {
	Currency: { schema: CurrencySchema, strategy: "output" },
	Wallet: { schema: WalletSchema, strategy: "output" },
	UpdateWallet: { schema: UpdateWalletSchema, strategy: "input" },
	WalletMonthlySummaryResponse: {
		schema: WalletMonthlySummaryResponseSchema,
		strategy: "output",
	},
	WalletMonthlySummaryQuery: {
		schema: WalletMonthlySummaryQuerySchema,
		strategy: "input",
	},
} satisfies SchemaRegistries;

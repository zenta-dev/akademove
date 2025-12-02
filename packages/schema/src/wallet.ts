import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { CURRENCY } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const CurrencySchema = z.enum(CURRENCY);

export const walletSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	balance: z.number(),
	currency: CurrencySchema,
	isActive: z.boolean(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});

export const walletKeySchema = extractSchemaKeysAsEnum(walletSchema);

export const UpdatewalletSchema = walletSchema
	.omit({
		id: true,
		createdAt: true,
		updatedAt: true,
	})
	.partial();

export const walletMonthlySummaryQuerySchema = z.object({
	year: z.coerce.number(),
	month: z.coerce.number(),
});

export const walletMonthlySummaryResponseSchema = z.object({
	month: z.string().describe("YYYY-MM"),
	totalIncome: z.coerce.number(),
	totalExpense: z.coerce.number(),
	net: z.coerce.number(),
});

export type walletCurrency = z.infer<typeof CurrencySchema>;
export type wallet = z.infer<typeof walletSchema>;
export type Updatewallet = z.infer<typeof UpdatewalletSchema>;
export type walletMonthlySummaryRequest = z.infer<
	typeof walletMonthlySummaryQuerySchema
>;
export type walletMonthlySummaryResponse = z.infer<
	typeof walletMonthlySummaryResponseSchema
>;

export const walletSchemaRegistries = {
	Currency: { schema: CurrencySchema, strategy: "output" },
	wallet: { schema: walletSchema, strategy: "output" },
	Updatewallet: { schema: UpdatewalletSchema, strategy: "input" },
	walletMonthlySummaryResponse: {
		schema: walletMonthlySummaryResponseSchema,
		strategy: "output",
	},
	walletMonthlySummaryQuery: {
		schema: walletMonthlySummaryQuerySchema,
		strategy: "input",
	},
	walletKey: { schema: walletKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

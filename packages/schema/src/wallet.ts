import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { CURRENCY } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const CurrencySchema = z.enum(CURRENCY);

export const WalletSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	balance: z.coerce.number(),
	currency: CurrencySchema,
	isActive: z.boolean(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});

export const WalletKeySchema = extractSchemaKeysAsEnum(WalletSchema);

export const UpdateWalletSchema = WalletSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
}).partial();

export const WalletMonthlySummaryQuerySchema = z.object({
	year: z.coerce.number(),
	month: z.coerce.number(),
});

export const WalletMonthlySummaryResponseSchema = z.object({
	month: z.string().describe("YYYY-MM"),
	totalIncome: z.coerce.number(),
	totalExpense: z.coerce.number(),
	net: z.coerce.number(),
	/** Total earnings from completed orders (EARNING transactions) */
	totalEarnings: z.coerce.number(),
	/** Total platform commission deducted (COMMISSION transactions) */
	totalCommission: z.coerce.number(),
	/** Platform commission rate (as percentage, e.g., 20 = 20%) */
	commissionRate: z.coerce.number(),
});

// Commission Report schemas
export const CommissionReportPeriodSchema = z.enum([
	"daily",
	"weekly",
	"monthly",
]);
export type CommissionReportPeriod = z.infer<
	typeof CommissionReportPeriodSchema
>;

export const CommissionReportQuerySchema = z.object({
	period: CommissionReportPeriodSchema.default("daily"),
	startDate: z.coerce.date().optional(),
	endDate: z.coerce.date().optional(),
});

export const CommissionTransactionSchema = z.object({
	id: z.uuid(),
	type: z.enum(["EARNING", "COMMISSION"]),
	amount: z.coerce.number(),
	description: z.string().optional(),
	orderType: z.string().optional(),
	createdAt: DateSchema,
});

export const ChartDataPointSchema = z.object({
	label: z.string(),
	income: z.coerce.number(),
	outcome: z.coerce.number(),
});

export const CommissionReportResponseSchema = z.object({
	currentBalance: z.coerce.number(),
	incomingBalance: z.coerce.number(),
	outgoingBalance: z.coerce.number(),
	totalEarnings: z.coerce.number(),
	totalCommission: z.coerce.number(),
	netIncome: z.coerce.number(),
	commissionRate: z.coerce.number(),
	chartData: z.array(ChartDataPointSchema),
	transactions: z.array(CommissionTransactionSchema),
	period: CommissionReportPeriodSchema,
});

export type CommissionReportQuery = z.infer<typeof CommissionReportQuerySchema>;
export type CommissionTransaction = z.infer<typeof CommissionTransactionSchema>;
export type ChartDataPoint = z.infer<typeof ChartDataPointSchema>;
export type CommissionReportResponse = z.infer<
	typeof CommissionReportResponseSchema
>;

export type WalletCurrency = z.infer<typeof CurrencySchema>;
export type Wallet = z.infer<typeof WalletSchema>;
export type UpdateWallet = z.infer<typeof UpdateWalletSchema>;
export type WalletMonthlySummaryRequest = z.infer<
	typeof WalletMonthlySummaryQuerySchema
>;
export type WalletMonthlySummaryResponse = z.infer<
	typeof WalletMonthlySummaryResponseSchema
>;

export const walletSchemaRegistries = {
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
	walletKey: { schema: WalletKeySchema, strategy: "input" },
	CommissionReportPeriod: {
		schema: CommissionReportPeriodSchema,
		strategy: "input",
	},
	CommissionReportQuery: {
		schema: CommissionReportQuerySchema,
		strategy: "input",
	},
	CommissionTransaction: {
		schema: CommissionTransactionSchema,
		strategy: "output",
	},
	ChartDataPoint: {
		schema: ChartDataPointSchema,
		strategy: "output",
	},
	CommissionReportResponse: {
		schema: CommissionReportResponseSchema,
		strategy: "output",
	},
} satisfies SchemaRegistries;

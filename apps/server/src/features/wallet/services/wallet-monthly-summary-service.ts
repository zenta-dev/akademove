import type {
	WalletMonthlySummaryRequest,
	WalletMonthlySummaryResponse,
} from "@repo/schema/wallet";
import { sql } from "drizzle-orm";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { safeAsync } from "@/utils";

type DatabaseOrTransaction = DatabaseService | DatabaseTransaction;

/**
 * Service responsible for calculating wallet monthly summaries
 *
 * @responsibility Calculate income, expense, and net balance for a given month
 */
export class WalletMonthlySummaryService {
	/**
	 * Calculate date range for a given year and month
	 */
	static calculateDateRange(
		year: number,
		month: number,
	): {
		startDate: Date;
		endDate: Date;
	} {
		const startDate = new Date(Date.UTC(year, month - 1, 1, 0, 0, 0));
		const endDate = new Date(Date.UTC(year, month, 1, 0, 0, 0));

		return { startDate, endDate };
	}

	/**
	 * Format month as YYYY-MM string
	 */
	static formatMonth(year: number, month: number): string {
		return `${year}-${String(month).padStart(2, "0")}`;
	}

	/**
	 * Categorize transaction types into income/expense
	 */
	static categorizeTransaction(
		type:
			| "TOPUP"
			| "REFUND"
			| "PAYMENT"
			| "WITHDRAW"
			| "ADJUSTMENT"
			| "COMMISSION"
			| "EARNING",
		amount: number,
	): {
		income: number;
		expense: number;
	} {
		switch (type) {
			case "TOPUP":
			case "REFUND":
			case "EARNING":
				return { income: amount, expense: 0 };
			case "PAYMENT":
			case "WITHDRAW":
			case "COMMISSION":
				return { income: 0, expense: amount };
			case "ADJUSTMENT":
				// For adjustments (transfers), check if amount is positive or negative
				// Positive amount = incoming transfer (income)
				// Negative amount = outgoing transfer (expense)
				if (amount >= 0) {
					return { income: amount, expense: 0 };
				}
				return { income: 0, expense: Math.abs(amount) };
			default:
				return { income: 0, expense: 0 };
		}
	}

	/**
	 * Calculate monthly summary from transaction aggregates
	 */
	static calculateSummary(
		rows:
			| Array<{
					type:
						| "TOPUP"
						| "REFUND"
						| "PAYMENT"
						| "WITHDRAW"
						| "ADJUSTMENT"
						| "COMMISSION"
						| "EARNING";
					total: string;
			  }>
			| undefined,
		year: number,
		month: number,
	): WalletMonthlySummaryResponse {
		const monthStr = WalletMonthlySummaryService.formatMonth(year, month);

		if (!rows || rows.length === 0) {
			return {
				month: monthStr,
				totalIncome: 0,
				totalExpense: 0,
				net: 0,
			};
		}

		let totalIncome = 0;
		let totalExpense = 0;

		for (const row of rows) {
			const amount = Number(row.total);
			const { income, expense } =
				WalletMonthlySummaryService.categorizeTransaction(row.type, amount);
			totalIncome += income;
			totalExpense += expense;
		}

		return {
			month: monthStr,
			totalIncome,
			totalExpense,
			net: totalIncome - totalExpense,
		};
	}

	/**
	 * Fetch transaction aggregates for a wallet in a given month
	 */
	static async fetchMonthlyTransactions(
		db: DatabaseOrTransaction,
		walletId: string,
		year: number,
		month: number,
	): Promise<
		| Array<{
				type:
					| "TOPUP"
					| "REFUND"
					| "PAYMENT"
					| "WITHDRAW"
					| "ADJUSTMENT"
					| "COMMISSION"
					| "EARNING";
				total: string;
		  }>
		| undefined
	> {
		const { startDate, endDate } =
			WalletMonthlySummaryService.calculateDateRange(year, month);

		const res = await safeAsync(
			db
				.select({
					type: tables.transaction.type,
					total: sql<string>`SUM(${tables.transaction.amount})`,
				})
				.from(tables.transaction)
				.where(
					sql`${tables.transaction.walletId} = ${walletId} AND ${tables.transaction.status} = 'SUCCESS' AND ${tables.transaction.createdAt} >= ${startDate} AND ${tables.transaction.createdAt} < ${endDate}`,
				)
				.groupBy(tables.transaction.type),
		);

		return res.data;
	}

	/**
	 * Get monthly summary for a wallet
	 */
	static async getMonthlySummary(
		db: DatabaseOrTransaction,
		params: WalletMonthlySummaryRequest & { walletId: string },
	): Promise<WalletMonthlySummaryResponse> {
		const { walletId, year, month } = params;

		const rows = await WalletMonthlySummaryService.fetchMonthlyTransactions(
			db,
			walletId,
			year,
			month,
		);

		return WalletMonthlySummaryService.calculateSummary(rows, year, month);
	}
}

import type {
	ChartDataPoint,
	CommissionReportPeriod,
	CommissionReportQuery,
	CommissionReportResponse,
	CommissionTransaction,
} from "@repo/schema/wallet";
import { and, desc, eq, gte, inArray, lt, sql } from "drizzle-orm";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { toNumberSafe } from "@/utils";

type DatabaseOrTransaction = DatabaseService | DatabaseTransaction;

/**
 * Service responsible for generating commission reports for drivers
 *
 * @responsibility Calculate and aggregate commission data for reporting
 */
export class CommissionReportService {
	/**
	 * Calculate date range based on period
	 */
	static calculateDateRange(
		period: CommissionReportPeriod,
		startDate?: Date,
		endDate?: Date,
	): { start: Date; end: Date } {
		const now = new Date();
		const end = endDate ?? now;

		if (startDate) {
			return { start: startDate, end };
		}

		let start: Date;
		switch (period) {
			case "daily":
				// Last 24 hours
				start = new Date(end);
				start.setHours(0, 0, 0, 0);
				break;
			case "weekly":
				// Last 7 days
				start = new Date(end);
				start.setDate(start.getDate() - 6);
				start.setHours(0, 0, 0, 0);
				break;
			case "monthly":
				// Last 30 days
				start = new Date(end);
				start.setDate(start.getDate() - 29);
				start.setHours(0, 0, 0, 0);
				break;
			default:
				start = new Date(end);
				start.setHours(0, 0, 0, 0);
		}

		return { start, end };
	}

	/**
	 * Generate chart data based on period
	 */
	static async generateChartData(
		db: DatabaseOrTransaction,
		walletId: string,
		period: CommissionReportPeriod,
		start: Date,
		end: Date,
	): Promise<ChartDataPoint[]> {
		const chartData: ChartDataPoint[] = [];

		switch (period) {
			case "daily": {
				// Group by hour
				const hourlyData = await db
					.select({
						hour: sql<number>`EXTRACT(HOUR FROM ${tables.transaction.createdAt})`,
						type: tables.transaction.type,
						total: sql<string>`SUM(ABS(${tables.transaction.amount}))`,
					})
					.from(tables.transaction)
					.where(
						and(
							eq(tables.transaction.walletId, walletId),
							eq(tables.transaction.status, "SUCCESS"),
							inArray(tables.transaction.type, ["EARNING", "COMMISSION"]),
							gte(tables.transaction.createdAt, start),
							lt(tables.transaction.createdAt, end),
						),
					)
					.groupBy(
						sql`EXTRACT(HOUR FROM ${tables.transaction.createdAt})`,
						tables.transaction.type,
					);

				// Create hourly chart data
				for (let hour = 0; hour < 24; hour++) {
					const hourStr = `${hour.toString().padStart(2, "0")}:00`;
					const earning = hourlyData.find(
						(d) => Number(d.hour) === hour && d.type === "EARNING",
					);
					const commission = hourlyData.find(
						(d) => Number(d.hour) === hour && d.type === "COMMISSION",
					);

					chartData.push({
						label: hourStr,
						income: earning ? toNumberSafe(earning.total) : 0,
						outcome: commission ? toNumberSafe(commission.total) : 0,
					});
				}
				break;
			}
			case "weekly": {
				// Group by day
				const dailyData = await db
					.select({
						day: sql<string>`TO_CHAR(${tables.transaction.createdAt}, 'Dy')`,
						dayNum: sql<number>`EXTRACT(DOW FROM ${tables.transaction.createdAt})`,
						type: tables.transaction.type,
						total: sql<string>`SUM(ABS(${tables.transaction.amount}))`,
					})
					.from(tables.transaction)
					.where(
						and(
							eq(tables.transaction.walletId, walletId),
							eq(tables.transaction.status, "SUCCESS"),
							inArray(tables.transaction.type, ["EARNING", "COMMISSION"]),
							gte(tables.transaction.createdAt, start),
							lt(tables.transaction.createdAt, end),
						),
					)
					.groupBy(
						sql`TO_CHAR(${tables.transaction.createdAt}, 'Dy')`,
						sql`EXTRACT(DOW FROM ${tables.transaction.createdAt})`,
						tables.transaction.type,
					);

				const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
				for (let i = 0; i < 7; i++) {
					const earning = dailyData.find(
						(d) => Number(d.dayNum) === i && d.type === "EARNING",
					);
					const commission = dailyData.find(
						(d) => Number(d.dayNum) === i && d.type === "COMMISSION",
					);

					chartData.push({
						label: days[i],
						income: earning ? toNumberSafe(earning.total) : 0,
						outcome: commission ? toNumberSafe(commission.total) : 0,
					});
				}
				break;
			}
			case "monthly": {
				// Group by week
				const weeklyData = await db
					.select({
						week: sql<number>`EXTRACT(WEEK FROM ${tables.transaction.createdAt})`,
						type: tables.transaction.type,
						total: sql<string>`SUM(ABS(${tables.transaction.amount}))`,
					})
					.from(tables.transaction)
					.where(
						and(
							eq(tables.transaction.walletId, walletId),
							eq(tables.transaction.status, "SUCCESS"),
							inArray(tables.transaction.type, ["EARNING", "COMMISSION"]),
							gte(tables.transaction.createdAt, start),
							lt(tables.transaction.createdAt, end),
						),
					)
					.groupBy(
						sql`EXTRACT(WEEK FROM ${tables.transaction.createdAt})`,
						tables.transaction.type,
					);

				// Get unique weeks in range
				const weeks = [...new Set(weeklyData.map((d) => Number(d.week)))].sort(
					(a, b) => a - b,
				);

				for (const week of weeks) {
					const earning = weeklyData.find(
						(d) => Number(d.week) === week && d.type === "EARNING",
					);
					const commission = weeklyData.find(
						(d) => Number(d.week) === week && d.type === "COMMISSION",
					);

					chartData.push({
						label: `Week ${week}`,
						income: earning ? toNumberSafe(earning.total) : 0,
						outcome: commission ? toNumberSafe(commission.total) : 0,
					});
				}

				// If no data, create placeholder weeks
				if (chartData.length === 0) {
					for (let i = 1; i <= 4; i++) {
						chartData.push({
							label: `Week ${i}`,
							income: 0,
							outcome: 0,
						});
					}
				}
				break;
			}
		}

		return chartData;
	}

	/**
	 * Fetch commission-related transactions
	 */
	static async fetchTransactions(
		db: DatabaseOrTransaction,
		walletId: string,
		start: Date,
		end: Date,
		limit = 50,
	): Promise<CommissionTransaction[]> {
		const transactions = await db
			.select({
				id: tables.transaction.id,
				type: tables.transaction.type,
				amount: tables.transaction.amount,
				description: tables.transaction.description,
				metadata: tables.transaction.metadata,
				createdAt: tables.transaction.createdAt,
			})
			.from(tables.transaction)
			.where(
				and(
					eq(tables.transaction.walletId, walletId),
					eq(tables.transaction.status, "SUCCESS"),
					inArray(tables.transaction.type, ["EARNING", "COMMISSION"]),
					gte(tables.transaction.createdAt, start),
					lt(tables.transaction.createdAt, end),
				),
			)
			.orderBy(desc(tables.transaction.createdAt))
			.limit(limit);

		return transactions.map((t) => ({
			id: t.id,
			type: t.type as "EARNING" | "COMMISSION",
			amount: Math.abs(toNumberSafe(t.amount)),
			description: t.description ?? undefined,
			orderType: (t.metadata as Record<string, unknown> | null)?.orderType as
				| string
				| undefined,
			createdAt: t.createdAt,
		}));
	}

	/**
	 * Calculate totals from transactions in a period
	 */
	static async calculateTotals(
		db: DatabaseOrTransaction,
		walletId: string,
		start: Date,
		end: Date,
	): Promise<{
		totalEarnings: number;
		totalCommission: number;
		incomingBalance: number;
		outgoingBalance: number;
	}> {
		const result = await db
			.select({
				type: tables.transaction.type,
				total: sql<string>`SUM(ABS(${tables.transaction.amount}))`,
			})
			.from(tables.transaction)
			.where(
				and(
					eq(tables.transaction.walletId, walletId),
					eq(tables.transaction.status, "SUCCESS"),
					inArray(tables.transaction.type, [
						"EARNING",
						"COMMISSION",
						"TOPUP",
						"REFUND",
						"WITHDRAW",
						"PAYMENT",
					]),
					gte(tables.transaction.createdAt, start),
					lt(tables.transaction.createdAt, end),
				),
			)
			.groupBy(tables.transaction.type);

		let totalEarnings = 0;
		let totalCommission = 0;
		let incomingBalance = 0;
		let outgoingBalance = 0;

		for (const row of result) {
			const amount = toNumberSafe(row.total);
			switch (row.type) {
				case "EARNING":
					totalEarnings = amount;
					incomingBalance += amount;
					break;
				case "TOPUP":
				case "REFUND":
					incomingBalance += amount;
					break;
				case "COMMISSION":
					totalCommission = amount;
					outgoingBalance += amount;
					break;
				case "WITHDRAW":
				case "PAYMENT":
					outgoingBalance += amount;
					break;
			}
		}

		return {
			totalEarnings,
			totalCommission,
			incomingBalance,
			outgoingBalance,
		};
	}

	/**
	 * Get commission report for a wallet
	 */
	static async getCommissionReport(
		db: DatabaseOrTransaction,
		walletId: string,
		currentBalance: number,
		query: CommissionReportQuery,
	): Promise<CommissionReportResponse> {
		const period = query.period ?? "daily";
		const { start, end } = CommissionReportService.calculateDateRange(
			period,
			query.startDate,
			query.endDate,
		);

		const [totals, chartData, transactions] = await Promise.all([
			CommissionReportService.calculateTotals(db, walletId, start, end),
			CommissionReportService.generateChartData(
				db,
				walletId,
				period,
				start,
				end,
			),
			CommissionReportService.fetchTransactions(db, walletId, start, end),
		]);

		const netIncome = totals.totalEarnings - totals.totalCommission;
		const commissionRate =
			totals.totalEarnings > 0
				? (totals.totalCommission / totals.totalEarnings) * 100
				: 0;

		return {
			currentBalance,
			incomingBalance: totals.incomingBalance,
			outgoingBalance: totals.outgoingBalance,
			totalEarnings: totals.totalEarnings,
			totalCommission: totals.totalCommission,
			netIncome,
			commissionRate: Math.round(commissionRate * 100) / 100,
			chartData,
			transactions,
			period,
		};
	}
}

import type {
	ChartDataPoint,
	CommissionReportPeriod,
	CommissionReportQuery,
	CommissionReportResponse,
	CommissionTransaction,
} from "@repo/schema/wallet";
import { and, desc, eq, gte, inArray, lte, sql } from "drizzle-orm";
import { CACHE_TTLS } from "@/core/constants";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

const log = logger.child({ module: "CommissionReportService" });

type DatabaseOrTransaction = DatabaseService | DatabaseTransaction;

/**
 * Cache key pattern for driver commission reports
 */
export function getCommissionReportCacheKey(
	walletId: string,
	period: CommissionReportPeriod,
): string {
	return `commission-report:driver:${walletId}:${period}`;
}

/**
 * Service responsible for generating commission reports for drivers
 *
 * @responsibility Calculate and aggregate commission data for reporting
 */
export class CommissionReportService {
	/**
	 * Calculate date range based on period
	 * Returns inclusive start and end dates for the period
	 */
	static calculateDateRange(
		period: CommissionReportPeriod,
		startDate?: Date,
		endDate?: Date,
	): { start: Date; end: Date } {
		const now = new Date();

		// If custom dates are provided, use them with proper end-of-day for end date
		if (startDate && endDate) {
			const end = new Date(endDate);
			end.setHours(23, 59, 59, 999);
			return { start: startDate, end };
		}

		if (startDate) {
			// If only start date provided, end is now
			return { start: startDate, end: now };
		}

		let start: Date;
		let end: Date;

		switch (period) {
			case "daily":
				// Today from 00:00:00 to 23:59:59
				start = new Date(now);
				start.setHours(0, 0, 0, 0);
				end = new Date(now);
				end.setHours(23, 59, 59, 999);
				break;
			case "weekly":
				// Last 7 days from start of first day to end of today
				start = new Date(now);
				start.setDate(start.getDate() - 6);
				start.setHours(0, 0, 0, 0);
				end = new Date(now);
				end.setHours(23, 59, 59, 999);
				break;
			case "monthly":
				// Last 30 days from start of first day to end of today
				start = new Date(now);
				start.setDate(start.getDate() - 29);
				start.setHours(0, 0, 0, 0);
				end = new Date(now);
				end.setHours(23, 59, 59, 999);
				break;
			default:
				// Default to today
				start = new Date(now);
				start.setHours(0, 0, 0, 0);
				end = new Date(now);
				end.setHours(23, 59, 59, 999);
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
							lte(tables.transaction.createdAt, end),
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
							lte(tables.transaction.createdAt, end),
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
							lte(tables.transaction.createdAt, end),
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
					lte(tables.transaction.createdAt, end),
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
					lte(tables.transaction.createdAt, end),
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

		log.info(
			{
				walletId,
				period,
				start: start.toISOString(),
				end: end.toISOString(),
			},
			"[CommissionReportService] Generating commission report",
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

		log.info(
			{
				walletId,
				totalEarnings: totals.totalEarnings,
				totalCommission: totals.totalCommission,
				incomingBalance: totals.incomingBalance,
				outgoingBalance: totals.outgoingBalance,
				transactionsCount: transactions.length,
			},
			"[CommissionReportService] Commission report generated",
		);

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

	/**
	 * Get commission report with cache support
	 *
	 * This method first checks KV cache for pre-computed reports
	 * (populated by the commission report cron job).
	 * Falls back to computing the report if cache miss.
	 *
	 * @param db - Database service
	 * @param kv - KV cache service
	 * @param walletId - Wallet ID to get report for
	 * @param currentBalance - Current wallet balance
	 * @param query - Report query parameters
	 * @returns Commission report response
	 */
	static async getCommissionReportWithCache(
		db: DatabaseOrTransaction,
		kv: KeyValueService,
		walletId: string,
		currentBalance: number,
		query: CommissionReportQuery,
	): Promise<CommissionReportResponse> {
		const period = query.period ?? "daily";

		// For custom date ranges, always compute fresh (don't use cache)
		if (query.startDate || query.endDate) {
			return CommissionReportService.getCommissionReport(
				db,
				walletId,
				currentBalance,
				query,
			);
		}

		const cacheKey = getCommissionReportCacheKey(walletId, period);

		// Use fallback pattern to handle cache miss gracefully
		const report = await kv.get<CommissionReportResponse>(cacheKey, {
			fallback: async () => {
				log.debug(
					{ walletId, period, cacheKey },
					"[CommissionReportService] Cache miss, computing fresh report",
				);

				// Compute fresh report
				const freshReport = await CommissionReportService.getCommissionReport(
					db,
					walletId,
					currentBalance,
					query,
				);

				// Cache the result for future requests
				try {
					await kv.put(cacheKey, freshReport, {
						expirationTtl: CACHE_TTLS["1h"],
					});
				} catch (error) {
					log.warn(
						{ error, walletId, period },
						"[CommissionReportService] Failed to cache report",
					);
				}

				return freshReport;
			},
		});

		// Update current balance as it may have changed since cache was created
		report.currentBalance = currentBalance;

		log.debug(
			{ walletId, period, cacheKey },
			"[CommissionReportService] Returning commission report",
		);

		return report;
	}
}

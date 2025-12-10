import type {
	LEADERBOARD_CATEGORIES,
	LEADERBOARD_PERIODS,
} from "@repo/schema/constants";
import { and, eq } from "drizzle-orm";
import { v7 } from "uuid";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import type { DriverMetrics } from "@/features/driver/services/driver-metrics-service";
import { DriverMetricsService } from "@/features/driver/services/driver-metrics-service";
import { logger } from "@/utils/logger";
import { LeaderboardScoreCalculator } from "./leaderboard-score-calculator";

type LeaderboardPeriod = (typeof LEADERBOARD_PERIODS)[number];
type LeaderboardCategory = (typeof LEADERBOARD_CATEGORIES)[number];

interface PeriodDates {
	periodStart: Date;
	periodEnd: Date;
}

interface DriverScoreEntry {
	userId: string;
	driverId: string;
	score: number;
}

/**
 * Service for calculating and updating leaderboard rankings
 * Handles batch processing for all drivers, categories, and periods
 */
export class LeaderboardCalculationService {
	#db: DatabaseService;
	#metricsService: DriverMetricsService;

	constructor(db: DatabaseService) {
		this.#db = db;
		this.#metricsService = new DriverMetricsService(db);
	}

	/**
	 * Calculate and update leaderboards for all periods and categories
	 * This is the main entry point for scheduled cron jobs
	 */
	async calculateAllLeaderboards(): Promise<void> {
		try {
			logger.info(
				{},
				"[LeaderboardCalculationService] Starting full leaderboard calculation",
			);

			const periods: LeaderboardPeriod[] = [
				"DAILY",
				"WEEKLY",
				"MONTHLY",
				"QUARTERLY",
				"YEARLY",
				"ALL-TIME",
			];
			const categories: LeaderboardCategory[] = [
				"RATING",
				"VOLUME",
				"EARNINGS",
				"ON-TIME",
				"COMPLETION-RATE",
				"STREAK",
			];

			// Process all combinations of period + category within transactions
			for (const period of periods) {
				for (const category of categories) {
					await this.#db.transaction(async (tx) => {
						await this.calculateLeaderboardForPeriodAndCategory(
							period,
							category,
							{
								tx,
							},
						);
					});
				}
			}

			logger.info(
				{},
				"[LeaderboardCalculationService] Completed full leaderboard calculation",
			);
		} catch (error) {
			logger.error(
				{ error },
				"[LeaderboardCalculationService] Failed to calculate leaderboards",
			);
			throw error;
		}
	}

	/**
	 * Calculate and update leaderboard for a specific period and category
	 */
	async calculateLeaderboardForPeriodAndCategory(
		period: LeaderboardPeriod,
		category: LeaderboardCategory,
		opts?: { tx: DatabaseTransaction },
	): Promise<void> {
		try {
			const db = opts?.tx ?? this.#db;
			const { periodStart, periodEnd } = this.#getPeriodDates(period);

			logger.info(
				{ period, category, periodStart, periodEnd },
				"[LeaderboardCalculationService] Calculating leaderboard",
			);

			// Get all active drivers
			const activeDrivers = await db.query.driver.findMany({
				where: (f, _op) => eq(f.status, "ACTIVE"),
			});

			if (activeDrivers.length === 0) {
				logger.info(
					{ period, category },
					"[LeaderboardCalculationService] No active drivers found",
				);
				return;
			}

			// Calculate scores for all drivers
			const driverScores: DriverScoreEntry[] = [];

			for (const driver of activeDrivers) {
				const metrics = await this.#metricsService.calculateDriverMetrics(
					driver.id,
					opts,
				);

				// Filter metrics based on period for non-ALL-TIME periods
				const filteredMetrics =
					period === "ALL-TIME"
						? metrics
						: await this.#filterMetricsByPeriod(
								driver.id,
								metrics,
								periodStart,
								periodEnd,
								db,
							);

				const score = LeaderboardScoreCalculator.calculateScore(
					category,
					filteredMetrics,
				);

				driverScores.push({
					userId: driver.userId,
					driverId: driver.id,
					score,
				});
			}

			// Sort by score descending
			driverScores.sort((a, b) => b.score - a.score);

			// Assign ranks and upsert to database
			await this.#upsertLeaderboardEntries(
				driverScores,
				category,
				period,
				periodStart,
				periodEnd,
				db,
			);

			logger.info(
				{ period, category, entries: driverScores.length },
				"[LeaderboardCalculationService] Leaderboard calculated successfully",
			);
		} catch (error) {
			logger.error(
				{ error, period, category },
				"[LeaderboardCalculationService] Failed to calculate leaderboard",
			);
			throw error;
		}
	}

	/**
	 * Get period start and end dates based on period type
	 */
	#getPeriodDates(period: LeaderboardPeriod): PeriodDates {
		const now = new Date();
		let periodStart: Date;
		let periodEnd: Date;

		switch (period) {
			case "DAILY": {
				periodStart = new Date(now);
				periodStart.setHours(0, 0, 0, 0);
				periodEnd = new Date(periodStart);
				periodEnd.setDate(periodEnd.getDate() + 1);
				break;
			}
			case "WEEKLY": {
				periodStart = new Date(now);
				const dayOfWeek = periodStart.getDay();
				periodStart.setDate(periodStart.getDate() - dayOfWeek); // Start of week (Sunday)
				periodStart.setHours(0, 0, 0, 0);
				periodEnd = new Date(periodStart);
				periodEnd.setDate(periodEnd.getDate() + 7);
				break;
			}
			case "MONTHLY": {
				periodStart = new Date(now.getFullYear(), now.getMonth(), 1);
				periodStart.setHours(0, 0, 0, 0);
				periodEnd = new Date(now.getFullYear(), now.getMonth() + 1, 1);
				break;
			}
			case "QUARTERLY": {
				const quarter = Math.floor(now.getMonth() / 3);
				periodStart = new Date(now.getFullYear(), quarter * 3, 1);
				periodStart.setHours(0, 0, 0, 0);
				periodEnd = new Date(now.getFullYear(), (quarter + 1) * 3, 1);
				break;
			}
			case "YEARLY": {
				periodStart = new Date(now.getFullYear(), 0, 1);
				periodStart.setHours(0, 0, 0, 0);
				periodEnd = new Date(now.getFullYear() + 1, 0, 1);
				break;
			}
			case "ALL-TIME": {
				// For all-time, use epoch as start and far future as end
				periodStart = new Date(0);
				periodEnd = new Date(2099, 11, 31);
				break;
			}
			default: {
				const _exhaustive: never = period;
				throw new Error(`Unknown period: ${_exhaustive}`);
			}
		}

		return { periodStart, periodEnd };
	}

	/**
	 * Filter driver metrics to only include data within the specified period
	 * For non-ALL-TIME periods, we need to recalculate metrics based on period-specific data
	 */
	async #filterMetricsByPeriod(
		driverId: string,
		metrics: DriverMetrics,
		periodStart: Date,
		periodEnd: Date,
		db: DatabaseService | DatabaseTransaction,
	): Promise<DriverMetrics> {
		// For period-specific calculations, we need to query orders within the period
		const periodOrders = await db.query.order.findMany({
			where: (f, op) =>
				and(
					eq(f.driverId, driverId),
					op.gte(f.createdAt, periodStart),
					op.lt(f.createdAt, periodEnd),
				),
		});

		const completedOrders = periodOrders.filter(
			(o) => o.status === "COMPLETED",
		);
		const totalOrders = periodOrders.length;
		const completedCount = completedOrders.length;

		// Calculate earnings for period
		const totalEarnings = completedOrders.reduce(
			(sum, order) => sum + Number(order.driverEarning ?? 0),
			0,
		);

		// Calculate on-time rate for period
		const onTimeThresholdMinutes = 10;
		let onTimeCount = 0;
		for (const order of completedOrders) {
			if (!order.acceptedAt || !order.arrivedAt) continue;
			const timeDiffMs = order.arrivedAt.getTime() - order.acceptedAt.getTime();
			const timeDiffMinutes = timeDiffMs / (1000 * 60);
			if (timeDiffMinutes <= onTimeThresholdMinutes) {
				onTimeCount++;
			}
		}
		const onTimeRate = completedCount > 0 ? onTimeCount / completedCount : 0;

		// Use full metrics for rating (reviews are cumulative)
		// and streak (current streak is current)
		return {
			...metrics,
			totalOrders,
			completedOrders: completedCount,
			completionRate: totalOrders > 0 ? completedCount / totalOrders : 0,
			onTimeRate,
			totalEarnings,
		};
	}

	/**
	 * Upsert leaderboard entries to database with rankings
	 */
	async #upsertLeaderboardEntries(
		driverScores: DriverScoreEntry[],
		category: LeaderboardCategory,
		period: LeaderboardPeriod,
		periodStart: Date,
		periodEnd: Date,
		tx: DatabaseService | DatabaseTransaction,
	): Promise<void> {
		// Delete existing entries for this period/category/dates
		await tx
			.delete(tables.leaderboard)
			.where(
				and(
					eq(tables.leaderboard.category, category),
					eq(tables.leaderboard.period, period),
					eq(tables.leaderboard.periodStart, periodStart),
				),
			);

		// Insert new entries with ranks
		const entries = driverScores.map((entry, index) => ({
			id: v7(),
			userId: entry.userId,
			driverId: entry.driverId,
			merchantId: null,
			category,
			period,
			rank: index + 1,
			score: entry.score,
			periodStart,
			periodEnd,
			createdAt: new Date(),
			updatedAt: new Date(),
		}));

		if (entries.length > 0) {
			await tx.insert(tables.leaderboard).values(entries);
		}
	}
}

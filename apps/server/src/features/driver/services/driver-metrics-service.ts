import { and, avg, count, eq, gte, sql } from "drizzle-orm";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { log, toNumberSafe } from "@/utils";

export interface DriverMetrics {
	driverId: string;
	totalOrders: number;
	completedOrders: number;
	averageRating: number;
	onTimeRate: number;
	completionRate: number;
	currentStreak: number;
	totalEarnings: number;
	lastActiveDate: Date | null;
}

export class DriverMetricsService {
	#db: DatabaseService;

	constructor(db: DatabaseService) {
		this.#db = db;
	}

	/**
	 * Calculate comprehensive metrics for a driver
	 */
	async calculateDriverMetrics(
		driverId: string,
		opts?: { tx: DatabaseTransaction },
	): Promise<DriverMetrics> {
		try {
			const tx = opts?.tx ?? this.#db;

			const [orderStats, ratingStats, onTimeStats, earningsStats, streakDays] =
				await Promise.all([
					this.#getOrderStats(driverId, tx),
					this.#getRatingStats(driverId, tx),
					this.#getOnTimeRate(driverId, tx),
					this.#getTotalEarnings(driverId, tx),
					this.#calculateStreak(driverId, tx),
				]);

			const metrics: DriverMetrics = {
				driverId,
				totalOrders: orderStats.total,
				completedOrders: orderStats.completed,
				averageRating: ratingStats.avgRating,
				onTimeRate: onTimeStats.rate,
				completionRate:
					orderStats.total > 0 ? orderStats.completed / orderStats.total : 0,
				currentStreak: streakDays,
				totalEarnings: earningsStats.total,
				lastActiveDate: orderStats.lastActiveDate,
			};

			log.info(
				{ driverId, metrics },
				"[DriverMetricsService] Metrics calculated",
			);

			return metrics;
		} catch (error) {
			log.error(
				{ error, driverId },
				"[DriverMetricsService] Failed to calculate metrics",
			);
			throw error;
		}
	}

	/**
	 * Get order statistics (total, completed, last active)
	 */
	async #getOrderStats(
		driverId: string,
		tx: DatabaseService | DatabaseTransaction,
	): Promise<{
		total: number;
		completed: number;
		lastActiveDate: Date | null;
	}> {
		const [totalResult, completedResult, lastOrderResult] = await Promise.all([
			tx
				.select({ count: count() })
				.from(tables.order)
				.where(eq(tables.order.driverId, driverId)),

			tx
				.select({ count: count() })
				.from(tables.order)
				.where(
					and(
						eq(tables.order.driverId, driverId),
						eq(tables.order.status, "COMPLETED"),
					),
				),

			tx
				.select({ lastActive: sql<Date>`MAX(${tables.order.updatedAt})` })
				.from(tables.order)
				.where(eq(tables.order.driverId, driverId)),
		]);

		return {
			total: totalResult[0]?.count ?? 0,
			completed: completedResult[0]?.count ?? 0,
			lastActiveDate: lastOrderResult[0]?.lastActive ?? null,
		};
	}

	/**
	 * Get average rating from reviews
	 */
	async #getRatingStats(
		driverId: string,
		tx: DatabaseService | DatabaseTransaction,
	): Promise<{ avgRating: number }> {
		// Get driver's userId first
		const driver = await tx.query.driver.findFirst({
			where: (f, op) => op.eq(f.id, driverId),
		});

		if (!driver) {
			return { avgRating: 0 };
		}

		const result = await tx
			.select({
				avg: avg(tables.review.score),
			})
			.from(tables.review)
			.where(eq(tables.review.toUserId, driver.userId));

		const avgScore = result[0]?.avg ?? 0;
		return { avgRating: toNumberSafe(avgScore) };
	}

	/**
	 * Calculate on-time delivery rate
	 * On-time is defined as arriving within 10 minutes of accepted time
	 */
	async #getOnTimeRate(
		driverId: string,
		tx: DatabaseService | DatabaseTransaction,
	): Promise<{ rate: number }> {
		const completedOrders = await tx
			.select({
				acceptedAt: tables.order.acceptedAt,
				arrivedAt: tables.order.arrivedAt,
			})
			.from(tables.order)
			.where(
				and(
					eq(tables.order.driverId, driverId),
					eq(tables.order.status, "COMPLETED"),
				),
			);

		if (completedOrders.length === 0) {
			return { rate: 0 };
		}

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

		return { rate: onTimeCount / completedOrders.length };
	}

	/**
	 * Calculate total earnings from completed orders
	 */
	async #getTotalEarnings(
		driverId: string,
		tx: DatabaseService | DatabaseTransaction,
	): Promise<{ total: number }> {
		const result = await tx
			.select({
				sum: sql<number>`COALESCE(SUM(${tables.order.driverEarning}), 0)`,
			})
			.from(tables.order)
			.where(
				and(
					eq(tables.order.driverId, driverId),
					eq(tables.order.status, "COMPLETED"),
				),
			);

		return { total: toNumberSafe(result[0]?.sum ?? 0) };
	}

	/**
	 * Calculate current streak (consecutive days with at least 1 completed order)
	 */
	async #calculateStreak(
		driverId: string,
		tx: DatabaseService | DatabaseTransaction,
	): Promise<number> {
		// Get completed orders ordered by date descending
		const recentOrders = await tx
			.select({
				completedDate: sql<string>`DATE(${tables.order.updatedAt})`,
			})
			.from(tables.order)
			.where(
				and(
					eq(tables.order.driverId, driverId),
					eq(tables.order.status, "COMPLETED"),
					// Only consider last 90 days for performance
					gte(tables.order.updatedAt, sql`NOW() - INTERVAL '90 days'`),
				),
			)
			.orderBy(sql`DATE(${tables.order.updatedAt}) DESC`);

		if (recentOrders.length === 0) {
			return 0;
		}

		// Group by date and count streak
		const uniqueDates = new Set<string>();
		for (const order of recentOrders) {
			uniqueDates.add(order.completedDate);
		}

		const sortedDates = Array.from(uniqueDates).sort((a, b) =>
			b.localeCompare(a),
		);

		// Check if most recent date is today or yesterday
		const today = new Date();
		today.setHours(0, 0, 0, 0);
		const todayStr = today.toISOString().split("T")[0];

		const yesterday = new Date(today);
		yesterday.setDate(yesterday.getDate() - 1);
		const yesterdayStr = yesterday.toISOString().split("T")[0];

		// Streak only counts if driver was active today or yesterday
		if (
			!sortedDates[0] ||
			(sortedDates[0] !== todayStr && sortedDates[0] !== yesterdayStr)
		) {
			return 0;
		}

		// Count consecutive days
		let streak = 1;
		for (let i = 1; i < sortedDates.length; i++) {
			const currentDate = new Date(sortedDates[i]);
			const prevDate = new Date(sortedDates[i - 1]);

			const diffDays = Math.round(
				(prevDate.getTime() - currentDate.getTime()) / (1000 * 60 * 60 * 24),
			);

			if (diffDays === 1) {
				streak++;
			} else {
				break;
			}
		}

		return streak;
	}
}

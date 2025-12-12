import { sql } from "drizzle-orm";
import { order } from "@/core/tables/order";
import { logger } from "@/utils/logger";

export interface DriverStatsOptions {
	startDate?: Date;
	endDate?: Date;
	period?: "today" | "week" | "month" | "year";
}

export interface DriverStats {
	totalOrders: number;
	totalEarnings: number;
	totalCommission: number;
	netEarnings: number;
	completedOrders: number;
	cancelledOrders: number;
	averageRating: number;
	completionRate: number;
	earningsByType: Array<{
		type: "RIDE" | "DELIVERY" | "FOOD";
		orders: number;
		earnings: number;
		commission: number;
	}>;
	earningsByDay: Array<{
		date: string;
		earnings: number;
		commission: number;
		orders: number;
	}>;
	topEarningDays: Array<{
		date: string;
		earnings: number;
		orders: number;
	}>;
}

interface RawOverallStats {
	total_orders: number;
	total_earnings: string;
	total_commission: string;
	completed_orders: number;
	cancelled_orders: number;
	average_rating: string;
}

interface RawEarningsByType {
	type: "RIDE" | "DELIVERY" | "FOOD";
	orders: number;
	earnings: string;
	commission: string;
}

interface RawEarningsByDay {
	date: string;
	earnings: string;
	commission: string;
	orders: number;
}

/**
 * Driver Stats Service
 *
 * Handles complex driver statistics calculations.
 * Follows SRP by separating stats logic from repository.
 */
export class DriverStatsService {
	/**
	 * Calculate date range based on period or custom dates
	 */
	static calculateDateRange(
		period?: "today" | "week" | "month" | "year",
		customStartDate?: Date,
		customEndDate?: Date,
	): {
		startDate: Date;
		endDate: Date;
	} {
		// If custom dates provided, use them
		if (customStartDate && customEndDate) {
			return { startDate: customStartDate, endDate: customEndDate };
		}

		// Otherwise calculate from period
		const startDate = new Date();
		const endDate = new Date();

		switch (period ?? "month") {
			case "today":
				startDate.setHours(0, 0, 0, 0);
				break;
			case "week":
				startDate.setDate(startDate.getDate() - 7);
				break;
			case "month":
				startDate.setMonth(startDate.getMonth() - 1);
				break;
			case "year":
				startDate.setFullYear(startDate.getFullYear() - 1);
				break;
		}

		return { startDate, endDate };
	}

	/**
	 * Generate cache key for driver stats
	 */
	static getCacheKey(driverId: string, startDate: Date, endDate: Date): string {
		return `driver-stats:${driverId}:${startDate.toISOString()}-${endDate.toISOString()}`;
	}

	/**
	 * Generate SQL for overall driver statistics
	 */
	static getOverallStatsSQL(driverId: string, startDate: Date, endDate: Date) {
		return sql`
			SELECT
				COUNT(*)::int AS total_orders,
				COALESCE(SUM(CASE WHEN ${order.status} = 'COMPLETED' THEN ${order.driverEarning} END), 0)::text AS total_earnings,
				COALESCE(SUM(CASE WHEN ${order.status} = 'COMPLETED' THEN ${order.platformCommission} END), 0)::text AS total_commission,
				COUNT(CASE WHEN ${order.status} = 'COMPLETED' THEN 1 END)::int AS completed_orders,
				COUNT(CASE WHEN ${order.status}::text LIKE 'CANCELLED%' THEN 1 END)::int AS cancelled_orders,
				COALESCE(AVG(CASE WHEN ${order.status} = 'COMPLETED' THEN 5.0 END), 0)::text AS average_rating
			FROM ${order}
			WHERE ${order.driverId} = ${driverId}
				AND ${order.requestedAt} >= ${startDate.toISOString()}
				AND ${order.requestedAt} <= ${endDate.toISOString()}
		`;
	}

	/**
	 * Generate SQL for earnings by order type
	 */
	static getEarningsByTypeSQL(
		driverId: string,
		startDate: Date,
		endDate: Date,
	) {
		return sql`
			SELECT
				${order.type},
				COUNT(*)::int AS orders,
				COALESCE(SUM(${order.driverEarning}), 0)::text AS earnings,
				COALESCE(SUM(${order.platformCommission}), 0)::text AS commission
			FROM ${order}
			WHERE ${order.driverId} = ${driverId}
				AND ${order.status} = 'COMPLETED'
				AND ${order.requestedAt} >= ${startDate.toISOString()}
				AND ${order.requestedAt} <= ${endDate.toISOString()}
			GROUP BY ${order.type}
		`;
	}

	/**
	 * Generate SQL for earnings by day
	 */
	static getEarningsByDaySQL(driverId: string, startDate: Date, endDate: Date) {
		return sql`
			SELECT
				TO_CHAR(DATE(${order.requestedAt}), 'YYYY-MM-DD') AS date,
				COALESCE(SUM(${order.driverEarning}), 0)::text AS earnings,
				COALESCE(SUM(${order.platformCommission}), 0)::text AS commission,
				COUNT(*)::int AS orders
			FROM ${order}
			WHERE ${order.driverId} = ${driverId}
				AND ${order.status} = 'COMPLETED'
				AND ${order.requestedAt} >= ${startDate.toISOString()}
				AND ${order.requestedAt} <= ${endDate.toISOString()}
			GROUP BY DATE(${order.requestedAt})
			ORDER BY DATE(${order.requestedAt}) ASC
		`;
	}

	/**
	 * Calculate completion rate
	 */
	static calculateCompletionRate(
		totalOrders: number,
		completedOrders: number,
	): number {
		return totalOrders > 0 ? (completedOrders / totalOrders) * 100 : 0;
	}

	/**
	 * Calculate top earning days
	 */
	static calculateTopEarningDays(
		earningsByDay: Array<{ date: string; earnings: string; orders: number }>,
		limit = 3,
	): Array<{ date: string; earnings: number; orders: number }> {
		return earningsByDay
			.map((day) => ({
				date: day.date,
				earnings: Number.parseFloat(day.earnings),
				orders: day.orders,
			}))
			.sort((a, b) => b.earnings - a.earnings)
			.slice(0, limit);
	}

	/**
	 * Compose driver stats from raw database results
	 */
	static composeDriverStats(
		overallStats: RawOverallStats | undefined,
		earningsByType: RawEarningsByType[],
		earningsByDay: RawEarningsByDay[],
	): DriverStats {
		// Handle undefined/missing stats
		const stats = overallStats ?? {
			total_orders: 0,
			total_earnings: "0",
			total_commission: "0",
			completed_orders: 0,
			cancelled_orders: 0,
			average_rating: "0",
		};

		const totalEarnings = Number.parseFloat(stats.total_earnings);
		const totalCommission = Number.parseFloat(stats.total_commission);
		const averageRating = Number.parseFloat(stats.average_rating);
		const completionRate = DriverStatsService.calculateCompletionRate(
			stats.total_orders,
			stats.completed_orders,
		);

		const topEarningDays = DriverStatsService.calculateTopEarningDays(
			earningsByDay,
			3,
		);

		logger.info(
			{
				totalOrders: stats.total_orders,
				totalEarnings,
				earningTypesCount: earningsByType.length,
			},
			"[DriverStatsService] Composing driver stats",
		);

		return {
			totalOrders: stats.total_orders,
			totalEarnings,
			totalCommission,
			netEarnings: totalEarnings - totalCommission,
			completedOrders: stats.completed_orders,
			cancelledOrders: stats.cancelled_orders,
			averageRating,
			completionRate,
			earningsByType: earningsByType.map((item) => ({
				type: item.type,
				orders: item.orders,
				earnings: Number.parseFloat(item.earnings),
				commission: Number.parseFloat(item.commission),
			})),
			earningsByDay: earningsByDay.map((item) => ({
				date: item.date,
				earnings: Number.parseFloat(item.earnings),
				commission: Number.parseFloat(item.commission),
				orders: item.orders,
			})),
			topEarningDays,
		};
	}
}

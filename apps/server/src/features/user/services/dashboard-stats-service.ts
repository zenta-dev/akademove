import { log } from "@/utils";

export interface DashboardStatsOptions {
	startDate?: Date;
	endDate?: Date;
	period?: "today" | "week" | "month" | "year";
}

export interface DashboardStats {
	totalUsers: number;
	totalDrivers: number;
	totalMerchants: number;
	activeOrders: number;
	totalOrders: number;
	completedOrders: number;
	cancelledOrders: number;
	totalRevenue: number;
	todayRevenue: number;
	todayOrders: number;
	onlineDrivers: number;
	revenueByDay: Array<{
		date: string;
		revenue: number;
		orders: number;
	}>;
	ordersByDay: Array<{
		date: string;
		total: number;
		completed: number;
		cancelled: number;
	}>;
	ordersByType: Array<{
		type: string;
		orders: number;
		revenue: number;
	}>;
	topDrivers: Array<{
		id: string;
		name: string;
		earnings: number;
		orders: number;
		rating: number;
	}>;
	topMerchants: Array<{
		id: string;
		name: string;
		revenue: number;
		orders: number;
		rating: number;
	}>;
	highCancellationDrivers: Array<{
		id: string;
		name: string;
		totalOrders: number;
		cancelledOrders: number;
		cancellationRate: number;
	}>;
}

interface RawBasicStats {
	total_users: number;
	total_drivers: number;
	total_merchants: number;
	active_orders: number;
	total_orders: number;
	completed_orders: number;
	cancelled_orders: number;
	total_revenue: string;
	today_revenue: string;
	today_orders: number;
	online_drivers: number;
}

interface RawRevenueByDay {
	date: string;
	revenue: string;
	orders: number;
}

interface RawOrdersByDay {
	date: string;
	total: number;
	completed: number;
	cancelled: number;
}

interface RawOrdersByType {
	type: string;
	orders: number;
	revenue: string;
}

interface RawTopDriver {
	id: string;
	name: string;
	earnings: string;
	orders: number;
	rating: string;
}

interface RawTopMerchant {
	id: string;
	name: string;
	revenue: string;
	orders: number;
	rating: string;
}

interface RawHighCancellation {
	id: string;
	name: string;
	total_orders: number;
	cancelled_orders: number;
}

/**
 * Dashboard Stats Service
 *
 * Handles complex dashboard analytics calculations.
 * Follows SRP by separating stats calculation logic from repository.
 */
export class DashboardStatsService {
	/**
	 * Calculate date range based on period or custom dates
	 */
	static calculateDateRange(options?: DashboardStatsOptions): {
		startDate: Date;
		endDate: Date;
	} {
		let startDate: Date;
		const endDate: Date = new Date();

		if (options?.startDate && options?.endDate) {
			startDate = options.startDate;
			return { startDate, endDate: options.endDate };
		}

		const period = options?.period ?? "month";
		startDate = new Date();
		switch (period) {
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
	 * Generate cache key for dashboard stats
	 */
	static getCacheKey(startDate: Date, endDate: Date): string {
		return `dashboard-stats-${startDate.toISOString()}-${endDate.toISOString()}`;
	}

	/**
	 * Get today's date at midnight (start of day)
	 */
	static getTodayMidnight(): Date {
		const today = new Date();
		today.setHours(0, 0, 0, 0);
		return today;
	}

	/**
	 * Compose dashboard stats from raw database results
	 * Transforms database types to proper numeric types
	 */
	static composeDashboardStats(params: {
		basicStats: RawBasicStats;
		revenueByDay: RawRevenueByDay[];
		ordersByDay: RawOrdersByDay[];
		ordersByType: RawOrdersByType[];
		topDrivers: RawTopDriver[];
		topMerchants: RawTopMerchant[];
		highCancellation: RawHighCancellation[];
	}): DashboardStats {
		const {
			basicStats,
			revenueByDay,
			ordersByDay,
			ordersByType,
			topDrivers,
			topMerchants,
			highCancellation,
		} = params;

		log.info(
			{
				revenueCount: revenueByDay.length,
				ordersCount: ordersByDay.length,
				topDriversCount: topDrivers.length,
			},
			"[DashboardStatsService] Composing dashboard stats",
		);

		return {
			totalUsers: basicStats.total_users,
			totalDrivers: basicStats.total_drivers,
			totalMerchants: basicStats.total_merchants,
			activeOrders: basicStats.active_orders,
			totalOrders: basicStats.total_orders,
			completedOrders: basicStats.completed_orders,
			cancelledOrders: basicStats.cancelled_orders,
			totalRevenue: Number.parseFloat(basicStats.total_revenue),
			todayRevenue: Number.parseFloat(basicStats.today_revenue),
			todayOrders: basicStats.today_orders,
			onlineDrivers: basicStats.online_drivers,
			revenueByDay: revenueByDay.map((item) => ({
				date: item.date,
				revenue: Number.parseFloat(item.revenue),
				orders: item.orders,
			})),
			ordersByDay: ordersByDay.map((item) => ({
				date: item.date,
				total: item.total,
				completed: item.completed,
				cancelled: item.cancelled,
			})),
			ordersByType: ordersByType.map((item) => ({
				type: item.type,
				orders: item.orders,
				revenue: Number.parseFloat(item.revenue),
			})),
			topDrivers: topDrivers.map((item) => ({
				id: item.id,
				name: item.name,
				earnings: Number.parseFloat(item.earnings),
				orders: item.orders,
				rating: Number.parseFloat(item.rating),
			})),
			topMerchants: topMerchants.map((item) => ({
				id: item.id,
				name: item.name,
				revenue: Number.parseFloat(item.revenue),
				orders: item.orders,
				rating: Number.parseFloat(item.rating),
			})),
			highCancellationDrivers: highCancellation.map((item) => ({
				id: item.id,
				name: item.name,
				totalOrders: item.total_orders,
				cancelledOrders: item.cancelled_orders,
				cancellationRate:
					item.total_orders > 0
						? (item.cancelled_orders / item.total_orders) * 100
						: 0,
			})),
		};
	}

	/**
	 * Generate SQL for basic stats
	 */
	static getBasicStatsSQL(today: Date): string {
		return /* sql */ `
			SELECT
				(SELECT COUNT(*)::int FROM am_users WHERE role = 'USER') AS total_users,
				(SELECT COUNT(*)::int FROM am_drivers) AS total_drivers,
				(SELECT COUNT(*)::int FROM am_merchants) AS total_merchants,
				(SELECT COUNT(*)::int FROM am_orders WHERE status NOT IN ('COMPLETED', 'CANCELLED_BY_USER', 'CANCELLED_BY_DRIVER', 'CANCELLED_BY_SYSTEM')) AS active_orders,
				(SELECT COUNT(*)::int FROM am_orders) AS total_orders,
				(SELECT COUNT(*)::int FROM am_orders WHERE status = 'COMPLETED') AS completed_orders,
				(SELECT COUNT(*)::int FROM am_orders WHERE status IN ('CANCELLED_BY_USER', 'CANCELLED_BY_DRIVER', 'CANCELLED_BY_SYSTEM')) AS cancelled_orders,
				(SELECT COALESCE(SUM(total_price), 0)::text FROM am_orders WHERE status = 'COMPLETED') AS total_revenue,
				(SELECT COALESCE(SUM(total_price), 0)::text FROM am_orders WHERE status = 'COMPLETED' AND created_at >= '${today.toISOString()}') AS today_revenue,
				(SELECT COUNT(*)::int FROM am_orders WHERE created_at >= '${today.toISOString()}') AS today_orders,
				(SELECT COUNT(*)::int FROM am_drivers WHERE is_online = true) AS online_drivers
		`;
	}

	/**
	 * Generate SQL for revenue by day
	 */
	static getRevenueByDaySQL(startDate: Date, endDate: Date): string {
		return /* sql */ `
			SELECT
				TO_CHAR(DATE(requested_at), 'YYYY-MM-DD') AS date,
				COALESCE(SUM(total_price), 0)::text AS revenue,
				COUNT(*)::int AS orders
			FROM am_orders
			WHERE status = 'COMPLETED'
				AND requested_at >= '${startDate.toISOString()}'
				AND requested_at <= '${endDate.toISOString()}'
			GROUP BY DATE(requested_at)
			ORDER BY DATE(requested_at) ASC
		`;
	}

	/**
	 * Generate SQL for orders by day
	 */
	static getOrdersByDaySQL(startDate: Date, endDate: Date): string {
		return /* sql */ `
			SELECT
				TO_CHAR(DATE(requested_at), 'YYYY-MM-DD') AS date,
				COUNT(*)::int AS total,
				COUNT(*) FILTER (WHERE status = 'COMPLETED')::int AS completed,
				COUNT(*) FILTER (WHERE status IN ('CANCELLED_BY_USER', 'CANCELLED_BY_DRIVER', 'CANCELLED_BY_SYSTEM'))::int AS cancelled
			FROM am_orders
			WHERE requested_at >= '${startDate.toISOString()}'
				AND requested_at <= '${endDate.toISOString()}'
			GROUP BY DATE(requested_at)
			ORDER BY DATE(requested_at) ASC
		`;
	}

	/**
	 * Generate SQL for orders by type
	 */
	static getOrdersByTypeSQL(startDate: Date, endDate: Date): string {
		return /* sql */ `
			SELECT
				type,
				COUNT(*)::int AS orders,
				COALESCE(SUM(total_price), 0)::text AS revenue
			FROM am_orders
			WHERE status = 'COMPLETED'
				AND requested_at >= '${startDate.toISOString()}'
				AND requested_at <= '${endDate.toISOString()}'
			GROUP BY type
			ORDER BY revenue DESC
		`;
	}

	/**
	 * Generate SQL for top drivers
	 */
	static getTopDriversSQL(startDate: Date, endDate: Date): string {
		return /* sql */ `
			SELECT
				d.id,
				u.name,
				COALESCE(SUM(o.total_price), 0)::text AS earnings,
				COUNT(o.id)::int AS orders,
				COALESCE(AVG(o.driver_rating), 0)::text AS rating
			FROM am_drivers d
			JOIN am_users u ON d.id = u.id
			LEFT JOIN am_orders o ON o.driver_id = d.id
				AND o.status = 'COMPLETED'
				AND o.requested_at >= '${startDate.toISOString()}'
				AND o.requested_at <= '${endDate.toISOString()}'
			GROUP BY d.id, u.name
			HAVING COUNT(o.id) > 0
			ORDER BY earnings DESC
			LIMIT 5
		`;
	}

	/**
	 * Generate SQL for top merchants
	 */
	static getTopMerchantsSQL(startDate: Date, endDate: Date): string {
		return /* sql */ `
			SELECT
				m.id,
				m.name,
				COALESCE(SUM(o.total_price), 0)::text AS revenue,
				COUNT(o.id)::int AS orders,
				COALESCE(AVG(o.driver_rating), 0)::text AS rating
			FROM am_merchants m
			LEFT JOIN am_orders o ON o.merchant_id = m.id
				AND o.status = 'COMPLETED'
				AND o.requested_at >= '${startDate.toISOString()}'
				AND o.requested_at <= '${endDate.toISOString()}'
			GROUP BY m.id, m.name
			HAVING COUNT(o.id) > 0
			ORDER BY revenue DESC
			LIMIT 5
		`;
	}

	/**
	 * Generate SQL for high cancellation drivers
	 */
	static getHighCancellationSQL(startDate: Date, endDate: Date): string {
		return /* sql */ `
			SELECT
				d.id,
				u.name,
				COUNT(o.id)::int AS total_orders,
				COUNT(*) FILTER (WHERE o.status = 'CANCELLED_BY_DRIVER')::int AS cancelled_orders
			FROM am_drivers d
			JOIN am_users u ON d.id = u.id
			LEFT JOIN am_orders o ON o.driver_id = d.id
				AND o.requested_at >= '${startDate.toISOString()}'
				AND o.requested_at <= '${endDate.toISOString()}'
			GROUP BY d.id, u.name
			HAVING COUNT(o.id) >= 10
				AND COUNT(*) FILTER (WHERE o.status = 'CANCELLED_BY_DRIVER')::int > 0
			ORDER BY (COUNT(*) FILTER (WHERE o.status = 'CANCELLED_BY_DRIVER')::float / COUNT(o.id)::float) DESC
			LIMIT 5
		`;
	}
}

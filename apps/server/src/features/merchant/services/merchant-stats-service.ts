import { sql } from "drizzle-orm";
import { logger } from "@/utils/logger";

export interface MerchantStatsOptions {
	startDate?: Date;
	endDate?: Date;
	period?: "today" | "week" | "month" | "year";
}

export interface MerchantStats {
	totalOrders: number;
	totalRevenue: number;
	totalCommission: number;
	completedOrders: number;
	cancelledOrders: number;
	averageOrderValue: number;
	topSellingItems: Array<{
		menuId: string;
		menuName: string;
		menuImage?: string;
		totalOrders: number;
		totalRevenue: number;
	}>;
	revenueByDay: Array<{
		date: string;
		revenue: number;
		orders: number;
	}>;
}

interface RawOverallStats {
	total_orders: number;
	total_revenue: string;
	total_commission: string;
	completed_orders: number;
	cancelled_orders: number;
	average_order_value: string;
}

interface RawTopSellingItem {
	menu_id: string;
	menu_name: string;
	menu_image: string | null;
	total_orders: number;
	total_revenue: string;
}

interface RawRevenueByDay {
	date: string;
	revenue: string;
	orders: number;
}

/**
 * Merchant Stats Service
 *
 * Handles complex merchant statistics calculations.
 * Follows SRP by separating stats logic from repository.
 */
export class MerchantStatsService {
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
	 * Generate cache key for merchant stats
	 */
	static getCacheKey(
		merchantId: string,
		startDate: Date,
		endDate: Date,
	): string {
		return `merchant-stats:${merchantId}:${startDate.toISOString()}-${endDate.toISOString()}`;
	}

	/**
	 * Generate SQL for overall merchant statistics
	 */
	static getOverallStatsSQL(
		merchantId: string,
		startDate: Date,
		endDate: Date,
	) {
		return sql`
			SELECT
				COUNT(*)::int AS total_orders,
				COALESCE(SUM(total_price), 0)::text AS total_revenue,
				COALESCE(SUM(merchant_commission), 0)::text AS total_commission,
				COUNT(CASE WHEN status = 'COMPLETED' THEN 1 END)::int AS completed_orders,
				COUNT(CASE WHEN status IN ('CANCELLED_BY_USER', 'CANCELLED_BY_DRIVER', 'CANCELLED_BY_SYSTEM') THEN 1 END)::int AS cancelled_orders,
				COALESCE(AVG(CASE WHEN status = 'COMPLETED' THEN total_price END), 0)::text AS average_order_value
			FROM am_orders
			WHERE merchant_id = ${merchantId}
				AND requested_at >= ${startDate.toISOString()}
				AND requested_at <= ${endDate.toISOString()}
		`;
	}

	/**
	 * Generate SQL for top selling items
	 */
	static getTopSellingItemsSQL(
		merchantId: string,
		startDate: Date,
		endDate: Date,
		limit = 10,
	) {
		return sql`
			SELECT
				oi."menuId" AS menu_id,
				mm.name AS menu_name,
				mm.image AS menu_image,
				COUNT(DISTINCT o.id)::int AS total_orders,
				COALESCE(SUM(oi.unit_price * oi.quantity), 0)::text AS total_revenue
			FROM am_orders o
			INNER JOIN am_order_items oi ON o.id = oi."orderId"
			INNER JOIN am_merchant_menus mm ON oi."menuId" = mm.id
			WHERE o.merchant_id = ${merchantId}
				AND o.status = 'COMPLETED'
				AND o.requested_at >= ${startDate.toISOString()}
				AND o.requested_at <= ${endDate.toISOString()}
			GROUP BY oi."menuId", mm.name, mm.image
			ORDER BY total_orders DESC
			LIMIT ${limit}
		`;
	}

	/**
	 * Generate SQL for revenue by day
	 */
	static getRevenueByDaySQL(
		merchantId: string,
		startDate: Date,
		endDate: Date,
	) {
		return sql`
			SELECT
				TO_CHAR(DATE(requested_at), 'YYYY-MM-DD') AS date,
				COALESCE(SUM(total_price), 0)::text AS revenue,
				COUNT(*)::int AS orders
			FROM am_orders
			WHERE merchant_id = ${merchantId}
				AND status = 'COMPLETED'
				AND requested_at >= ${startDate.toISOString()}
				AND requested_at <= ${endDate.toISOString()}
			GROUP BY DATE(requested_at)
			ORDER BY DATE(requested_at) ASC
		`;
	}

	/**
	 * Transform top selling items with image URLs
	 */
	static transformTopSellingItems(
		items: RawTopSellingItem[],
		callbacks: {
			getMenuImageUrl: (key: string | null) => string | undefined;
		},
	): Array<{
		menuId: string;
		menuName: string;
		menuImage?: string;
		totalOrders: number;
		totalRevenue: number;
	}> {
		return items.map((item) => ({
			menuId: item.menu_id,
			menuName: item.menu_name,
			menuImage: callbacks.getMenuImageUrl(item.menu_image),
			totalOrders: item.total_orders,
			totalRevenue: Number.parseFloat(item.total_revenue),
		}));
	}

	/**
	 * Compose merchant stats from raw database results
	 */
	static composeMerchantStats(
		overallStats: RawOverallStats | undefined,
		topSellingItems: RawTopSellingItem[],
		revenueByDay: RawRevenueByDay[],
		callbacks: {
			getMenuImageUrl: (key: string | null) => string | undefined;
		},
	): MerchantStats {
		// Handle undefined/missing stats
		const stats = overallStats ?? {
			total_orders: 0,
			total_revenue: "0",
			total_commission: "0",
			completed_orders: 0,
			cancelled_orders: 0,
			average_order_value: "0",
		};

		const totalRevenue = Number.parseFloat(stats.total_revenue);
		const totalCommission = Number.parseFloat(stats.total_commission);
		const averageOrderValue = Number.parseFloat(stats.average_order_value);

		logger.info(
			{
				totalOrders: stats.total_orders,
				totalRevenue,
				topItemsCount: topSellingItems.length,
			},
			"[MerchantStatsService] Composing merchant stats",
		);

		return {
			totalOrders: stats.total_orders,
			totalRevenue,
			totalCommission,
			completedOrders: stats.completed_orders,
			cancelledOrders: stats.cancelled_orders,
			averageOrderValue,
			topSellingItems: MerchantStatsService.transformTopSellingItems(
				topSellingItems,
				callbacks,
			),
			revenueByDay: revenueByDay.map((day) => ({
				date: day.date,
				revenue: Number.parseFloat(day.revenue),
				orders: day.orders,
			})),
		};
	}
}

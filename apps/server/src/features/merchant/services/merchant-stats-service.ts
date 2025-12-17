import { getTableName, sql } from "drizzle-orm";
import { merchantMenu } from "@/core/tables/merchant";
import { order, orderItem } from "@/core/tables/order";
import { logger } from "@/utils/logger";

// Get table names for complex raw SQL queries with JOINs
const orderTable = getTableName(order);
const orderItemTable = getTableName(orderItem);
const merchantMenuTable = getTableName(merchantMenu);

export interface MerchantStatsOptions {
	startDate?: Date;
	endDate?: Date;
	period?: "today" | "week" | "month" | "year";
}

export interface MerchantStats {
	totalOrders: number;
	totalRevenue: number;
	totalCommission: number;
	/** Commission rate as percentage (e.g., 10 for 10%) - from server config */
	commissionRate: number;
	/** Net income after commission deduction (totalRevenue - totalCommission) */
	netIncome: number;
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
				COALESCE(SUM(${order.totalPrice}), 0)::text AS total_revenue,
				COALESCE(SUM(${order.merchantCommission}), 0)::text AS total_commission,
				COUNT(CASE WHEN ${order.status} = 'COMPLETED' THEN 1 END)::int AS completed_orders,
				COUNT(CASE WHEN ${order.status} IN ('CANCELLED_BY_USER', 'CANCELLED_BY_DRIVER', 'CANCELLED_BY_SYSTEM') THEN 1 END)::int AS cancelled_orders,
				COALESCE(AVG(CASE WHEN ${order.status} = 'COMPLETED' THEN ${order.totalPrice} END), 0)::text AS average_order_value
			FROM ${order}
			WHERE ${order.merchantId} = ${merchantId}
				AND ${order.requestedAt} >= ${startDate.toISOString()}
				AND ${order.requestedAt} <= ${endDate.toISOString()}
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
				oi.${sql.identifier(orderItem.menuId.name)} AS menu_id,
				mm.${sql.identifier(merchantMenu.name.name)} AS menu_name,
				mm.${sql.identifier(merchantMenu.image.name)} AS menu_image,
				COUNT(DISTINCT o.${sql.identifier(order.id.name)})::int AS total_orders,
				COALESCE(SUM(oi.${sql.identifier(orderItem.unitPrice.name)} * oi.${sql.identifier(orderItem.quantity.name)}), 0)::text AS total_revenue
			FROM ${sql.identifier(orderTable)} o
			INNER JOIN ${sql.identifier(orderItemTable)} oi ON o.${sql.identifier(order.id.name)} = oi.${sql.identifier(orderItem.orderId.name)}
			INNER JOIN ${sql.identifier(merchantMenuTable)} mm ON oi.${sql.identifier(orderItem.menuId.name)} = mm.${sql.identifier(merchantMenu.id.name)}
			WHERE o.${sql.identifier(order.merchantId.name)} = ${merchantId}
				AND o.${sql.identifier(order.status.name)} = 'COMPLETED'
				AND o.${sql.identifier(order.requestedAt.name)} >= ${startDate.toISOString()}
				AND o.${sql.identifier(order.requestedAt.name)} <= ${endDate.toISOString()}
			GROUP BY oi.${sql.identifier(orderItem.menuId.name)}, mm.${sql.identifier(merchantMenu.name.name)}, mm.${sql.identifier(merchantMenu.image.name)}
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
				TO_CHAR(DATE(${order.requestedAt}), 'YYYY-MM-DD') AS date,
				COALESCE(SUM(${order.totalPrice}), 0)::text AS revenue,
				COUNT(*)::int AS orders
			FROM ${order}
			WHERE ${order.merchantId} = ${merchantId}
				AND ${order.status} = 'COMPLETED'
				AND ${order.requestedAt} >= ${startDate.toISOString()}
				AND ${order.requestedAt} <= ${endDate.toISOString()}
			GROUP BY DATE(${order.requestedAt})
			ORDER BY DATE(${order.requestedAt}) ASC
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
	 * @param overallStats - Raw overall stats from database
	 * @param topSellingItems - Raw top selling items from database
	 * @param revenueByDay - Raw revenue by day from database
	 * @param callbacks - Callbacks for image URL generation
	 * @param merchantCommissionRate - Commission rate from configuration (decimal, e.g., 0.1 for 10%)
	 */
	static composeMerchantStats(
		overallStats: RawOverallStats | undefined,
		topSellingItems: RawTopSellingItem[],
		revenueByDay: RawRevenueByDay[],
		callbacks: {
			getMenuImageUrl: (key: string | null) => string | undefined;
		},
		merchantCommissionRate: number,
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
		const netIncome = totalRevenue - totalCommission;
		// Convert decimal rate to percentage (e.g., 0.1 -> 10)
		const commissionRate = merchantCommissionRate * 100;

		logger.info(
			{
				totalOrders: stats.total_orders,
				totalRevenue,
				totalCommission,
				commissionRate,
				netIncome,
				topItemsCount: topSellingItems.length,
			},
			"[MerchantStatsService] Composing merchant stats",
		);

		return {
			totalOrders: stats.total_orders,
			totalRevenue,
			totalCommission,
			commissionRate,
			netIncome,
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

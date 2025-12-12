import { getTableName, sql } from "drizzle-orm";
import type { DatabaseService } from "@/core/services/db";
import { user } from "@/core/tables/auth";
import { merchant } from "@/core/tables/merchant";
import { order } from "@/core/tables/order";
import type {
	DriverAnalyticsRecord,
	MerchantAnalyticsRecord,
	OperatorAnalyticsRecord,
} from "./analytics-export-service";

// Get table names for raw SQL queries
const orderTable = getTableName(order);
const userTable = getTableName(user);
const merchantTable = getTableName(merchant);

/**
 * Service responsible for generating and executing analytics SQL queries
 * with proper parameterization to prevent SQL injection.
 *
 * @responsibility Query generation and execution for analytics data
 */
export class AnalyticsQueryService {
	/**
	 * Execute driver analytics query with safe parameterization
	 */
	static async executeDriverAnalyticsQuery(
		db: DatabaseService,
		options: {
			driverId: string;
			startDate: Date;
			endDate: Date;
		},
	): Promise<DriverAnalyticsRecord[]> {
		const { driverId, startDate, endDate } = options;

		const query = sql`
			SELECT
				${order.id},
				${order.type},
				${order.status},
				${order.totalPrice},
				${order.platformCommission},
				${order.driverEarning},
				${order.requestedAt}
			FROM ${order}
			WHERE ${order.driverId} = ${driverId}
				AND ${order.requestedAt} >= ${startDate.toISOString()}
				AND ${order.requestedAt} <= ${endDate.toISOString()}
			ORDER BY ${order.requestedAt} DESC
		`;

		const result = (await db.execute(query)) as unknown as {
			rows: DriverAnalyticsRecord[];
		};

		return result.rows;
	}

	/**
	 * Execute merchant analytics query with safe parameterization
	 */
	static async executeMerchantAnalyticsQuery(
		db: DatabaseService,
		options: {
			merchantId: string;
			startDate: Date;
			endDate: Date;
		},
	): Promise<MerchantAnalyticsRecord[]> {
		const { merchantId, startDate, endDate } = options;

		const query = sql`
			SELECT
				${order.id},
				${order.type},
				${order.status},
				${order.totalPrice},
				${order.merchantCommission},
				${order.requestedAt}
			FROM ${order}
			WHERE ${order.merchantId} = ${merchantId}
				AND ${order.requestedAt} >= ${startDate.toISOString()}
				AND ${order.requestedAt} <= ${endDate.toISOString()}
			ORDER BY ${order.requestedAt} DESC
		`;

		const result = (await db.execute(query)) as unknown as {
			rows: MerchantAnalyticsRecord[];
		};

		return result.rows;
	}

	/**
	 * Execute operator/platform analytics query with safe parameterization
	 */
	static async executeOperatorAnalyticsQuery(
		db: DatabaseService,
		options: {
			startDate: Date;
			endDate: Date;
		},
	): Promise<OperatorAnalyticsRecord[]> {
		const { startDate, endDate } = options;

		// For complex JOINs with aliases, use table names with sql.identifier
		const query = sql`
			SELECT
				o.${sql.identifier(order.id.name)},
				o.${sql.identifier(order.type.name)},
				o.${sql.identifier(order.status.name)},
				o.${sql.identifier(order.totalPrice.name)},
				o.${sql.identifier(order.platformCommission.name)},
				o.${sql.identifier(order.merchantCommission.name)},
				o.${sql.identifier(order.driverId.name)},
				du.${sql.identifier(user.name.name)} AS driver_name,
				o.${sql.identifier(order.userId.name)},
				uu.${sql.identifier(user.name.name)} AS user_name,
				o.${sql.identifier(order.merchantId.name)},
				m.${sql.identifier(merchant.name.name)} AS merchant_name,
				o.${sql.identifier(order.requestedAt.name)}
			FROM ${sql.identifier(orderTable)} o
			LEFT JOIN ${sql.identifier(userTable)} du ON o.${sql.identifier(order.driverId.name)} = du.${sql.identifier(user.id.name)}
			LEFT JOIN ${sql.identifier(userTable)} uu ON o.${sql.identifier(order.userId.name)} = uu.${sql.identifier(user.id.name)}
			LEFT JOIN ${sql.identifier(merchantTable)} m ON o.${sql.identifier(order.merchantId.name)} = m.${sql.identifier(merchant.id.name)}
			WHERE o.${sql.identifier(order.requestedAt.name)} >= ${startDate.toISOString()}
				AND o.${sql.identifier(order.requestedAt.name)} <= ${endDate.toISOString()}
			ORDER BY o.${sql.identifier(order.requestedAt.name)} DESC
		`;

		const result = (await db.execute(query)) as unknown as {
			rows: OperatorAnalyticsRecord[];
		};

		return result.rows;
	}
}

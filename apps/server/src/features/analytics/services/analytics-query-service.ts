import { sql } from "drizzle-orm";
import type { DatabaseService } from "@/core/services/db";
import type {
	DriverAnalyticsRecord,
	MerchantAnalyticsRecord,
	OperatorAnalyticsRecord,
} from "./analytics-export-service";

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
				o.id,
				o.type,
				o.status,
				o.total_price,
				o.platform_commission,
				o.driver_earning,
				o.driver_rating,
				o.user_rating,
				o.requested_at,
				o.completed_at
			FROM am_orders o
			WHERE o.driver_id = ${driverId}
				AND o.requested_at >= ${startDate.toISOString()}
				AND o.requested_at <= ${endDate.toISOString()}
			ORDER BY o.requested_at DESC
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
				o.id,
				o.type,
				o.status,
				o.total_price,
				o.merchant_commission,
				o.driver_rating,
				o.user_rating,
				o.requested_at,
				o.completed_at
			FROM am_orders o
			WHERE o.merchant_id = ${merchantId}
				AND o.requested_at >= ${startDate.toISOString()}
				AND o.requested_at <= ${endDate.toISOString()}
			ORDER BY o.requested_at DESC
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

		const query = sql`
			SELECT
				o.id,
				o.type,
				o.status,
				o.total_price,
				o.platform_commission,
				o.merchant_commission,
				o.driver_id,
				du.name AS driver_name,
				o.user_id,
				uu.name AS user_name,
				o.merchant_id,
				m.name AS merchant_name,
				o.requested_at,
				o.completed_at
			FROM am_orders o
			LEFT JOIN am_users du ON o.driver_id = du.id
			LEFT JOIN am_users uu ON o.user_id = uu.id
			LEFT JOIN am_merchants m ON o.merchant_id = m.id
			WHERE o.requested_at >= ${startDate.toISOString()}
				AND o.requested_at <= ${endDate.toISOString()}
			ORDER BY o.requested_at DESC
		`;

		const result = (await db.execute(query)) as unknown as {
			rows: OperatorAnalyticsRecord[];
		};

		return result.rows;
	}
}

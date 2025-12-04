import { stringify } from "csv-stringify/sync";
import { BaseRepository } from "@/core/base";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { log } from "@/utils";

export class AnalyticsRepository extends BaseRepository {
	constructor(kv: KeyValueService, db: DatabaseService) {
		super("order", kv, db);
	}

	/**
	 * Export driver analytics to CSV format
	 */
	async exportDriverAnalytics(options: {
		driverId: string;
		startDate: Date;
		endDate: Date;
	}): Promise<string> {
		try {
			const { driverId, startDate, endDate } = options;

			const result = await this.db.execute<{
				id: string;
				type: string;
				status: string;
				total_price: string;
				driver_commission: string;
				driver_rating: string;
				user_rating: string;
				requested_at: string;
				completed_at: string;
			}>(/* sql */ `
				SELECT
					o.id,
					o.type,
					o.status,
					o.total_price,
					o.driver_commission,
					o.driver_rating,
					o.user_rating,
					o.requested_at,
					o.completed_at
				FROM am_orders o
				WHERE o.driver_id = '${driverId}'
					AND o.requested_at >= '${startDate.toISOString()}'
					AND o.requested_at <= '${endDate.toISOString()}'
				ORDER BY o.requested_at DESC
			`);

			const records = result.map((row) => ({
				"Order ID": row.id,
				"Service Type": row.type,
				Status: row.status,
				"Total Price": row.total_price,
				"Driver Commission": row.driver_commission,
				"Net Earnings":
					Number.parseFloat(row.total_price) -
					Number.parseFloat(row.driver_commission),
				"Driver Rating": row.driver_rating ?? "N/A",
				"User Rating": row.user_rating ?? "N/A",
				"Requested At": row.requested_at,
				"Completed At": row.completed_at ?? "N/A",
			}));

			const csv = stringify(records, {
				header: true,
				columns: [
					"Order ID",
					"Service Type",
					"Status",
					"Total Price",
					"Driver Commission",
					"Net Earnings",
					"Driver Rating",
					"User Rating",
					"Requested At",
					"Completed At",
				],
			});

			log.info(
				{ driverId, recordCount: records.length },
				"[AnalyticsRepository] Driver analytics exported",
			);

			return csv;
		} catch (error) {
			log.error(
				{ error, options },
				"[AnalyticsRepository] Failed to export driver analytics",
			);
			throw this.handleError(error, "export driver analytics");
		}
	}

	/**
	 * Export merchant analytics to CSV format
	 */
	async exportMerchantAnalytics(options: {
		merchantId: string;
		startDate: Date;
		endDate: Date;
	}): Promise<string> {
		try {
			const { merchantId, startDate, endDate } = options;

			const result = await this.db.execute<{
				id: string;
				type: string;
				status: string;
				total_price: string;
				merchant_commission: string;
				driver_rating: string;
				user_rating: string;
				requested_at: string;
				completed_at: string;
			}>(/* sql */ `
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
				WHERE o.merchant_id = '${merchantId}'
					AND o.requested_at >= '${startDate.toISOString()}'
					AND o.requested_at <= '${endDate.toISOString()}'
				ORDER BY o.requested_at DESC
			`);

			const records = result.map((row) => ({
				"Order ID": row.id,
				"Service Type": row.type,
				Status: row.status,
				"Total Price": row.total_price,
				"Merchant Commission": row.merchant_commission,
				"Net Revenue":
					Number.parseFloat(row.total_price) -
					Number.parseFloat(row.merchant_commission),
				"Driver Rating": row.driver_rating ?? "N/A",
				"User Rating": row.user_rating ?? "N/A",
				"Requested At": row.requested_at,
				"Completed At": row.completed_at ?? "N/A",
			}));

			const csv = stringify(records, {
				header: true,
				columns: [
					"Order ID",
					"Service Type",
					"Status",
					"Total Price",
					"Merchant Commission",
					"Net Revenue",
					"Driver Rating",
					"User Rating",
					"Requested At",
					"Completed At",
				],
			});

			log.info(
				{ merchantId, recordCount: records.length },
				"[AnalyticsRepository] Merchant analytics exported",
			);

			return csv;
		} catch (error) {
			log.error(
				{ error, options },
				"[AnalyticsRepository] Failed to export merchant analytics",
			);
			throw this.handleError(error, "export merchant analytics");
		}
	}

	/**
	 * Export operator/platform analytics to CSV format
	 */
	async exportOperatorAnalytics(options: {
		startDate: Date;
		endDate: Date;
	}): Promise<string> {
		try {
			const { startDate, endDate } = options;

			const result = await this.db.execute<{
				id: string;
				type: string;
				status: string;
				total_price: string;
				driver_commission: string;
				merchant_commission: string;
				driver_id: string;
				driver_name: string;
				user_id: string;
				user_name: string;
				merchant_id: string;
				merchant_name: string;
				requested_at: string;
				completed_at: string;
			}>(/* sql */ `
				SELECT
					o.id,
					o.type,
					o.status,
					o.total_price,
					o.driver_commission,
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
				WHERE o.requested_at >= '${startDate.toISOString()}'
					AND o.requested_at <= '${endDate.toISOString()}'
				ORDER BY o.requested_at DESC
			`);

			const records = result.map((row) => ({
				"Order ID": row.id,
				"Service Type": row.type,
				Status: row.status,
				"Total Price": row.total_price,
				"Driver Commission": row.driver_commission ?? "0",
				"Merchant Commission": row.merchant_commission ?? "0",
				"Platform Revenue":
					Number.parseFloat(row.driver_commission ?? "0") +
					Number.parseFloat(row.merchant_commission ?? "0"),
				"Driver ID": row.driver_id ?? "N/A",
				"Driver Name": row.driver_name ?? "N/A",
				"User ID": row.user_id,
				"User Name": row.user_name,
				"Merchant ID": row.merchant_id ?? "N/A",
				"Merchant Name": row.merchant_name ?? "N/A",
				"Requested At": row.requested_at,
				"Completed At": row.completed_at ?? "N/A",
			}));

			const csv = stringify(records, {
				header: true,
				columns: [
					"Order ID",
					"Service Type",
					"Status",
					"Total Price",
					"Driver Commission",
					"Merchant Commission",
					"Platform Revenue",
					"Driver ID",
					"Driver Name",
					"User ID",
					"User Name",
					"Merchant ID",
					"Merchant Name",
					"Requested At",
					"Completed At",
				],
			});

			log.info(
				{ recordCount: records.length },
				"[AnalyticsRepository] Operator analytics exported",
			);

			return csv;
		} catch (error) {
			log.error(
				{ error, options },
				"[AnalyticsRepository] Failed to export operator analytics",
			);
			throw this.handleError(error, "export operator analytics");
		}
	}
}

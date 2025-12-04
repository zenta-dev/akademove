import { stringify } from "csv-stringify/sync";
import { log } from "@/utils";

export interface DriverAnalyticsRecord {
	id: string;
	type: string;
	status: string;
	total_price: string;
	driver_commission: string;
	driver_rating: string | null;
	user_rating: string | null;
	requested_at: string;
	completed_at: string | null;
}

export interface MerchantAnalyticsRecord {
	id: string;
	type: string;
	status: string;
	total_price: string;
	merchant_commission: string;
	driver_rating: string | null;
	user_rating: string | null;
	requested_at: string;
	completed_at: string | null;
}

export interface OperatorAnalyticsRecord {
	id: string;
	type: string;
	status: string;
	total_price: string;
	driver_commission: string | null;
	merchant_commission: string | null;
	driver_id: string | null;
	driver_name: string | null;
	user_id: string;
	user_name: string;
	merchant_id: string | null;
	merchant_name: string | null;
	requested_at: string;
	completed_at: string | null;
}

/**
 * Service for exporting analytics data to CSV format
 *
 * Follows SOLID principles:
 * - Single Responsibility: Only CSV export and data formatting
 * - Open/Closed: Extensible for new export formats (JSON, Excel, etc.)
 * - Dependency Inversion: No external dependencies (pure transformation)
 */
export class AnalyticsExportService {
	/**
	 * Calculate net earnings for driver (total price - commission)
	 */
	static calculateNetEarnings(totalPrice: string, commission: string): number {
		try {
			return Number.parseFloat(totalPrice) - Number.parseFloat(commission);
		} catch (error) {
			log.error(
				{ error, totalPrice, commission },
				"[AnalyticsExportService] Failed to calculate net earnings",
			);
			return 0;
		}
	}

	/**
	 * Calculate platform revenue (driver commission + merchant commission)
	 */
	static calculatePlatformRevenue(
		driverCommission: string | null,
		merchantCommission: string | null,
	): number {
		try {
			const driver = Number.parseFloat(driverCommission ?? "0");
			const merchant = Number.parseFloat(merchantCommission ?? "0");
			return driver + merchant;
		} catch (error) {
			log.error(
				{ error, driverCommission, merchantCommission },
				"[AnalyticsExportService] Failed to calculate platform revenue",
			);
			return 0;
		}
	}

	/**
	 * Format driver analytics records for CSV export
	 */
	static formatDriverRecords(
		records: DriverAnalyticsRecord[],
	): Array<Record<string, unknown>> {
		try {
			return records.map((row) => ({
				"Order ID": row.id,
				"Service Type": row.type,
				Status: row.status,
				"Total Price": row.total_price,
				"Driver Commission": row.driver_commission,
				"Net Earnings": AnalyticsExportService.calculateNetEarnings(
					row.total_price,
					row.driver_commission,
				),
				"Driver Rating": row.driver_rating ?? "N/A",
				"User Rating": row.user_rating ?? "N/A",
				"Requested At": row.requested_at,
				"Completed At": row.completed_at ?? "N/A",
			}));
		} catch (error) {
			log.error(
				{ error, recordCount: records.length },
				"[AnalyticsExportService] Failed to format driver records",
			);
			return [];
		}
	}

	/**
	 * Format merchant analytics records for CSV export
	 */
	static formatMerchantRecords(
		records: MerchantAnalyticsRecord[],
	): Array<Record<string, unknown>> {
		try {
			return records.map((row) => ({
				"Order ID": row.id,
				"Service Type": row.type,
				Status: row.status,
				"Total Price": row.total_price,
				"Merchant Commission": row.merchant_commission,
				"Net Revenue": AnalyticsExportService.calculateNetEarnings(
					row.total_price,
					row.merchant_commission,
				),
				"Driver Rating": row.driver_rating ?? "N/A",
				"User Rating": row.user_rating ?? "N/A",
				"Requested At": row.requested_at,
				"Completed At": row.completed_at ?? "N/A",
			}));
		} catch (error) {
			log.error(
				{ error, recordCount: records.length },
				"[AnalyticsExportService] Failed to format merchant records",
			);
			return [];
		}
	}

	/**
	 * Format operator analytics records for CSV export
	 */
	static formatOperatorRecords(
		records: OperatorAnalyticsRecord[],
	): Array<Record<string, unknown>> {
		try {
			return records.map((row) => ({
				"Order ID": row.id,
				"Service Type": row.type,
				Status: row.status,
				"Total Price": row.total_price,
				"Driver Commission": row.driver_commission ?? "0",
				"Merchant Commission": row.merchant_commission ?? "0",
				"Platform Revenue": AnalyticsExportService.calculatePlatformRevenue(
					row.driver_commission,
					row.merchant_commission,
				),
				"Driver ID": row.driver_id ?? "N/A",
				"Driver Name": row.driver_name ?? "N/A",
				"User ID": row.user_id,
				"User Name": row.user_name,
				"Merchant ID": row.merchant_id ?? "N/A",
				"Merchant Name": row.merchant_name ?? "N/A",
				"Requested At": row.requested_at,
				"Completed At": row.completed_at ?? "N/A",
			}));
		} catch (error) {
			log.error(
				{ error, recordCount: records.length },
				"[AnalyticsExportService] Failed to format operator records",
			);
			return [];
		}
	}

	/**
	 * Export driver analytics to CSV
	 */
	static exportDriverAnalytics(records: DriverAnalyticsRecord[]): string {
		try {
			const formatted = AnalyticsExportService.formatDriverRecords(records);

			const csv = stringify(formatted, {
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
				{ recordCount: records.length },
				"[AnalyticsExportService] Driver analytics exported to CSV",
			);

			return csv;
		} catch (error) {
			log.error(
				{ error, recordCount: records.length },
				"[AnalyticsExportService] Failed to export driver analytics",
			);
			throw error;
		}
	}

	/**
	 * Export merchant analytics to CSV
	 */
	static exportMerchantAnalytics(records: MerchantAnalyticsRecord[]): string {
		try {
			const formatted = AnalyticsExportService.formatMerchantRecords(records);

			const csv = stringify(formatted, {
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
				{ recordCount: records.length },
				"[AnalyticsExportService] Merchant analytics exported to CSV",
			);

			return csv;
		} catch (error) {
			log.error(
				{ error, recordCount: records.length },
				"[AnalyticsExportService] Failed to export merchant analytics",
			);
			throw error;
		}
	}

	/**
	 * Export operator analytics to CSV
	 */
	static exportOperatorAnalytics(records: OperatorAnalyticsRecord[]): string {
		try {
			const formatted = AnalyticsExportService.formatOperatorRecords(records);

			const csv = stringify(formatted, {
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
				"[AnalyticsExportService] Operator analytics exported to CSV",
			);

			return csv;
		} catch (error) {
			log.error(
				{ error, recordCount: records.length },
				"[AnalyticsExportService] Failed to export operator analytics",
			);
			throw error;
		}
	}
}

import { BaseRepository } from "@/core/base";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { logger } from "@/utils/logger";
import { AnalyticsExportService } from "./services/analytics-export-service";
import { AnalyticsQueryService } from "./services/analytics-query-service";

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
			const result = await AnalyticsQueryService.executeDriverAnalyticsQuery(
				this.db,
				options,
			);

			const csv = AnalyticsExportService.exportDriverAnalytics(result);

			logger.info(
				{ driverId: options.driverId, recordCount: result.length },
				"[AnalyticsRepository] Driver analytics exported",
			);

			return csv;
		} catch (error) {
			logger.error(
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
			const result = await AnalyticsQueryService.executeMerchantAnalyticsQuery(
				this.db,
				options,
			);

			const csv = AnalyticsExportService.exportMerchantAnalytics(result);

			logger.info(
				{ merchantId: options.merchantId, recordCount: result.length },
				"[AnalyticsRepository] Merchant analytics exported",
			);

			return csv;
		} catch (error) {
			logger.error(
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
			const result = await AnalyticsQueryService.executeOperatorAnalyticsQuery(
				this.db,
				options,
			);

			const csv = AnalyticsExportService.exportOperatorAnalytics(result);

			logger.info(
				{ recordCount: result.length },
				"[AnalyticsRepository] Operator analytics exported",
			);

			return csv;
		} catch (error) {
			logger.error(
				{ error, options },
				"[AnalyticsRepository] Failed to export operator analytics",
			);
			throw this.handleError(error, "export operator analytics");
		}
	}
}

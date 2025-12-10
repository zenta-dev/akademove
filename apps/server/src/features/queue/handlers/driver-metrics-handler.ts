/**
 * Driver Metrics Handler
 *
 * Handles DRIVER_METRICS queue messages.
 * Updates driver statistics after order events.
 *
 * Note: The DriverMetricsService calculates metrics on-demand via
 * calculateDriverMetrics(). This handler logs events for metrics
 * that should be tracked incrementally but the service doesn't
 * have individual increment methods yet.
 */

import type { DriverMetricsJob } from "@repo/schema/queue";
import { DriverMetricsService } from "@/features/driver/services/driver-metrics-service";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleDriverMetrics(
	job: DriverMetricsJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload } = job;
	const { driverId, orderId, metricsType, value } = payload;

	logger.debug(
		{ driverId, orderId, metricsType },
		"[DriverMetricsHandler] Updating driver metrics",
	);

	try {
		const metricsService = new DriverMetricsService(context.svc.db);

		// Currently, DriverMetricsService calculates all metrics on-demand
		// via calculateDriverMetrics(). For incremental updates, we just
		// recalculate the full metrics which reads from the database.
		//
		// In the future, we could add caching/incremental update methods.
		switch (metricsType) {
			case "ORDER_COMPLETED":
			case "ORDER_CANCELLED":
			case "RATING_RECEIVED":
			case "NO_SHOW_REPORTED": {
				// Recalculate metrics to update any cached values
				const metrics = await metricsService.calculateDriverMetrics(driverId);
				logger.debug(
					{ driverId, metricsType, metrics },
					"[DriverMetricsHandler] Metrics recalculated",
				);
				break;
			}
			default: {
				logger.warn(
					{ driverId, metricsType },
					"[DriverMetricsHandler] Unknown metrics type",
				);
			}
		}

		logger.info(
			{ driverId, metricsType, orderId, value },
			"[DriverMetricsHandler] Metrics update processed",
		);
	} catch (error) {
		logger.error(
			{ error, driverId, metricsType },
			"[DriverMetricsHandler] Failed to update metrics",
		);
		// Don't throw - metrics are non-critical
	}
}

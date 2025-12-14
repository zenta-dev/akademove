import type { ExecutionContext } from "@cloudflare/workers-types";
import { and, eq, isNotNull, lt } from "drizzle-orm";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Stale location threshold in minutes
 * Drivers whose last location update is older than this will be set offline
 */
const STALE_LOCATION_THRESHOLD_MINUTES = 15;

/**
 * Stale Location Cron Handler
 * Schedule: Every 5 minutes (*/5 * * * *)
 *
 * Purpose:
 * - Set `isOnline = false` for drivers with stale location updates
 * - A stale location is one that hasn't been updated in 15+ minutes
 * - This ensures offline drivers (app closed, lost connection) don't receive orders
 *
 * This handles cases where:
 * 1. Driver's app crashes without proper cleanup
 * 2. Driver loses internet connection
 * 3. Driver closes the app without going offline
 */
export async function handleStaleLocationCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info({}, "[StaleLocationCron] Starting stale location check");

		const svc = getServices();
		const managers = getManagers();
		const repo = getRepositories(svc, managers);
		const now = new Date();
		let offlineCount = 0;

		// Calculate the threshold timestamp
		const staleThreshold = new Date(
			now.getTime() - STALE_LOCATION_THRESHOLD_MINUTES * 60 * 1000,
		);

		// Find online drivers with stale location updates
		const staleDrivers = await svc.db.query.driver.findMany({
			where: (f, op) =>
				and(
					eq(f.isOnline, true),
					eq(f.status, "APPROVED"),
					isNotNull(f.lastLocationUpdate),
					lt(f.lastLocationUpdate, staleThreshold),
				),
			columns: {
				id: true,
				userId: true,
				lastLocationUpdate: true,
			},
			limit: 100, // Process up to 100 drivers per cron run
		});

		if (staleDrivers.length === 0) {
			logger.info({}, "[StaleLocationCron] No drivers with stale location");
			return new Response(
				"Stale location check completed. No stale drivers found.",
				{ status: 200 },
			);
		}

		logger.info(
			{ count: staleDrivers.length, staleThreshold },
			"[StaleLocationCron] Found drivers with stale location",
		);

		// Set stale drivers offline
		for (const driver of staleDrivers) {
			try {
				await svc.db.transaction(async (tx) => {
					await tx
						.update(tables.driver)
						.set({ isOnline: false })
						.where(eq(tables.driver.id, driver.id));
				});

				// Invalidate driver cache
				await repo.driver.main.deleteCache(driver.id);

				offlineCount++;

				logger.info(
					{
						driverId: driver.id,
						userId: driver.userId,
						lastLocationUpdate: driver.lastLocationUpdate,
						staleDuration: driver.lastLocationUpdate
							? Math.round(
									(now.getTime() - driver.lastLocationUpdate.getTime()) /
										60000,
								)
							: null,
					},
					"[StaleLocationCron] Set driver offline due to stale location",
				);
			} catch (error) {
				logger.error(
					{ error, driverId: driver.id },
					"[StaleLocationCron] Failed to set driver offline",
				);
			}
		}

		logger.info(
			{
				offlineCount,
				totalStale: staleDrivers.length,
				duration: Date.now() - now.getTime(),
			},
			"[StaleLocationCron] Completed stale location check",
		);

		return new Response(
			`Stale location check completed. Set ${offlineCount} drivers offline.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error },
			"[StaleLocationCron] Failed to check stale locations",
		);
		return new Response("Stale location check failed", { status: 500 });
	}
}

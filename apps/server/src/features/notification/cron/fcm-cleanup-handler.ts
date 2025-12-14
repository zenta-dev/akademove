import type { ExecutionContext } from "@cloudflare/workers-types";
import { lt } from "drizzle-orm";
import { getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Stale FCM token threshold in days
 * Tokens not updated in this many days will be removed
 */
const STALE_TOKEN_THRESHOLD_DAYS = 60;

/**
 * FCM Token Cleanup Cron Handler
 * Schedule: Weekly on Sunday at 4 AM (0 4 * * 0)
 *
 * Purpose:
 * - Remove FCM tokens that haven't been updated in 60+ days
 * - These tokens are likely invalid (user uninstalled app, token expired)
 * - Cleaning them up reduces failed notification attempts
 *
 * FCM tokens can become invalid when:
 * 1. User uninstalls the app
 * 2. User clears app data
 * 3. Token is revoked by Firebase
 * 4. Token expires naturally
 */
export async function handleFcmCleanupCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info({}, "[FcmCleanupCron] Starting stale FCM token cleanup");

		const svc = getServices();
		const now = new Date();
		let deletedCount = 0;

		// Calculate the threshold date
		const staleThreshold = new Date(
			now.getTime() - STALE_TOKEN_THRESHOLD_DAYS * 24 * 60 * 60 * 1000,
		);

		// Delete stale tokens in a single transaction
		await svc.db.transaction(async (tx) => {
			// Count tokens to be deleted first for logging
			const staleTokens = await tx.query.fcmToken.findMany({
				where: (f, _op) => lt(f.updatedAt, staleThreshold),
				columns: { id: true },
				limit: 1000, // Limit count query
			});

			if (staleTokens.length === 0) {
				logger.info({}, "[FcmCleanupCron] No stale FCM tokens found");
				return;
			}

			logger.info(
				{ count: staleTokens.length, staleThreshold },
				"[FcmCleanupCron] Found stale FCM tokens to delete",
			);

			// Delete stale tokens
			const result = await tx
				.delete(tables.fcmToken)
				.where(lt(tables.fcmToken.updatedAt, staleThreshold));

			deletedCount = staleTokens.length;

			logger.info(
				{ deletedCount },
				"[FcmCleanupCron] Deleted stale FCM tokens",
			);
		});

		logger.info(
			{ deletedCount, duration: Date.now() - now.getTime() },
			"[FcmCleanupCron] Completed stale FCM token cleanup",
		);

		return new Response(
			`FCM token cleanup completed. Deleted ${deletedCount} stale tokens.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error({ error }, "[FcmCleanupCron] Failed to cleanup FCM tokens");
		return new Response("FCM token cleanup failed", { status: 500 });
	}
}

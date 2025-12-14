import type { ExecutionContext } from "@cloudflare/workers-types";
import { and, eq, isNotNull, lt } from "drizzle-orm";
import { getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Ban Expiry Cron Handler
 * Schedule: Every hour (0 * * * *)
 *
 * Purpose:
 * - Clear expired user bans by resetting `banned`, `banReason`, and `banExpires` fields
 * - Users whose `banExpires` timestamp has passed should be automatically unbanned
 *
 * This ensures temporary bans are lifted automatically without manual intervention.
 */
export async function handleBanExpiryCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info({}, "[BanExpiryCron] Starting expired ban cleanup");

		const svc = getServices();
		const now = new Date();
		let unbannedCount = 0;

		// Find and clear expired bans in a single transaction
		await svc.db.transaction(async (tx) => {
			// Find users with expired bans
			const expiredBans = await tx.query.user.findMany({
				where: (f, op) =>
					and(
						eq(f.banned, true),
						isNotNull(f.banExpires),
						lt(f.banExpires, now),
					),
				columns: {
					id: true,
					name: true,
					email: true,
					banExpires: true,
				},
				limit: 100, // Process up to 100 users per cron run
			});

			if (expiredBans.length === 0) {
				logger.info({}, "[BanExpiryCron] No expired bans found");
				return;
			}

			logger.info(
				{ count: expiredBans.length },
				"[BanExpiryCron] Found expired bans to clear",
			);

			// Clear expired bans
			for (const user of expiredBans) {
				try {
					await tx
						.update(tables.user)
						.set({
							banned: false,
							banReason: null,
							banExpires: null,
						})
						.where(eq(tables.user.id, user.id));

					unbannedCount++;

					logger.info(
						{
							userId: user.id,
							userName: user.name,
							banExpires: user.banExpires,
						},
						"[BanExpiryCron] Cleared expired ban for user",
					);
				} catch (error) {
					logger.error(
						{ error, userId: user.id },
						"[BanExpiryCron] Failed to clear ban for user",
					);
				}
			}
		});

		logger.info(
			{ unbannedCount, duration: Date.now() - now.getTime() },
			"[BanExpiryCron] Completed expired ban cleanup",
		);

		return new Response(
			`Ban expiry cleanup completed. Unbanned ${unbannedCount} users.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error({ error }, "[BanExpiryCron] Failed to clear expired bans");
		return new Response("Ban expiry cleanup failed", { status: 500 });
	}
}

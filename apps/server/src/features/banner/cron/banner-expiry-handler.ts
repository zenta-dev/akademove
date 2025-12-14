import type { ExecutionContext } from "@cloudflare/workers-types";
import { and, eq, isNotNull, lt } from "drizzle-orm";
import { getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Banner Expiry Cron Handler
 * Schedule: Daily at midnight (0 0 * * *)
 *
 * Purpose:
 * - Deactivate banners whose `endAt` has passed
 * - Set `isActive = false` for expired banners
 *
 * This ensures expired banners are not displayed and keeps the active banner list clean.
 */
export async function handleBannerExpiryCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info({}, "[BannerExpiryCron] Starting expired banner deactivation");

		const svc = getServices();
		const now = new Date();
		let deactivatedCount = 0;

		// Find and deactivate expired banners in a single transaction
		await svc.db.transaction(async (tx) => {
			// Find active banners that have expired (endAt is set and has passed)
			const expiredBanners = await tx.query.banner.findMany({
				where: (f, op) =>
					and(eq(f.isActive, true), isNotNull(f.endAt), lt(f.endAt, now)),
				columns: {
					id: true,
					title: true,
					endAt: true,
				},
				limit: 200, // Process up to 200 banners per cron run
			});

			if (expiredBanners.length === 0) {
				logger.info({}, "[BannerExpiryCron] No expired banners found");
				return;
			}

			logger.info(
				{ count: expiredBanners.length },
				"[BannerExpiryCron] Found expired banners to deactivate",
			);

			// Deactivate expired banners
			for (const banner of expiredBanners) {
				try {
					await tx
						.update(tables.banner)
						.set({ isActive: false })
						.where(eq(tables.banner.id, banner.id));

					deactivatedCount++;

					logger.info(
						{
							bannerId: banner.id,
							bannerTitle: banner.title,
							endAt: banner.endAt,
						},
						"[BannerExpiryCron] Deactivated expired banner",
					);
				} catch (error) {
					logger.error(
						{ error, bannerId: banner.id },
						"[BannerExpiryCron] Failed to deactivate banner",
					);
				}
			}
		});

		logger.info(
			{ deactivatedCount, duration: Date.now() - now.getTime() },
			"[BannerExpiryCron] Completed expired banner deactivation",
		);

		return new Response(
			`Banner expiry cleanup completed. Deactivated ${deactivatedCount} banners.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error },
			"[BannerExpiryCron] Failed to deactivate expired banners",
		);
		return new Response("Banner expiry cleanup failed", { status: 500 });
	}
}

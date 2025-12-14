import type { ExecutionContext } from "@cloudflare/workers-types";
import { and, eq, lt } from "drizzle-orm";
import { getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Coupon Expiry Cron Handler
 * Schedule: Daily at midnight (0 0 * * *)
 *
 * Purpose:
 * - Deactivate coupons whose `periodEnd` has passed
 * - Set `isActive = false` for expired coupons
 *
 * This ensures expired coupons cannot be used and keeps the active coupon list clean.
 */
export async function handleCouponExpiryCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info({}, "[CouponExpiryCron] Starting expired coupon deactivation");

		const svc = getServices();
		const now = new Date();
		let deactivatedCount = 0;

		// Find and deactivate expired coupons in a single transaction
		await svc.db.transaction(async (tx) => {
			// Find active coupons that have expired
			const expiredCoupons = await tx.query.coupon.findMany({
				where: (f, _op) => and(eq(f.isActive, true), lt(f.periodEnd, now)),
				columns: {
					id: true,
					name: true,
					code: true,
					periodEnd: true,
				},
				limit: 500, // Process up to 500 coupons per cron run
			});

			if (expiredCoupons.length === 0) {
				logger.info({}, "[CouponExpiryCron] No expired coupons found");
				return;
			}

			logger.info(
				{ count: expiredCoupons.length },
				"[CouponExpiryCron] Found expired coupons to deactivate",
			);

			// Deactivate expired coupons
			for (const coupon of expiredCoupons) {
				try {
					await tx
						.update(tables.coupon)
						.set({ isActive: false })
						.where(eq(tables.coupon.id, coupon.id));

					deactivatedCount++;

					logger.info(
						{
							couponId: coupon.id,
							couponCode: coupon.code,
							couponName: coupon.name,
							periodEnd: coupon.periodEnd,
						},
						"[CouponExpiryCron] Deactivated expired coupon",
					);
				} catch (error) {
					logger.error(
						{ error, couponId: coupon.id },
						"[CouponExpiryCron] Failed to deactivate coupon",
					);
				}
			}
		});

		logger.info(
			{ deactivatedCount, duration: Date.now() - now.getTime() },
			"[CouponExpiryCron] Completed expired coupon deactivation",
		);

		return new Response(
			`Coupon expiry cleanup completed. Deactivated ${deactivatedCount} coupons.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error },
			"[CouponExpiryCron] Failed to deactivate expired coupons",
		);
		return new Response("Coupon expiry cleanup failed", { status: 500 });
	}
}

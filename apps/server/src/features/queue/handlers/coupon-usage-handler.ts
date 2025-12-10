/**
 * Coupon Usage Handler
 *
 * Handles COUPON_USAGE queue messages.
 * Records coupon usage after order placement.
 */

import type { CouponUsageJob } from "@repo/schema/queue";
import { log } from "@/utils";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleCouponUsage(
	job: CouponUsageJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload } = job;
	const { couponId, userId, orderId, discountAmount } = payload;

	log.debug(
		{ couponId, orderId, discountAmount },
		"[CouponUsageHandler] Recording coupon usage",
	);

	try {
		// Record coupon usage in the database
		await context.repo.coupon.recordUsage(
			couponId,
			orderId,
			userId,
			discountAmount,
		);

		log.info(
			{ couponId, userId, orderId, discountAmount },
			"[CouponUsageHandler] Coupon usage recorded",
		);
	} catch (error) {
		log.error(
			{ error, couponId, orderId },
			"[CouponUsageHandler] Failed to record coupon usage",
		);
		// Don't throw - coupon usage recording is for analytics
		// The order is already placed with the discount applied
	}
}

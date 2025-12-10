/**
 * Badge Evaluation Handler
 *
 * Handles BADGE_EVALUATION queue messages.
 * Checks and awards badges after order completion.
 */

import type { BadgeEvaluationJob } from "@repo/schema/queue";
import { BadgeAwardService } from "@/features/badge/services/badge-award-service";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleBadgeEvaluation(
	job: BadgeEvaluationJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload } = job;
	const { driverId, userId: _userId, orderId, orderType } = payload;

	logger.debug(
		{ driverId, orderId, orderType },
		"[BadgeEvaluationHandler] Processing badge evaluation",
	);

	try {
		const badgeService = new BadgeAwardService(context.svc.db, context.repo);

		const result = await badgeService.evaluateAndAwardBadges(driverId);

		if (result.newBadges.length > 0) {
			logger.info(
				{
					driverId,
					orderId,
					newBadges: result.newBadges,
					alreadyEarned: result.alreadyEarned.length,
				},
				"[BadgeEvaluationHandler] New badges awarded",
			);
		} else {
			logger.debug(
				{ driverId, orderId },
				"[BadgeEvaluationHandler] No new badges earned",
			);
		}
	} catch (error) {
		logger.error(
			{ error, driverId, orderId },
			"[BadgeEvaluationHandler] Failed to evaluate badges",
		);
		// Don't throw - badge evaluation is non-critical
		// The order is already completed, we just couldn't award badges
	}
}

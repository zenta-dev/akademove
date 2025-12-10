import type { BadgeCriteria } from "@repo/schema/badge";
import type { DriverMetrics } from "@/features/driver/services/driver-metrics-service";
import { logger } from "@/utils/logger";

export class BadgeCriteriaEvaluator {
	/**
	 * Evaluate if driver metrics meet badge criteria
	 */
	static evaluateCriteria(
		metrics: DriverMetrics,
		criteria: BadgeCriteria,
	): boolean {
		try {
			const checks = [];

			// Check minimum orders
			if (criteria.minOrders !== undefined) {
				checks.push(metrics.completedOrders >= criteria.minOrders);
			}

			// Check minimum rating (0-5 scale)
			if (criteria.minRating !== undefined) {
				checks.push(metrics.averageRating >= criteria.minRating);
			}

			// Check minimum on-time rate (0-1 scale, represents percentage)
			if (criteria.minOnTimeRate !== undefined) {
				checks.push(metrics.onTimeRate >= criteria.minOnTimeRate);
			}

			// Check minimum streak
			if (criteria.minStreak !== undefined) {
				checks.push(metrics.currentStreak >= criteria.minStreak);
			}

			// Check minimum earnings
			if (criteria.minEarnings !== undefined) {
				checks.push(metrics.totalEarnings >= criteria.minEarnings);
			}

			// All criteria must be met
			// If no criteria are defined (checks.length === 0), badge is auto-awarded
			const allCriteriaMet =
				checks.length === 0 || checks.every((c) => c === true);

			logger.debug(
				{
					driverId: metrics.driverId,
					criteria,
					metrics: {
						completedOrders: metrics.completedOrders,
						averageRating: metrics.averageRating,
						onTimeRate: metrics.onTimeRate,
						currentStreak: metrics.currentStreak,
						totalEarnings: metrics.totalEarnings,
					},
					checks,
					result: allCriteriaMet,
				},
				"[BadgeCriteriaEvaluator] Criteria evaluation",
			);

			return allCriteriaMet;
		} catch (error) {
			logger.error(
				{ error, criteria, metrics },
				"[BadgeCriteriaEvaluator] Failed to evaluate criteria",
			);
			return false;
		}
	}

	/**
	 * Calculate badge progress percentage (0-100)
	 */
	static calculateProgress(
		metrics: DriverMetrics,
		criteria: BadgeCriteria,
	): number {
		try {
			const progressChecks: number[] = [];

			// Calculate progress for each criterion
			if (criteria.minOrders !== undefined && criteria.minOrders > 0) {
				const progress = Math.min(
					(metrics.completedOrders / criteria.minOrders) * 100,
					100,
				);
				progressChecks.push(progress);
			}

			if (criteria.minRating !== undefined && criteria.minRating > 0) {
				const progress = Math.min(
					(metrics.averageRating / criteria.minRating) * 100,
					100,
				);
				progressChecks.push(progress);
			}

			if (criteria.minOnTimeRate !== undefined && criteria.minOnTimeRate > 0) {
				const progress = Math.min(
					(metrics.onTimeRate / criteria.minOnTimeRate) * 100,
					100,
				);
				progressChecks.push(progress);
			}

			if (criteria.minStreak !== undefined && criteria.minStreak > 0) {
				const progress = Math.min(
					(metrics.currentStreak / criteria.minStreak) * 100,
					100,
				);
				progressChecks.push(progress);
			}

			if (criteria.minEarnings !== undefined && criteria.minEarnings > 0) {
				const progress = Math.min(
					(metrics.totalEarnings / criteria.minEarnings) * 100,
					100,
				);
				progressChecks.push(progress);
			}

			// Average progress across all criteria
			if (progressChecks.length === 0) return 0;

			const avgProgress =
				progressChecks.reduce((sum, p) => sum + p, 0) / progressChecks.length;

			return Math.round(avgProgress);
		} catch (error) {
			logger.error(
				{ error, criteria, metrics },
				"[BadgeCriteriaEvaluator] Failed to calculate progress",
			);
			return 0;
		}
	}
}

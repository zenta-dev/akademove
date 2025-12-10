import type { LEADERBOARD_CATEGORIES } from "@repo/schema/constants";
import type { DriverMetrics } from "@/features/driver/services/driver-metrics-service";
import { logger } from "@/utils/logger";

type LeaderboardCategory = (typeof LEADERBOARD_CATEGORIES)[number];

/**
 * Static utility class for calculating leaderboard scores per category
 * Each category has a different scoring algorithm based on driver metrics
 */
export class LeaderboardScoreCalculator {
	/**
	 * Calculate score for a specific leaderboard category
	 */
	static calculateScore(
		category: LeaderboardCategory,
		metrics: DriverMetrics,
	): number {
		try {
			switch (category) {
				case "RATING":
					return LeaderboardScoreCalculator.#calculateRatingScore(metrics);
				case "VOLUME":
					return LeaderboardScoreCalculator.#calculateVolumeScore(metrics);
				case "EARNINGS":
					return LeaderboardScoreCalculator.#calculateEarningsScore(metrics);
				case "ON-TIME":
					return LeaderboardScoreCalculator.#calculateOnTimeScore(metrics);
				case "COMPLETION-RATE":
					return LeaderboardScoreCalculator.#calculateCompletionRateScore(
						metrics,
					);
				case "STREAK":
					return LeaderboardScoreCalculator.#calculateStreakScore(metrics);
				default:
					logger.warn(
						{ category },
						"[LeaderboardScoreCalculator] Unknown category, returning 0",
					);
					return 0;
			}
		} catch (error) {
			logger.error(
				{ error, category, driverId: metrics.driverId },
				"[LeaderboardScoreCalculator] Failed to calculate score",
			);
			return 0;
		}
	}

	/**
	 * Calculate all category scores for a driver
	 */
	static calculateAllScores(
		metrics: DriverMetrics,
	): Record<LeaderboardCategory, number> {
		return {
			RATING: LeaderboardScoreCalculator.#calculateRatingScore(metrics),
			VOLUME: LeaderboardScoreCalculator.#calculateVolumeScore(metrics),
			EARNINGS: LeaderboardScoreCalculator.#calculateEarningsScore(metrics),
			"ON-TIME": LeaderboardScoreCalculator.#calculateOnTimeScore(metrics),
			"COMPLETION-RATE":
				LeaderboardScoreCalculator.#calculateCompletionRateScore(metrics),
			STREAK: LeaderboardScoreCalculator.#calculateStreakScore(metrics),
		};
	}

	/**
	 * RATING category: Average rating * 100
	 * Range: 0-500 (assuming 5.0 max rating)
	 */
	static #calculateRatingScore(metrics: DriverMetrics): number {
		if (metrics.totalOrders === 0) return 0;
		return Math.round(metrics.averageRating * 100);
	}

	/**
	 * VOLUME category: Total completed orders
	 * Range: 0-unlimited
	 */
	static #calculateVolumeScore(metrics: DriverMetrics): number {
		return metrics.completedOrders;
	}

	/**
	 * EARNINGS category: Total earnings (in cents/smallest currency unit)
	 * Range: 0-unlimited
	 */
	static #calculateEarningsScore(metrics: DriverMetrics): number {
		return Math.round(metrics.totalEarnings);
	}

	/**
	 * ON-TIME category: On-time rate * 1000 (to preserve decimals as integer)
	 * Range: 0-1000 (represents 0% to 100%)
	 */
	static #calculateOnTimeScore(metrics: DriverMetrics): number {
		if (metrics.completedOrders === 0) return 0;
		return Math.round(metrics.onTimeRate * 1000);
	}

	/**
	 * COMPLETION-RATE category: Completion rate * 1000
	 * Range: 0-1000 (represents 0% to 100%)
	 */
	static #calculateCompletionRateScore(metrics: DriverMetrics): number {
		if (metrics.totalOrders === 0) return 0;
		return Math.round(metrics.completionRate * 1000);
	}

	/**
	 * STREAK category: Current consecutive day streak
	 * Range: 0-unlimited
	 */
	static #calculateStreakScore(metrics: DriverMetrics): number {
		return metrics.currentStreak;
	}
}

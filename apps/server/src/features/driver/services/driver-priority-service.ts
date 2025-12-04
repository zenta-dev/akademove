import { desc, eq } from "drizzle-orm";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import { log } from "@/utils";

interface DriverWithPriority {
	driverId: string;
	userId: string;
	priorityScore: number;
	badgeLevel: string | null;
	leaderboardRank: number | null;
}

/**
 * Service for calculating driver priority in order matching
 * Priority is based on: badge benefits (priorityBoost) + leaderboard rankings
 */
export class DriverPriorityService {
	#db: DatabaseService;

	constructor(db: DatabaseService) {
		this.#db = db;
	}

	/**
	 * Sort drivers by priority score (higher = better)
	 * Priority calculation:
	 * - Badge priorityBoost: 0-100 points (from highest level badge)
	 * - Leaderboard bonus: Inverse of rank for top 100 drivers (1st = 100, 100th = 1)
	 */
	async sortDriversByPriority(
		driverIds: string[],
		opts?: { tx: DatabaseTransaction },
	): Promise<DriverWithPriority[]> {
		try {
			if (driverIds.length === 0) {
				return [];
			}

			const db = opts?.tx ?? this.#db;

			// Get driver priorities in parallel
			const driverPriorities = await Promise.all(
				driverIds.map((driverId) =>
					this.#calculateDriverPriority(driverId, db),
				),
			);

			// Sort by priority score descending (highest first)
			driverPriorities.sort((a, b) => b.priorityScore - a.priorityScore);

			log.info(
				{ count: driverPriorities.length },
				"[DriverPriorityService] Drivers sorted by priority",
			);

			return driverPriorities;
		} catch (error) {
			log.error(
				{ error, driverIds },
				"[DriverPriorityService] Failed to sort drivers by priority",
			);
			throw error;
		}
	}

	/**
	 * Calculate priority score for a single driver
	 */
	async #calculateDriverPriority(
		driverId: string,
		db: DatabaseService | DatabaseTransaction,
	): Promise<DriverWithPriority> {
		const driver = await db.query.driver.findFirst({
			where: (f, op) => op.eq(f.id, driverId),
		});

		if (!driver) {
			return {
				driverId,
				userId: "",
				priorityScore: 0,
				badgeLevel: null,
				leaderboardRank: null,
			};
		}

		const [badgeBoost, leaderboardBonus] = await Promise.all([
			this.#getBadgePriorityBoost(driver.userId, db),
			this.#getLeaderboardBonus(driver.userId, db),
		]);

		const priorityScore = badgeBoost + leaderboardBonus;

		return {
			driverId,
			userId: driver.userId,
			priorityScore,
			badgeLevel: badgeBoost > 0 ? "BADGE" : null,
			leaderboardRank:
				leaderboardBonus > 0 ? Math.round(101 - leaderboardBonus) : null,
		};
	}

	/**
	 * Get the highest priorityBoost from driver's earned badges
	 */
	async #getBadgePriorityBoost(
		userId: string,
		db: DatabaseService | DatabaseTransaction,
	): Promise<number> {
		const userBadges = await db.query.userBadge.findMany({
			where: (f, _op) => eq(f.userId, userId),
			with: {
				badge: true,
			},
		});

		if (userBadges.length === 0) {
			return 0;
		}

		// Find highest priorityBoost from all badges
		let maxBoost = 0;
		for (const userBadge of userBadges) {
			const boost = userBadge.badge.benefits?.priorityBoost ?? 0;
			if (boost > maxBoost) {
				maxBoost = boost;
			}
		}

		return maxBoost;
	}

	/**
	 * Get leaderboard bonus based on current WEEKLY VOLUME ranking
	 * Top 100 drivers get bonus: 1st = 100, 2nd = 99, ..., 100th = 1
	 */
	async #getLeaderboardBonus(
		userId: string,
		db: DatabaseService | DatabaseTransaction,
	): Promise<number> {
		// Get current week's VOLUME leaderboard ranking
		const leaderboardEntry = await db.query.leaderboard.findFirst({
			where: (f, op) =>
				op.and(
					eq(f.userId, userId),
					eq(f.category, "VOLUME"),
					eq(f.period, "WEEKLY"),
				),
			orderBy: (f, _op) => [desc(f.periodStart)],
		});

		if (!leaderboardEntry || leaderboardEntry.rank > 100) {
			return 0;
		}

		// Inverse rank: 1st place = 100, 100th place = 1
		return 101 - leaderboardEntry.rank;
	}
}

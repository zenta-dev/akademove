import { RepositoryError } from "@/core/error";
import type { RepositoryContext } from "@/core/interface";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import type { DriverMetricsConfig } from "@/features/driver/services/driver-metrics-service";
import { DriverMetricsService } from "@/features/driver/services/driver-metrics-service";
import { logger } from "@/utils/logger";
import { BadgeCriteriaEvaluator } from "./badge-criteria-evaluator";

export class BadgeAwardService {
	#db: DatabaseService;
	#repo: RepositoryContext;
	#metricsService: DriverMetricsService;
	#metricsConfig: DriverMetricsConfig;

	/**
	 * @param db - Database service
	 * @param repo - Repository context
	 * @param metricsConfig - Driver metrics configuration (onTimeDeliveryThresholdMinutes)
	 */
	constructor(
		db: DatabaseService,
		repo: RepositoryContext,
		metricsConfig: DriverMetricsConfig,
	) {
		this.#db = db;
		this.#repo = repo;
		this.#metricsService = new DriverMetricsService(db);
		this.#metricsConfig = metricsConfig;
	}

	/**
	 * Check and award eligible badges to a driver after order completion
	 */
	async evaluateAndAwardBadges(
		driverId: string,
		opts?: { tx: DatabaseTransaction },
	): Promise<{
		newBadges: string[];
		alreadyEarned: string[];
	}> {
		try {
			const driver = await this.#db.query.driver.findFirst({
				where: (f, op) => op.eq(f.id, driverId),
			});

			if (!driver) {
				throw new RepositoryError(`Driver with id ${driverId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const metrics = await this.#metricsService.calculateDriverMetrics(
				driverId,
				this.#metricsConfig,
				opts,
			);

			const availableBadges = await this.#db.query.badge.findMany({
				where: (f, op) =>
					op.and(op.eq(f.isActive, true), op.eq(f.targetRole, "DRIVER")),
				orderBy: (f, op) => [op.asc(f.level), op.asc(f.displayOrder)],
			});

			const existingBadges = await this.#db.query.userBadge.findMany({
				where: (f, op) => op.eq(f.userId, driver.userId),
			});

			const existingBadgeIds = new Set(existingBadges.map((ub) => ub.badgeId));

			const newBadges: string[] = [];
			const alreadyEarned: string[] = [];

			for (const badge of availableBadges) {
				if (existingBadgeIds.has(badge.id)) {
					alreadyEarned.push(badge.code);
					continue;
				}

				const qualifies = BadgeCriteriaEvaluator.evaluateCriteria(
					metrics,
					badge.criteria,
				);

				if (qualifies) {
					await this.#repo.badge.user.create(
						{
							userId: driver.userId,
							badgeId: badge.id,
							metadata: {
								ordersCompleted: metrics.completedOrders,
								finalRating: metrics.averageRating,
								streakDays: metrics.currentStreak,
							},
						},
						opts,
					);

					newBadges.push(badge.code);

					logger.info(
						{ driverId, badgeCode: badge.code },
						"[BadgeAwardService] Badge awarded",
					);

					this.#sendBadgeNotification(driver.userId, badge).catch((error) => {
						logger.warn(
							{ error, driverId, badgeId: badge.id },
							"[BadgeAwardService] Failed to send notification",
						);
					});
				}
			}

			return { newBadges, alreadyEarned };
		} catch (error) {
			logger.error(
				{ error, driverId },
				"[BadgeAwardService] Failed to evaluate badges",
			);
			throw error;
		}
	}

	async #sendBadgeNotification(
		userId: string,
		badge: { id: string; code: string; name: string; description: string },
	): Promise<void> {
		await this.#repo.notification.sendNotificationToUserId({
			fromUserId: "system",
			toUserId: userId,
			title: `New Badge Earned: ${badge.name}`,
			body: badge.description,
			data: {
				type: "BADGE_EARNED",
				badgeId: badge.id,
				badgeCode: badge.code,
				deeplink: `akademove://driver/badges/${badge.id}`,
			},
			android: {
				priority: "high",
				notification: { clickAction: "BADGE_DETAIL" },
			},
			apns: {
				payload: { aps: { category: "BADGE_DETAIL", sound: "default" } },
			},
		});
	}

	async checkBadgeProgress(
		driverId: string,
		badgeId: string,
	): Promise<{ progress: number; qualified: boolean }> {
		try {
			const driver = await this.#db.query.driver.findFirst({
				where: (f, op) => op.eq(f.id, driverId),
			});

			if (!driver) {
				throw new RepositoryError(`Driver with id ${driverId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const badge = await this.#db.query.badge.findFirst({
				where: (f, op) => op.eq(f.id, badgeId),
			});

			if (!badge) {
				throw new RepositoryError(`Badge with id ${badgeId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const metrics = await this.#metricsService.calculateDriverMetrics(
				driverId,
				this.#metricsConfig,
			);

			const progress = BadgeCriteriaEvaluator.calculateProgress(
				metrics,
				badge.criteria,
			);

			const qualified = BadgeCriteriaEvaluator.evaluateCriteria(
				metrics,
				badge.criteria,
			);

			return { progress, qualified };
		} catch (error) {
			logger.error(
				{ error, driverId, badgeId },
				"[BadgeAwardService] Failed to check badge progress",
			);
			throw error;
		}
	}
}

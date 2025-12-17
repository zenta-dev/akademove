import {
	type BusinessConfiguration,
	BusinessConfigurationSchema,
} from "@repo/schema/configuration";
import { CACHE_TTLS, CONFIGURATION_KEYS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { logger } from "@/utils/logger";

/**
 * BusinessConfigurationService - Provides typed access to business configuration values.
 *
 * All pricing-related values MUST come from the database, not static constants.
 * This service ensures consistent access to business rules that can be changed
 * by admin/operator via the configuration panel.
 *
 * @example
 * ```typescript
 * const config = await BusinessConfigurationService.getConfig(db, kv);
 * const minTransfer = config.minTransferAmount;
 * const cancellationFee = config.userCancellationFeeAfterAccept;
 * ```
 */
export class BusinessConfigurationService {
	private static readonly CACHE_KEY = "business-config";

	/**
	 * Get business configuration from database with caching
	 *
	 * @param db - Database service
	 * @param kv - Key-value service for caching
	 * @returns Business configuration
	 * @throws {RepositoryError} When configuration is not found
	 */
	static async getConfig(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<BusinessConfiguration> {
		try {
			// Fetch from database with cache fallback
			const fetchFromDatabase = async (): Promise<BusinessConfiguration> => {
				const result = await db.query.configuration.findFirst({
					where: (f, op) =>
						op.eq(f.key, CONFIGURATION_KEYS.BUSINESS_CONFIGURATION),
				});

				if (!result) {
					logger.error(
						"[BusinessConfigurationService] Business configuration not found in database",
					);
					throw new RepositoryError(
						"Business configuration not found. Please run database seed.",
						{ code: "NOT_FOUND" },
					);
				}

				// Parse through Zod schema to apply defaults for any missing fields
				// This ensures backward compatibility when new config fields are added
				const config = BusinessConfigurationSchema.parse(result.value);

				// Cache for 1 hour
				await kv.put(BusinessConfigurationService.CACHE_KEY, config, {
					expirationTtl: CACHE_TTLS["1h"],
				});

				return config;
			};

			// Try to get from cache first, with database fallback
			return await kv.get<BusinessConfiguration>(
				BusinessConfigurationService.CACHE_KEY,
				{ fallback: fetchFromDatabase },
			);
		} catch (error) {
			if (error instanceof RepositoryError) {
				throw error;
			}
			logger.error(
				{ error },
				"[BusinessConfigurationService] Failed to get business configuration",
			);
			throw new RepositoryError("Failed to get business configuration", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Invalidate the cached business configuration.
	 * Call this when business configuration is updated.
	 *
	 * @param kv - Key-value service
	 */
	static async invalidateCache(kv: KeyValueService): Promise<void> {
		await kv.delete(BusinessConfigurationService.CACHE_KEY);
		logger.info(
			"[BusinessConfigurationService] Business configuration cache invalidated",
		);
	}

	/**
	 * Get minimum transfer amount from config
	 */
	static async getMinTransferAmount(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.minTransferAmount;
	}

	/**
	 * Get minimum withdrawal amount from config
	 */
	static async getMinWithdrawalAmount(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.minWithdrawalAmount;
	}

	/**
	 * Get minimum top-up amount from config
	 */
	static async getMinTopUpAmount(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.minTopUpAmount;
	}

	/**
	 * Get quick top-up amounts from config
	 */
	static async getQuickTopUpAmounts(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number[]> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.quickTopUpAmounts;
	}

	/**
	 * Get cancellation fee rate before driver accepts
	 */
	static async getCancellationFeeBeforeAccept(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.userCancellationFeeBeforeAccept;
	}

	/**
	 * Get cancellation fee rate after driver accepts
	 */
	static async getCancellationFeeAfterAccept(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.userCancellationFeeAfterAccept;
	}

	/**
	 * Get no-show fee rate
	 */
	static async getNoShowFee(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.noShowFee;
	}

	/**
	 * Get high value order threshold for OTP verification
	 */
	static async getHighValueOrderThreshold(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.highValueOrderThreshold;
	}

	/**
	 * Get driver matching configuration
	 * Returns all values needed for driver matching logic
	 */
	static async getDriverMatchingConfig(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<{
		initialRadiusKm: number;
		maxRadiusKm: number;
		expansionRate: number;
		timeoutMinutes: number;
		intervalSeconds: number;
		broadcastLimit: number;
		maxCancellationsPerDay: number;
	}> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return {
			initialRadiusKm: config.driverMatchingInitialRadiusKm,
			maxRadiusKm: config.driverMatchingMaxRadiusKm,
			expansionRate: config.driverMatchingRadiusExpansionRate,
			timeoutMinutes: config.driverMatchingTimeoutMinutes,
			intervalSeconds: config.driverMatchingIntervalSeconds,
			broadcastLimit: config.driverMatchingBroadcastLimit,
			maxCancellationsPerDay: config.driverMaxCancellationsPerDay,
		};
	}

	/**
	 * Get order lifecycle configuration
	 * Returns all values needed for order status checking and cleanup
	 */
	static async getOrderLifecycleConfig(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<{
		paymentPendingTimeoutMinutes: number;
		driverMatchingTimeoutMinutes: number;
		orderCompletionTimeoutMinutes: number;
		noShowTimeoutMinutes: number;
		orderStaleTimestampMinutes: number;
	}> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return {
			paymentPendingTimeoutMinutes: config.paymentPendingTimeoutMinutes,
			driverMatchingTimeoutMinutes: config.driverMatchingTimeoutMinutes,
			orderCompletionTimeoutMinutes: config.orderCompletionTimeoutMinutes,
			noShowTimeoutMinutes: config.noShowTimeoutMinutes,
			orderStaleTimestampMinutes: config.orderStaleTimestampMinutes,
		};
	}

	/**
	 * Get driver location tracking configuration
	 */
	static async getDriverLocationStaleThresholdMinutes(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.driverLocationStaleThresholdMinutes;
	}

	/**
	 * Get driver rebroadcast configuration
	 * Returns all values needed for order rebroadcasting to drivers
	 */
	static async getDriverRebroadcastConfig(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<{
		intervalMinutes: number;
		radiusMultiplier: number;
	}> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return {
			intervalMinutes: config.driverRebroadcastIntervalMinutes,
			radiusMultiplier: config.driverRebroadcastRadiusMultiplier,
		};
	}

	/**
	 * Get maximum badge commission reduction rate
	 */
	static async getMaxBadgeCommissionReduction(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.maxBadgeCommissionReduction;
	}

	/**
	 * Get scheduled order configuration
	 * Returns all values needed for scheduled order validation and processing
	 */
	static async getScheduledOrderConfig(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<{
		minAdvanceMinutes: number;
		maxAdvanceDays: number;
		matchingLeadTimeMinutes: number;
		minRescheduleHours: number;
	}> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return {
			minAdvanceMinutes: config.scheduledOrderMinAdvanceMinutes,
			maxAdvanceDays: config.scheduledOrderMaxAdvanceDays,
			matchingLeadTimeMinutes: config.scheduledOrderMatchingLeadTimeMinutes,
			minRescheduleHours: config.scheduledOrderMinRescheduleHours,
		};
	}

	/**
	 * Get on-time delivery threshold in minutes
	 * Used for driver metrics and leaderboard calculations
	 */
	static async getOnTimeDeliveryThresholdMinutes(
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<number> {
		const config = await BusinessConfigurationService.getConfig(db, kv);
		return config.onTimeDeliveryThresholdMinutes;
	}
}

/**
 * OrderSchedulingService - Manages scheduled order logic
 *
 * SOLID Principles:
 * - SRP: Single responsibility for scheduled order validation and activation
 * - OCP: Open for extension with new scheduling rules
 * - LSP: All scheduling operations follow consistent patterns
 *
 * NOTE: All scheduling configuration values come from the database configuration.
 * The SchedulingConfig interface must be populated from BusinessConfigurationService.
 */

import { RepositoryError } from "@/core/error";
import { logger } from "@/utils/logger";

/**
 * Configuration for scheduled orders - populated from database config
 */
export interface SchedulingConfig {
	/** Minimum minutes in advance for scheduling */
	minAdvanceMinutes: number;
	/** Maximum days in advance for scheduling */
	maxAdvanceDays: number;
	/** Minutes before scheduled time to start matching */
	matchingLeadTimeMinutes: number;
	/** Minimum hours before scheduled time to allow rescheduling */
	minRescheduleHours: number;
}

/**
 * OrderSchedulingService
 *
 * Responsibilities:
 * - Validate scheduled order times
 * - Calculate matching activation times
 * - Check rescheduling eligibility
 * - Validate cancellation timing
 *
 * All methods require a SchedulingConfig parameter populated from the database.
 */
export class OrderSchedulingService {
	/**
	 * Validate that the scheduled time is within acceptable bounds
	 *
	 * @param scheduledAt - Requested scheduled time
	 * @param config - Scheduling configuration from database
	 * @throws {RepositoryError} When scheduled time is invalid
	 */
	static validateScheduledTime(
		scheduledAt: Date,
		config: SchedulingConfig,
	): void {
		const now = new Date();
		const minTime = new Date(
			now.getTime() + config.minAdvanceMinutes * 60 * 1000,
		);
		const maxTime = new Date(
			now.getTime() + config.maxAdvanceDays * 24 * 60 * 60 * 1000,
		);

		if (scheduledAt < minTime) {
			const error = new RepositoryError(
				`Scheduled time must be at least ${config.minAdvanceMinutes} minutes in the future`,
				{ code: "BAD_REQUEST" },
			);

			logger.warn(
				{ scheduledAt, minTime, minAdvanceMinutes: config.minAdvanceMinutes },
				"[OrderSchedulingService] Scheduled time too soon",
			);

			throw error;
		}

		if (scheduledAt > maxTime) {
			const error = new RepositoryError(
				`Scheduled time cannot be more than ${config.maxAdvanceDays} days in the future`,
				{ code: "BAD_REQUEST" },
			);

			logger.warn(
				{ scheduledAt, maxTime, maxAdvanceDays: config.maxAdvanceDays },
				"[OrderSchedulingService] Scheduled time too far in the future",
			);

			throw error;
		}

		logger.debug(
			{ scheduledAt },
			"[OrderSchedulingService] Scheduled time valid",
		);
	}

	/**
	 * Calculate when driver matching should begin for a scheduled order
	 *
	 * @param scheduledAt - The scheduled pickup time
	 * @param config - Scheduling configuration from database
	 * @returns The time when matching should start
	 */
	static calculateMatchingTime(
		scheduledAt: Date,
		config: SchedulingConfig,
	): Date {
		return new Date(
			scheduledAt.getTime() - config.matchingLeadTimeMinutes * 60 * 1000,
		);
	}

	/**
	 * Check if a scheduled order can be rescheduled
	 *
	 * @param currentScheduledAt - Current scheduled time
	 * @param config - Scheduling configuration from database
	 * @returns True if rescheduling is allowed
	 */
	static canReschedule(
		currentScheduledAt: Date,
		config: SchedulingConfig,
	): boolean {
		const now = new Date();
		const minRescheduleTime = new Date(
			currentScheduledAt.getTime() - config.minRescheduleHours * 60 * 60 * 1000,
		);

		return now < minRescheduleTime;
	}

	/**
	 * Validate rescheduling request
	 *
	 * @param currentScheduledAt - Current scheduled time
	 * @param newScheduledAt - New requested time
	 * @param config - Scheduling configuration from database
	 * @throws {RepositoryError} When rescheduling is not allowed
	 */
	static validateReschedule(
		currentScheduledAt: Date,
		newScheduledAt: Date,
		config: SchedulingConfig,
	): void {
		if (!OrderSchedulingService.canReschedule(currentScheduledAt, config)) {
			throw new RepositoryError(
				`Cannot reschedule order less than ${config.minRescheduleHours} hour(s) before scheduled time`,
				{ code: "BAD_REQUEST" },
			);
		}

		// Validate the new time
		OrderSchedulingService.validateScheduledTime(newScheduledAt, config);

		logger.info(
			{ currentScheduledAt, newScheduledAt },
			"[OrderSchedulingService] Reschedule validated",
		);
	}

	/**
	 * Check if a scheduled order is ready for matching
	 *
	 * @param scheduledAt - Scheduled pickup time
	 * @param config - Scheduling configuration from database
	 * @returns True if matching should begin
	 */
	static isReadyForMatching(
		scheduledAt: Date,
		config: SchedulingConfig,
	): boolean {
		const now = new Date();
		const matchingTime = OrderSchedulingService.calculateMatchingTime(
			scheduledAt,
			config,
		);
		return now >= matchingTime;
	}

	/**
	 * Check if a scheduled order can be cancelled without penalty
	 *
	 * @param scheduledAt - Scheduled pickup time
	 * @param config - Scheduling configuration from database
	 * @returns True if cancellation is free
	 */
	static canCancelWithoutPenalty(
		scheduledAt: Date,
		config: SchedulingConfig,
	): boolean {
		const now = new Date();
		const matchingTime = OrderSchedulingService.calculateMatchingTime(
			scheduledAt,
			config,
		);

		// Free cancellation if we haven't started matching yet
		return now < matchingTime;
	}

	/**
	 * Get time remaining until matching begins
	 *
	 * @param scheduledAt - Scheduled pickup time
	 * @param config - Scheduling configuration from database
	 * @returns Milliseconds until matching, or 0 if already past
	 */
	static getTimeUntilMatching(
		scheduledAt: Date,
		config: SchedulingConfig,
	): number {
		const now = new Date();
		const matchingTime = OrderSchedulingService.calculateMatchingTime(
			scheduledAt,
			config,
		);
		const diff = matchingTime.getTime() - now.getTime();
		return Math.max(0, diff);
	}

	/**
	 * Format time remaining for display
	 *
	 * @param scheduledAt - Scheduled pickup time
	 * @returns Human-readable time remaining string
	 */
	static formatTimeUntilScheduled(scheduledAt: Date): string {
		const now = new Date();
		const diff = scheduledAt.getTime() - now.getTime();

		if (diff <= 0) return "Now";

		const hours = Math.floor(diff / (1000 * 60 * 60));
		const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));

		if (hours > 24) {
			const days = Math.floor(hours / 24);
			return `${days} day${days > 1 ? "s" : ""}`;
		}

		if (hours > 0) {
			return `${hours}h ${minutes}m`;
		}

		return `${minutes} minutes`;
	}
}

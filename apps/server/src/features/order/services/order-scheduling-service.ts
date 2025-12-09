/**
 * OrderSchedulingService - Manages scheduled order logic
 *
 * SOLID Principles:
 * - SRP: Single responsibility for scheduled order validation and activation
 * - OCP: Open for extension with new scheduling rules
 * - LSP: All scheduling operations follow consistent patterns
 */

import { RepositoryError } from "@/core/error";
import { log } from "@/utils";

/**
 * Configuration for scheduled orders
 */
export const SCHEDULING_CONFIG = {
	/** Minimum minutes in advance for scheduling */
	MIN_ADVANCE_MINUTES: 30,
	/** Maximum days in advance for scheduling */
	MAX_ADVANCE_DAYS: 7,
	/** Minutes before scheduled time to start matching */
	MATCHING_LEAD_TIME_MINUTES: 15,
	/** Minimum hours before scheduled time to allow rescheduling */
	MIN_RESCHEDULE_HOURS: 1,
} as const;

/**
 * OrderSchedulingService
 *
 * Responsibilities:
 * - Validate scheduled order times
 * - Calculate matching activation times
 * - Check rescheduling eligibility
 * - Validate cancellation timing
 */
export class OrderSchedulingService {
	/**
	 * Validate that the scheduled time is within acceptable bounds
	 *
	 * @param scheduledAt - Requested scheduled time
	 * @throws {RepositoryError} When scheduled time is invalid
	 */
	static validateScheduledTime(scheduledAt: Date): void {
		const now = new Date();
		const minTime = new Date(
			now.getTime() + SCHEDULING_CONFIG.MIN_ADVANCE_MINUTES * 60 * 1000,
		);
		const maxTime = new Date(
			now.getTime() + SCHEDULING_CONFIG.MAX_ADVANCE_DAYS * 24 * 60 * 60 * 1000,
		);

		if (scheduledAt < minTime) {
			const error = new RepositoryError(
				`Scheduled time must be at least ${SCHEDULING_CONFIG.MIN_ADVANCE_MINUTES} minutes in the future`,
				{ code: "BAD_REQUEST" },
			);

			log.warn(
				{ scheduledAt, minTime },
				"[OrderSchedulingService] Scheduled time too soon",
			);

			throw error;
		}

		if (scheduledAt > maxTime) {
			const error = new RepositoryError(
				`Scheduled time cannot be more than ${SCHEDULING_CONFIG.MAX_ADVANCE_DAYS} days in the future`,
				{ code: "BAD_REQUEST" },
			);

			log.warn(
				{ scheduledAt, maxTime },
				"[OrderSchedulingService] Scheduled time too far in the future",
			);

			throw error;
		}

		log.debug({ scheduledAt }, "[OrderSchedulingService] Scheduled time valid");
	}

	/**
	 * Calculate when driver matching should begin for a scheduled order
	 *
	 * @param scheduledAt - The scheduled pickup time
	 * @returns The time when matching should start
	 */
	static calculateMatchingTime(scheduledAt: Date): Date {
		return new Date(
			scheduledAt.getTime() -
				SCHEDULING_CONFIG.MATCHING_LEAD_TIME_MINUTES * 60 * 1000,
		);
	}

	/**
	 * Check if a scheduled order can be rescheduled
	 *
	 * @param currentScheduledAt - Current scheduled time
	 * @returns True if rescheduling is allowed
	 */
	static canReschedule(currentScheduledAt: Date): boolean {
		const now = new Date();
		const minRescheduleTime = new Date(
			currentScheduledAt.getTime() -
				SCHEDULING_CONFIG.MIN_RESCHEDULE_HOURS * 60 * 60 * 1000,
		);

		return now < minRescheduleTime;
	}

	/**
	 * Validate rescheduling request
	 *
	 * @param currentScheduledAt - Current scheduled time
	 * @param newScheduledAt - New requested time
	 * @throws {RepositoryError} When rescheduling is not allowed
	 */
	static validateReschedule(
		currentScheduledAt: Date,
		newScheduledAt: Date,
	): void {
		if (!OrderSchedulingService.canReschedule(currentScheduledAt)) {
			throw new RepositoryError(
				`Cannot reschedule order less than ${SCHEDULING_CONFIG.MIN_RESCHEDULE_HOURS} hour(s) before scheduled time`,
				{ code: "BAD_REQUEST" },
			);
		}

		// Validate the new time
		OrderSchedulingService.validateScheduledTime(newScheduledAt);

		log.info(
			{ currentScheduledAt, newScheduledAt },
			"[OrderSchedulingService] Reschedule validated",
		);
	}

	/**
	 * Check if a scheduled order is ready for matching
	 *
	 * @param scheduledAt - Scheduled pickup time
	 * @returns True if matching should begin
	 */
	static isReadyForMatching(scheduledAt: Date): boolean {
		const now = new Date();
		const matchingTime =
			OrderSchedulingService.calculateMatchingTime(scheduledAt);
		return now >= matchingTime;
	}

	/**
	 * Check if a scheduled order can be cancelled without penalty
	 *
	 * @param scheduledAt - Scheduled pickup time
	 * @returns True if cancellation is free
	 */
	static canCancelWithoutPenalty(scheduledAt: Date): boolean {
		const now = new Date();
		const matchingTime =
			OrderSchedulingService.calculateMatchingTime(scheduledAt);

		// Free cancellation if we haven't started matching yet
		return now < matchingTime;
	}

	/**
	 * Get time remaining until matching begins
	 *
	 * @param scheduledAt - Scheduled pickup time
	 * @returns Milliseconds until matching, or 0 if already past
	 */
	static getTimeUntilMatching(scheduledAt: Date): number {
		const now = new Date();
		const matchingTime =
			OrderSchedulingService.calculateMatchingTime(scheduledAt);
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

import { logger } from "@/utils/logger";

export type ReportStatus =
	| "PENDING"
	| "INVESTIGATING"
	| "RESOLVED"
	| "DISMISSED";

/**
 * Report Status Service
 *
 * Handles report status transitions and related business logic.
 * Follows SRP by separating status logic from repository.
 */
export class ReportStatusService {
	/**
	 * Determine if status transition requires resolvedAt timestamp
	 */
	static requiresResolvedAt(newStatus: ReportStatus): boolean {
		return newStatus === "RESOLVED";
	}

	/**
	 * Calculate resolvedAt timestamp based on status change
	 * Returns current timestamp if status is RESOLVED, otherwise preserves existing value
	 */
	static calculateResolvedAt(
		newStatus: ReportStatus | undefined,
		existingResolvedAt: Date | undefined,
	): Date | null {
		// If explicitly setting to RESOLVED, set timestamp to now
		if (newStatus === "RESOLVED") {
			logger.debug(
				{ newStatus },
				"[ReportStatusService] Setting resolvedAt to current timestamp",
			);
			return new Date();
		}

		// If already resolved, preserve the timestamp
		if (existingResolvedAt) {
			return existingResolvedAt;
		}

		// Otherwise, no resolved timestamp
		return null;
	}

	/**
	 * Validate status transition
	 * Returns true if transition is valid
	 */
	static validateStatusTransition(
		currentStatus: ReportStatus,
		newStatus: ReportStatus,
	): { valid: boolean; message?: string } {
		// Allow any transition from PENDING
		if (currentStatus === "PENDING") {
			return { valid: true };
		}

		// Once RESOLVED, can only move to INVESTIGATING (reopen)
		if (currentStatus === "RESOLVED") {
			if (newStatus === "INVESTIGATING") {
				logger.info(
					{ currentStatus, newStatus },
					"[ReportStatusService] Reopening resolved report",
				);
				return { valid: true };
			}
			if (newStatus === "RESOLVED") {
				return { valid: true }; // Allow re-resolving
			}
			return {
				valid: false,
				message: "Resolved reports can only be reopened (set to INVESTIGATING)",
			};
		}

		// Once DISMISSED, cannot change status
		if (currentStatus === "DISMISSED") {
			return {
				valid: false,
				message: "Dismissed reports cannot change status",
			};
		}

		// All other transitions are valid
		return { valid: true };
	}
}

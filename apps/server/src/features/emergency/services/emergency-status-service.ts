import type { EmergencyStatus } from "@repo/schema/emergency";
import { log } from "@/utils";

export interface StatusTimestamps {
	acknowledgedAt?: Date;
	respondingAt?: Date;
	resolvedAt?: Date;
}

/**
 * Service for managing emergency status transitions and timestamps
 *
 * Follows SOLID principles:
 * - Single Responsibility: Only emergency status management
 * - Open/Closed: Extensible for new status types
 * - Dependency Inversion: No external dependencies (pure logic)
 */
export class EmergencyStatusService {
	/**
	 * Calculate timestamps based on status transition
	 */
	static calculateStatusTimestamps(
		newStatus: EmergencyStatus,
	): StatusTimestamps {
		try {
			const timestamps: StatusTimestamps = {};

			switch (newStatus) {
				case "ACKNOWLEDGED":
					timestamps.acknowledgedAt = new Date();
					break;
				case "RESPONDING":
					timestamps.respondingAt = new Date();
					break;
				case "RESOLVED":
					timestamps.resolvedAt = new Date();
					break;
				case "REPORTED":
					// No timestamp updates for REPORTED status
					break;
			}

			log.debug(
				{ newStatus, timestamps },
				"[EmergencyStatusService] Status timestamps calculated",
			);

			return timestamps;
		} catch (error) {
			log.error(
				{ error, newStatus },
				"[EmergencyStatusService] Failed to calculate timestamps",
			);
			return {};
		}
	}

	/**
	 * Validate status transition
	 */
	static validateStatusTransition(
		currentStatus: EmergencyStatus,
		newStatus: EmergencyStatus,
	): { valid: boolean; reason?: string } {
		try {
			// Define valid transitions
			const validTransitions: Record<EmergencyStatus, EmergencyStatus[]> = {
				REPORTED: ["ACKNOWLEDGED"],
				ACKNOWLEDGED: ["RESPONDING"],
				RESPONDING: ["RESOLVED"],
				RESOLVED: [], // Cannot transition from resolved
			};

			const allowedNextStatuses = validTransitions[currentStatus] ?? [];

			if (!allowedNextStatuses.includes(newStatus)) {
				return {
					valid: false,
					reason: `Cannot transition from ${currentStatus} to ${newStatus}`,
				};
			}

			return { valid: true };
		} catch (error) {
			log.error(
				{ error, currentStatus, newStatus },
				"[EmergencyStatusService] Failed to validate transition",
			);
			return {
				valid: false,
				reason: "Validation failed",
			};
		}
	}

	/**
	 * Get response time in minutes
	 */
	static calculateResponseTime(
		reportedAt: Date,
		acknowledgedAt?: Date,
	): number | undefined {
		try {
			if (!acknowledgedAt) return undefined;

			const diffMs = acknowledgedAt.getTime() - reportedAt.getTime();
			const diffMinutes = Math.floor(diffMs / (1000 * 60));

			return diffMinutes;
		} catch (error) {
			log.error(
				{ error, reportedAt, acknowledgedAt },
				"[EmergencyStatusService] Failed to calculate response time",
			);
			return undefined;
		}
	}

	/**
	 * Get resolution time in minutes
	 */
	static calculateResolutionTime(
		reportedAt: Date,
		resolvedAt?: Date,
	): number | undefined {
		try {
			if (!resolvedAt) return undefined;

			const diffMs = resolvedAt.getTime() - reportedAt.getTime();
			const diffMinutes = Math.floor(diffMs / (1000 * 60));

			return diffMinutes;
		} catch (error) {
			log.error(
				{ error, reportedAt, resolvedAt },
				"[EmergencyStatusService] Failed to calculate resolution time",
			);
			return undefined;
		}
	}

	/**
	 * Check if emergency requires escalation (based on response time)
	 */
	static requiresEscalation(
		reportedAt: Date,
		status: EmergencyStatus,
		escalationThresholdMinutes = 5,
	): boolean {
		try {
			// Only escalate if still in REPORTED status
			if (status !== "REPORTED") return false;

			const now = new Date();
			const diffMs = now.getTime() - reportedAt.getTime();
			const diffMinutes = Math.floor(diffMs / (1000 * 60));

			return diffMinutes >= escalationThresholdMinutes;
		} catch (error) {
			log.error(
				{ error, reportedAt, status },
				"[EmergencyStatusService] Failed to check escalation",
			);
			return false;
		}
	}
}

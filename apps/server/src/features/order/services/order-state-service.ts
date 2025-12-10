/**
 * OrderStateService - Manages order status transitions
 *
 * SOLID Principles:
 * - SRP: Single responsibility for order state machine logic
 * - OCP: Open for extension with new order states
 * - LSP: All state transitions follow consistent patterns
 */

import type { OrderStatus } from "@repo/schema/order";
import { ERROR_MESSAGES } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import { log } from "@/utils";

/**
 * Valid order state transitions
 * This defines the order state machine
 */
const VALID_TRANSITIONS: Record<OrderStatus, OrderStatus[]> = {
	SCHEDULED: ["MATCHING", "CANCELLED_BY_USER", "CANCELLED_BY_SYSTEM"],
	REQUESTED: ["MATCHING", "CANCELLED_BY_USER", "CANCELLED_BY_SYSTEM"],
	MATCHING: ["ACCEPTED", "CANCELLED_BY_USER", "CANCELLED_BY_SYSTEM"],
	// FIX: Added CANCELLED_BY_SYSTEM to ACCEPTED transitions
	// System may need to cancel orders after acceptance (e.g., driver becomes unavailable)
	ACCEPTED: [
		"PREPARING",
		"ARRIVING",
		"CANCELLED_BY_USER",
		"CANCELLED_BY_DRIVER",
		"CANCELLED_BY_SYSTEM",
	],
	PREPARING: ["READY_FOR_PICKUP", "CANCELLED_BY_MERCHANT", "CANCELLED_BY_USER"],
	READY_FOR_PICKUP: ["ARRIVING", "CANCELLED_BY_MERCHANT", "CANCELLED_BY_USER"],
	ARRIVING: ["IN_TRIP", "CANCELLED_BY_DRIVER", "CANCELLED_BY_USER", "NO_SHOW"],
	IN_TRIP: ["COMPLETED", "CANCELLED_BY_DRIVER", "CANCELLED_BY_SYSTEM"],
	COMPLETED: [],
	CANCELLED_BY_USER: [],
	CANCELLED_BY_DRIVER: [],
	CANCELLED_BY_MERCHANT: [],
	CANCELLED_BY_SYSTEM: [],
	NO_SHOW: [],
} as const;

/**
 * Order state descriptions for logging/UI
 */
const STATE_DESCRIPTIONS: Record<OrderStatus, string> = {
	SCHEDULED: "Order scheduled for future pickup",
	REQUESTED: "Order created, waiting for matching",
	MATCHING: "Finding available driver",
	ACCEPTED: "Driver accepted order",
	PREPARING: "Merchant is preparing order",
	READY_FOR_PICKUP: "Order ready for driver pickup",
	ARRIVING: "Driver is arriving at pickup location",
	IN_TRIP: "Order in transit to destination",
	COMPLETED: "Order completed successfully",
	CANCELLED_BY_USER: "Order cancelled by user",
	CANCELLED_BY_DRIVER: "Order cancelled by driver",
	CANCELLED_BY_MERCHANT: "Order cancelled by merchant",
	CANCELLED_BY_SYSTEM: "Order cancelled by system",
	NO_SHOW: "Customer did not show up",
};

/**
 * OrderStateService
 *
 * Responsibilities:
 * - Validate state transitions
 * - Track state history
 * - Provide state-specific business rules
 */
export class OrderStateService {
	/**
	 * Validate if a state transition is allowed
	 *
	 * @param currentStatus - Current order status
	 * @param newStatus - Desired new status
	 * @throws {RepositoryError} When transition is invalid
	 */
	validateTransition(currentStatus: OrderStatus, newStatus: OrderStatus): void {
		const allowedTransitions = VALID_TRANSITIONS[currentStatus];

		if (!allowedTransitions.includes(newStatus)) {
			const error = new RepositoryError(
				`${ERROR_MESSAGES.INVALID_ORDER_STATUS}: Cannot transition from ${currentStatus} to ${newStatus}`,
				{ code: "BAD_REQUEST" },
			);

			log.error(
				{ currentStatus, newStatus, allowedTransitions },
				"[OrderStateService] Invalid transition",
			);

			throw error;
		}

		log.debug(
			{ currentStatus, newStatus },
			"[OrderStateService] Valid transition",
		);
	}

	/**
	 * Check if order can be cancelled
	 *
	 * @param currentStatus - Current order status
	 * @returns True if order can be cancelled
	 */
	canBeCancelled(currentStatus: OrderStatus): boolean {
		// Orders cannot be cancelled after completion or if already cancelled
		return ![
			"COMPLETED",
			"CANCELLED_BY_USER",
			"CANCELLED_BY_DRIVER",
			"CANCELLED_BY_MERCHANT",
			"CANCELLED_BY_SYSTEM",
		].includes(currentStatus);
	}

	/**
	 * Check if order requires driver assignment
	 *
	 * @param currentStatus - Current order status
	 * @returns True if driver must be assigned
	 */
	requiresDriver(currentStatus: OrderStatus): boolean {
		return [
			"ACCEPTED",
			"PREPARING",
			"READY_FOR_PICKUP",
			"ARRIVING",
			"IN_TRIP",
		].includes(currentStatus);
	}

	/**
	 * Check if order is in progress
	 *
	 * @param currentStatus - Current order status
	 * @returns True if order is actively being fulfilled
	 */
	isInProgress(currentStatus: OrderStatus): boolean {
		return [
			"MATCHING",
			"ACCEPTED",
			"PREPARING",
			"READY_FOR_PICKUP",
			"ARRIVING",
			"IN_TRIP",
		].includes(currentStatus);
	}

	/**
	 * Check if order is a scheduled order waiting to be activated
	 *
	 * @param currentStatus - Current order status
	 * @returns True if order is scheduled
	 */
	isScheduled(currentStatus: OrderStatus): boolean {
		return currentStatus === "SCHEDULED";
	}

	/**
	 * Get all allowed next states
	 *
	 * @param currentStatus - Current order status
	 * @returns Array of allowed next states
	 */
	getAllowedTransitions(currentStatus: OrderStatus): OrderStatus[] {
		return VALID_TRANSITIONS[currentStatus];
	}

	/**
	 * Get state description
	 *
	 * @param status - Order status
	 * @returns Human-readable description
	 */
	getStateDescription(status: OrderStatus): string {
		return STATE_DESCRIPTIONS[status];
	}

	/**
	 * Calculate completion percentage for UI
	 *
	 * @param currentStatus - Current order status
	 * @returns Completion percentage (0-100)
	 */
	getCompletionPercentage(currentStatus: OrderStatus): number {
		const stateOrder: OrderStatus[] = [
			"SCHEDULED",
			"REQUESTED",
			"MATCHING",
			"ACCEPTED",
			"PREPARING",
			"READY_FOR_PICKUP",
			"ARRIVING",
			"IN_TRIP",
			"COMPLETED",
		];

		const index = stateOrder.indexOf(currentStatus);
		if (index === -1) return 0; // CANCELLED or unknown

		return Math.round((index / (stateOrder.length - 1)) * 100);
	}

	/**
	 * Get timeline events for order tracking UI
	 *
	 * @param currentStatus - Current order status
	 * @param isScheduledOrder - Whether order is a scheduled order
	 * @returns Array of timeline events with completion status
	 */
	getTimelineEvents(
		currentStatus: OrderStatus,
		isScheduledOrder = false,
	): Array<{
		status: OrderStatus;
		description: string;
		completed: boolean;
	}> {
		const timeline: OrderStatus[] = isScheduledOrder
			? [
					"SCHEDULED",
					"MATCHING",
					"ACCEPTED",
					"PREPARING",
					"READY_FOR_PICKUP",
					"ARRIVING",
					"IN_TRIP",
					"COMPLETED",
				]
			: [
					"REQUESTED",
					"MATCHING",
					"ACCEPTED",
					"PREPARING",
					"READY_FOR_PICKUP",
					"ARRIVING",
					"IN_TRIP",
					"COMPLETED",
				];

		const currentIndex = timeline.indexOf(currentStatus);

		return timeline.map((status, index) => ({
			status,
			description: STATE_DESCRIPTIONS[status],
			completed: index <= currentIndex,
		}));
	}
}

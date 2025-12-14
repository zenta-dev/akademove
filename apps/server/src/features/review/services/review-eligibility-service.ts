/**
 * ReviewEligibilityService
 *
 * SOLID Principles Applied:
 * - SRP: Handles only review eligibility validation logic
 * - OCP: Open for extension with new eligibility rules
 * - DIP: Depends on abstractions (callbacks for data fetching)
 */

import type { OrderStatus } from "@repo/schema/order";
import type { DatabaseService } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Order review status result
 */
export interface OrderReviewStatus {
	canReview: boolean;
	alreadyReviewed: boolean;
	orderCompleted: boolean;
}

/**
 * Order data required for eligibility check
 */
interface OrderData {
	id: string;
	status: OrderStatus;
	userId: string;
	driverId: string | null;
	completedDriverId: string | null;
}

/**
 * ReviewEligibilityService
 *
 * Static service for determining review eligibility:
 * - Check if user can review an order
 * - Validate order completion status
 * - Verify user participation in order
 * - Check if review already exists
 *
 * Note: Uses completedDriverId for driver lookup after order completion,
 * as driverId may be cleared after the trip ends.
 */
export class ReviewEligibilityService {
	/**
	 * Check if user already reviewed an order
	 * Queries the database for existing review from user
	 *
	 * @param db - Database service instance
	 * @param orderId - Order ID to check
	 * @param userId - User ID to check
	 * @returns True if user already reviewed this order
	 */
	static async hasUserReviewedOrder(
		db: DatabaseService,
		orderId: string,
		userId: string,
	): Promise<boolean> {
		try {
			const result = await db.query.review.findFirst({
				where: (f, op) =>
					op.and(op.eq(f.orderId, orderId), op.eq(f.fromUserId, userId)),
			});

			return !!result;
		} catch (error) {
			logger.error(
				{ orderId, userId, error },
				"[ReviewEligibilityService] Failed to check if user reviewed order",
			);
			return false;
		}
	}

	/**
	 * Check if order status allows reviews
	 * Only COMPLETED orders can be reviewed
	 *
	 * @param status - Order status to check
	 * @returns True if order can be reviewed
	 */
	static isOrderReviewable(status: OrderStatus): boolean {
		return status === "COMPLETED";
	}

	/**
	 * Check if user is participant in the order
	 * User must be either the customer (userId) or the driver (via driver.userId lookup)
	 *
	 * Note: For driver comparison, we need to look up the driver record to get userId
	 * This method checks driverId directly; for full validation use isUserOrderParticipantAsync
	 *
	 * @param order - Order data
	 * @param userId - User ID to check
	 * @param driverUserId - Optional driver's userId (from driver table lookup)
	 * @returns True if user is part of the order
	 */
	static isUserOrderParticipant(
		order: OrderData,
		userId: string,
		driverUserId?: string | null,
	): boolean {
		// Check if user is the customer
		if (order.userId === userId) {
			return true;
		}

		// Check if user is the driver (via driverUserId lookup)
		if (driverUserId && driverUserId === userId) {
			return true;
		}

		return false;
	}

	/**
	 * Determine if user can review an order
	 * Combines all eligibility rules:
	 * 1. Order must be completed
	 * 2. User must be participant (customer or driver)
	 * 3. User must not have already reviewed
	 *
	 * @param order - Order data
	 * @param userId - User ID attempting to review
	 * @param alreadyReviewed - Whether user already reviewed
	 * @param driverUserId - Driver's user ID (from driver table lookup)
	 * @returns True if user can submit review
	 */
	static canUserReviewOrder(
		order: OrderData,
		userId: string,
		alreadyReviewed: boolean,
		driverUserId?: string | null,
	): boolean {
		const orderCompleted = ReviewEligibilityService.isOrderReviewable(
			order.status,
		);
		const isParticipant = ReviewEligibilityService.isUserOrderParticipant(
			order,
			userId,
			driverUserId,
		);

		return orderCompleted && isParticipant && !alreadyReviewed;
	}

	/**
	 * Get comprehensive review status for an order
	 * Fetches order data and review history to determine eligibility
	 *
	 * @param db - Database service instance
	 * @param orderId - Order ID to check
	 * @param userId - User ID attempting to review
	 * @returns Review status with eligibility flags
	 */
	static async getOrderReviewStatus(
		db: DatabaseService,
		orderId: string,
		userId: string,
	): Promise<OrderReviewStatus> {
		try {
			// Fetch order data
			const order = await db.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!order) {
				return {
					canReview: false,
					alreadyReviewed: false,
					orderCompleted: false,
				};
			}

			const orderCompleted = ReviewEligibilityService.isOrderReviewable(
				order.status,
			);

			// Get driver's userId for comparison
			// Use completedDriverId first (set when order is completed), fallback to driverId
			const effectiveDriverId = order.completedDriverId ?? order.driverId;
			let driverUserId: string | null = null;

			if (effectiveDriverId) {
				const driver = await db.query.driver.findFirst({
					where: (f, op) => op.eq(f.id, effectiveDriverId),
				});
				driverUserId = driver?.userId ?? null;
			}

			const isParticipant = ReviewEligibilityService.isUserOrderParticipant(
				order,
				userId,
				driverUserId,
			);

			// Check if already reviewed
			const alreadyReviewed =
				await ReviewEligibilityService.hasUserReviewedOrder(
					db,
					orderId,
					userId,
				);

			const canReview = orderCompleted && isParticipant && !alreadyReviewed;

			return {
				canReview,
				alreadyReviewed,
				orderCompleted,
			};
		} catch (error) {
			logger.error(
				{ orderId, userId, error },
				"[ReviewEligibilityService] Failed to get order review status",
			);
			return {
				canReview: false,
				alreadyReviewed: false,
				orderCompleted: false,
			};
		}
	}

	/**
	 * Validate review eligibility and throw error if not allowed
	 * Used by handlers to enforce review rules
	 *
	 * @param status - Order review status
	 * @param orderId - Order ID (for error message)
	 * @throws Error if review not allowed
	 */
	static validateCanReview(status: OrderReviewStatus, orderId: string): void {
		if (status.alreadyReviewed) {
			throw new Error(`You have already reviewed order ${orderId}`);
		}

		if (!status.orderCompleted) {
			throw new Error(`Order ${orderId} is not completed yet`);
		}

		if (!status.canReview) {
			throw new Error(`You are not allowed to review order ${orderId}`);
		}
	}
}

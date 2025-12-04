import type { OrderStatus } from "@repo/schema/order";
import type { UserRole } from "@repo/schema/user";
import Decimal from "decimal.js";

/**
 * Service responsible for order cancellation business logic
 *
 * Handles:
 * - Determining cancellation status based on user role
 * - Calculating cancellation penalties
 * - Refund amount calculation
 */
export class OrderCancellationService {
	/**
	 * Determine cancellation status based on user role
	 *
	 * @param userRole - Role of user cancelling the order
	 * @returns Appropriate cancellation status
	 */
	static determineCancellationStatus(userRole: UserRole): OrderStatus {
		switch (userRole) {
			case "USER":
				return "CANCELLED_BY_USER";
			case "DRIVER":
				return "CANCELLED_BY_DRIVER";
			case "MERCHANT":
				return "CANCELLED_BY_MERCHANT";
			default:
				return "CANCELLED_BY_SYSTEM";
		}
	}

	/**
	 * Calculate refund amount with penalty logic
	 *
	 * Per SRS 8.3:
	 * - User cancels before driver acceptance: Full refund
	 * - User cancels after driver acceptance: 10% penalty
	 * - Driver/Merchant/System cancels: Full refund
	 *
	 * @param totalPrice - Original order total price
	 * @param cancelStatus - Type of cancellation
	 * @param orderStatus - Current order status
	 * @param driverId - Driver ID (if assigned)
	 * @returns Object with refundAmount and penaltyAmount
	 */
	static calculateRefund(
		totalPrice: number,
		cancelStatus: OrderStatus,
		orderStatus: OrderStatus,
		driverId?: string | null,
	): {
		refundAmount: Decimal;
		penaltyAmount: Decimal;
	} {
		const total = new Decimal(totalPrice);
		let refundAmount = total;
		let penaltyAmount = new Decimal(0);

		// Apply 10% penalty for user cancellation after driver acceptance
		if (
			cancelStatus === "CANCELLED_BY_USER" &&
			driverId &&
			["ACCEPTED", "PREPARING", "READY_FOR_PICKUP", "ARRIVING"].includes(
				orderStatus,
			)
		) {
			penaltyAmount = total.times(0.1); // 10% penalty
			refundAmount = total.minus(penaltyAmount);
		}

		return { refundAmount, penaltyAmount };
	}

	/**
	 * Check if cancellation penalty applies
	 *
	 * @param cancelStatus - Type of cancellation
	 * @param orderStatus - Current order status
	 * @param driverId - Driver ID (if assigned)
	 * @returns True if penalty should be applied
	 */
	static shouldApplyPenalty(
		cancelStatus: OrderStatus,
		orderStatus: OrderStatus,
		driverId?: string | null,
	): boolean {
		return (
			cancelStatus === "CANCELLED_BY_USER" &&
			!!driverId &&
			["ACCEPTED", "PREPARING", "READY_FOR_PICKUP", "ARRIVING"].includes(
				orderStatus,
			)
		);
	}
}

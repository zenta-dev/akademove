import type { BusinessConfiguration } from "@repo/schema/configuration";
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
 * - No-show penalty calculation
 *
 * NOTE: All pricing-related values (cancellation fees, no-show fees) MUST come
 * from the database via BusinessConfiguration. Static constants are forbidden.
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
	 * - User cancels after driver acceptance: Penalty based on config
	 * - Driver/Merchant/System cancels: Full refund
	 *
	 * @param totalPrice - Original order total price
	 * @param cancelStatus - Type of cancellation
	 * @param orderStatus - Current order status
	 * @param businessConfig - Business configuration from database
	 * @param driverId - Driver ID (if assigned)
	 * @returns Object with refundAmount and penaltyAmount
	 */
	static calculateRefund(
		totalPrice: number,
		cancelStatus: OrderStatus,
		orderStatus: OrderStatus,
		businessConfig: BusinessConfiguration,
		driverId?: string | null,
	): {
		refundAmount: Decimal;
		penaltyAmount: Decimal;
	} {
		const total = new Decimal(totalPrice);
		let refundAmount = total;
		let penaltyAmount = new Decimal(0);

		// Apply penalty for user cancellation after driver acceptance (rate from config)
		if (
			cancelStatus === "CANCELLED_BY_USER" &&
			driverId &&
			["ACCEPTED", "PREPARING", "READY_FOR_PICKUP", "ARRIVING"].includes(
				orderStatus,
			)
		) {
			penaltyAmount = total.times(
				businessConfig.userCancellationFeeAfterAccept,
			);
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

	/**
	 * Calculate no-show refund and fee
	 *
	 * Per SRS 8.3: When driver arrives but user is not present (no-show),
	 * the user is charged a percentage of the order total as a penalty.
	 * The driver receives compensation for their time and effort.
	 *
	 * @param totalPrice - Original order total price
	 * @param businessConfig - Business configuration from database
	 * @returns Object with refundAmount, penaltyAmount, and driverCompensation
	 */
	static calculateNoShowRefund(
		totalPrice: number,
		businessConfig: BusinessConfiguration,
	): {
		refundAmount: Decimal;
		penaltyAmount: Decimal;
		driverCompensation: Decimal;
	} {
		const total = new Decimal(totalPrice);
		const penaltyAmount = total.times(businessConfig.noShowFee);
		const refundAmount = total.minus(penaltyAmount);
		// Driver receives configured percentage of the penalty as compensation
		// Platform keeps the rest as commission
		const driverCompensation = penaltyAmount.times(
			businessConfig.noShowDriverCompensationRate,
		);

		return { refundAmount, penaltyAmount, driverCompensation };
	}

	/**
	 * Check if order status allows no-show reporting
	 *
	 * No-show can only be reported when driver has arrived at pickup location
	 *
	 * @param orderStatus - Current order status
	 * @returns True if no-show can be reported
	 */
	static canReportNoShow(orderStatus: OrderStatus): boolean {
		return orderStatus === "ARRIVING";
	}
}

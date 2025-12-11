import { describe, expect, it } from "bun:test";
import type { BusinessConfiguration } from "@repo/schema/configuration";
import { OrderCancellationService } from "../src/features/order/services/order-cancellation-service";

// Mock business configuration
const mockBusinessConfig: BusinessConfiguration = {
	// Wallet limits
	minTransferAmount: 10000,
	minWithdrawalAmount: 50000,
	minTopUpAmount: 10000,
	quickTopUpAmounts: [50000, 100000, 200000, 500000],

	// Cancellation fees
	userCancellationFeeBeforeAccept: 0, // 0% penalty before driver accepts
	userCancellationFeeAfterAccept: 0.1, // 10% penalty after driver accepts
	noShowFee: 0.25, // 25% no-show fee
	noShowDriverCompensationRate: 0.6, // Driver gets 60% of penalty

	// Delivery verification
	highValueOrderThreshold: 500000,

	// Order matching config
	driverMatchingTimeoutMinutes: 15,
	driverMatchingInitialRadiusKm: 5,
	driverMatchingMaxRadiusKm: 20,
	driverMatchingRadiusExpansionRate: 0.2,
	driverMatchingIntervalSeconds: 30,
	driverMatchingBroadcastLimit: 10,
	driverMaxCancellationsPerDay: 3,

	// Payment timeout
	paymentPendingTimeoutMinutes: 15,
};

describe("OrderCancellationService", () => {
	describe("determineCancellationStatus", () => {
		it("should return CANCELLED_BY_USER for USER role", () => {
			expect(OrderCancellationService.determineCancellationStatus("USER")).toBe(
				"CANCELLED_BY_USER",
			);
		});

		it("should return CANCELLED_BY_DRIVER for DRIVER role", () => {
			expect(
				OrderCancellationService.determineCancellationStatus("DRIVER"),
			).toBe("CANCELLED_BY_DRIVER");
		});

		it("should return CANCELLED_BY_MERCHANT for MERCHANT role", () => {
			expect(
				OrderCancellationService.determineCancellationStatus("MERCHANT"),
			).toBe("CANCELLED_BY_MERCHANT");
		});

		it("should return CANCELLED_BY_SYSTEM for ADMIN role", () => {
			expect(
				OrderCancellationService.determineCancellationStatus("ADMIN"),
			).toBe("CANCELLED_BY_SYSTEM");
		});

		it("should return CANCELLED_BY_SYSTEM for OPERATOR role", () => {
			expect(
				OrderCancellationService.determineCancellationStatus("OPERATOR"),
			).toBe("CANCELLED_BY_SYSTEM");
		});
	});

	describe("calculateRefund", () => {
		it("should give full refund when user cancels before driver acceptance", () => {
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_USER",
				"MATCHING",
				mockBusinessConfig,
				null, // no driver assigned
			);

			expect(result.refundAmount.toNumber()).toBe(50000);
			expect(result.penaltyAmount.toNumber()).toBe(0);
		});

		it("should apply penalty when user cancels after driver acceptance", () => {
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_USER",
				"ACCEPTED",
				mockBusinessConfig,
				"driver-123", // driver assigned
			);

			// 10% penalty = 5000, refund = 45000
			expect(result.penaltyAmount.toNumber()).toBe(5000);
			expect(result.refundAmount.toNumber()).toBe(45000);
		});

		it("should apply penalty when user cancels during ARRIVING status", () => {
			const result = OrderCancellationService.calculateRefund(
				100000,
				"CANCELLED_BY_USER",
				"ARRIVING",
				mockBusinessConfig,
				"driver-123",
			);

			// 10% penalty = 10000, refund = 90000
			expect(result.penaltyAmount.toNumber()).toBe(10000);
			expect(result.refundAmount.toNumber()).toBe(90000);
		});

		it("should give full refund when driver cancels", () => {
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_DRIVER",
				"ACCEPTED",
				mockBusinessConfig,
				"driver-123",
			);

			expect(result.refundAmount.toNumber()).toBe(50000);
			expect(result.penaltyAmount.toNumber()).toBe(0);
		});

		it("should give full refund when merchant cancels", () => {
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_MERCHANT",
				"PREPARING",
				mockBusinessConfig,
				"driver-123",
			);

			expect(result.refundAmount.toNumber()).toBe(50000);
			expect(result.penaltyAmount.toNumber()).toBe(0);
		});

		it("should give full refund when system cancels", () => {
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_SYSTEM",
				"MATCHING",
				mockBusinessConfig,
				null,
			);

			expect(result.refundAmount.toNumber()).toBe(50000);
			expect(result.penaltyAmount.toNumber()).toBe(0);
		});

		it("should not apply penalty when user cancels in IN_TRIP status", () => {
			// IN_TRIP is not in the penalty statuses list
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_USER",
				"IN_TRIP",
				mockBusinessConfig,
				"driver-123",
			);

			expect(result.refundAmount.toNumber()).toBe(50000);
			expect(result.penaltyAmount.toNumber()).toBe(0);
		});
	});

	describe("shouldApplyPenalty", () => {
		it("should return true for user cancel after acceptance with driver", () => {
			expect(
				OrderCancellationService.shouldApplyPenalty(
					"CANCELLED_BY_USER",
					"ACCEPTED",
					"driver-123",
				),
			).toBe(true);
		});

		it("should return false for user cancel before driver assignment", () => {
			expect(
				OrderCancellationService.shouldApplyPenalty(
					"CANCELLED_BY_USER",
					"MATCHING",
					null,
				),
			).toBe(false);
		});

		it("should return false for driver cancel", () => {
			expect(
				OrderCancellationService.shouldApplyPenalty(
					"CANCELLED_BY_DRIVER",
					"ACCEPTED",
					"driver-123",
				),
			).toBe(false);
		});

		it("should return false for system cancel", () => {
			expect(
				OrderCancellationService.shouldApplyPenalty(
					"CANCELLED_BY_SYSTEM",
					"ACCEPTED",
					"driver-123",
				),
			).toBe(false);
		});
	});

	describe("calculateNoShowRefund", () => {
		it("should calculate correct refund and penalty for no-show", () => {
			const result = OrderCancellationService.calculateNoShowRefund(
				100000,
				mockBusinessConfig,
			);

			// 25% penalty = 25000, refund = 75000
			// Driver gets 60% of penalty = 15000
			expect(result.penaltyAmount.toNumber()).toBe(25000);
			expect(result.refundAmount.toNumber()).toBe(75000);
			expect(result.driverCompensation.toNumber()).toBe(15000);
		});

		it("should handle small order amounts", () => {
			const result = OrderCancellationService.calculateNoShowRefund(
				10000,
				mockBusinessConfig,
			);

			// 25% penalty = 2500, refund = 7500
			// Driver gets 60% of penalty = 1500
			expect(result.penaltyAmount.toNumber()).toBe(2500);
			expect(result.refundAmount.toNumber()).toBe(7500);
			expect(result.driverCompensation.toNumber()).toBe(1500);
		});
	});

	describe("canReportNoShow", () => {
		it("should return true for ARRIVING status", () => {
			expect(OrderCancellationService.canReportNoShow("ARRIVING")).toBe(true);
		});

		it("should return false for ACCEPTED status", () => {
			expect(OrderCancellationService.canReportNoShow("ACCEPTED")).toBe(false);
		});

		it("should return false for IN_TRIP status", () => {
			expect(OrderCancellationService.canReportNoShow("IN_TRIP")).toBe(false);
		});

		it("should return false for MATCHING status", () => {
			expect(OrderCancellationService.canReportNoShow("MATCHING")).toBe(false);
		});
	});
});

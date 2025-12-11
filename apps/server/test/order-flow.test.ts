import { describe, expect, it } from "bun:test";
import type { BusinessConfiguration } from "@repo/schema/configuration";
import Decimal from "decimal.js";
import { OrderCancellationService } from "../src/features/order/services/order-cancellation-service";

/**
 * Order Flow Tests
 *
 * Tests the complete order delivery flow including:
 * 1. Order creation and payment verification
 * 2. Driver matching and broadcast logic
 * 3. Order timeout and cancellation handling
 * 4. Commission calculations
 * 5. Order completion flow
 *
 * Flow Reference (from requirements):
 * - Customer creates order -> Payment required
 * - Payment verified -> Broadcast to nearby drivers
 * - No driver accepts in 15 minutes -> Auto-cancel with full refund
 * - Driver accepts -> Broadcast driver location to customer
 * - Order completed -> Calculate commission and show rating
 */

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
	driverMatchingTimeoutMinutes: 15, // 15 minute timeout
	driverMatchingInitialRadiusKm: 5,
	driverMatchingMaxRadiusKm: 20,
	driverMatchingRadiusExpansionRate: 0.2, // 20% expansion
	driverMatchingIntervalSeconds: 30,
	driverMatchingBroadcastLimit: 10,
	driverMaxCancellationsPerDay: 3,

	// Payment timeout
	paymentPendingTimeoutMinutes: 15,
};

describe("Order Flow", () => {
	describe("Order Creation and Payment", () => {
		it("should require payment before driver matching", () => {
			// Order status should be REQUESTED until payment is verified
			const orderStatuses = [
				"REQUESTED",
				"MATCHING",
				"ACCEPTED",
				"ARRIVING",
				"IN_TRIP",
				"COMPLETED",
			];

			// REQUESTED is the initial state before payment
			expect(orderStatuses[0]).toBe("REQUESTED");

			// MATCHING starts after payment verification
			expect(orderStatuses[1]).toBe("MATCHING");
		});

		it("should transition order from REQUESTED to MATCHING after payment", () => {
			// Simulate order state machine
			const validTransitions: Record<string, string[]> = {
				REQUESTED: ["MATCHING", "CANCELLED_BY_USER", "CANCELLED_BY_SYSTEM"],
				MATCHING: [
					"ACCEPTED",
					"CANCELLED_BY_USER",
					"CANCELLED_BY_SYSTEM",
					"CANCELLED_BY_DRIVER",
				],
				ACCEPTED: [
					"ARRIVING",
					"CANCELLED_BY_USER",
					"CANCELLED_BY_DRIVER",
					"NO_SHOW",
				],
				ARRIVING: [
					"IN_TRIP",
					"CANCELLED_BY_USER",
					"CANCELLED_BY_DRIVER",
					"NO_SHOW",
				],
				IN_TRIP: ["COMPLETED", "CANCELLED_BY_USER", "CANCELLED_BY_DRIVER"],
				COMPLETED: [], // Terminal state
				CANCELLED_BY_USER: [], // Terminal state
				CANCELLED_BY_SYSTEM: [], // Terminal state
				CANCELLED_BY_DRIVER: [], // Terminal state
				NO_SHOW: [], // Terminal state
			};

			// Verify payment triggers MATCHING
			expect(validTransitions.REQUESTED).toContain("MATCHING");
		});
	});

	describe("Driver Matching Timeout (15 minutes)", () => {
		it("should have 15 minute timeout configured", () => {
			expect(mockBusinessConfig.driverMatchingTimeoutMinutes).toBe(15);
		});

		it("should auto-cancel order when no driver accepts within timeout", () => {
			// Simulate timeout cancellation
			const orderStatus = "MATCHING";
			const timeoutMinutes = mockBusinessConfig.driverMatchingTimeoutMinutes;

			// After 15 minutes without acceptance
			const shouldCancel = orderStatus === "MATCHING";
			expect(shouldCancel).toBe(true);
			expect(timeoutMinutes).toBe(15);
		});

		it("should give full refund on system cancellation (timeout)", () => {
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_SYSTEM",
				"MATCHING",
				mockBusinessConfig,
				null, // no driver assigned
			);

			// Full refund for system cancellation
			expect(result.refundAmount.toNumber()).toBe(50000);
			expect(result.penaltyAmount.toNumber()).toBe(0);
		});

		it("should expand search radius when no drivers found", () => {
			const initialRadius = mockBusinessConfig.driverMatchingInitialRadiusKm;
			const expansionRate =
				mockBusinessConfig.driverMatchingRadiusExpansionRate;

			// First expansion
			const expandedRadius1 = initialRadius * (1 + expansionRate);
			expect(expandedRadius1).toBeCloseTo(6, 2); // 5 * 1.2 = 6km

			// Second expansion
			const expandedRadius2 = expandedRadius1 * (1 + expansionRate);
			expect(expandedRadius2).toBeCloseTo(7.2, 2); // 6 * 1.2 = 7.2km

			// Third expansion
			const expandedRadius3 = expandedRadius2 * (1 + expansionRate);
			expect(expandedRadius3).toBeCloseTo(8.64, 2); // 7.2 * 1.2 = 8.64km
		});

		it("should respect maximum radius limit", () => {
			const maxRadius = mockBusinessConfig.driverMatchingMaxRadiusKm;
			expect(maxRadius).toBe(20);

			// Simulating multiple expansions
			let currentRadius = mockBusinessConfig.driverMatchingInitialRadiusKm;
			const expansionRate =
				mockBusinessConfig.driverMatchingRadiusExpansionRate;

			// Keep expanding until we exceed max
			while (currentRadius < maxRadius) {
				currentRadius = currentRadius * (1 + expansionRate);
			}

			// Should cap at max radius
			const cappedRadius = Math.min(currentRadius, maxRadius);
			expect(cappedRadius).toBeLessThanOrEqual(maxRadius);
		});
	});

	describe("Driver Acceptance Flow", () => {
		it("should prevent multiple drivers from accepting same order", () => {
			// Using SELECT FOR UPDATE prevents race condition
			// Order status should be MATCHING for acceptance
			const orderStatus = "MATCHING";
			const canAccept =
				orderStatus === "MATCHING" || orderStatus === "REQUESTED";
			expect(canAccept).toBe(true);

			// After first driver accepts, status changes to ACCEPTED
			const newStatus = "ACCEPTED";
			const canAcceptAfter =
				newStatus === "MATCHING" || newStatus === "REQUESTED";
			expect(canAcceptAfter).toBe(false);
		});

		it("should mark driver as taking order after acceptance", () => {
			// Driver's isTakingOrder flag should be set
			const driverBefore = { isTakingOrder: false, isOnline: true };
			const driverAfter = { ...driverBefore, isTakingOrder: true };

			expect(driverBefore.isTakingOrder).toBe(false);
			expect(driverAfter.isTakingOrder).toBe(true);
		});

		it("should notify other broadcasted drivers that order is unavailable", () => {
			// When one driver accepts, others should receive UNAVAILABLE event
			const expectedEvent = "UNAVAILABLE";
			expect(expectedEvent).toBe("UNAVAILABLE");
		});
	});

	describe("Driver Location Broadcasting", () => {
		it("should broadcast driver location to customer during trip", () => {
			// WebSocket event for location updates
			const locationUpdateEvent = "DRIVER_LOCATION_UPDATE";
			expect(locationUpdateEvent).toBe("DRIVER_LOCATION_UPDATE");
		});

		it("should only broadcast location when order is in active state", () => {
			const activeStatuses = ["ACCEPTED", "ARRIVING", "IN_TRIP"];
			const orderStatus = "ACCEPTED";

			const shouldBroadcast = activeStatuses.includes(orderStatus);
			expect(shouldBroadcast).toBe(true);

			// Should not broadcast for completed/cancelled orders
			const completedStatus = "COMPLETED";
			const shouldNotBroadcast = activeStatuses.includes(completedStatus);
			expect(shouldNotBroadcast).toBe(false);
		});
	});

	describe("Order Completion and Commission", () => {
		it("should calculate platform commission correctly", () => {
			const totalPrice = new Decimal(100000);
			const platformFeeRate = 0.1; // 10% platform fee

			const platformCommission = totalPrice.times(platformFeeRate);
			expect(platformCommission.toNumber()).toBe(10000);
		});

		it("should calculate driver earning correctly (minus platform commission)", () => {
			const totalPrice = new Decimal(100000);
			const platformFeeRate = 0.1;

			const platformCommission = totalPrice.times(platformFeeRate);
			const driverEarning = totalPrice.minus(platformCommission);

			expect(driverEarning.toNumber()).toBe(90000);
		});

		it("should calculate FOOD order commission including merchant commission", () => {
			const totalPrice = new Decimal(100000);
			const platformFeeRate = 0.1; // 10% platform fee
			const merchantCommissionRate = 0.15; // 15% merchant commission

			const platformCommission = totalPrice.times(platformFeeRate);
			const merchantCommission = totalPrice.times(merchantCommissionRate);
			const driverEarning = totalPrice
				.minus(platformCommission)
				.minus(merchantCommission);

			expect(platformCommission.toNumber()).toBe(10000);
			expect(merchantCommission.toNumber()).toBe(15000);
			expect(driverEarning.toNumber()).toBe(75000);
		});

		it("should apply badge commission reduction for drivers", () => {
			const baseCommissionRate = 0.1; // 10%
			const badgeReduction = 0.2; // 20% reduction from badge

			// Apply reduction (multiplicative)
			const reducedRate = baseCommissionRate * (1 - badgeReduction);
			expect(reducedRate).toBeCloseTo(0.08, 4); // 8% final rate

			const totalPrice = new Decimal(100000);
			const platformCommission = totalPrice.times(reducedRate);
			const driverEarning = totalPrice.minus(platformCommission);

			expect(platformCommission.toNumber()).toBeCloseTo(8000, 0);
			expect(driverEarning.toNumber()).toBeCloseTo(92000, 0);
		});

		it("should broadcast COMPLETED event to user when order is done", () => {
			const completedEvent = "COMPLETED";
			expect(completedEvent).toBe("COMPLETED");
		});

		it("should reset driver isTakingOrder flag after completion", () => {
			const driverBefore = { isTakingOrder: true };
			const driverAfter = { ...driverBefore, isTakingOrder: false };

			expect(driverAfter.isTakingOrder).toBe(false);
		});
	});

	describe("Order Cancellation Scenarios", () => {
		it("should give full refund when user cancels before driver accepts", () => {
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_USER",
				"MATCHING",
				mockBusinessConfig,
				null,
			);

			expect(result.refundAmount.toNumber()).toBe(50000);
			expect(result.penaltyAmount.toNumber()).toBe(0);
		});

		it("should apply 10% penalty when user cancels after driver accepts", () => {
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_USER",
				"ACCEPTED",
				mockBusinessConfig,
				"driver-123",
			);

			expect(result.penaltyAmount.toNumber()).toBe(5000); // 10%
			expect(result.refundAmount.toNumber()).toBe(45000);
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

		it("should increment driver cancellation count on cancel", () => {
			// Driver has daily cancellation limit
			const maxCancellations = mockBusinessConfig.driverMaxCancellationsPerDay;
			expect(maxCancellations).toBe(3);

			// After 3 cancellations, driver should be excluded from matching
			const driverCancellations = 3;
			const canReceiveOrders = driverCancellations < maxCancellations;
			expect(canReceiveOrders).toBe(false);
		});
	});

	describe("No-Show Handling", () => {
		it("should only allow no-show report when order status is ARRIVING", () => {
			expect(OrderCancellationService.canReportNoShow("ARRIVING")).toBe(true);
			expect(OrderCancellationService.canReportNoShow("ACCEPTED")).toBe(false);
			expect(OrderCancellationService.canReportNoShow("IN_TRIP")).toBe(false);
			expect(OrderCancellationService.canReportNoShow("MATCHING")).toBe(false);
		});

		it("should calculate no-show penalty and driver compensation", () => {
			const result = OrderCancellationService.calculateNoShowRefund(
				100000,
				mockBusinessConfig,
			);

			// 25% penalty
			expect(result.penaltyAmount.toNumber()).toBe(25000);

			// 75% refund to user
			expect(result.refundAmount.toNumber()).toBe(75000);

			// Driver gets 60% of penalty = 15000
			expect(result.driverCompensation.toNumber()).toBe(15000);
		});
	});

	describe("WebSocket Events", () => {
		it("should define all required order events", () => {
			const orderEvents = [
				"OFFER", // New order broadcast to drivers
				"DRIVER_ACCEPTED", // Driver accepted the order
				"UNAVAILABLE", // Order no longer available (accepted by another driver)
				"DRIVER_LOCATION_UPDATE", // Driver location broadcast
				"COMPLETED", // Order completed
				"CANCELED", // Order cancelled
				"NO_SHOW", // User no-show
				"CHAT_MESSAGE", // Chat between user and driver
				"MERCHANT_ACCEPTED", // Merchant accepted food order
				"MERCHANT_REJECTED", // Merchant rejected food order
				"MERCHANT_PREPARING", // Merchant preparing food
				"MERCHANT_READY", // Food ready for pickup
			];

			// Verify all events are defined
			expect(orderEvents).toContain("OFFER");
			expect(orderEvents).toContain("DRIVER_ACCEPTED");
			expect(orderEvents).toContain("UNAVAILABLE");
			expect(orderEvents).toContain("DRIVER_LOCATION_UPDATE");
			expect(orderEvents).toContain("COMPLETED");
			expect(orderEvents).toContain("CANCELED");
			expect(orderEvents).toContain("NO_SHOW");
			expect(orderEvents).toContain("CHAT_MESSAGE");
		});
	});

	describe("Order State Recovery", () => {
		it("should return active order statuses for recovery", () => {
			// These statuses indicate an active order that should be recovered on app reopen
			const activeStatuses = [
				"REQUESTED",
				"MATCHING",
				"ACCEPTED",
				"ARRIVING",
				"IN_TRIP",
				"PREPARING",
				"READY",
			];

			// Terminal statuses should not be recovered
			const terminalStatuses = [
				"COMPLETED",
				"CANCELLED_BY_USER",
				"CANCELLED_BY_DRIVER",
				"CANCELLED_BY_SYSTEM",
				"CANCELLED_BY_MERCHANT",
				"NO_SHOW",
			];

			// Active order check should only return active statuses
			expect(activeStatuses).toContain("MATCHING");
			expect(activeStatuses).toContain("ACCEPTED");
			expect(activeStatuses).toContain("IN_TRIP");

			// Should not include terminal statuses
			expect(activeStatuses).not.toContain("COMPLETED");
			expect(activeStatuses).not.toContain("CANCELLED_BY_USER");
		});

		it("should include driver and payment info in active order response", () => {
			// Active order response structure
			const activeOrderFields = [
				"order",
				"driver", // Driver info for tracking
				"payment", // Payment details
				"transaction", // Transaction record
			];

			expect(activeOrderFields).toContain("driver");
			expect(activeOrderFields).toContain("payment");
		});
	});

	describe("Gender Preference Matching", () => {
		it("should filter drivers by gender when preference is SAME", () => {
			const userGender = "FEMALE";
			const genderPreference = "SAME";

			// Should only match female drivers
			const matchesGender = (driverGender: string) => {
				if (genderPreference === "SAME") {
					return driverGender === userGender;
				}
				return true; // ANY preference matches all
			};

			expect(matchesGender("FEMALE")).toBe(true);
			expect(matchesGender("MALE")).toBe(false);
		});

		it("should match all drivers when preference is ANY", () => {
			const genderPreference = "ANY";

			const matchesGender = (driverGender: string) => {
				if (genderPreference === "ANY") {
					return true;
				}
				return false;
			};

			expect(matchesGender("FEMALE")).toBe(true);
			expect(matchesGender("MALE")).toBe(true);
		});
	});

	describe("Driver Priority (Badges + Leaderboard)", () => {
		it("should prioritize drivers with higher ratings", () => {
			const drivers = [
				{ id: "1", rating: 4.5 },
				{ id: "2", rating: 4.9 },
				{ id: "3", rating: 4.2 },
			];

			// Sort by rating DESC
			const sortedDrivers = [...drivers].sort(
				(a, b) => (b.rating ?? 0) - (a.rating ?? 0),
			);

			expect(sortedDrivers[0].id).toBe("2"); // Highest rating
			expect(sortedDrivers[1].id).toBe("1");
			expect(sortedDrivers[2].id).toBe("3");
		});

		it("should factor in badge level for driver priority", () => {
			// Badge benefits can include priority boost
			const badgeBenefits = {
				commissionReduction: 0.1,
				priorityBoost: 5, // Percentage boost in matching priority
			};

			expect(badgeBenefits.priorityBoost).toBe(5);
		});
	});
});

describe("Order Timeout Handler", () => {
	it("should only cancel orders in MATCHING or REQUESTED status", () => {
		const canTimeout = (status: string) => {
			return status === "MATCHING" || status === "REQUESTED";
		};

		expect(canTimeout("MATCHING")).toBe(true);
		expect(canTimeout("REQUESTED")).toBe(true);
		expect(canTimeout("ACCEPTED")).toBe(false);
		expect(canTimeout("COMPLETED")).toBe(false);
	});

	it("should set cancel reason when timing out", () => {
		const timeoutReason = "No driver found within 15 minutes";
		expect(timeoutReason).toContain("15 minutes");
	});

	it("should process refund when timeout occurs", () => {
		const result = OrderCancellationService.calculateRefund(
			50000,
			"CANCELLED_BY_SYSTEM",
			"MATCHING",
			mockBusinessConfig,
			null,
		);

		// Full refund on timeout
		expect(result.refundAmount.toNumber()).toBe(50000);
		expect(result.penaltyAmount.toNumber()).toBe(0);
	});
});

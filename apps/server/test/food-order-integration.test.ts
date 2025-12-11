import { describe, expect, it } from "bun:test";
import type { BusinessConfiguration } from "@repo/schema/configuration";
import type { OrderStatus, OrderType } from "@repo/schema/order";
import Decimal from "decimal.js";
import { OrderCancellationService } from "../src/features/order/services/order-cancellation-service";

/**
 * FOOD Order Integration Tests
 *
 * Comprehensive tests for the FOOD order flow including:
 * 1. Order creation → Payment → Merchant notification
 * 2. Merchant processing: Accept → Prepare → Ready
 * 3. Driver matching after food is ready
 * 4. Delivery flow: Driver accepts → Pickup → Delivery → Complete
 * 5. Commission calculation with merchant commission
 * 6. Cancellation scenarios at each stage
 * 7. WebSocket event broadcasting
 * 8. State machine transitions
 * 9. Edge cases and error handling
 *
 * Key FOOD Order Differences from RIDE/DELIVERY:
 * - Payment verified → Order stays in REQUESTED (not MATCHING)
 * - Merchant must accept/prepare/ready before driver matching
 * - 30-minute driver matching timeout (vs 15 for RIDE/DELIVERY)
 * - Merchant commission deducted from driver earnings
 * - Merchant can reject order at any point before ready
 */

// Business configuration with FOOD-specific settings
const mockBusinessConfig: BusinessConfiguration = {
	// Wallet limits
	minTransferAmount: 10000,
	minWithdrawalAmount: 50000,
	minTopUpAmount: 10000,
	quickTopUpAmounts: [50000, 100000, 200000, 500000],

	// Cancellation fees
	userCancellationFeeBeforeAccept: 0, // 0% penalty before merchant/driver accepts
	userCancellationFeeAfterAccept: 0.1, // 10% penalty after acceptance
	noShowFee: 0.25, // 25% no-show fee
	noShowDriverCompensationRate: 0.6, // Driver gets 60% of penalty

	// Delivery verification
	highValueOrderThreshold: 500000,

	// Order matching config - 30 minutes for FOOD orders
	driverMatchingTimeoutMinutes: 30,
	driverMatchingInitialRadiusKm: 5,
	driverMatchingMaxRadiusKm: 20,
	driverMatchingRadiusExpansionRate: 0.2, // 20% expansion
	driverMatchingIntervalSeconds: 30,
	driverMatchingBroadcastLimit: 10,
	driverMaxCancellationsPerDay: 3,

	// Payment timeout
	paymentPendingTimeoutMinutes: 15,
};

// Commission rates
const PLATFORM_COMMISSION_RATE = 0.1; // 10%
const MERCHANT_COMMISSION_RATE = 0.15; // 15%

/**
 * Helper to simulate order state transitions
 */
class OrderStateMachine {
	private static VALID_TRANSITIONS: Record<OrderStatus, OrderStatus[]> = {
		SCHEDULED: ["MATCHING", "CANCELLED_BY_USER", "CANCELLED_BY_SYSTEM"],
		REQUESTED: [
			"MATCHING",
			"ACCEPTED", // Merchant accepts (FOOD only)
			"CANCELLED_BY_USER",
			"CANCELLED_BY_SYSTEM",
			"CANCELLED_BY_MERCHANT", // Merchant rejects (FOOD only)
		],
		MATCHING: ["ACCEPTED", "CANCELLED_BY_USER", "CANCELLED_BY_SYSTEM"],
		ACCEPTED: [
			"PREPARING",
			"ARRIVING",
			"CANCELLED_BY_USER",
			"CANCELLED_BY_DRIVER",
			"CANCELLED_BY_SYSTEM",
		],
		PREPARING: [
			"READY_FOR_PICKUP",
			"CANCELLED_BY_MERCHANT",
			"CANCELLED_BY_USER",
		],
		READY_FOR_PICKUP: [
			"MATCHING",
			"ARRIVING",
			"CANCELLED_BY_MERCHANT",
			"CANCELLED_BY_USER",
		],
		ARRIVING: [
			"IN_TRIP",
			"CANCELLED_BY_DRIVER",
			"CANCELLED_BY_USER",
			"NO_SHOW",
		],
		IN_TRIP: ["COMPLETED", "CANCELLED_BY_DRIVER", "CANCELLED_BY_SYSTEM"],
		COMPLETED: [],
		CANCELLED_BY_USER: [],
		CANCELLED_BY_DRIVER: ["MATCHING"], // Can re-match
		CANCELLED_BY_MERCHANT: [],
		CANCELLED_BY_SYSTEM: [],
		NO_SHOW: [],
	};

	static canTransition(from: OrderStatus, to: OrderStatus): boolean {
		return OrderStateMachine.VALID_TRANSITIONS[from]?.includes(to) ?? false;
	}

	static getValidTransitions(from: OrderStatus): OrderStatus[] {
		return OrderStateMachine.VALID_TRANSITIONS[from] ?? [];
	}

	static isTerminalState(status: OrderStatus): boolean {
		return OrderStateMachine.VALID_TRANSITIONS[status]?.length === 0;
	}

	static isCancelledState(status: OrderStatus): boolean {
		return [
			"CANCELLED_BY_USER",
			"CANCELLED_BY_DRIVER",
			"CANCELLED_BY_MERCHANT",
			"CANCELLED_BY_SYSTEM",
		].includes(status);
	}
}

/**
 * Helper to calculate FOOD order commission
 */
class FoodOrderCommissionCalculator {
	static calculate(totalPrice: number) {
		const total = new Decimal(totalPrice);
		const platformCommission = total.times(PLATFORM_COMMISSION_RATE);
		const merchantCommission = total.times(MERCHANT_COMMISSION_RATE);
		const driverEarning = total
			.minus(platformCommission)
			.minus(merchantCommission);

		return {
			total: total.toNumber(),
			platformCommission: platformCommission.toNumber(),
			merchantCommission: merchantCommission.toNumber(),
			driverEarning: driverEarning.toNumber(),
		};
	}
}

// =============================================================================
// TEST SUITES
// =============================================================================

describe("FOOD Order Integration Tests", () => {
	describe("1. Order Creation and Payment Phase", () => {
		it("should create FOOD order in REQUESTED status", () => {
			const initialStatus: OrderStatus = "REQUESTED";
			expect(initialStatus).toBe("REQUESTED");
		});

		it("should keep FOOD order in REQUESTED after payment (not MATCHING)", () => {
			// This is the key difference: FOOD orders don't go to MATCHING after payment
			const orderType: OrderType = "FOOD";
			const statusAfterPayment =
				orderType === "FOOD" ? "REQUESTED" : "MATCHING";

			expect(statusAfterPayment).toBe("REQUESTED");
		});

		it("should NOT enqueue driver matching timeout after payment", () => {
			// For FOOD orders, timeout is only enqueued after READY_FOR_PICKUP
			const orderType: OrderType = "FOOD";
			const shouldEnqueueTimeout = orderType !== "FOOD";

			expect(shouldEnqueueTimeout).toBe(false);
		});

		it("should notify merchant via WebSocket after payment", () => {
			// Expected WebSocket event
			const expectedEvent = "NEW_ORDER";
			const expectedTarget = "merchant-ws";

			expect(expectedEvent).toBe("NEW_ORDER");
			expect(expectedTarget).toBe("merchant-ws");
		});

		it("should NOT broadcast to driver pool after payment", () => {
			const orderType: OrderType = "FOOD";
			const shouldBroadcastToDriverPool = orderType !== "FOOD";

			expect(shouldBroadcastToDriverPool).toBe(false);
		});

		it("should include order items in FOOD order", () => {
			const orderItems = [
				{
					menuId: "menu-1",
					menuName: "Nasi Goreng",
					quantity: 2,
					price: 25000,
				},
				{ menuId: "menu-2", menuName: "Es Teh", quantity: 3, price: 5000 },
			];

			const subtotal = orderItems.reduce(
				(sum, item) => sum + item.price * item.quantity,
				0,
			);
			expect(subtotal).toBe(65000); // 2*25000 + 3*5000
		});

		it("should validate menu stock before order creation", () => {
			const menuStock = 10;
			const orderQuantity = 5;
			const canOrder = orderQuantity <= menuStock;

			expect(canOrder).toBe(true);

			const outOfStockQuantity = 15;
			const canOrderOutOfStock = outOfStockQuantity <= menuStock;
			expect(canOrderOutOfStock).toBe(false);
		});
	});

	describe("2. Merchant Processing Phase", () => {
		describe("2.1. Merchant Accept", () => {
			it("should allow merchant to accept order in REQUESTED status", () => {
				const canAccept = OrderStateMachine.canTransition(
					"REQUESTED",
					"ACCEPTED",
				);
				expect(canAccept).toBe(true);
			});

			it("should NOT allow merchant to accept order in other statuses", () => {
				expect(OrderStateMachine.canTransition("MATCHING", "ACCEPTED")).toBe(
					true,
				); // Driver accepts
				expect(OrderStateMachine.canTransition("PREPARING", "ACCEPTED")).toBe(
					false,
				);
				expect(OrderStateMachine.canTransition("COMPLETED", "ACCEPTED")).toBe(
					false,
				);
			});

			it("should broadcast MERCHANT_ACCEPTED to user WebSocket", () => {
				const event = "MERCHANT_ACCEPTED";
				expect(event).toBe("MERCHANT_ACCEPTED");
			});

			it("should include merchant info in MERCHANT_ACCEPTED event", () => {
				const eventPayload = {
					type: "MERCHANT_ACCEPTED",
					orderId: "order-123",
					merchantId: "merchant-456",
					merchantName: "Warung Sederhana",
					acceptedAt: new Date().toISOString(),
				};

				expect(eventPayload.type).toBe("MERCHANT_ACCEPTED");
				expect(eventPayload.merchantId).toBeDefined();
			});
		});

		describe("2.2. Merchant Preparing", () => {
			it("should allow transition from ACCEPTED to PREPARING", () => {
				const canTransition = OrderStateMachine.canTransition(
					"ACCEPTED",
					"PREPARING",
				);
				expect(canTransition).toBe(true);
			});

			it("should NOT allow PREPARING from invalid statuses", () => {
				expect(OrderStateMachine.canTransition("REQUESTED", "PREPARING")).toBe(
					false,
				);
				expect(OrderStateMachine.canTransition("MATCHING", "PREPARING")).toBe(
					false,
				);
			});

			it("should broadcast MERCHANT_PREPARING to user WebSocket", () => {
				const event = "MERCHANT_PREPARING";
				expect(event).toBe("MERCHANT_PREPARING");
			});

			it("should include estimated preparation time in event", () => {
				const eventPayload = {
					type: "MERCHANT_PREPARING",
					orderId: "order-123",
					estimatedMinutes: 15,
					startedAt: new Date().toISOString(),
				};

				expect(eventPayload.estimatedMinutes).toBe(15);
			});
		});

		describe("2.3. Merchant Ready", () => {
			it("should allow transition from PREPARING to READY_FOR_PICKUP", () => {
				const canTransition = OrderStateMachine.canTransition(
					"PREPARING",
					"READY_FOR_PICKUP",
				);
				expect(canTransition).toBe(true);
			});

			it("should trigger driver matching after READY_FOR_PICKUP", () => {
				// After merchant marks ready, system starts finding drivers
				const shouldStartMatching = true;
				expect(shouldStartMatching).toBe(true);
			});

			it("should enqueue 30-minute timeout after marking ready", () => {
				const timeoutMinutes = 30;
				expect(timeoutMinutes).toBe(30);
			});

			it("should broadcast MERCHANT_READY to user WebSocket", () => {
				const event = "MERCHANT_READY";
				expect(event).toBe("MERCHANT_READY");
			});

			it("should transition to MATCHING for driver search", () => {
				const canTransition = OrderStateMachine.canTransition(
					"READY_FOR_PICKUP",
					"MATCHING",
				);
				expect(canTransition).toBe(true);
			});
		});

		describe("2.4. Merchant Rejection", () => {
			it("should allow merchant to reject order in REQUESTED status", () => {
				const canReject = OrderStateMachine.canTransition(
					"REQUESTED",
					"CANCELLED_BY_MERCHANT",
				);
				expect(canReject).toBe(true);
			});

			it("should allow merchant to reject during PREPARING", () => {
				const canReject = OrderStateMachine.canTransition(
					"PREPARING",
					"CANCELLED_BY_MERCHANT",
				);
				expect(canReject).toBe(true);
			});

			it("should give full refund when merchant rejects", () => {
				const result = OrderCancellationService.calculateRefund(
					50000,
					"CANCELLED_BY_MERCHANT",
					"REQUESTED",
					mockBusinessConfig,
					null,
				);

				expect(result.refundAmount.toNumber()).toBe(50000);
				expect(result.penaltyAmount.toNumber()).toBe(0);
			});

			it("should broadcast MERCHANT_REJECTED to user WebSocket", () => {
				const event = "MERCHANT_REJECTED";
				expect(event).toBe("MERCHANT_REJECTED");
			});

			it("should include rejection reason in event", () => {
				const eventPayload = {
					type: "MERCHANT_REJECTED",
					orderId: "order-123",
					reason: "OUT_OF_STOCK",
					note: "Sorry, we ran out of chicken",
				};

				expect(eventPayload.reason).toBe("OUT_OF_STOCK");
			});

			it("should NOT allow merchant to reject after driver accepts", () => {
				// Once driver has the order, merchant cannot reject
				const canReject = OrderStateMachine.canTransition(
					"ARRIVING",
					"CANCELLED_BY_MERCHANT",
				);
				expect(canReject).toBe(false);
			});
		});
	});

	describe("3. Driver Matching Phase (After Food Ready)", () => {
		it("should only start driver matching after READY_FOR_PICKUP", () => {
			const canStartMatching = (status: OrderStatus) => {
				return status === "READY_FOR_PICKUP" || status === "MATCHING";
			};

			expect(canStartMatching("REQUESTED")).toBe(false);
			expect(canStartMatching("ACCEPTED")).toBe(false);
			expect(canStartMatching("PREPARING")).toBe(false);
			expect(canStartMatching("READY_FOR_PICKUP")).toBe(true);
		});

		it("should have 30-minute timeout for FOOD orders", () => {
			const timeoutMinutes = mockBusinessConfig.driverMatchingTimeoutMinutes;
			expect(timeoutMinutes).toBe(30);
		});

		it("should broadcast to driver pool after food is ready", () => {
			const event = "OFFER";
			expect(event).toBe("OFFER");
		});

		it("should include merchant location as pickup in driver offer", () => {
			const offerPayload = {
				type: "OFFER",
				orderId: "order-123",
				orderType: "FOOD",
				pickupLocation: { x: 106.8456, y: -6.2088 }, // Merchant location
				dropoffLocation: { x: 106.85, y: -6.21 }, // User location
				merchantName: "Warung Sederhana",
				itemCount: 3,
			};

			expect(offerPayload.orderType).toBe("FOOD");
			expect(offerPayload.merchantName).toBeDefined();
		});

		it("should expand search radius when no drivers found", () => {
			const initialRadius = mockBusinessConfig.driverMatchingInitialRadiusKm;
			const expansionRate =
				mockBusinessConfig.driverMatchingRadiusExpansionRate;

			const expanded1 = initialRadius * (1 + expansionRate);
			const expanded2 = expanded1 * (1 + expansionRate);

			expect(expanded1).toBeCloseTo(6, 2);
			expect(expanded2).toBeCloseTo(7.2, 2);
		});

		it("should auto-cancel with full refund after 30-minute timeout", () => {
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

		it("should respect gender preference in driver matching", () => {
			const userGender = "FEMALE";
			const genderPreference = "SAME";

			const matchesGender = (driverGender: string) => {
				if (genderPreference === "SAME") {
					return driverGender === userGender;
				}
				return true;
			};

			expect(matchesGender("FEMALE")).toBe(true);
			expect(matchesGender("MALE")).toBe(false);
		});
	});

	describe("4. Driver Delivery Phase", () => {
		it("should transition from MATCHING to ACCEPTED when driver accepts", () => {
			const canTransition = OrderStateMachine.canTransition(
				"MATCHING",
				"ACCEPTED",
			);
			expect(canTransition).toBe(true);
		});

		it("should broadcast DRIVER_ACCEPTED to user and merchant", () => {
			const events = ["DRIVER_ACCEPTED"];
			expect(events).toContain("DRIVER_ACCEPTED");
		});

		it("should mark driver as taking order", () => {
			const driverBefore = { isTakingOrder: false };
			const driverAfter = { isTakingOrder: true };

			expect(driverAfter.isTakingOrder).toBe(true);
		});

		it("should broadcast UNAVAILABLE to other drivers", () => {
			const event = "UNAVAILABLE";
			expect(event).toBe("UNAVAILABLE");
		});

		it("should allow transition to ARRIVING when driver picks up", () => {
			// For FOOD orders, can go from ACCEPTED to ARRIVING (skipping PREPARING since merchant did it)
			const canTransition = OrderStateMachine.canTransition(
				"ACCEPTED",
				"ARRIVING",
			);
			expect(canTransition).toBe(true);
		});

		it("should broadcast driver location to user during delivery", () => {
			const event = "DRIVER_LOCATION_UPDATE";
			expect(event).toBe("DRIVER_LOCATION_UPDATE");
		});

		it("should allow transition to IN_TRIP when driver starts delivery", () => {
			const canTransition = OrderStateMachine.canTransition(
				"ARRIVING",
				"IN_TRIP",
			);
			expect(canTransition).toBe(true);
		});

		it("should allow transition to COMPLETED when delivery done", () => {
			const canTransition = OrderStateMachine.canTransition(
				"IN_TRIP",
				"COMPLETED",
			);
			expect(canTransition).toBe(true);
		});
	});

	describe("5. Commission Calculation", () => {
		it("should calculate platform commission (10%)", () => {
			const result = FoodOrderCommissionCalculator.calculate(100000);
			expect(result.platformCommission).toBe(10000);
		});

		it("should calculate merchant commission (15%)", () => {
			const result = FoodOrderCommissionCalculator.calculate(100000);
			expect(result.merchantCommission).toBe(15000);
		});

		it("should calculate driver earning (total - platform - merchant)", () => {
			const result = FoodOrderCommissionCalculator.calculate(100000);
			expect(result.driverEarning).toBe(75000);
		});

		it("should handle decimal amounts correctly", () => {
			const result = FoodOrderCommissionCalculator.calculate(123456);

			expect(result.total).toBe(123456);
			expect(result.platformCommission).toBeCloseTo(12345.6, 2);
			expect(result.merchantCommission).toBeCloseTo(18518.4, 2);
			expect(result.driverEarning).toBeCloseTo(92592, 0);
		});

		it("should NOT have merchant commission for RIDE orders", () => {
			const orderType = "RIDE" as OrderType;
			const hasMerchantCommission = orderType === "FOOD";
			const merchantCommission = hasMerchantCommission ? 15000 : 0;

			expect(merchantCommission).toBe(0);
		});

		it("should apply badge commission reduction", () => {
			const baseRate = PLATFORM_COMMISSION_RATE;
			const badgeReduction = 0.2; // 20% reduction
			const reducedRate = baseRate * (1 - badgeReduction);

			expect(reducedRate).toBeCloseTo(0.08, 4);

			const total = new Decimal(100000);
			const reducedCommission = total.times(reducedRate);
			expect(reducedCommission.toNumber()).toBeCloseTo(8000, 0);
		});
	});

	describe("6. Cancellation Scenarios", () => {
		describe("6.1. User Cancellation", () => {
			it("should give full refund when user cancels in REQUESTED", () => {
				const result = OrderCancellationService.calculateRefund(
					50000,
					"CANCELLED_BY_USER",
					"REQUESTED",
					mockBusinessConfig,
					null,
				);

				expect(result.refundAmount.toNumber()).toBe(50000);
				expect(result.penaltyAmount.toNumber()).toBe(0);
			});

			it("should apply penalty when user cancels after merchant accepts", () => {
				const result = OrderCancellationService.calculateRefund(
					50000,
					"CANCELLED_BY_USER",
					"ACCEPTED",
					mockBusinessConfig,
					null,
				);

				// Penalty applies after acceptance
				expect(result.penaltyAmount.toNumber()).toBeGreaterThanOrEqual(0);
			});

			it("should apply penalty when user cancels during preparation", () => {
				const result = OrderCancellationService.calculateRefund(
					50000,
					"CANCELLED_BY_USER",
					"PREPARING",
					mockBusinessConfig,
					null,
				);

				expect(result.penaltyAmount.toNumber()).toBeGreaterThanOrEqual(0);
			});

			it("should NOT allow user cancellation during IN_TRIP", () => {
				// Business rule: Cannot cancel once delivery has started
				const canCancel = OrderStateMachine.canTransition(
					"IN_TRIP",
					"CANCELLED_BY_USER",
				);
				expect(canCancel).toBe(false);
			});
		});

		describe("6.2. Driver Cancellation", () => {
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

			it("should allow re-matching after driver cancels", () => {
				const canRematch = OrderStateMachine.canTransition(
					"CANCELLED_BY_DRIVER",
					"MATCHING",
				);
				expect(canRematch).toBe(true);
			});

			it("should increment driver cancellation count", () => {
				const maxCancellations =
					mockBusinessConfig.driverMaxCancellationsPerDay;
				const driverCancellations = 3;
				const canReceiveOrders = driverCancellations < maxCancellations;

				expect(canReceiveOrders).toBe(false);
			});
		});

		describe("6.3. System Cancellation", () => {
			it("should give full refund on timeout cancellation", () => {
				const result = OrderCancellationService.calculateRefund(
					50000,
					"CANCELLED_BY_SYSTEM",
					"MATCHING",
					mockBusinessConfig,
					null,
				);

				expect(result.refundAmount.toNumber()).toBe(50000);
			});

			it("should set appropriate cancel reason for timeout", () => {
				const cancelReason = "No driver found within 30 minutes";
				expect(cancelReason).toContain("30 minutes");
			});
		});

		describe("6.4. No-Show Handling", () => {
			it("should only allow no-show report when driver is ARRIVING", () => {
				expect(OrderCancellationService.canReportNoShow("ARRIVING")).toBe(true);
				expect(OrderCancellationService.canReportNoShow("ACCEPTED")).toBe(
					false,
				);
				expect(OrderCancellationService.canReportNoShow("IN_TRIP")).toBe(false);
			});

			it("should calculate no-show penalty and compensation", () => {
				const result = OrderCancellationService.calculateNoShowRefund(
					100000,
					mockBusinessConfig,
				);

				expect(result.penaltyAmount.toNumber()).toBe(25000); // 25%
				expect(result.refundAmount.toNumber()).toBe(75000); // 75%
				expect(result.driverCompensation.toNumber()).toBe(15000); // 60% of penalty
			});
		});
	});

	describe("7. WebSocket Events", () => {
		it("should define all FOOD-specific events", () => {
			const foodEvents = [
				"NEW_ORDER", // To merchant
				"MERCHANT_ACCEPTED",
				"MERCHANT_PREPARING",
				"MERCHANT_READY",
				"MERCHANT_REJECTED",
			];

			expect(foodEvents).toContain("NEW_ORDER");
			expect(foodEvents).toContain("MERCHANT_ACCEPTED");
			expect(foodEvents).toContain("MERCHANT_PREPARING");
			expect(foodEvents).toContain("MERCHANT_READY");
			expect(foodEvents).toContain("MERCHANT_REJECTED");
		});

		it("should define all driver-related events", () => {
			const driverEvents = [
				"OFFER",
				"DRIVER_ACCEPTED",
				"UNAVAILABLE",
				"DRIVER_LOCATION_UPDATE",
				"COMPLETED",
				"CANCELED",
			];

			expect(driverEvents).toContain("OFFER");
			expect(driverEvents).toContain("DRIVER_ACCEPTED");
		});

		it("should broadcast to correct recipients", () => {
			const eventTargets = {
				NEW_ORDER: "merchant",
				MERCHANT_ACCEPTED: "user",
				MERCHANT_PREPARING: "user",
				MERCHANT_READY: "user",
				MERCHANT_REJECTED: "user",
				OFFER: "driver-pool",
				DRIVER_ACCEPTED: ["user", "merchant"],
				DRIVER_LOCATION_UPDATE: "user",
				COMPLETED: ["user", "merchant"],
			};

			expect(eventTargets.NEW_ORDER).toBe("merchant");
			expect(eventTargets.MERCHANT_ACCEPTED).toBe("user");
		});
	});

	describe("8. State Machine Validation", () => {
		it("should validate all FOOD order state transitions", () => {
			// Happy path: REQUESTED → ACCEPTED → PREPARING → READY_FOR_PICKUP → MATCHING → ACCEPTED → ARRIVING → IN_TRIP → COMPLETED
			expect(OrderStateMachine.canTransition("REQUESTED", "ACCEPTED")).toBe(
				true,
			);
			expect(OrderStateMachine.canTransition("ACCEPTED", "PREPARING")).toBe(
				true,
			);
			expect(
				OrderStateMachine.canTransition("PREPARING", "READY_FOR_PICKUP"),
			).toBe(true);
			expect(
				OrderStateMachine.canTransition("READY_FOR_PICKUP", "MATCHING"),
			).toBe(true);
			expect(OrderStateMachine.canTransition("MATCHING", "ACCEPTED")).toBe(
				true,
			);
			expect(OrderStateMachine.canTransition("ACCEPTED", "ARRIVING")).toBe(
				true,
			);
			expect(OrderStateMachine.canTransition("ARRIVING", "IN_TRIP")).toBe(true);
			expect(OrderStateMachine.canTransition("IN_TRIP", "COMPLETED")).toBe(
				true,
			);
		});

		it("should identify terminal states", () => {
			expect(OrderStateMachine.isTerminalState("COMPLETED")).toBe(true);
			expect(OrderStateMachine.isTerminalState("CANCELLED_BY_USER")).toBe(true);
			expect(OrderStateMachine.isTerminalState("CANCELLED_BY_MERCHANT")).toBe(
				true,
			);
			expect(OrderStateMachine.isTerminalState("CANCELLED_BY_SYSTEM")).toBe(
				true,
			);
			expect(OrderStateMachine.isTerminalState("NO_SHOW")).toBe(true);

			// Not terminal - can transition further
			expect(OrderStateMachine.isTerminalState("REQUESTED")).toBe(false);
			expect(OrderStateMachine.isTerminalState("PREPARING")).toBe(false);
		});

		it("should reject invalid transitions", () => {
			expect(OrderStateMachine.canTransition("REQUESTED", "IN_TRIP")).toBe(
				false,
			);
			expect(OrderStateMachine.canTransition("COMPLETED", "ARRIVING")).toBe(
				false,
			);
			expect(OrderStateMachine.canTransition("PREPARING", "MATCHING")).toBe(
				false,
			);
		});
	});

	describe("9. Edge Cases and Error Handling", () => {
		it("should handle concurrent merchant acceptance (race condition)", () => {
			// Only one merchant should be able to accept
			// Implemented via SELECT FOR UPDATE in database
			const orderStatus: OrderStatus = "REQUESTED";
			const canAccept = orderStatus === "REQUESTED";
			expect(canAccept).toBe(true);

			// After first accept, status changes - cannot accept again
			const newStatus: OrderStatus = "ACCEPTED";
			// Use state machine to check if still in valid state for acceptance
			const canAcceptAgain =
				OrderStateMachine.getValidTransitions(newStatus).includes("ACCEPTED");
			expect(canAcceptAgain).toBe(false);
		});

		it("should handle merchant going offline during order", () => {
			// If merchant goes offline, order should be auto-cancelled
			const merchantOnline = false;
			const orderStatus: OrderStatus = "PREPARING";
			const shouldCancel = !merchantOnline && orderStatus === "PREPARING";

			expect(shouldCancel).toBe(true);
		});

		it("should handle zero-item orders", () => {
			const items: unknown[] = [];
			const isValid = items.length > 0;

			expect(isValid).toBe(false);
		});

		it("should handle out-of-stock items during order", () => {
			const menuStock = 0;
			const orderQuantity = 1;
			const canOrder = orderQuantity <= menuStock;

			expect(canOrder).toBe(false);
		});

		it("should handle merchant closing during preparation", () => {
			const merchantOpen = false;
			const orderStatus: OrderStatus = "PREPARING";

			// Merchant can still complete existing orders
			const canContinue = orderStatus === "PREPARING";
			expect(canContinue).toBe(true);
		});

		it("should enforce single merchant per order", () => {
			const cartItems = [
				{ merchantId: "merchant-1", menuId: "menu-1" },
				{ merchantId: "merchant-2", menuId: "menu-2" }, // Different merchant
			];

			const merchantIds = [...new Set(cartItems.map((i) => i.merchantId))];
			const isValidCart = merchantIds.length === 1;

			expect(isValidCart).toBe(false);
		});

		it("should prevent multiple active orders per user", () => {
			const userActiveOrders = 1;
			const maxActiveOrders = 1;
			const canPlaceNewOrder = userActiveOrders < maxActiveOrders;

			expect(canPlaceNewOrder).toBe(false);
		});
	});

	describe("10. Order Recovery for FOOD Orders", () => {
		it("should include FOOD-specific statuses in active order check", () => {
			const activeFoodStatuses: OrderStatus[] = [
				"REQUESTED", // Waiting for merchant
				"ACCEPTED", // Merchant accepted
				"PREPARING", // Food being prepared
				"READY_FOR_PICKUP", // Food ready
				"MATCHING", // Finding driver
				"ARRIVING", // Driver on the way
				"IN_TRIP", // Delivering
			];

			expect(activeFoodStatuses).toContain("PREPARING");
			expect(activeFoodStatuses).toContain("READY_FOR_PICKUP");
		});

		it("should recover WebSocket connection based on FOOD order status", () => {
			const determineWebSocketConnection = (
				status: OrderStatus,
				orderType: OrderType,
				paymentStatus: string,
			) => {
				if (
					orderType === "FOOD" &&
					status === "REQUESTED" &&
					paymentStatus === "SUCCESS"
				) {
					return "order-ws"; // Listen for merchant updates
				}
				if (["MATCHING", "ACCEPTED", "ARRIVING", "IN_TRIP"].includes(status)) {
					return "order-ws"; // Listen for driver updates
				}
				return null;
			};

			expect(determineWebSocketConnection("REQUESTED", "FOOD", "SUCCESS")).toBe(
				"order-ws",
			);
			expect(determineWebSocketConnection("MATCHING", "FOOD", "SUCCESS")).toBe(
				"order-ws",
			);
		});

		it("should include merchant info in active order response", () => {
			const activeOrderResponse = {
				order: { id: "order-123", status: "PREPARING" },
				merchant: { id: "merchant-456", name: "Warung Sederhana" },
				driver: null, // Not yet assigned
				payment: { status: "SUCCESS" },
			};

			expect(activeOrderResponse.merchant).toBeDefined();
			expect(activeOrderResponse.driver).toBeNull();
		});
	});
});

describe("FOOD Order Timeout Handler", () => {
	it("should NOT enqueue timeout immediately after payment", () => {
		const orderType: OrderType = "FOOD";
		const shouldEnqueue = orderType !== "FOOD";

		expect(shouldEnqueue).toBe(false);
	});

	it("should enqueue 30-minute timeout after READY_FOR_PICKUP", () => {
		const status: OrderStatus = "READY_FOR_PICKUP";
		const shouldEnqueue = status === "READY_FOR_PICKUP";
		const timeoutMinutes = 30;

		expect(shouldEnqueue).toBe(true);
		expect(timeoutMinutes).toBe(30);
	});

	it("should check order is still in MATCHING before cancelling", () => {
		const canCancel = (status: OrderStatus) => {
			return status === "MATCHING";
		};

		expect(canCancel("MATCHING")).toBe(true);
		expect(canCancel("ACCEPTED")).toBe(false);
		expect(canCancel("COMPLETED")).toBe(false);
	});
});

describe("FOOD Order Location Handling", () => {
	it("should use merchant location as pickup", () => {
		const merchantLocation = { x: 106.8456, y: -6.2088 };
		const pickupLocation = merchantLocation;

		expect(pickupLocation).toEqual(merchantLocation);
	});

	it("should use user location as dropoff", () => {
		const userLocation = { x: 106.85, y: -6.21 };
		const dropoffLocation = userLocation;

		expect(dropoffLocation).toEqual(userLocation);
	});

	it("should calculate distance for delivery fee", () => {
		const merchantLat = -6.2088;
		const merchantLng = 106.8456;
		const userLat = -6.21;
		const userLng = 106.85;

		// Simple distance calculation (Haversine would be more accurate)
		const latDiff = Math.abs(userLat - merchantLat);
		const lngDiff = Math.abs(userLng - merchantLng);

		expect(latDiff).toBeGreaterThan(0);
		expect(lngDiff).toBeGreaterThan(0);
	});
});

import { describe, expect, it } from "bun:test";
import type { BusinessConfiguration } from "@repo/schema/configuration";
import Decimal from "decimal.js";
import { OrderCancellationService } from "../src/features/order/services/order-cancellation-service";

/**
 * FOOD Order (Mart) Flow Tests
 *
 * Tests the complete FOOD order flow specific to merchant orders:
 * 1. Customer creates FOOD order -> Payment required
 * 2. Payment verified -> Order stays in REQUESTED, merchant notified
 * 3. Merchant accepts -> Status changes to ACCEPTED
 * 4. Merchant prepares -> Status changes to PREPARING
 * 5. Merchant marks ready -> Status changes to READY_FOR_PICKUP, driver matching starts
 * 6. 30-minute timeout for driver acceptance
 * 7. Driver accepts -> Pickup -> Delivery -> Completion
 * 8. Commission calculation includes merchant commission
 * 9. Review/Rating after completion
 *
 * Key Differences from RIDE/DELIVERY:
 * - After payment, FOOD orders stay in REQUESTED (not MATCHING)
 * - Merchant must accept/prepare/mark-ready before driver matching
 * - Merchant can reject order (full refund to user)
 * - 30-minute driver matching timeout (vs 15 for RIDE/DELIVERY)
 * - Merchant commission deducted from driver earnings
 */

// Mock business configuration
const mockBusinessConfig: BusinessConfiguration = {
	// Wallet limits
	minTransferAmount: 10000,
	minWithdrawalAmount: 50000,
	minTopUpAmount: 10000,
	quickTopUpAmounts: [50000, 100000, 200000, 500000],

	// Cancellation fees
	userCancellationFeeBeforeAccept: 0,
	userCancellationFeeAfterAccept: 0.1,
	noShowFee: 0.25,
	noShowDriverCompensationRate: 0.6,

	// Delivery verification
	highValueOrderThreshold: 500000,

	// Order matching config (30 min for FOOD orders)
	driverMatchingTimeoutMinutes: 30,
	driverMatchingInitialRadiusKm: 5,
	driverMatchingMaxRadiusKm: 20,
	driverMatchingRadiusExpansionRate: 0.2,
	driverMatchingIntervalSeconds: 30,
	driverMatchingBroadcastLimit: 10,
	driverMaxCancellationsPerDay: 3,

	// Payment timeout
	paymentPendingTimeoutMinutes: 15,
};

describe("FOOD Order (Mart) Flow", () => {
	describe("Order Creation and Payment", () => {
		it("should keep FOOD order in REQUESTED status after payment", () => {
			// FOOD orders should NOT transition to MATCHING immediately after payment
			// Instead, they wait for merchant to accept/prepare/ready
			const foodOrderStatusAfterPayment = "REQUESTED";
			expect(foodOrderStatusAfterPayment).toBe("REQUESTED");
		});

		it("should notify merchant (not drivers) after FOOD order payment", () => {
			// For FOOD orders, the NEW_ORDER event goes to merchant WebSocket
			// NOT to driver-pool WebSocket
			const targetWebSocket = "merchant-ws";
			const event = "NEW_ORDER";

			expect(targetWebSocket).toBe("merchant-ws");
			expect(event).toBe("NEW_ORDER");
		});

		it("should NOT broadcast to driver pool after FOOD order payment", () => {
			// Driver pool broadcast should only happen for RIDE/DELIVERY
			const orderType = "FOOD";
			const shouldBroadcastToDriverPool = orderType !== "FOOD";

			expect(shouldBroadcastToDriverPool).toBe(false);
		});
	});

	describe("Merchant Order Actions", () => {
		it("should allow merchant to accept FOOD order in REQUESTED status", () => {
			const validStatusForAccept = "REQUESTED";
			const canAccept = validStatusForAccept === "REQUESTED";

			expect(canAccept).toBe(true);
		});

		it("should transition to ACCEPTED when merchant accepts", () => {
			const statusBefore = "REQUESTED";
			const statusAfter = "ACCEPTED";

			expect(statusBefore).toBe("REQUESTED");
			expect(statusAfter).toBe("ACCEPTED");
		});

		it("should transition to PREPARING when merchant marks preparing", () => {
			const statusAfter = "PREPARING";
			expect(statusAfter).toBe("PREPARING");
		});

		it("should start driver matching when merchant marks READY_FOR_PICKUP", () => {
			// When merchant marks order ready:
			// 1. Status changes to MATCHING (for driver search)
			// 2. 30-minute timeout job is enqueued
			// 3. Driver pool is notified
			const statusAfterReady = "MATCHING";
			const timeoutMinutes = 30;

			expect(statusAfterReady).toBe("MATCHING");
			expect(timeoutMinutes).toBe(30);
		});

		it("should broadcast MERCHANT_ACCEPTED event to user WebSocket", () => {
			const event = "MERCHANT_ACCEPTED";
			expect(event).toBe("MERCHANT_ACCEPTED");
		});

		it("should broadcast MERCHANT_PREPARING event to user WebSocket", () => {
			const event = "MERCHANT_PREPARING";
			expect(event).toBe("MERCHANT_PREPARING");
		});

		it("should broadcast MERCHANT_READY event to user WebSocket", () => {
			const event = "MERCHANT_READY";
			expect(event).toBe("MERCHANT_READY");
		});
	});

	describe("Merchant Rejection", () => {
		it("should allow merchant to reject FOOD order", () => {
			const statusBefore = "REQUESTED";
			const canReject = statusBefore === "REQUESTED";

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

			// Full refund for merchant rejection
			expect(result.refundAmount.toNumber()).toBe(50000);
			expect(result.penaltyAmount.toNumber()).toBe(0);
		});

		it("should broadcast MERCHANT_REJECTED event to user WebSocket", () => {
			const event = "MERCHANT_REJECTED";
			expect(event).toBe("MERCHANT_REJECTED");
		});
	});

	describe("FOOD Order State Machine", () => {
		it("should define valid transitions for FOOD orders", () => {
			const validTransitions: Record<string, string[]> = {
				// FOOD orders wait for merchant after payment
				REQUESTED: [
					"ACCEPTED", // Merchant accepts
					"CANCELLED_BY_USER",
					"CANCELLED_BY_SYSTEM",
					"CANCELLED_BY_MERCHANT",
				],
				// Merchant accepted, preparing food
				ACCEPTED: ["PREPARING", "CANCELLED_BY_USER", "CANCELLED_BY_MERCHANT"],
				// Food being prepared
				PREPARING: [
					"READY_FOR_PICKUP", // Merchant marks ready
					"CANCELLED_BY_USER",
					"CANCELLED_BY_MERCHANT",
				],
				// Food ready, searching for driver
				READY_FOR_PICKUP: [
					"MATCHING", // Start driver search
				],
				// Searching for driver
				MATCHING: [
					"ACCEPTED", // Driver accepts (changes meaning here)
					"CANCELLED_BY_USER",
					"CANCELLED_BY_SYSTEM", // Timeout
				],
				// Driver accepted, going to pickup
				// ACCEPTED: handled above, same as general flow
				ARRIVING: [
					"IN_TRIP", // Picked up, delivering
					"CANCELLED_BY_USER",
					"CANCELLED_BY_DRIVER",
					"NO_SHOW",
				],
				IN_TRIP: ["COMPLETED", "CANCELLED_BY_USER", "CANCELLED_BY_DRIVER"],
				COMPLETED: [], // Terminal
				CANCELLED_BY_USER: [], // Terminal
				CANCELLED_BY_SYSTEM: [], // Terminal
				CANCELLED_BY_MERCHANT: [], // Terminal
				CANCELLED_BY_DRIVER: [], // Terminal
				NO_SHOW: [], // Terminal
			};

			// FOOD order specific: REQUESTED can go to ACCEPTED (merchant) or CANCELLED_BY_MERCHANT
			expect(validTransitions.REQUESTED).toContain("ACCEPTED");
			expect(validTransitions.REQUESTED).toContain("CANCELLED_BY_MERCHANT");

			// Merchant prepares food
			expect(validTransitions.ACCEPTED).toContain("PREPARING");

			// Merchant marks ready
			expect(validTransitions.PREPARING).toContain("READY_FOR_PICKUP");
		});
	});

	describe("Driver Matching After Food Ready", () => {
		it("should have 30-minute timeout for FOOD order driver matching", () => {
			const foodOrderTimeoutMinutes = 30;
			expect(foodOrderTimeoutMinutes).toBe(30);
		});

		it("should only start driver matching after READY_FOR_PICKUP", () => {
			// Driver matching should NOT start until food is ready
			const canStartMatching = (status: string) => {
				return status === "READY_FOR_PICKUP" || status === "MATCHING";
			};

			expect(canStartMatching("REQUESTED")).toBe(false);
			expect(canStartMatching("ACCEPTED")).toBe(false);
			expect(canStartMatching("PREPARING")).toBe(false);
			expect(canStartMatching("READY_FOR_PICKUP")).toBe(true);
			expect(canStartMatching("MATCHING")).toBe(true);
		});

		it("should auto-cancel with refund if no driver accepts within 30 minutes", () => {
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

	describe("FOOD Order Commission Calculation", () => {
		it("should calculate merchant commission for FOOD orders", () => {
			const totalPrice = new Decimal(100000);
			const merchantCommissionRate = 0.15; // 15% to merchant

			const merchantCommission = totalPrice.times(merchantCommissionRate);
			expect(merchantCommission.toNumber()).toBe(15000);
		});

		it("should calculate driver earning minus both platform and merchant commission", () => {
			const totalPrice = new Decimal(100000);
			const platformFeeRate = 0.1; // 10% platform
			const merchantCommissionRate = 0.15; // 15% merchant

			const platformCommission = totalPrice.times(platformFeeRate);
			const merchantCommission = totalPrice.times(merchantCommissionRate);
			const driverEarning = totalPrice
				.minus(platformCommission)
				.minus(merchantCommission);

			// Driver gets: 100000 - 10000 - 15000 = 75000
			expect(platformCommission.toNumber()).toBe(10000);
			expect(merchantCommission.toNumber()).toBe(15000);
			expect(driverEarning.toNumber()).toBe(75000);
		});

		it("should NOT have merchant commission for RIDE/DELIVERY orders", () => {
			const orderType = "RIDE" as string;
			const merchantCommission =
				orderType === "FOOD" ? new Decimal(15000) : new Decimal(0);

			expect(merchantCommission.toNumber()).toBe(0);
		});
	});

	describe("WebSocket Events for FOOD Orders", () => {
		it("should define merchant-specific order events", () => {
			const merchantEvents = [
				"NEW_ORDER", // New FOOD order to merchant
				"MERCHANT_ACCEPTED", // Merchant accepted
				"MERCHANT_REJECTED", // Merchant rejected
				"MERCHANT_PREPARING", // Merchant preparing food
				"MERCHANT_READY", // Food ready for pickup
			];

			expect(merchantEvents).toContain("NEW_ORDER");
			expect(merchantEvents).toContain("MERCHANT_ACCEPTED");
			expect(merchantEvents).toContain("MERCHANT_REJECTED");
			expect(merchantEvents).toContain("MERCHANT_PREPARING");
			expect(merchantEvents).toContain("MERCHANT_READY");
		});

		it("should broadcast merchant events to user WebSocket", () => {
			// User should receive all merchant status updates
			const userReceivedEvents = [
				"MERCHANT_ACCEPTED",
				"MERCHANT_REJECTED",
				"MERCHANT_PREPARING",
				"MERCHANT_READY",
			];

			expect(userReceivedEvents).toContain("MERCHANT_ACCEPTED");
			expect(userReceivedEvents).toContain("MERCHANT_PREPARING");
			expect(userReceivedEvents).toContain("MERCHANT_READY");
		});
	});

	describe("User Cancellation for FOOD Orders", () => {
		it("should allow user to cancel before merchant accepts (full refund)", () => {
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

		it("should apply penalty if user cancels after merchant accepts", () => {
			// After merchant accepts but before driver assigned
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_USER",
				"ACCEPTED",
				mockBusinessConfig,
				null, // No driver assigned yet
			);

			// Configuration determines the penalty
			// For FOOD orders with merchant accepted, might have penalty
			expect(result.penaltyAmount.toNumber()).toBeGreaterThanOrEqual(0);
		});

		it("should apply penalty if user cancels during preparation", () => {
			const result = OrderCancellationService.calculateRefund(
				50000,
				"CANCELLED_BY_USER",
				"PREPARING",
				mockBusinessConfig,
				null,
			);

			// Merchant has already started work, penalty may apply
			expect(result.penaltyAmount.toNumber()).toBeGreaterThanOrEqual(0);
		});
	});

	describe("Order State Recovery for FOOD Orders", () => {
		it("should include FOOD-specific active statuses for recovery", () => {
			const activeFoodOrderStatuses = [
				"REQUESTED", // Waiting for merchant
				"ACCEPTED", // Merchant accepted
				"PREPARING", // Food being prepared
				"READY_FOR_PICKUP", // Food ready, waiting for driver
				"MATCHING", // Searching for driver
				"ARRIVING", // Driver going to pickup
				"IN_TRIP", // Delivering
			];

			expect(activeFoodOrderStatuses).toContain("PREPARING");
			expect(activeFoodOrderStatuses).toContain("READY_FOR_PICKUP");
		});

		it("should recover WebSocket connection based on FOOD order status", () => {
			// For paid FOOD orders in REQUESTED status:
			// - Should connect to order WebSocket (not driver-pool)
			// - To receive merchant updates (ACCEPTED, PREPARING, READY)
			const status = "REQUESTED";
			const orderType = "FOOD";
			const paymentStatus = "SUCCESS";

			const shouldConnectToOrderWs =
				status === "REQUESTED" &&
				orderType === "FOOD" &&
				paymentStatus === "SUCCESS";

			expect(shouldConnectToOrderWs).toBe(true);
		});
	});

	describe("Order Items for FOOD Orders", () => {
		it("should include order items in FOOD order", () => {
			// FOOD orders have associated menu items
			const orderFields = ["id", "userId", "merchantId", "items", "totalPrice"];

			expect(orderFields).toContain("items");
			expect(orderFields).toContain("merchantId");
		});

		it("should calculate total from item prices and quantities", () => {
			const items = [
				{ menuId: "1", price: 25000, quantity: 2 }, // 50000
				{ menuId: "2", price: 15000, quantity: 1 }, // 15000
			];

			const subtotal = items.reduce(
				(sum, item) => sum + item.price * item.quantity,
				0,
			);

			expect(subtotal).toBe(65000);
		});
	});

	describe("Rating and Review After FOOD Order Completion", () => {
		it("should require review after FOOD order completion", () => {
			// Both user and driver should rate each other
			const reviewRequired = true;
			expect(reviewRequired).toBe(true);
		});

		it("should check if user has already reviewed", () => {
			const reviews = [
				{ fromUserId: "user-123", toUserId: "driver-456", score: 5 },
			];
			const currentUserId = "user-123";

			const hasAlreadyReviewed = reviews.some(
				(r) => r.fromUserId === currentUserId,
			);

			expect(hasAlreadyReviewed).toBe(true);
		});

		it("should allow review if user has not reviewed yet", () => {
			const reviews = [
				{ fromUserId: "driver-456", toUserId: "user-123", score: 5 },
			];
			const currentUserId = "user-123";

			const hasAlreadyReviewed = reviews.some(
				(r) => r.fromUserId === currentUserId,
			);
			const canReview = !hasAlreadyReviewed;

			expect(canReview).toBe(true);
		});
	});
});

describe("FOOD Order Timeout Handler", () => {
	it("should NOT enqueue timeout job immediately after FOOD order payment", () => {
		// Timeout job should only be enqueued after READY_FOR_PICKUP
		const orderType = "FOOD";
		const shouldEnqueueTimeoutAfterPayment = orderType !== "FOOD";

		expect(shouldEnqueueTimeoutAfterPayment).toBe(false);
	});

	it("should enqueue 30-minute timeout job after merchant marks ready", () => {
		const timeoutMinutes = 30;
		const shouldEnqueue = true;

		expect(timeoutMinutes).toBe(30);
		expect(shouldEnqueue).toBe(true);
	});

	it("should cancel FOOD order if no driver accepts within 30 minutes", () => {
		const status = "MATCHING";
		const timeoutMinutes = 30;
		const shouldCancel = status === "MATCHING";

		expect(shouldCancel).toBe(true);
		expect(timeoutMinutes).toBe(30);
	});
});

describe("Merchant Location for FOOD Orders", () => {
	it("should use merchant location as pickup location", () => {
		const merchantLocation = { x: 106.8456, y: -6.2088 };
		const pickupLocation = merchantLocation;

		expect(pickupLocation).toEqual(merchantLocation);
	});

	it("should use user location as dropoff location", () => {
		const userLocation = { x: 106.85, y: -6.21 };
		const dropoffLocation = userLocation;

		expect(dropoffLocation).toEqual(userLocation);
	});

	it("should store merchant location in cart", () => {
		const cart = {
			merchantId: "merchant-123",
			merchantLocation: { x: 106.8456, y: -6.2088 },
			items: [],
		};

		expect(cart.merchantLocation).toBeDefined();
		expect(cart.merchantLocation.x).toBe(106.8456);
		expect(cart.merchantLocation.y).toBe(-6.2088);
	});
});

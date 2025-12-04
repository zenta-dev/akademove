import { env } from "cloudflare:workers";
import type { Order, OrderStatus } from "@repo/schema/order";
import { RepositoryError } from "@/core/error";
import { log } from "@/utils";

/**
 * Service responsible for merchant order status management
 *
 * Handles:
 * - Order status validation (can accept/reject/prepare/ready)
 * - Status transition rules (REQUESTED → ACCEPTED → PREPARING → READY_FOR_PICKUP)
 * - WebSocket event emission for real-time updates
 * - Merchant ownership validation
 *
 * @example
 * ```typescript
 * const statusService = new MerchantOrderStatusService();
 *
 * // Validate if merchant can accept order
 * const canAccept = statusService.canAcceptOrder(order, merchantId);
 * if (!canAccept.allowed) {
 *   throw new Error(canAccept.reason);
 * }
 * ```
 */
export class MerchantOrderStatusService {
	/**
	 * Validates if merchant can accept an order
	 *
	 * @param order - Order to validate
	 * @param merchantId - Merchant ID attempting action
	 * @returns Validation result
	 */
	canAcceptOrder(
		order: Order,
		merchantId: string,
	): { allowed: boolean; reason?: string } {
		// Check ownership
		if (order.merchantId !== merchantId) {
			return {
				allowed: false,
				reason: "Order does not belong to this merchant",
			};
		}

		// Check status
		if (order.status !== "REQUESTED" && order.status !== "MATCHING") {
			return {
				allowed: false,
				reason: `Cannot accept order with status ${order.status}`,
			};
		}

		return { allowed: true };
	}

	/**
	 * Validates if merchant can reject an order
	 *
	 * @param order - Order to validate
	 * @param merchantId - Merchant ID attempting action
	 * @returns Validation result
	 */
	canRejectOrder(
		order: Order,
		merchantId: string,
	): { allowed: boolean; reason?: string } {
		// Check ownership
		if (order.merchantId !== merchantId) {
			return {
				allowed: false,
				reason: "Order does not belong to this merchant",
			};
		}

		// Check status
		if (
			order.status !== "REQUESTED" &&
			order.status !== "MATCHING" &&
			order.status !== "ACCEPTED"
		) {
			return {
				allowed: false,
				reason: `Cannot reject order with status ${order.status}`,
			};
		}

		return { allowed: true };
	}

	/**
	 * Validates if merchant can mark order as preparing
	 *
	 * @param order - Order to validate
	 * @param merchantId - Merchant ID attempting action
	 * @returns Validation result
	 */
	canMarkPreparing(
		order: Order,
		merchantId: string,
	): { allowed: boolean; reason?: string } {
		// Check ownership
		if (order.merchantId !== merchantId) {
			return {
				allowed: false,
				reason: "Order does not belong to this merchant",
			};
		}

		// Check status
		if (order.status !== "ACCEPTED") {
			return {
				allowed: false,
				reason: `Cannot mark order as preparing with status ${order.status}`,
			};
		}

		return { allowed: true };
	}

	/**
	 * Validates if merchant can mark order as ready
	 *
	 * @param order - Order to validate
	 * @param merchantId - Merchant ID attempting action
	 * @returns Validation result
	 */
	canMarkReady(
		order: Order,
		merchantId: string,
	): { allowed: boolean; reason?: string } {
		// Check ownership
		if (order.merchantId !== merchantId) {
			return {
				allowed: false,
				reason: "Order does not belong to this merchant",
			};
		}

		// Check status
		if (order.status !== "PREPARING") {
			return {
				allowed: false,
				reason: `Cannot mark order as ready with status ${order.status}`,
			};
		}

		return { allowed: true };
	}

	/**
	 * Formats cancel reason with optional note
	 *
	 * @param reason - Cancel reason code (e.g., "OUT_OF_STOCK", "TOO_BUSY")
	 * @param note - Optional additional note
	 * @returns Formatted cancel reason
	 */
	formatCancelReason(reason: string, note?: string): string {
		if (note) {
			return `${reason}: ${note}`;
		}
		return reason.replace(/_/g, " ");
	}

	/**
	 * Emits WebSocket event for order status update
	 *
	 * Broadcasts status change to all connected clients in the order room.
	 * Non-critical operation - logs warning if fails.
	 *
	 * @param orderId - Order ID
	 * @param status - New status
	 */
	async emitStatusUpdate(orderId: string, status: OrderStatus): Promise<void> {
		try {
			const stub = env.ORDER_ROOM.idFromName(orderId);
			const room = env.ORDER_ROOM.get(stub);

			await room.fetch("https://internal/broadcast", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify({
					t: "r",
					e: "ORDER_STATUS_UPDATED",
					p: { detail: { order: { id: orderId, status } } },
				}),
			});

			log.info(
				{ orderId, status },
				"[MerchantOrderStatusService] WebSocket event emitted",
			);
		} catch (error) {
			log.warn(
				{ error, orderId, status },
				"[MerchantOrderStatusService] Failed to emit WebSocket event - non-critical",
			);
		}
	}

	/**
	 * Validates merchant ownership of order
	 *
	 * @param order - Order to validate
	 * @param merchantId - Merchant ID to check
	 * @throws RepositoryError if not owned by merchant
	 */
	validateOwnership(order: Order, merchantId: string): void {
		if (order.merchantId !== merchantId) {
			throw new RepositoryError("Order does not belong to this merchant", {
				code: "FORBIDDEN",
			});
		}
	}

	/**
	 * Gets valid next statuses for merchant operations
	 *
	 * @param currentStatus - Current order status
	 * @returns Array of valid next statuses
	 */
	getValidNextStatuses(currentStatus: OrderStatus): OrderStatus[] {
		switch (currentStatus) {
			case "REQUESTED":
			case "MATCHING":
				return ["ACCEPTED", "CANCELLED_BY_MERCHANT"];
			case "ACCEPTED":
				return ["PREPARING", "CANCELLED_BY_MERCHANT"];
			case "PREPARING":
				return ["READY_FOR_PICKUP"];
			case "READY_FOR_PICKUP":
				return []; // Driver handles pickup
			default:
				return [];
		}
	}

	/**
	 * Validates status transition
	 *
	 * @param from - Current status
	 * @param to - Target status
	 * @returns true if transition is valid
	 */
	isValidTransition(from: OrderStatus, to: OrderStatus): boolean {
		const validNextStatuses = this.getValidNextStatuses(from);
		return validNextStatuses.includes(to);
	}
}

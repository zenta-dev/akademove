import { env } from "cloudflare:workers";
import type { Order, OrderStatus } from "@repo/schema/order";
import type { MerchantEnvelope, OrderEnvelope } from "@repo/schema/ws";
import { RepositoryError } from "@/core/error";
import { logger } from "@/utils/logger";

/**
 * Maps order status to the appropriate WebSocket event for OrderRoom
 * These events are what the mobile clients (USER, DRIVER) listen for
 */
function getOrderRoomEventForStatus(
	status: OrderStatus,
): OrderEnvelope["e"] | null {
	switch (status) {
		case "ACCEPTED":
			return "MERCHANT_ACCEPTED";
		case "PREPARING":
			return "MERCHANT_PREPARING";
		case "READY_FOR_PICKUP":
			return "MERCHANT_READY";
		case "CANCELLED_BY_MERCHANT":
			return "MERCHANT_REJECTED";
		default:
			// For other statuses, use generic ORDER_STATUS_CHANGED
			return "ORDER_STATUS_CHANGED";
	}
}

/**
 * Maps order status to the appropriate WebSocket event for MerchantRoom
 * These events are for merchant dashboard sync across devices
 */
function getMerchantRoomEventForStatus(
	status: OrderStatus,
): MerchantEnvelope["e"] {
	switch (status) {
		case "CANCELLED_BY_MERCHANT":
		case "CANCELLED_BY_USER":
		case "CANCELLED_BY_DRIVER":
		case "CANCELLED_BY_SYSTEM":
			return "ORDER_CANCELLED";
		case "COMPLETED":
			return "ORDER_COMPLETED";
		default:
			return "ORDER_STATUS_CHANGED";
	}
}

/**
 * Service responsible for merchant order status management
 *
 * Handles:
 * - Order status validation (can accept/reject/prepare/ready)
 * - Status transition rules (REQUESTED → ACCEPTED → PREPARING → READY_FOR_PICKUP)
 * - WebSocket event emission for real-time updates to ALL roles
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
	 * Emits WebSocket events for order status update to ALL relevant rooms
	 *
	 * Broadcasts to:
	 * 1. OrderRoom (orderId) - For USER and DRIVER real-time updates
	 * 2. MerchantRoom (merchantId) - For merchant dashboard sync across devices
	 *
	 * Uses specific event names that match the schema and mobile client handlers:
	 * - MERCHANT_ACCEPTED, MERCHANT_PREPARING, MERCHANT_READY, MERCHANT_REJECTED
	 *
	 * Non-critical operation - logs warning if fails.
	 *
	 * @param order - Full order object with updated status
	 * @param cancelReason - Optional cancel reason for rejected orders
	 */
	async emitStatusUpdate(order: Order, cancelReason?: string): Promise<void> {
		const { id: orderId, status, merchantId } = order;

		// Broadcast to OrderRoom (for USER and DRIVER)
		await this.#emitToOrderRoom(order, cancelReason);

		// Broadcast to MerchantRoom (for merchant dashboard sync)
		if (merchantId) {
			await this.#emitToMerchantRoom(order, cancelReason);
		}

		logger.info(
			{ orderId, status, merchantId },
			"[MerchantOrderStatusService] WebSocket events emitted to all rooms",
		);
	}

	/**
	 * Emits event to OrderRoom for USER and DRIVER clients
	 */
	async #emitToOrderRoom(order: Order, cancelReason?: string): Promise<void> {
		try {
			const event = getOrderRoomEventForStatus(order.status);
			if (!event) {
				logger.warn(
					{ orderId: order.id, status: order.status },
					"[MerchantOrderStatusService] No OrderRoom event for status",
				);
				return;
			}

			const stub = env.ORDER_ROOM.idFromName(order.id);
			const room = env.ORDER_ROOM.get(stub);

			const payload: OrderEnvelope = {
				e: event,
				f: "s",
				t: "c",
				p: {
					detail: {
						order,
						payment: null,
						transaction: null,
					},
					...(cancelReason && { cancelReason }),
				},
			};

			await room.fetch("https://internal/broadcast", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(payload),
			});

			logger.debug(
				{ orderId: order.id, event, status: order.status },
				"[MerchantOrderStatusService] OrderRoom event emitted",
			);
		} catch (error) {
			logger.warn(
				{ error, orderId: order.id, status: order.status },
				"[MerchantOrderStatusService] Failed to emit OrderRoom event - non-critical",
			);
		}
	}

	/**
	 * Emits event to MerchantRoom for merchant dashboard sync
	 */
	async #emitToMerchantRoom(
		order: Order,
		cancelReason?: string,
	): Promise<void> {
		try {
			if (!order.merchantId) {
				return;
			}

			const event = getMerchantRoomEventForStatus(order.status);

			const stub = env.MERCHANT_ROOM.idFromName(order.merchantId);
			const room = env.MERCHANT_ROOM.get(stub);

			const payload: MerchantEnvelope = {
				e: event,
				f: "s",
				t: "c",
				p: {
					order,
					orderId: order.id,
					merchantId: order.merchantId,
					newStatus: order.status,
					...(cancelReason && { cancelReason }),
				},
			};

			await room.fetch("https://internal/broadcast", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(payload),
			});

			logger.debug(
				{ orderId: order.id, merchantId: order.merchantId, event },
				"[MerchantOrderStatusService] MerchantRoom event emitted",
			);
		} catch (error) {
			logger.warn(
				{ error, orderId: order.id, merchantId: order.merchantId },
				"[MerchantOrderStatusService] Failed to emit MerchantRoom event - non-critical",
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

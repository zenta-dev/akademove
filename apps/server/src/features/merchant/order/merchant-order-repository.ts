import { env } from "cloudflare:workers";
import type { Order, OrderStatus } from "@repo/schema/order";
import { eq } from "drizzle-orm";
import { BaseRepository } from "@/core/base";
import { RepositoryError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import { tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { OrderDatabase } from "@/core/tables/order";
import { log, toNumberSafe } from "@/utils";

export class MerchantOrderRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("order", kv, db);
	}

	/**
	 * Compose entity from database result
	 * Converts database types to schema types
	 */
	private composeEntity(item: OrderDatabase): Order {
		return {
			...item,
			driverId: item.driverId ?? undefined,
			merchantId: item.merchantId ?? undefined,
			note: item.note ?? undefined,
			basePrice: toNumberSafe(item.basePrice),
			totalPrice: toNumberSafe(item.totalPrice),
			tip: item.tip ? toNumberSafe(item.tip) : undefined,
			acceptedAt: item.acceptedAt ?? undefined,
			preparedAt: item.preparedAt ?? undefined,
			readyAt: item.readyAt ?? undefined,
			arrivedAt: item.arrivedAt ?? undefined,
			cancelReason: item.cancelReason ?? undefined,
			gender: item.gender ?? undefined,
			genderPreference: item.genderPreference ?? undefined,
			platformCommission: item.platformCommission
				? toNumberSafe(item.platformCommission)
				: undefined,
			driverEarning: item.driverEarning
				? toNumberSafe(item.driverEarning)
				: undefined,
			merchantCommission: item.merchantCommission
				? toNumberSafe(item.merchantCommission)
				: undefined,
		};
	}

	/**
	 * Emit WebSocket event for order status update
	 * Broadcasts status change to all connected clients in the order room
	 */
	async #emitOrderStatusUpdate(
		orderId: string,
		status: OrderStatus,
	): Promise<void> {
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
				"[MerchantOrderRepository] WebSocket event emitted",
			);
		} catch (error) {
			log.warn(
				{ error, orderId, status },
				"[MerchantOrderRepository] Failed to emit WebSocket event - non-critical",
			);
		}
	}

	/**
	 * Accept a food order
	 * Updates order status to ACCEPTED and sets acceptedAt timestamp
	 */
	async acceptOrder(
		orderId: string,
		merchantId: string,
		opts: WithTx,
	): Promise<Order> {
		try {
			// Verify order belongs to merchant
			const existing = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!existing) {
				throw new RepositoryError("Order not found", { code: "NOT_FOUND" });
			}

			if (existing.merchantId !== merchantId) {
				throw new RepositoryError("Order does not belong to this merchant", {
					code: "FORBIDDEN",
				});
			}

			if (existing.status !== "REQUESTED" && existing.status !== "MATCHING") {
				throw new RepositoryError(
					`Cannot accept order with status ${existing.status}`,
					{ code: "BAD_REQUEST" },
				);
			}

			// Update order status
			const [updated] = await opts.tx
				.update(tables.order)
				.set({
					status: "ACCEPTED",
					acceptedAt: new Date(),
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, orderId))
				.returning();

			if (!updated) {
				throw new RepositoryError("Failed to accept order");
			}

			log.info(
				{ orderId, merchantId, status: updated.status },
				"[MerchantOrderRepository] Order accepted",
			);

			// Invalidate cache and emit WebSocket event
			await Promise.allSettled([
				this.deleteCache(orderId),
				this.#emitOrderStatusUpdate(orderId, updated.status),
			]);

			return this.composeEntity(updated);
		} catch (error) {
			log.error(
				{ error, orderId, merchantId },
				"[MerchantOrderRepository] Failed to accept order",
			);
			throw this.handleError(error, "accept order");
		}
	}

	/**
	 * Reject a food order with reason
	 * Updates order status to CANCELLED_BY_MERCHANT
	 */
	async rejectOrder(
		orderId: string,
		merchantId: string,
		reason: string,
		note: string | undefined,
		opts: WithTx,
	): Promise<Order> {
		try {
			// Verify order belongs to merchant
			const existing = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!existing) {
				throw new RepositoryError("Order not found", { code: "NOT_FOUND" });
			}

			if (existing.merchantId !== merchantId) {
				throw new RepositoryError("Order does not belong to this merchant", {
					code: "FORBIDDEN",
				});
			}

			if (
				existing.status !== "REQUESTED" &&
				existing.status !== "MATCHING" &&
				existing.status !== "ACCEPTED"
			) {
				throw new RepositoryError(
					`Cannot reject order with status ${existing.status}`,
					{ code: "BAD_REQUEST" },
				);
			}

			// Format cancel reason
			const cancelReason = note
				? `${reason}: ${note}`
				: reason.replace(/_/g, " ");

			// Update order status
			const [updated] = await opts.tx
				.update(tables.order)
				.set({
					status: "CANCELLED_BY_MERCHANT",
					cancelReason,
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, orderId))
				.returning();

			if (!updated) {
				throw new RepositoryError("Failed to reject order");
			}

			log.info(
				{ orderId, merchantId, status: updated.status, reason },
				"[MerchantOrderRepository] Order rejected",
			);

			// Invalidate cache and emit WebSocket event
			// NOTE: Refund logic should be handled by payment service/handler
			await Promise.allSettled([
				this.deleteCache(orderId),
				this.#emitOrderStatusUpdate(orderId, updated.status),
			]);

			return this.composeEntity(updated);
		} catch (error) {
			log.error(
				{ error, orderId, merchantId },
				"[MerchantOrderRepository] Failed to reject order",
			);
			throw this.handleError(error, "reject order");
		}
	}

	/**
	 * Mark order as preparing
	 * Updates order status to PREPARING and sets preparedAt timestamp
	 */
	async markPreparing(
		orderId: string,
		merchantId: string,
		opts: WithTx,
	): Promise<Order> {
		try {
			// Verify order belongs to merchant
			const existing = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!existing) {
				throw new RepositoryError("Order not found", { code: "NOT_FOUND" });
			}

			if (existing.merchantId !== merchantId) {
				throw new RepositoryError("Order does not belong to this merchant", {
					code: "FORBIDDEN",
				});
			}

			if (existing.status !== "ACCEPTED") {
				throw new RepositoryError(
					`Cannot mark order as preparing with status ${existing.status}`,
					{ code: "BAD_REQUEST" },
				);
			}

			// Update order status
			const [updated] = await opts.tx
				.update(tables.order)
				.set({
					status: "PREPARING",
					preparedAt: new Date(),
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, orderId))
				.returning();

			if (!updated) {
				throw new RepositoryError("Failed to mark order as preparing");
			}

			log.info(
				{ orderId, merchantId, status: updated.status },
				"[MerchantOrderRepository] Order marked as preparing",
			);

			// Invalidate cache and emit WebSocket event to notify driver/user
			await Promise.allSettled([
				this.deleteCache(orderId),
				this.#emitOrderStatusUpdate(orderId, updated.status),
			]);

			return this.composeEntity(updated);
		} catch (error) {
			log.error(
				{ error, orderId, merchantId },
				"[MerchantOrderRepository] Failed to mark order as preparing",
			);
			throw this.handleError(error, "mark order as preparing");
		}
	}

	/**
	 * Mark order as ready for pickup
	 * Updates order status to READY_FOR_PICKUP and sets readyAt timestamp
	 */
	async markReady(
		orderId: string,
		merchantId: string,
		opts: WithTx,
	): Promise<Order> {
		try {
			// Verify order belongs to merchant
			const existing = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!existing) {
				throw new RepositoryError("Order not found", { code: "NOT_FOUND" });
			}

			if (existing.merchantId !== merchantId) {
				throw new RepositoryError("Order does not belong to this merchant", {
					code: "FORBIDDEN",
				});
			}

			if (existing.status !== "PREPARING") {
				throw new RepositoryError(
					`Cannot mark order as ready with status ${existing.status}`,
					{ code: "BAD_REQUEST" },
				);
			}

			// Update order status
			const [updated] = await opts.tx
				.update(tables.order)
				.set({
					status: "READY_FOR_PICKUP",
					readyAt: new Date(),
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, orderId))
				.returning();

			if (!updated) {
				throw new RepositoryError("Failed to mark order as ready");
			}

			log.info(
				{ orderId, merchantId, status: updated.status },
				"[MerchantOrderRepository] Order marked as ready",
			);

			// Invalidate cache and emit WebSocket event
			// NOTE: Push notification should be handled by notification service
			await Promise.allSettled([
				this.deleteCache(orderId),
				this.#emitOrderStatusUpdate(orderId, updated.status),
			]);

			return this.composeEntity(updated);
		} catch (error) {
			log.error(
				{ error, orderId, merchantId },
				"[MerchantOrderRepository] Failed to mark order as ready",
			);
			throw this.handleError(error, "mark order as ready");
		}
	}
}

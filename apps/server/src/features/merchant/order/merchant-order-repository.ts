import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import { eq } from "drizzle-orm";
import { BaseRepository } from "@/core/base";
import { RepositoryError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import { tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { OrderDatabase } from "@/core/tables/order";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
import { MerchantOrderStatusService } from "../services";

export class MerchantOrderRepository extends BaseRepository {
	private statusService: MerchantOrderStatusService;

	constructor(db: DatabaseService, kv: KeyValueService) {
		super("order", kv, db);
		this.statusService = new MerchantOrderStatusService();
	}

	/**
	 * Compose entity from database result
	 * Converts database types to schema types
	 */
	private composeEntity(item: OrderDatabase): Order {
		return {
			...item,
			driverId: item.driverId ?? undefined,
			completedDriverId: item.completedDriverId ?? undefined,
			merchantId: item.merchantId ?? undefined,
			pickupAddress: item.pickupAddress ?? undefined,
			dropoffAddress: item.dropoffAddress ?? undefined,
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
			couponId: item.couponId ?? undefined,
			couponCode: item.couponCode ?? undefined,
			discountAmount: item.discountAmount
				? toNumberSafe(item.discountAmount)
				: undefined,
			proofOfDeliveryUrl: item.proofOfDeliveryUrl ?? undefined,
			deliveryOtp: item.deliveryOtp ?? undefined,
			otpVerifiedAt: item.otpVerifiedAt ?? undefined,
			scheduledAt: item.scheduledAt ?? undefined,
			scheduledMatchingAt: item.scheduledMatchingAt ?? undefined,
			deliveryItemType: item.deliveryItemType ?? undefined,
			deliveryItemPhotoUrl: item.deliveryItemPhotoUrl ?? undefined,
		};
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
			// Get existing order
			const existing = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!existing) {
				throw new RepositoryError(m.error_order_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const order = this.composeEntity(existing);

			// Validate using service
			const validation = this.statusService.canAcceptOrder(order, merchantId);
			if (!validation.allowed) {
				throw new RepositoryError(validation.reason ?? "Cannot accept order", {
					code: validation.reason?.includes("belong")
						? "FORBIDDEN"
						: "BAD_REQUEST",
				});
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
				throw new RepositoryError(m.error_failed_accept_order());
			}

			logger.info(
				{ orderId, merchantId, status: updated.status },
				"[MerchantOrderRepository] Order accepted",
			);

			const composedOrder = this.composeEntity(updated);

			// Invalidate cache and emit WebSocket event to all roles (USER, DRIVER, MERCHANT)
			await Promise.allSettled([
				this.deleteCache(orderId),
				this.statusService.emitStatusUpdate(composedOrder),
			]);

			return composedOrder;
		} catch (error) {
			logger.error(
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
			// Get existing order
			const existing = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!existing) {
				throw new RepositoryError(m.error_order_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const order = this.composeEntity(existing);

			// Validate using service
			const validation = this.statusService.canRejectOrder(order, merchantId);
			if (!validation.allowed) {
				throw new RepositoryError(validation.reason ?? "Cannot reject order", {
					code: validation.reason?.includes("belong")
						? "FORBIDDEN"
						: "BAD_REQUEST",
				});
			}

			// Format cancel reason using service
			const cancelReason = this.statusService.formatCancelReason(reason, note);

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
				throw new RepositoryError(m.error_failed_reject_order());
			}

			logger.info(
				{ orderId, merchantId, status: updated.status, reason },
				"[MerchantOrderRepository] Order rejected",
			);

			const composedOrder = this.composeEntity(updated);

			// Invalidate cache and emit WebSocket event to all roles (USER, DRIVER, MERCHANT)
			// NOTE: Refund logic should be handled by payment service/handler
			await Promise.allSettled([
				this.deleteCache(orderId),
				this.statusService.emitStatusUpdate(composedOrder, cancelReason),
			]);

			return composedOrder;
		} catch (error) {
			logger.error(
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
			// Get existing order
			const existing = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!existing) {
				throw new RepositoryError(m.error_order_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const order = this.composeEntity(existing);

			// Validate using service
			const validation = this.statusService.canMarkPreparing(order, merchantId);
			if (!validation.allowed) {
				throw new RepositoryError(
					validation.reason ?? "Cannot mark as preparing",
					{
						code: validation.reason?.includes("belong")
							? "FORBIDDEN"
							: "BAD_REQUEST",
					},
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
				throw new RepositoryError(m.error_failed_mark_order_preparing());
			}

			logger.info(
				{ orderId, merchantId, status: updated.status },
				"[MerchantOrderRepository] Order marked as preparing",
			);

			const composedOrder = this.composeEntity(updated);

			// Invalidate cache and emit WebSocket event to all roles (USER, DRIVER, MERCHANT)
			await Promise.allSettled([
				this.deleteCache(orderId),
				this.statusService.emitStatusUpdate(composedOrder),
			]);

			return composedOrder;
		} catch (error) {
			logger.error(
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
			// Get existing order
			const existing = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!existing) {
				throw new RepositoryError(m.error_order_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const order = this.composeEntity(existing);

			// Validate using service
			const validation = this.statusService.canMarkReady(order, merchantId);
			if (!validation.allowed) {
				throw new RepositoryError(validation.reason ?? "Cannot mark as ready", {
					code: validation.reason?.includes("belong")
						? "FORBIDDEN"
						: "BAD_REQUEST",
				});
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
				throw new RepositoryError(m.error_failed_mark_order_ready());
			}

			logger.info(
				{ orderId, merchantId, status: updated.status },
				"[MerchantOrderRepository] Order marked as ready",
			);

			const composedOrder = this.composeEntity(updated);

			// Invalidate cache and emit WebSocket event to all roles (USER, DRIVER, MERCHANT)
			// NOTE: Push notification should be handled by notification service
			await Promise.allSettled([
				this.deleteCache(orderId),
				this.statusService.emitStatusUpdate(composedOrder),
			]);

			return composedOrder;
		} catch (error) {
			logger.error(
				{ error, orderId, merchantId },
				"[MerchantOrderRepository] Failed to mark order as ready",
			);
			throw this.handleError(error, "mark order as ready");
		}
	}
}

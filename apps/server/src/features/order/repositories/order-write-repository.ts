import { m } from "@repo/i18n";
import type { Order, OrderStatus, UpdateOrder } from "@repo/schema/order";
import { eq } from "drizzle-orm";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { log, toStringNumberSafe } from "@/utils";
import type { DeliveryProofService, OrderStateService } from "../services";
import { OrderBaseRepository } from "./order-base-repository";

/**
 * OrderWriteRepository - Handles basic write operations for orders
 *
 * Responsibilities:
 * - Update order fields
 * - Remove orders
 * - Validate state transitions
 * - Generate delivery OTP when needed
 * - Record status changes in audit trail
 */
export class OrderWriteRepository extends OrderBaseRepository {
	readonly #stateService: OrderStateService;
	readonly #deliveryProofService: DeliveryProofService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		stateService: OrderStateService,
		deliveryProofService: DeliveryProofService,
	) {
		super(db, kv);
		this.#stateService = stateService;
		this.#deliveryProofService = deliveryProofService;
	}

	/**
	 * Update an order with state transition validation
	 */
	async update(
		id: string,
		item: UpdateOrder,
		opts: WithTx & {
			changedBy?: string;
			changedByRole?:
				| "USER"
				| "DRIVER"
				| "MERCHANT"
				| "OPERATOR"
				| "ADMIN"
				| "SYSTEM";
			reason?: string;
		},
	): Promise<Order> {
		try {
			const existing = await this.getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`Order with id "${id}" not found`);

			// Validate status transition using OrderStateService
			const newStatus = item.status;
			const isStatusChange = newStatus && newStatus !== existing.status;
			if (isStatusChange) {
				this.#stateService.validateTransition(existing.status, newStatus);
			}

			// Generate OTP for delivery proof if order is ARRIVING or IN_TRIP and requires OTP
			let deliveryOtp = item.deliveryOtp;
			const shouldGenerateOtp =
				item.status &&
				(item.status === "ARRIVING" || item.status === "IN_TRIP") &&
				existing.status !== "ARRIVING" &&
				existing.status !== "IN_TRIP" &&
				!existing.deliveryOtp &&
				(await this.#deliveryProofService.requiresOTP(existing.totalPrice));
			if (shouldGenerateOtp) {
				deliveryOtp = this.#deliveryProofService.generateOTP();
				log.info(
					{ orderId: id, totalPrice: existing.totalPrice },
					"[OrderWriteRepository] Generated OTP for high-value delivery order",
				);
			}

			const [operation] = await opts.tx
				.update(tables.order)
				.set({
					...item,
					deliveryOtp: deliveryOtp ?? item.deliveryOtp,
					basePrice: existing.basePrice
						? toStringNumberSafe(existing.basePrice)
						: undefined,
					totalPrice: item.totalPrice
						? toStringNumberSafe(item.totalPrice)
						: undefined,
					tip: item.tip ? toStringNumberSafe(item.tip) : undefined,
					acceptedAt: existing.acceptedAt
						? new Date(existing.acceptedAt)
						: null,
					discountAmount: item.discountAmount
						? toStringNumberSafe(item.discountAmount)
						: undefined,
					platformCommission: item.platformCommission
						? toStringNumberSafe(item.platformCommission)
						: undefined,
					driverEarning: item.driverEarning
						? toStringNumberSafe(item.driverEarning)
						: undefined,
					merchantCommission: item.merchantCommission
						? toStringNumberSafe(item.merchantCommission)
						: undefined,
					arrivedAt: existing.arrivedAt ? new Date(existing.arrivedAt) : null,
					createdAt: new Date(existing.createdAt),
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, id))
				.returning({ id: tables.order.id });

			// Record status change in audit trail
			if (isStatusChange && newStatus) {
				await this.#recordStatusHistory(
					id,
					existing.status,
					newStatus,
					opts.changedBy,
					opts.changedByRole,
					opts.reason ?? item.cancelReason,
					opts,
				);
			}

			const result = await this.getFromDB(operation.id, opts);
			if (!result) throw new RepositoryError(m.error_failed_update_order());

			await this.setCache(id, result, {
				expirationTtl: CACHE_TTLS["1h"],
			});
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	/**
	 * Record a status change in the order status history table
	 */
	async #recordStatusHistory(
		orderId: string,
		previousStatus: OrderStatus,
		newStatus: OrderStatus,
		changedBy?: string,
		changedByRole?:
			| "USER"
			| "DRIVER"
			| "MERCHANT"
			| "OPERATOR"
			| "ADMIN"
			| "SYSTEM",
		reason?: string,
		opts?: WithTx,
	): Promise<void> {
		try {
			await (opts?.tx ?? this.db).insert(tables.orderStatusHistory).values({
				orderId,
				previousStatus,
				newStatus,
				changedBy,
				changedByRole: changedByRole ?? "SYSTEM",
				reason,
				changedAt: new Date(),
			});

			log.debug(
				{ orderId, previousStatus, newStatus, changedBy, changedByRole },
				"[OrderWriteRepository] Status change recorded in audit trail",
			);
		} catch (error) {
			// Log but don't fail the main operation if audit trail fails
			log.error(
				{ error, orderId, previousStatus, newStatus },
				"[OrderWriteRepository] Failed to record status history",
			);
		}
	}

	/**
	 * Remove an order by ID
	 */
	async remove(id: string, opts: WithTx): Promise<void> {
		try {
			const result = await opts.tx
				.delete(tables.order)
				.where(eq(tables.order.id, id))
				.returning({ id: tables.order.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "remove");
		}
	}
}

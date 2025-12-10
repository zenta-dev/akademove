import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import type { UserRole } from "@repo/schema/user";
import { eq } from "drizzle-orm";
import { RepositoryError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { log, toNumberSafe } from "@/utils";
import {
	DriverCancellationService,
	OrderCancellationService,
	OrderRefundService,
	type OrderStateService,
} from "../services";
import { OrderBaseRepository } from "./order-base-repository";
import type { OrderWriteRepository } from "./order-write-repository";

/**
 * OrderCancellationRepository - Handles order cancellation logic
 *
 * Responsibilities:
 * - Cancel orders with penalty calculation
 * - Process refunds
 * - Track driver cancellations
 * - Handle driver suspension for excessive cancellations
 */
export class OrderCancellationRepository extends OrderBaseRepository {
	readonly #stateService: OrderStateService;
	readonly #writeRepo: OrderWriteRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		stateService: OrderStateService,
		writeRepo: OrderWriteRepository,
	) {
		super(db, kv);
		this.#stateService = stateService;
		this.#writeRepo = writeRepo;
	}

	/**
	 * Cancels an order with penalty logic based on SRS requirements:
	 * - User cancels: No penalty before driver acceptance, 10% fee after acceptance
	 * - Driver cancels: Warning and suspension tracking after 3 cancellations/day
	 * - System/Merchant cancels: Full refund
	 */
	async cancelOrder(
		orderId: string,
		userId: string,
		userRole: UserRole,
		reason?: string,
		opts: WithTx = {} as WithTx,
	): Promise<Order> {
		if (!opts.tx) {
			throw new RepositoryError(
				"cancelOrder must be called within a transaction",
				{ code: "BAD_REQUEST" },
			);
		}

		try {
			// Get order details
			const order = await this.getFromDB(orderId, opts);
			if (!order) {
				throw new RepositoryError(`Order with id "${orderId}" not found`, {
					code: "NOT_FOUND",
				});
			}

			// Use OrderCancellationService to determine cancellation status
			const cancelStatus =
				OrderCancellationService.determineCancellationStatus(userRole);

			// Validate status transition
			this.#stateService.validateTransition(order.status, cancelStatus);

			// Fetch business configuration for cancellation fee rates
			const businessConfig = await BusinessConfigurationService.getConfig(
				this.db,
				this.kv,
			);

			// Use OrderCancellationService to calculate refund with penalty logic
			const { refundAmount, penaltyAmount } =
				OrderCancellationService.calculateRefund(
					order.totalPrice,
					cancelStatus,
					order.status,
					businessConfig,
					order.driverId,
				);

			// Log penalty if applied
			if (
				OrderCancellationService.shouldApplyPenalty(
					cancelStatus,
					order.status,
					order.driverId,
				)
			) {
				log.info(
					{
						orderId: order.id,
						userId: order.userId,
						totalPrice: order.totalPrice,
						penaltyAmount: toNumberSafe(penaltyAmount),
						refundAmount: toNumberSafe(refundAmount),
					},
					"[OrderCancellationRepository] User cancellation penalty applied (10%)",
				);
			}

			// Handle driver cancellation - track and suspend if excessive
			if (cancelStatus === "CANCELLED_BY_DRIVER" && order.driverId) {
				await this.#handleDriverCancellation(order.driverId, order.id, opts);
			}

			// Reset driver's isTakingOrder flag if order had an assigned driver
			// This allows the driver to accept new orders after cancellation
			if (order.driverId) {
				await opts.tx
					.update(tables.driver)
					.set({ isTakingOrder: false })
					.where(eq(tables.driver.id, order.driverId));

				log.info(
					{ driverId: order.driverId, orderId: order.id },
					"[OrderCancellationRepository] Reset driver isTakingOrder flag after order cancellation",
				);
			}

			// Use OrderRefundService to process refund
			await OrderRefundService.processRefund(
				order.id,
				order.userId,
				refundAmount,
				penaltyAmount,
				opts,
			);

			// Update order status
			const updatedOrder = await this.#writeRepo.update(
				orderId,
				{
					status: cancelStatus,
					cancelReason: reason,
				},
				opts,
			);

			log.info(
				{
					orderId: order.id,
					status: cancelStatus,
					role: userRole,
					refundAmount: toNumberSafe(refundAmount),
				},
				m.server_order_cancelled(),
			);

			return updatedOrder;
		} catch (error) {
			log.error(
				{
					error,
					orderId,
					userId,
					userRole,
				},
				"[OrderCancellationRepository] Failed to cancel order - transaction will be rolled back",
			);
			throw this.handleError(error, "cancel");
		}
	}

	/**
	 * Handle driver cancellation tracking and suspension
	 */
	async #handleDriverCancellation(
		driverId: string,
		orderId: string,
		opts: WithTx,
	): Promise<void> {
		// Get driver details
		const driver = await opts.tx.query.driver.findFirst({
			where: (f, op) => op.eq(f.id, driverId),
		});

		if (!driver) return;

		// Use DriverCancellationService to prepare cancellation update
		const cancellationUpdate =
			DriverCancellationService.prepareCancellationUpdate(
				driver.cancellationCount,
				driver.lastCancellationDate,
			);

		// Update driver cancellation tracking
		await opts.tx
			.update(tables.driver)
			.set(cancellationUpdate)
			.where(eq(tables.driver.id, driverId));

		// Check if driver should be suspended
		if (
			DriverCancellationService.shouldSuspendDriver(
				cancellationUpdate.cancellationCount,
			)
		) {
			// Use service to prepare suspension data
			const suspensionData = DriverCancellationService.prepareSuspensionData();

			await opts.tx
				.update(tables.driver)
				.set(suspensionData)
				.where(eq(tables.driver.id, driverId));

			log.warn(
				{
					driverId,
					cancellationCount: cancellationUpdate.cancellationCount,
					orderId,
				},
				"[OrderCancellationRepository] Driver suspended due to excessive cancellations (3/day)",
			);
		} else {
			log.info(
				{
					driverId,
					cancellationCount: cancellationUpdate.cancellationCount,
					orderId,
				},
				"[OrderCancellationRepository] Driver cancellation recorded - warning issued",
			);
		}
	}
}

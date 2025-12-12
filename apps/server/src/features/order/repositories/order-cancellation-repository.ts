import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import type { UserRole } from "@repo/schema/user";
import type { OrderEnvelope } from "@repo/schema/ws";
import { eq } from "drizzle-orm";
import { RepositoryError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { OrderQueueService } from "@/core/services/queue";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
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
	 * - Driver cancels: Re-match with other drivers (no refund until timeout)
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

			// Handle driver cancellation - track and suspend if excessive
			if (cancelStatus === "CANCELLED_BY_DRIVER" && order.driverId) {
				await this.#handleDriverCancellation(order.driverId, order.id, opts);

				// Reset driver's isTakingOrder flag
				await opts.tx
					.update(tables.driver)
					.set({ isTakingOrder: false })
					.where(eq(tables.driver.id, order.driverId));

				logger.info(
					{ driverId: order.driverId, orderId: order.id },
					"[OrderCancellationRepository] Reset driver isTakingOrder flag after driver cancellation",
				);

				// Re-match with other drivers instead of cancelling
				// This allows the order to be offered to other drivers
				return await this.#retryMatchingAfterDriverCancel(
					order,
					order.driverId,
					reason,
					opts,
				);
			}

			// For non-driver cancellations, process normally with refund
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
				logger.info(
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

			// Reset driver's isTakingOrder flag if order had an assigned driver
			// This allows the driver to accept new orders after cancellation
			if (order.driverId) {
				await opts.tx
					.update(tables.driver)
					.set({ isTakingOrder: false })
					.where(eq(tables.driver.id, order.driverId));

				logger.info(
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

			logger.info(
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
			logger.error(
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
	 * Retry matching after driver cancellation
	 *
	 * Instead of refunding and cancelling, this:
	 * 1. Resets the order status to MATCHING
	 * 2. Clears the assigned driver
	 * 3. Re-enqueues driver matching with the cancelled driver excluded
	 * 4. Notifies the user via WebSocket that we're finding a new driver
	 */
	async #retryMatchingAfterDriverCancel(
		order: Order,
		cancelledDriverId: string,
		reason?: string,
		opts?: WithTx,
	): Promise<Order> {
		// Get existing excluded drivers from order metadata (if any previous retries)
		const existingExcludedDrivers: string[] = [];

		// Add the driver who just cancelled
		const excludedDriverIds = [
			...new Set([...existingExcludedDrivers, cancelledDriverId]),
		];

		// Update order: reset to MATCHING status and clear driver assignment
		// Use empty string '' as sentinel to clear fields to null in database
		const updatedOrder = await this.#writeRepo.update(
			order.id,
			{
				status: "MATCHING",
				driverId: "", // Clear driver assignment (empty string = null in update)
				cancelReason: "", // Clear any previous cancel reason (empty string = null in update)
			},
			{
				...opts,
				changedByRole: "SYSTEM",
				reason: `Re-matching after driver cancellation: ${reason ?? "Driver cancelled"}`,
			} as WithTx,
		);

		// Fetch driver matching config from database
		const matchingConfig =
			await BusinessConfigurationService.getDriverMatchingConfig(
				this.db,
				this.kv,
			);

		// Re-enqueue driver matching with excluded drivers
		await OrderQueueService.enqueueDriverMatching({
			orderId: order.id,
			pickupLocation: order.pickupLocation,
			orderType: order.type,
			genderPreference: order.genderPreference ?? undefined,
			userGender: order.gender ?? undefined,
			initialRadiusKm: matchingConfig.initialRadiusKm,
			maxRadiusKm: matchingConfig.maxRadiusKm,
			maxMatchingDurationMinutes: matchingConfig.timeoutMinutes,
			currentAttempt: 1,
			maxExpansionAttempts: Math.ceil(
				Math.log(matchingConfig.maxRadiusKm / matchingConfig.initialRadiusKm) /
					Math.log(1 + matchingConfig.expansionRate),
			),
			expansionRate: matchingConfig.expansionRate,
			matchingIntervalSeconds: matchingConfig.intervalSeconds,
			broadcastLimit: matchingConfig.broadcastLimit,
			maxCancellationsPerDay: matchingConfig.maxCancellationsPerDay,
			excludedDriverIds,
			isRetry: true,
		});

		// Enqueue a new timeout job for the retry matching
		// The new timeout starts fresh from now (15 minutes from retry)
		try {
			const businessConfig = await BusinessConfigurationService.getConfig(
				this.db,
				this.kv,
			);
			const timeoutMinutes = businessConfig.driverMatchingTimeoutMinutes;
			const timeoutSeconds = timeoutMinutes * 60;

			await OrderQueueService.enqueueOrderTimeout(
				{
					orderId: order.id,
					userId: order.userId,
					totalPrice: order.totalPrice,
					timeoutReason: `No driver found within ${timeoutMinutes} minutes after driver cancellation`,
					processRefund: true,
				},
				timeoutSeconds,
			);

			logger.info(
				{ orderId: order.id, timeoutMinutes },
				"[OrderCancellationRepository] New timeout job enqueued after driver cancel re-match",
			);
		} catch (queueError) {
			// Log but don't fail - cron fallback will handle stuck orders
			logger.error(
				{ error: queueError, orderId: order.id },
				"[OrderCancellationRepository] Failed to enqueue new timeout job - cron will handle",
			);
		}

		// Broadcast DRIVER_CANCELLED_REMATCHING event to notify user via WebSocket
		try {
			const roomStub = OrderBaseRepository.getRoomStubByName(order.id);
			const retryPayload: OrderEnvelope = {
				e: "DRIVER_CANCELLED_REMATCHING",
				f: "s",
				t: "c",
				tg: "USER",
				p: {
					detail: {
						order: updatedOrder,
						payment: null,
						transaction: null,
					},
					retryInfo: {
						orderId: order.id,
						cancelledDriverId,
						excludedDriverCount: excludedDriverIds.length,
						reason: reason ?? "Driver cancelled the order",
					},
				},
			};
			await roomStub.broadcast(retryPayload);

			logger.info(
				{
					orderId: order.id,
					userId: order.userId,
					event: "DRIVER_CANCELLED_REMATCHING",
				},
				"[OrderCancellationRepository] Broadcasted retry status to user",
			);
		} catch (error) {
			// Log but don't fail the transaction if WebSocket broadcast fails
			logger.error(
				{ error, orderId: order.id },
				"[OrderCancellationRepository] Failed to broadcast retry status via WebSocket",
			);
		}

		logger.info(
			{
				orderId: order.id,
				cancelledDriverId,
				excludedDriverIds,
				reason,
			},
			"[OrderCancellationRepository] Driver cancelled - re-matching with other drivers",
		);

		return updatedOrder;
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

			logger.warn(
				{
					driverId,
					cancellationCount: cancellationUpdate.cancellationCount,
					orderId,
				},
				"[OrderCancellationRepository] Driver suspended due to excessive cancellations (3/day)",
			);
		} else {
			logger.info(
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

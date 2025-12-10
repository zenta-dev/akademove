import { m } from "@repo/i18n";
import type {
	Order,
	PlaceScheduledOrder,
	PlaceScheduledOrderResponse,
	UpdateScheduledOrder,
} from "@repo/schema/order";
import { OrderKeySchema } from "@repo/schema/order";
import Decimal from "decimal.js";
import { and, count, eq, lt, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	OrderByOperation,
	UnifiedListResult,
	WithTx,
	WithUserId,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { BusinessConfigurationService } from "@/features/configuration/services";
import type {
	ChargePayload,
	PaymentRepository,
} from "@/features/payment/payment-repository";
import { toStringNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
import type { OrderListQuery } from "../order-spec";
import {
	OrderCouponService,
	OrderItemPreparationService,
	OrderRefundService,
	OrderSchedulingService,
	OrderValidationService,
} from "../services";
import { OrderBaseRepository } from "./order-base-repository";
import type { OrderReadRepository } from "./order-read-repository";

/**
 * ScheduledOrderRepository - Handles scheduled order operations
 *
 * Responsibilities:
 * - Place scheduled orders
 * - List scheduled orders
 * - Update/reschedule orders
 * - Cancel scheduled orders with penalty logic
 */
export class ScheduledOrderRepository extends OrderBaseRepository {
	readonly #paymentRepo: PaymentRepository;
	readonly #readRepo: OrderReadRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		paymentRepo: PaymentRepository,
		readRepo: OrderReadRepository,
	) {
		super(db, kv);
		this.#paymentRepo = paymentRepo;
		this.#readRepo = readRepo;
	}

	/**
	 * Place a scheduled order
	 * Creates an order with SCHEDULED status and calculates the matching activation time
	 */
	async placeScheduledOrder(
		params: PlaceScheduledOrder & WithUserId,
		opts: WithTx,
	): Promise<PlaceScheduledOrderResponse> {
		try {
			// Validate scheduled time
			OrderSchedulingService.validateScheduledTime(params.scheduledAt);

			// Calculate when matching should begin
			const scheduledMatchingAt = OrderSchedulingService.calculateMatchingTime(
				params.scheduledAt,
			);

			logger.debug(
				{
					userId: params.userId,
					type: params.type,
					scheduledAt: params.scheduledAt,
					scheduledMatchingAt,
				},
				"[ScheduledOrderRepository] Starting scheduled order placement",
			);

			// Validate required parameters
			OrderValidationService.validatePlaceOrderParams(params);

			// Extract menu item IDs
			const itemIds = OrderValidationService.extractMenuItemIds(params.items);

			// Fetch required data in parallel
			const [estimate, user, menus] = await Promise.all([
				this.#readRepo.estimate(params),
				opts.tx.query.user.findFirst({
					columns: { name: true, email: true, phone: true },
					where: (f, op) => op.eq(f.id, params.userId),
				}),
				itemIds?.length
					? opts.tx.query.merchantMenu.findMany({
							with: {
								merchant: {
									columns: {},
									with: { user: { columns: { id: true } } },
								},
							},
							where: (f, op) => op.inArray(f.id, itemIds),
						})
					: Promise.resolve([]),
			]);

			// Calculate menu items total for FOOD orders
			const menuItemsTotal =
				params.type === "FOOD"
					? OrderItemPreparationService.calculateMenuItemsTotal(
							menus,
							params.items,
						)
					: 0;

			// Total cost = delivery fee (from estimate) + menu items total
			const baseTotalCost = estimate.totalCost + menuItemsTotal;

			// Apply coupon logic
			let finalTotalCost = baseTotalCost;
			let couponId: string | undefined;
			let couponCode: string | undefined;
			let discountAmount = 0;
			let autoAppliedCoupon:
				| { code: string; discountAmount: number }
				| undefined;

			const merchantId = OrderValidationService.getMerchantId(menus);

			if (params.couponCode) {
				const couponResult = await OrderCouponService.validateAndApplyCoupon(
					params.couponCode,
					baseTotalCost,
					params.userId,
					this.db,
					this.kv,
				);

				couponId = couponResult.couponId;
				couponCode = couponResult.couponCode;
				discountAmount = couponResult.discountAmount;
				finalTotalCost = couponResult.finalTotalCost;
			} else {
				const autoCouponResult = await OrderCouponService.getAndApplyBestCoupon(
					baseTotalCost,
					params.userId,
					params.type,
					this.db,
					this.kv,
					merchantId,
				);

				if (autoCouponResult.autoApplied) {
					couponId = autoCouponResult.couponId;
					couponCode = autoCouponResult.couponCode;
					discountAmount = autoCouponResult.discountAmount;
					finalTotalCost = autoCouponResult.finalTotalCost;
					autoAppliedCoupon = {
						code: autoCouponResult.couponCode ?? "",
						discountAmount: autoCouponResult.discountAmount,
					};
				}
			}

			if (!user)
				throw new RepositoryError(`User ${params.userId} not found`, {
					code: "NOT_FOUND",
				});

			// Validate menu items
			OrderValidationService.validateMenuItems(menus, itemIds);
			OrderValidationService.validateSingleMerchant(menus);

			const now = new Date();

			const safeTotalCost = toStringNumberSafe(finalTotalCost);
			const baseFare = toStringNumberSafe(estimate.config.baseFare);
			const safeDiscountAmount =
				discountAmount > 0 ? toStringNumberSafe(discountAmount) : undefined;

			// Create the order with SCHEDULED status
			const [orderRow] = await opts.tx
				.insert(tables.order)
				.values({
					id: v7(),
					userId: params.userId,
					merchantId,
					type: params.type,
					status: "SCHEDULED",
					note: params.note,
					pickupLocation: params.pickupLocation,
					dropoffLocation: params.dropoffLocation,
					distanceKm: estimate.distanceKm,
					basePrice: baseFare,
					totalPrice: safeTotalCost,
					couponId,
					couponCode,
					discountAmount: safeDiscountAmount,
					scheduledAt: params.scheduledAt,
					scheduledMatchingAt,
					requestedAt: now,
					createdAt: now,
					updatedAt: now,
				})
				.returning({ id: tables.order.id });

			// Insert order items
			await OrderItemPreparationService.insertOrderItems(
				orderRow.id,
				menus,
				params.items,
				opts,
			);

			// Process payment
			const chargePayload: ChargePayload = {
				transactionType: "PAYMENT",
				amount: finalTotalCost,
				method: params.payment.method,
				provider: params.payment.provider,
				userId: params.userId,
				orderType: params.type,
				metadata: {
					orderId: orderRow.id,
					customerId: params.userId,
					scheduled: true,
					scheduledAt: params.scheduledAt.toISOString(),
					...(couponCode && { couponCode, discountAmount }),
				},
			};

			if (
				params.payment.bankProvider &&
				params.payment.method === "BANK_TRANSFER"
			) {
				chargePayload.bank = params.payment.bankProvider;
				const phoneNumber = user.phone?.number;
				if (phoneNumber) chargePayload.va_number = `${phoneNumber}`;
			}

			const { transaction, payment } = await this.#paymentRepo.charge(
				chargePayload,
				opts,
			);

			const order = await this.getFromDB(orderRow.id, opts);
			if (!order)
				throw new RepositoryError(m.error_failed_retrieve_placed_order());

			// Cache the order
			await Promise.allSettled([
				this.setCache(order.id, order, {
					expirationTtl: CACHE_TTLS["1h"],
				}),
				this.deleteCache("count"),
			]);

			// Record coupon usage
			if (couponId && discountAmount > 0) {
				await OrderCouponService.recordCouponUsage(
					couponId,
					order.id,
					params.userId,
					discountAmount,
					this.db,
					this.kv,
					opts,
				);
			}

			logger.info(
				{
					orderId: order.id,
					userId: params.userId,
					type: params.type,
					status: order.status,
					scheduledAt: params.scheduledAt,
					scheduledMatchingAt,
				},
				"[ScheduledOrderRepository] Scheduled order placed successfully",
			);

			return { order, payment, transaction, autoAppliedCoupon };
		} catch (err) {
			logger.error(
				{
					error: err,
					userId: params.userId,
					type: params.type,
					scheduledAt: params.scheduledAt,
				},
				"[ScheduledOrderRepository] Failed to place scheduled order - transaction will be rolled back",
			);
			throw this.handleError(err, "placeScheduledOrder");
		}
	}

	/**
	 * List scheduled orders for a user
	 */
	async listScheduledOrders(
		query: OrderListQuery & { userId: string },
		opts?: WithTx,
	): Promise<UnifiedListResult<Order>> {
		const {
			cursor,
			page = 1,
			limit = 10,
			sortBy,
			order = "asc",
			userId,
			mode = "offset",
		} = query;

		try {
			const tx = opts?.tx ?? this.db;

			const orderBy = (
				f: typeof tables.order._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = OrderKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.scheduledAt;
					return op[order](field);
				}
				// Default sort by scheduledAt for scheduled orders
				return op[order](f.scheduledAt);
			};

			const withx = {
				user: { columns: { name: true } },
				driver: {
					columns: {},
					with: { user: { columns: { name: true } } },
				},
				merchant: { columns: { name: true } },
			} as const;

			const clauses: SQL[] = [
				eq(tables.order.userId, userId),
				eq(tables.order.status, "SCHEDULED"),
			];

			if (mode === "cursor") {
				if (cursor) clauses.push(lt(tables.order.id, cursor));
				const res = await tx.query.order.findMany({
					with: withx,
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const mapped = res.map(OrderBaseRepository.composeEntity);
				const hasMore = mapped.length > limit;
				const rows = hasMore ? mapped.slice(0, limit) : mapped;
				const nextCursor = hasMore ? mapped[mapped.length - 1].id : undefined;

				return { rows, pagination: { hasMore, nextCursor } };
			}

			const offset = (page - 1) * limit;

			const result = await tx.query.order.findMany({
				with: withx,
				where: (_f, op) => op.and(...clauses),
				orderBy,
				offset,
				limit,
			});

			const rows = result.map(OrderBaseRepository.composeEntity);

			// Get total count for scheduled orders
			const [countResult] = await tx
				.select({ count: count(tables.order.id) })
				.from(tables.order)
				.where(
					and(
						eq(tables.order.userId, userId),
						eq(tables.order.status, "SCHEDULED"),
					),
				);

			const totalCount = countResult?.count ?? 0;
			const totalPages = Math.ceil(totalCount / limit);

			return { rows, pagination: { totalPages } };
		} catch (error) {
			this.handleError(error, "listScheduledOrders");
			return { rows: [] };
		}
	}

	/**
	 * Update a scheduled order (reschedule)
	 */
	async updateScheduledOrder(
		id: string,
		item: UpdateScheduledOrder,
		opts: WithTx,
	): Promise<Order> {
		try {
			const existing = await this.getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`Order with id "${id}" not found`, {
					code: "NOT_FOUND",
				});

			// Verify order is still in SCHEDULED status
			if (existing.status !== "SCHEDULED") {
				throw new RepositoryError(
					"Cannot update order that is no longer in SCHEDULED status",
					{ code: "BAD_REQUEST" },
				);
			}

			// If rescheduling, validate the new time
			let scheduledMatchingAt = existing.scheduledMatchingAt;
			if (item.scheduledAt && existing.scheduledAt) {
				OrderSchedulingService.validateReschedule(
					new Date(existing.scheduledAt),
					item.scheduledAt,
				);
				scheduledMatchingAt = OrderSchedulingService.calculateMatchingTime(
					item.scheduledAt,
				);
			}

			const [operation] = await opts.tx
				.update(tables.order)
				.set({
					scheduledAt: item.scheduledAt ?? existing.scheduledAt,
					scheduledMatchingAt:
						scheduledMatchingAt ?? existing.scheduledMatchingAt,
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, id))
				.returning({ id: tables.order.id });

			const result = await this.getFromDB(operation.id, opts);
			if (!result)
				throw new RepositoryError(m.error_failed_update_order(), {
					code: "INTERNAL_SERVER_ERROR",
				});

			await this.setCache(id, result, {
				expirationTtl: CACHE_TTLS["1h"],
			});

			logger.info(
				{
					orderId: id,
					newScheduledAt: item.scheduledAt,
					newMatchingAt: scheduledMatchingAt,
				},
				"[ScheduledOrderRepository] Scheduled order updated",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "updateScheduledOrder");
		}
	}

	/**
	 * Cancel a scheduled order
	 * Handles refund based on timing (free if before matching time)
	 */
	async cancelScheduledOrder(
		orderId: string,
		userId: string,
		reason?: string,
		opts: WithTx = {} as WithTx,
	): Promise<Order> {
		if (!opts.tx) {
			throw new RepositoryError(
				"cancelScheduledOrder must be called within a transaction",
				{ code: "BAD_REQUEST" },
			);
		}

		try {
			const order = await this.getFromDB(orderId, opts);
			if (!order) {
				throw new RepositoryError(`Order with id "${orderId}" not found`, {
					code: "NOT_FOUND",
				});
			}

			// Verify order is still in SCHEDULED status
			if (order.status !== "SCHEDULED") {
				throw new RepositoryError(
					"Cannot cancel order that is no longer in SCHEDULED status. Use regular cancel for active orders.",
					{ code: "BAD_REQUEST" },
				);
			}

			// Verify ownership
			if (order.userId !== userId) {
				throw new RepositoryError(
					"Cannot cancel order belonging to another user",
					{
						code: "FORBIDDEN",
					},
				);
			}

			// Check if cancellation is free (before matching time)
			const isFreeCancel = order.scheduledAt
				? OrderSchedulingService.canCancelWithoutPenalty(
						new Date(order.scheduledAt),
					)
				: true;

			let refundAmount = order.totalPrice;
			let penaltyAmount = 0;

			if (!isFreeCancel) {
				// Apply cancellation penalty (10%)
				const businessConfig = await BusinessConfigurationService.getConfig(
					this.db,
					this.kv,
				);
				const penaltyRate =
					businessConfig.userCancellationFeeAfterAccept ?? 0.1;
				penaltyAmount = order.totalPrice * penaltyRate;
				refundAmount = order.totalPrice - penaltyAmount;

				logger.info(
					{
						orderId,
						totalPrice: order.totalPrice,
						penaltyAmount,
						refundAmount,
					},
					"[ScheduledOrderRepository] Scheduled order cancellation penalty applied",
				);
			}

			// Process refund
			await OrderRefundService.processRefund(
				order.id,
				order.userId,
				new Decimal(refundAmount),
				new Decimal(penaltyAmount),
				opts,
			);

			// Update order status
			const [operation] = await opts.tx
				.update(tables.order)
				.set({
					status: "CANCELLED_BY_USER",
					cancelReason: reason,
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, orderId))
				.returning({ id: tables.order.id });

			const result = await this.getFromDB(operation.id, opts);
			if (!result)
				throw new RepositoryError(m.error_failed_update_order(), {
					code: "INTERNAL_SERVER_ERROR",
				});

			await this.setCache(orderId, result, {
				expirationTtl: CACHE_TTLS["1h"],
			});

			logger.info(
				{
					orderId,
					userId,
					reason,
					isFreeCancel,
					refundAmount,
				},
				"[ScheduledOrderRepository] Scheduled order cancelled",
			);

			return result;
		} catch (error) {
			logger.error(
				{
					error,
					orderId,
					userId,
				},
				"[ScheduledOrderRepository] Failed to cancel scheduled order - transaction will be rolled back",
			);
			throw this.handleError(error, "cancelScheduledOrder");
		}
	}
}

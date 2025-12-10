import { m } from "@repo/i18n";
import type { PlaceOrder, PlaceOrderResponse } from "@repo/schema/order";
import { v7 } from "uuid";
import { CACHE_TTLS, DRIVER_POOL_KEY } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { OrderQueueService } from "@/core/services/queue";
import { BusinessConfigurationService } from "@/features/configuration/services";
import type {
	ChargePayload,
	PaymentRepository,
} from "@/features/payment/payment-repository";
import { toStringNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
import {
	OrderCouponService,
	OrderItemPreparationService,
	OrderValidationService,
} from "../services";
import { OrderBaseRepository } from "./order-base-repository";
import type { OrderReadRepository } from "./order-read-repository";
import type { OrderWriteRepository } from "./order-write-repository";

/**
 * OrderPlacementRepository - Handles order placement logic
 *
 * Responsibilities:
 * - Place new orders
 * - Validate order parameters
 * - Process payments
 * - Apply coupons
 * - Broadcast order to driver pool
 */
export class OrderPlacementRepository extends OrderBaseRepository {
	readonly #paymentRepo: PaymentRepository;
	readonly #readRepo: OrderReadRepository;
	readonly #writeRepo: OrderWriteRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		paymentRepo: PaymentRepository,
		readRepo: OrderReadRepository,
		writeRepo: OrderWriteRepository,
	) {
		super(db, kv);
		this.#paymentRepo = paymentRepo;
		this.#readRepo = readRepo;
		this.#writeRepo = writeRepo;
	}

	/**
	 * Place a new order with payment processing
	 */
	async placeOrder(
		params: PlaceOrder & WithUserId,
		opts: WithTx,
	): Promise<PlaceOrderResponse> {
		try {
			// Validate required parameters
			OrderValidationService.validatePlaceOrderParams(params);

			logger.debug(
				{
					userId: params.userId,
					type: params.type,
					method: params.payment.method,
				},
				"[OrderPlacementRepository] Starting order placement",
			);

			// Extract menu item IDs
			const itemIds = OrderValidationService.extractMenuItemIds(params.items);

			// PERFORMANCE: Don't pass transaction to estimate() to prevent external API calls from holding DB locks
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

			if (menuItemsTotal > 0) {
				logger.info(
					{
						userId: params.userId,
						deliveryFee: estimate.totalCost,
						menuItemsTotal,
						baseTotalCost,
					},
					"[OrderPlacementRepository] FOOD order - menu items total calculated",
				);
			}

			if (params.couponCode) {
				// User provided a coupon code - validate and apply it
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
				// No coupon provided - auto-apply the best eligible coupon
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

					logger.info(
						{
							userId: params.userId,
							couponCode,
							discountAmount,
							originalTotal: baseTotalCost,
							finalTotal: finalTotalCost,
						},
						"[OrderPlacementRepository] Auto-applied best eligible coupon",
					);
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

			const [orderRow] = await opts.tx
				.insert(tables.order)
				.values({
					id: v7(),
					userId: params.userId,
					merchantId,
					type: params.type,
					note: params.note,
					pickupLocation: params.pickupLocation,
					dropoffLocation: params.dropoffLocation,
					distanceKm: estimate.distanceKm,
					basePrice: baseFare,
					totalPrice: safeTotalCost,
					couponId,
					couponCode,
					discountAmount: safeDiscountAmount,
					gender: params.gender,
					genderPreference: params.genderPreference ?? "ANY",
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

			let order = await this.getFromDB(orderRow.id, opts);
			if (!order)
				throw new RepositoryError(m.error_failed_retrieve_placed_order());

			// For wallet payments, automatically update order status to MATCHING
			if (params.payment.method === "wallet" && payment.status === "SUCCESS") {
				order = await this.#writeRepo.update(
					order.id,
					{ status: "MATCHING" },
					opts,
				);

				logger.info(
					{
						orderId: order.id,
						userId: params.userId,
						amount: estimate.totalCost,
					},
					"[OrderPlacementRepository] wallet payment successful - Order moved to MATCHING",
				);

				// Enqueue order timeout job for resilience
				// This ensures the order will be cancelled if no driver accepts within the timeout period
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
							userId: params.userId,
							paymentId: payment.id,
							totalPrice: finalTotalCost,
							timeoutReason: `No driver found within ${timeoutMinutes} minutes`,
							processRefund: true,
						},
						timeoutSeconds,
					);

					logger.info(
						{
							orderId: order.id,
							timeoutMinutes,
						},
						"[OrderPlacementRepository] Order timeout job enqueued",
					);
				} catch (queueError) {
					// Log but don't fail the order - the cron fallback will handle stuck orders
					logger.error(
						{ error: queueError, orderId: order.id },
						"[OrderPlacementRepository] Failed to enqueue timeout job - cron will handle",
					);
				}
			}

			await Promise.allSettled([
				this.setCache(order.id, order, {
					expirationTtl: CACHE_TTLS["1h"],
				}),
				this.deleteCache("count"),
			]);

			// Record coupon usage if a coupon was applied
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
					method: params.payment.method,
					status: order.status,
					autoAppliedCoupon: autoAppliedCoupon?.code,
				},
				m.server_order_placed(),
			);

			// Broadcast to driver pool
			const stub = OrderBaseRepository.getRoomStubByName(DRIVER_POOL_KEY);
			stub.broadcast({
				f: "s",
				t: "s",
				a: "MATCHING",
				p: {
					detail: {
						order,
						payment,
						transaction,
					},
				},
			});

			return { order, payment, transaction, autoAppliedCoupon };
		} catch (err) {
			logger.error(
				{
					error: err,
					userId: params.userId,
					type: params.type,
					method: params.payment?.method,
				},
				"[OrderPlacementRepository] Failed to place order - transaction will be rolled back",
			);
			throw this.handleError(err, "place");
		}
	}
}

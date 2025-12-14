import { m } from "@repo/i18n";
import type { PlaceOrder, PlaceOrderResponse } from "@repo/schema/order";
import { v7 } from "uuid";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import {
	NotificationQueueService,
	OrderQueueService,
} from "@/core/services/queue";
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

			// Validate user does not have an active order
			// Users can only place one order at a time
			await OrderValidationService.validateNoActiveOrder(
				params.userId,
				opts.tx,
			);

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
					pickupAddress: params.pickupAddress,
					dropoffAddress: params.dropoffAddress,
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
				// IMPORTANT: referenceId links the transaction to the order for refund processing
				referenceId: orderRow.id,
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

			const { transaction, payment, wallet } = await this.#paymentRepo.charge(
				chargePayload,
				opts,
			);

			let order = await this.getFromDB(orderRow.id, opts);
			if (!order)
				throw new RepositoryError(m.error_failed_retrieve_placed_order());

			logger.debug(
				{
					orderId: order.id,
					initialStatus: order.status,
					paymentMethod: params.payment.method,
					paymentStatus: payment.status,
					orderType: params.type,
					merchantId,
				},
				"[OrderPlacementRepository] Order created - checking if status update needed",
			);

			// For wallet payments, automatically update order status
			// FOOD orders: Notify merchant first (stay in REQUESTED status until merchant accepts)
			// RIDE/DELIVERY orders: Move directly to MATCHING for driver matching
			if (params.payment.method === "wallet" && payment.status === "SUCCESS") {
				if (params.type === "FOOD" && merchantId) {
					// FOOD orders: Notify merchant, stay in REQUESTED status
					// Driver matching only starts after merchant marks order as READY_FOR_PICKUP
					logger.info(
						{
							orderId: order.id,
							userId: params.userId,
							merchantId,
							amount: estimate.totalCost,
						},
						"[OrderPlacementRepository] FOOD order - wallet payment successful - Notifying merchant",
					);

					// Notify merchant via WebSocket about new order
					const { MerchantRoom } = await import(
						"@/features/merchant/merchant-ws"
					);
					const merchantStub = MerchantRoom.getRoomStubByName(merchantId);
					merchantStub.broadcast({
						e: "NEW_ORDER",
						f: "s",
						t: "c",
						p: {
							order,
							orderId: order.id,
							merchantId,
							itemCount: params.items?.length ?? 0,
							totalAmount: finalTotalCost,
						},
					});

					// Get merchant's user ID for push notification
					const merchantUserId = menus[0]?.merchant?.user?.id;
					if (merchantUserId) {
						// Also send push notification for when merchant is not connected to WebSocket
						const itemCount = params.items?.length ?? 0;
						try {
							await NotificationQueueService.enqueuePushNotification({
								fromUserId: params.userId,
								toUserId: merchantUserId,
								title: "New Order Received",
								body: `You have a new order with ${itemCount} item${itemCount > 1 ? "s" : ""}. Tap to view details.`,
								data: {
									type: "NEW_ORDER",
									orderId: order.id,
									merchantId,
									deeplink: "akademove://merchant/order",
								},
								android: {
									priority: "high",
									notification: { clickAction: "MERCHANT_OPEN_ORDER_DETAIL" },
								},
								apns: {
									payload: {
										aps: { category: "ORDER_DETAIL", sound: "default" },
									},
								},
							});

							logger.info(
								{ orderId: order.id, merchantId, merchantUserId },
								"[OrderPlacementRepository] Push notification enqueued for merchant (wallet payment)",
							);
						} catch (notifError) {
							// Log but don't fail the order - WebSocket notification was already sent
							logger.error(
								{ error: notifError, orderId: order.id, merchantId },
								"[OrderPlacementRepository] Failed to enqueue merchant push notification",
							);
						}
					}
				} else {
					// RIDE/DELIVERY orders: Move to MATCHING for driver matching
					logger.debug(
						{ orderId: order.id, currentStatus: order.status },
						"[OrderPlacementRepository] Attempting to update order status to MATCHING",
					);

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
							updatedStatus: order.status,
						},
						"[OrderPlacementRepository] wallet payment successful - Order moved to MATCHING",
					);
				}

				// Broadcast PAYMENT_SUCCESS to payment room for real-time UI updates
				// This ensures the mobile app receives the payment success event with updated wallet balance
				// (Same behavior as QRIS/Bank Transfer webhook handler)
				try {
					const { PaymentRepository } = await import(
						"@/features/payment/payment-repository"
					);
					const paymentStub = PaymentRepository.getRoomStubByName(payment.id);
					paymentStub.broadcast({
						e: "PAYMENT_SUCCESS",
						f: "s",
						t: "c",
						tg: "USER",
						p: {
							payment,
							transaction,
							wallet,
						},
					});

					logger.info(
						{ orderId: order.id, paymentId: payment.id },
						"[OrderPlacementRepository] PAYMENT_SUCCESS broadcast sent to payment room",
					);
				} catch (broadcastError) {
					// Log but don't fail the order - the payment was successful
					logger.error(
						{ error: broadcastError, orderId: order.id, paymentId: payment.id },
						"[OrderPlacementRepository] Failed to broadcast PAYMENT_SUCCESS to payment room",
					);
				}

				// Enqueue order timeout job for resilience
				// This ensures the order will be cancelled if no driver accepts within the timeout period
				// For FOOD orders, timeout starts from merchant marking order as ready
				if (params.type !== "FOOD") {
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
			} else {
				// Non-wallet payment or wallet payment not successful - status stays REQUESTED
				// Status will be updated when webhook confirms payment success
				logger.debug(
					{
						orderId: order.id,
						paymentMethod: params.payment.method,
						paymentStatus: payment.status,
						orderStatus: order.status,
					},
					"[OrderPlacementRepository] Status update skipped - non-wallet or payment not SUCCESS",
				);
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

			// For wallet payments that succeeded immediately, enqueue driver matching
			// For non-wallet payments (BANK_TRANSFER, QRIS), the webhook handler will handle this
			// For FOOD orders, driver matching only starts after merchant marks order as READY_FOR_PICKUP
			if (
				params.payment.method === "wallet" &&
				payment.status === "SUCCESS" &&
				params.type !== "FOOD"
			) {
				try {
					// Fetch driver matching config from database
					const matchingConfig =
						await BusinessConfigurationService.getDriverMatchingConfig(
							this.db,
							this.kv,
						);

					// Enqueue driver matching job (which handles push notifications to drivers)
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
							Math.log(
								matchingConfig.maxRadiusKm / matchingConfig.initialRadiusKm,
							) / Math.log(1 + matchingConfig.expansionRate),
						),
						expansionRate: matchingConfig.expansionRate,
						matchingIntervalSeconds: matchingConfig.intervalSeconds,
						broadcastLimit: matchingConfig.broadcastLimit,
						maxCancellationsPerDay: matchingConfig.maxCancellationsPerDay,
						paymentId: payment.id,
						excludedDriverIds: [],
						isRetry: false,
					});

					logger.info(
						{ orderId: order.id },
						"[OrderPlacementRepository] Driver matching job enqueued after wallet payment success",
					);

					// Broadcast to driver pool room via WebSocket for real-time driver matching
					// Uses queue-based delayed broadcast to allow WebSocket clients time to connect
					// The queue-based matching handles push notifications for offline drivers
					const { DRIVER_POOL_KEY, BUSINESS_CONSTANTS } = await import(
						"@/core/constants"
					);
					const { ProcessingQueueService } = await import(
						"@/core/services/queue"
					);

					// Use queue-based broadcast with delay for robustness
					// setTimeout doesn't work reliably in Cloudflare Workers
					await ProcessingQueueService.enqueueWebSocketBroadcast(
						{
							roomName: DRIVER_POOL_KEY,
							action: "MATCHING",
							target: "SYSTEM",
							data: {
								detail: {
									payment,
									order: {
										...order,
										status: "MATCHING",
									},
									transaction,
								},
							},
						},
						{ delaySeconds: BUSINESS_CONSTANTS.BROADCAST_DELAY_SECONDS },
					);

					logger.info(
						{ orderId: order.id },
						"[OrderPlacementRepository] Delayed broadcast enqueued to driver pool for RIDE/DELIVERY order after wallet payment",
					);
				} catch (matchingError) {
					// Log but don't fail the order - the timeout handler will handle stuck orders
					logger.error(
						{ error: matchingError, orderId: order.id },
						"[OrderPlacementRepository] Failed to enqueue driver matching job - cron will handle",
					);
				}
			}

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

/**
 * Order Completion Handler
 *
 * Handles ORDER_COMPLETION queue messages.
 * Processes commission calculation and driver earnings after order completion.
 *
 * Flow:
 * 1. Calculate commission based on order type and config
 * 2. Apply badge-based commission reduction
 * 3. Credit driver wallet with earnings
 * 4. Credit merchant wallet with earnings (FOOD orders)
 * 5. Record commission transactions
 * 6. Update driver availability
 */

import type { FoodPricingConfiguration } from "@repo/schema/configuration";
import type { OrderCompletionJob } from "@repo/schema/queue";
import Decimal from "decimal.js";
import { eq } from "drizzle-orm";
import { CONFIGURATION_KEYS } from "@/core/constants";
import { tables } from "@/core/services/db";
import { ProcessingQueueService } from "@/core/services/queue";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleOrderCompletion(
	job: OrderCompletionJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload, meta: _meta } = job;
	const {
		orderId,
		driverId,
		driverUserId,
		totalPrice,
		orderType,
		commissionRate,
		driverCurrentLocation,
	} = payload;

	logger.info(
		{ orderId, driverId, totalPrice, orderType },
		"[OrderCompletionHandler] Processing completion job",
	);

	try {
		await context.svc.db.transaction(async (tx) => {
			const opts = { tx };

			// Get order to verify status
			const order = await context.repo.order.get(orderId, opts);

			// Skip if order is not in a completable status
			if (order.status === "COMPLETED") {
				logger.info(
					{ orderId, currentStatus: order.status },
					"[OrderCompletionHandler] Order already completed - skipping",
				);
				return;
			}

			// Get pricing config for merchant commission (FOOD orders)
			let merchantCommissionRate = 0;
			if (orderType === "FOOD") {
				const key = CONFIGURATION_KEYS.FOOD_SERVICE_PRICING;
				const pricingConfig = await context.repo.configuration.get(key);
				const config = pricingConfig.value as FoodPricingConfiguration;
				merchantCommissionRate = config.merchantCommissionRate;
			}

			// Calculate amounts
			const total = new Decimal(totalPrice);

			// For FOOD orders, we need to split earnings between driver and merchant
			// Driver gets: delivery fee - platform commission on delivery
			// Merchant gets: food cost - merchant commission
			let menuItemsTotal = new Decimal(0);
			let deliveryFee = total;

			if (orderType === "FOOD") {
				// Calculate menu items total from order items
				const orderItems = await tx.query.orderItem.findMany({
					where: eq(tables.orderItem.orderId, orderId),
				});

				menuItemsTotal = orderItems.reduce((sum, item) => {
					const unitPrice = new Decimal(item.unitPrice);
					return sum.plus(unitPrice.times(item.quantity));
				}, new Decimal(0));

				// Delivery fee = total price - food cost
				deliveryFee = total.minus(menuItemsTotal);
			}

			// For FOOD orders: platform commission is only on delivery fee
			// For RIDE/DELIVERY: platform commission is on total price
			const platformCommission =
				orderType === "FOOD"
					? deliveryFee.times(commissionRate)
					: total.times(commissionRate);

			// For FOOD orders, merchantCommissionRate applies to food cost (menuItemsTotal)
			const merchantCommission =
				orderType === "FOOD"
					? menuItemsTotal.times(merchantCommissionRate)
					: new Decimal(0);

			// Driver earning:
			// - FOOD: delivery fee minus platform commission (driver only delivers, doesn't make food)
			// - RIDE/DELIVERY: total price minus platform commission
			const driverEarning =
				orderType === "FOOD"
					? deliveryFee.minus(platformCommission)
					: total.minus(platformCommission);

			// Merchant earning (FOOD orders only): food cost minus merchant commission
			const merchantEarning =
				orderType === "FOOD"
					? menuItemsTotal.minus(merchantCommission)
					: new Decimal(0);

			// Get driver wallet
			const driverWallet = await context.repo.wallet.getByUserId(
				driverUserId,
				opts,
			);

			// Atomic balance update for driver earnings
			const driverBalanceResult = await context.svc.walletServices.balance.add(
				{
					walletId: driverWallet.id,
					amount: toNumberSafe(driverEarning.toString()),
				},
				{ tx },
			);

			// For FOOD orders, credit merchant wallet
			let merchantBalanceResult:
				| { balanceBefore: number; balanceAfter: number }
				| undefined;
			let merchantWallet: { id: string } | undefined;

			if (orderType === "FOOD" && order.merchantId) {
				// Get merchant to find their userId
				const merchant = await tx.query.merchant.findFirst({
					where: (f, op) => op.eq(f.id, order.merchantId ?? ""),
				});

				if (merchant?.userId) {
					merchantWallet = await context.repo.wallet.getByUserId(
						merchant.userId,
						opts,
					);
					merchantBalanceResult = await context.svc.walletServices.balance.add(
						{
							walletId: merchantWallet.id,
							amount: toNumberSafe(merchantEarning.toString()),
						},
						{ tx },
					);
				} else {
					logger.error(
						{ orderId, merchantId: order.merchantId },
						"[OrderCompletionHandler] Merchant not found or missing userId - merchant earnings not credited",
					);
				}
			}

			// Update order and create transaction records
			const updatePromises: Promise<unknown>[] = [
				// Update order with commission details and store completedDriverId for reviews
				context.repo.order.update(
					orderId,
					{
						status: "COMPLETED",
						completedDriverId: driverId,
						platformCommission: toNumberSafe(platformCommission.toString()),
						driverEarning: toNumberSafe(driverEarning.toString()),
						merchantCommission: toNumberSafe(merchantCommission.toString()),
						merchantEarning: toNumberSafe(merchantEarning.toString()),
					},
					opts,
				),

				// Record driver earning transaction
				context.repo.transaction.insert(
					{
						walletId: driverWallet.id,
						type: "EARNING",
						amount: toNumberSafe(driverEarning.toString()),
						balanceBefore: driverBalanceResult.balanceBefore,
						balanceAfter: driverBalanceResult.balanceAfter,
						status: "SUCCESS",
						description: `Driver earning for order #${orderId.slice(0, 8)}`,
						referenceId: orderId,
						metadata: {
							orderId,
							orderType,
							totalPrice: toNumberSafe(total.toString()),
							deliveryFee: toNumberSafe(deliveryFee.toString()),
							commissionRate,
						},
					},
					opts,
				),

				// Record platform commission (for audit)
				context.repo.transaction.insert(
					{
						walletId: driverWallet.id,
						type: "COMMISSION",
						amount: toNumberSafe(platformCommission.toString()),
						status: "SUCCESS",
						description: `Platform commission for order #${orderId.slice(0, 8)}`,
						referenceId: orderId,
						metadata: {
							orderId,
							orderType,
							totalPrice: toNumberSafe(total.toString()),
							commissionRate,
						},
					},
					opts,
				),

				// Update driver availability
				context.repo.driver.main.update(
					driverId,
					{
						isTakingOrder: false,
						currentLocation: driverCurrentLocation,
					},
					opts,
				),
			];

			// Add merchant earning transaction for FOOD orders
			if (orderType === "FOOD" && merchantWallet && merchantBalanceResult) {
				updatePromises.push(
					// Credit merchant wallet with earnings
					context.repo.transaction.insert(
						{
							walletId: merchantWallet.id,
							type: "EARNING",
							amount: toNumberSafe(merchantEarning.toString()),
							balanceBefore: merchantBalanceResult.balanceBefore,
							balanceAfter: merchantBalanceResult.balanceAfter,
							status: "SUCCESS",
							description: `Merchant earning for order #${orderId.slice(0, 8)}`,
							referenceId: orderId,
							metadata: {
								orderId,
								orderType,
								menuItemsTotal: toNumberSafe(menuItemsTotal.toString()),
								merchantCommissionRate,
							},
						},
						opts,
					),
					// Record merchant commission (audit only)
					context.repo.transaction.insert(
						{
							walletId: merchantWallet.id,
							type: "COMMISSION",
							amount: toNumberSafe(merchantCommission.toString()),
							status: "SUCCESS",
							description: `Merchant commission for order #${orderId.slice(0, 8)}`,
							referenceId: orderId,
							metadata: {
								orderId,
								orderType,
								menuItemsTotal: toNumberSafe(menuItemsTotal.toString()),
								merchantCommissionRate,
							},
						},
						opts,
					),
				);
			}

			await Promise.all(updatePromises);

			logger.info(
				{
					orderId,
					driverId,
					totalPrice: toNumberSafe(total.toString()),
					menuItemsTotal: toNumberSafe(menuItemsTotal.toString()),
					deliveryFee: toNumberSafe(deliveryFee.toString()),
					platformCommission: toNumberSafe(platformCommission.toString()),
					driverEarning: toNumberSafe(driverEarning.toString()),
					merchantCommission: toNumberSafe(merchantCommission.toString()),
					merchantEarning: toNumberSafe(merchantEarning.toString()),
				},
				"[OrderCompletionHandler] Commission calculated and distributed",
			);

			// Queue badge evaluation (background task)
			await ProcessingQueueService.enqueueBadgeEvaluation({
				driverId,
				userId: driverUserId,
				orderId,
				orderType,
			});

			// Queue driver metrics update
			await ProcessingQueueService.enqueueDriverMetrics({
				driverId,
				orderId,
				metricsType: "ORDER_COMPLETED",
			});
		});

		// Send completion notification to driver
		await context.repo.notification.sendNotificationToUserId({
			fromUserId: "system",
			toUserId: driverUserId,
			title: "Order Completed",
			body: `You earned from order #${orderId.slice(0, 8)}`,
			data: {
				type: "ORDER_COMPLETED",
				orderId,
				deeplink: "akademove://driver/earnings",
			},
		});
	} catch (error) {
		logger.error(
			{ error, orderId, driverId },
			"[OrderCompletionHandler] Failed to process completion",
		);
		throw error;
	}
}

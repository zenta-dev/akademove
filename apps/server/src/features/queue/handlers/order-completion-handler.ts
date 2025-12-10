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
 * 4. Record commission transactions
 * 5. Update driver availability
 */

import type { FoodPricingConfiguration } from "@repo/schema/configuration";
import type { OrderCompletionJob } from "@repo/schema/queue";
import Decimal from "decimal.js";
import { CONFIGURATION_KEYS } from "@/core/constants";
import { ProcessingQueueService } from "@/core/services/queue";
import { log, toNumberSafe } from "@/utils";
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

	log.info(
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
				log.info(
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
			const platformCommission = total.times(commissionRate);
			const merchantCommission =
				orderType === "FOOD"
					? total.times(merchantCommissionRate)
					: new Decimal(0);
			const driverEarning = total
				.minus(platformCommission)
				.minus(merchantCommission);

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

			// Update order and create transaction records
			await Promise.all([
				// Update order with commission details
				context.repo.order.update(
					orderId,
					{
						status: "COMPLETED",
						platformCommission: toNumberSafe(platformCommission.toString()),
						driverEarning: toNumberSafe(driverEarning.toString()),
						merchantCommission: toNumberSafe(merchantCommission.toString()),
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
			]);

			log.info(
				{
					orderId,
					driverId,
					totalPrice: toNumberSafe(total.toString()),
					platformCommission: toNumberSafe(platformCommission.toString()),
					driverEarning: toNumberSafe(driverEarning.toString()),
					merchantCommission: toNumberSafe(merchantCommission.toString()),
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
		log.error(
			{ error, orderId, driverId },
			"[OrderCompletionHandler] Failed to process completion",
		);
		throw error;
	}
}

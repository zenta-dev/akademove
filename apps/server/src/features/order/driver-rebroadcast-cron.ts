import { env } from "cloudflare:workers";
import type { ExecutionContext } from "@cloudflare/workers-types";
import type { OrderEnvelope } from "@repo/schema/ws";
import { and, eq, isNull, lte } from "drizzle-orm";
import { DRIVER_POOL_KEY } from "@/core/constants";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { DriverPriorityService } from "@/features/driver/services/driver-priority-service";
import type { MatchingConfig } from "@/features/order/services/order-matching-service";
import { logger } from "@/utils/logger";
import { OrderBaseRepository } from "./repositories/order-base-repository";

/**
 * Rebroadcast interval in minutes
 * Orders in MATCHING status without a driver will be rebroadcast every X minutes
 */
const REBROADCAST_INTERVAL_MINUTES = 2;

/**
 * Scheduled handler for rebroadcasting orders to driver pool
 * Called by Cloudflare Workers cron trigger
 *
 * Purpose:
 * - Rebroadcast orders that are in MATCHING status but have no driver assigned
 * - This handles cases where:
 *   1. First broadcast had no nearby drivers online
 *   2. All nearby drivers rejected or ignored the order
 *   3. Drivers came online after the initial broadcast
 *   4. WebSocket connection issues caused missed broadcasts
 *
 * Applies to:
 * - FOOD orders that are READY_FOR_PICKUP (status is MATCHING, no driverId)
 * - RIDE/DELIVERY orders that are MATCHING (no driverId assigned yet)
 *
 * This cron runs every 2 minutes to give drivers time to accept before rebroadcasting
 */
export async function handleDriverRebroadcastCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info(
			{},
			"[DriverRebroadcastCron] Starting driver rebroadcast for unmatched orders",
		);

		const svc = getServices();
		const managers = getManagers();
		const repo = getRepositories(svc, managers);
		const now = new Date();
		let rebroadcastCount = 0;
		let errorCount = 0;

		// Find orders that:
		// 1. Are in MATCHING status
		// 2. Have no driver assigned (driverId is null)
		// 3. Were updated more than REBROADCAST_INTERVAL_MINUTES ago (to avoid rebroadcasting too soon)
		const rebroadcastThreshold = new Date(
			now.getTime() - REBROADCAST_INTERVAL_MINUTES * 60 * 1000,
		);

		const unmatchedOrders = await svc.db.query.order.findMany({
			where: (f, _op) =>
				and(
					eq(f.status, "MATCHING"),
					isNull(f.driverId),
					lte(f.updatedAt, rebroadcastThreshold),
				),
			with: {
				user: {
					columns: {
						id: true,
						name: true,
						gender: true,
					},
				},
				merchant: {
					columns: {
						id: true,
						name: true,
					},
				},
			},
			limit: 50, // Process up to 50 orders per cron run to avoid timeout
		});

		logger.info(
			{ unmatchedOrderCount: unmatchedOrders.length },
			"[DriverRebroadcastCron] Found unmatched orders for rebroadcast",
		);

		if (unmatchedOrders.length === 0) {
			return new Response(
				"Driver rebroadcast completed. No unmatched orders found.",
				{ status: 200 },
			);
		}

		// Fetch matching configuration from database
		const matchingConfigData =
			await BusinessConfigurationService.getDriverMatchingConfig(
				svc.db,
				svc.kv,
			);

		const matchingConfig: MatchingConfig = {
			initialRadiusKm: matchingConfigData.initialRadiusKm,
			maxRadiusKm: matchingConfigData.maxRadiusKm,
			expansionRate: matchingConfigData.expansionRate,
			timeoutMs: matchingConfigData.intervalSeconds * 1000,
			broadcastLimit: matchingConfigData.broadcastLimit,
			maxCancellationsPerDay: matchingConfigData.maxCancellationsPerDay,
		};

		// Get the driver pool room stub for broadcasting
		const driverPoolStub =
			OrderBaseRepository.getRoomStubByName(DRIVER_POOL_KEY);

		for (const order of unmatchedOrders) {
			try {
				// Use larger radius for rebroadcast (start with 1.5x initial radius)
				const rebroadcastRadius = matchingConfig.initialRadiusKm * 1.5;

				// Find available drivers using the matching service
				const matchedDrivers =
					await svc.orderServices.matching.findAvailableDrivers(
						{
							orderId: order.id,
							pickupLocation: order.pickupLocation,
							orderType: order.type,
							genderPreference: order.genderPreference ?? undefined,
							userGender: order.gender ?? undefined,
							radiusKm: Math.min(rebroadcastRadius, matchingConfig.maxRadiusKm),
						},
						matchingConfig,
					);

				if (matchedDrivers.length === 0) {
					logger.debug(
						{ orderId: order.id, type: order.type },
						"[DriverRebroadcastCron] No drivers found for rebroadcast, skipping",
					);
					continue;
				}

				// Sort drivers by priority (badges + leaderboard rank)
				const driverPriorityService = new DriverPriorityService(svc.db);
				const driverIds = matchedDrivers
					.map((m) => m.driver.id)
					.filter((id): id is string => id !== null && id !== undefined);

				const sortedDrivers =
					await driverPriorityService.sortDriversByPriority(driverIds);

				// Reorder matched drivers based on priority
				const sortedMatchedDrivers = sortedDrivers
					.map((pd) => matchedDrivers.find((m) => m.driver.id === pd.driverId))
					.filter((m): m is NonNullable<typeof m> => m !== undefined);

				logger.info(
					{
						orderId: order.id,
						type: order.type,
						availableDrivers: sortedMatchedDrivers.length,
					},
					"[DriverRebroadcastCron] Rebroadcasting order to driver pool",
				);

				// Compose the order entity for broadcast
				const composedOrder = await OrderBaseRepository.composeEntity(
					order as Parameters<typeof OrderBaseRepository.composeEntity>[0],
					svc.storage,
				);

				// Build the broadcast payload
				const payload: OrderEnvelope = {
					e: "ORDER_OFFER",
					f: "s",
					t: "c",
					tg: "DRIVER",
					p: {
						detail: {
							order: composedOrder,
							payment: null,
							transaction: null,
						},
					},
				};

				// Broadcast to driver pool room
				await driverPoolStub.fetch(
					new Request("http://internal/broadcast", {
						method: "POST",
						headers: { "Content-Type": "application/json" },
						body: JSON.stringify(payload),
					}),
				);

				// Send push notifications to matched drivers who may not be connected to WebSocket
				const orderUrl = `${env.CORS_ORIGIN}/dash/merchant/orders/${order.id}`;
				const notificationPromises = sortedMatchedDrivers
					.slice(0, matchingConfig.broadcastLimit)
					.map((matched) => {
						const driverUserId = matched.driver.userId;
						if (!driverUserId) return Promise.resolve();

						return repo.notification
							.sendNotificationToUserId({
								fromUserId: order.userId,
								toUserId: driverUserId,
								title: "New Order Available",
								body: `${order.type} order #${order.id.slice(0, 8)} is waiting for a driver. Tap to accept.`,
								data: {
									type: "NEW_ORDER",
									orderId: order.id,
									deeplink: `akademove://driver/order/${order.id}`,
								},
								android: {
									priority: "high",
									notification: { clickAction: "DRIVER_OPEN_ORDER_DETAIL" },
								},
								apns: {
									payload: {
										aps: { category: "ORDER_DETAIL", sound: "default" },
									},
								},
								webpush: { fcmOptions: { link: orderUrl } },
							})
							.catch((err) => {
								logger.warn(
									{
										error: err,
										driverId: matched.driver.id,
										orderId: order.id,
									},
									"[DriverRebroadcastCron] Failed to send push notification to driver",
								);
							});
					});

				await Promise.allSettled(notificationPromises);

				// Update order's updatedAt to track last rebroadcast time
				// This prevents rebroadcasting too frequently
				await svc.db.transaction(async (tx) => {
					const { tables } = await import("@/core/services/db");
					await tx
						.update(tables.order)
						.set({ updatedAt: now })
						.where(eq(tables.order.id, order.id));
				});

				rebroadcastCount++;

				logger.info(
					{
						orderId: order.id,
						type: order.type,
						userId: order.userId,
						merchantId: order.merchantId,
						driversNotified: Math.min(
							sortedMatchedDrivers.length,
							matchingConfig.broadcastLimit,
						),
					},
					"[DriverRebroadcastCron] Order rebroadcast completed",
				);
			} catch (error) {
				errorCount++;
				logger.error(
					{ error, orderId: order.id },
					"[DriverRebroadcastCron] Failed to rebroadcast order",
				);
			}
		}

		logger.info(
			{
				rebroadcastCount,
				errorCount,
				totalUnmatchedOrders: unmatchedOrders.length,
				duration: Date.now() - now.getTime(),
			},
			"[DriverRebroadcastCron] Completed driver rebroadcast",
		);

		return new Response(
			`Driver rebroadcast completed. Rebroadcast ${rebroadcastCount} orders, ${errorCount} errors.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error },
			"[DriverRebroadcastCron] Failed to rebroadcast orders to drivers",
		);
		return new Response("Driver rebroadcast failed", { status: 500 });
	}
}

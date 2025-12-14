import { env } from "cloudflare:workers";
import type { ExecutionContext } from "@cloudflare/workers-types";
import { and, eq, lte } from "drizzle-orm";
import { BUSINESS_CONSTANTS, DRIVER_POOL_KEY } from "@/core/constants";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import {
	OrderQueueService,
	ProcessingQueueService,
} from "@/core/services/queue";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { logger } from "@/utils/logger";
import { SCHEDULING_CONFIG } from "./services/order-scheduling-service";
import { OrderStateService } from "./services/order-state-service";

/**
 * Scheduled handler for processing scheduled orders
 * Called by Cloudflare Workers cron trigger
 *
 * Tasks:
 * 1. Find orders with status='SCHEDULED' where scheduledMatchingAt <= now
 * 2. Update status to 'MATCHING'
 * 3. Send push notification to user that their scheduled ride is being matched
 * 4. Enqueue driver matching job to find available drivers
 * 5. Broadcast to driver pool room via WebSocket for real-time driver matching
 */
export async function handleScheduledOrderCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info({}, "[ScheduledOrderCron] Starting scheduled order processing");

		const svc = getServices();
		const managers = getManagers();
		const repo = getRepositories(svc, managers);
		const stateService = new OrderStateService();

		const now = new Date();
		let processedOrders = 0;
		let notifiedOrders = 0;

		// Find orders ready for matching
		// scheduledMatchingAt is set to (scheduledAt - MATCHING_LEAD_TIME_MINUTES)
		const readyOrders = await svc.db.query.order.findMany({
			where: (f, _op) =>
				and(eq(f.status, "SCHEDULED"), lte(f.scheduledMatchingAt, now)),
			with: {
				user: {
					columns: {
						id: true,
						name: true,
					},
				},
			},
			limit: 100, // Process in batches to avoid timeout
		});

		logger.info(
			{ orderCount: readyOrders.length },
			"[ScheduledOrderCron] Found scheduled orders ready for matching",
		);

		for (const order of readyOrders) {
			try {
				// Validate state transition before updating
				// This ensures we don't process orders that have already been updated
				if (order.status !== "SCHEDULED") {
					logger.warn(
						{ orderId: order.id, currentStatus: order.status },
						"[ScheduledOrderCron] Order no longer in SCHEDULED status, skipping",
					);
					continue;
				}

				// Validate transition using state machine
				stateService.validateTransition(order.status, "MATCHING");

				await svc.db.transaction(async (tx) => {
					// Update order status to MATCHING
					await tx
						.update(tables.order)
						.set({
							status: "MATCHING",
							updatedAt: now,
						})
						.where(eq(tables.order.id, order.id));

					// Record status change in audit trail
					await tx.insert(tables.orderStatusHistory).values({
						orderId: order.id,
						previousStatus: "SCHEDULED",
						newStatus: "MATCHING",
						changedBy: undefined,
						changedByRole: "SYSTEM",
						reason: "Scheduled order matching time reached",
						changedAt: now,
					});

					logger.info(
						{
							orderId: order.id,
							userId: order.userId,
							scheduledAt: order.scheduledAt,
							scheduledMatchingAt: order.scheduledMatchingAt,
						},
						"[ScheduledOrderCron] Updated scheduled order to MATCHING status",
					);
				});

				processedOrders++;

				// Send push notification to user
				try {
					const scheduledTime = order.scheduledAt
						? new Date(order.scheduledAt).toLocaleTimeString("en-US", {
								hour: "2-digit",
								minute: "2-digit",
							})
						: "soon";

					const orderUrl = `${env.CORS_ORIGIN}/order/${order.id}`;

					await repo.notification.sendNotificationToUserId({
						fromUserId: "system",
						toUserId: order.userId,
						title: "Your Scheduled Ride is Starting",
						body: `We're finding a driver for your ${order.type.toLowerCase()} scheduled for ${scheduledTime}. Open the app to track your ride.`,
						data: {
							type: "SCHEDULED_ORDER_MATCHING",
							orderId: order.id,
							orderType: order.type,
							deeplink: `akademove://order/${order.id}`,
						},
						android: {
							priority: "high",
							notification: {
								clickAction: "USER_OPEN_ORDER_TRACKING",
							},
						},
						apns: {
							payload: {
								aps: {
									category: "ORDER_TRACKING",
									sound: "default",
								},
							},
						},
						webpush: {
							fcmOptions: {
								link: orderUrl,
							},
						},
					});

					notifiedOrders++;

					logger.info(
						{ orderId: order.id, userId: order.userId },
						"[ScheduledOrderCron] Sent matching notification to user",
					);
				} catch (notificationError) {
					// Don't fail the order processing if notification fails
					logger.error(
						{ error: notificationError, orderId: order.id },
						"[ScheduledOrderCron] Failed to send notification, but order was updated",
					);
				}

				// Enqueue driver matching job and broadcast to driver pool
				// This ensures drivers are notified immediately when scheduled order is ready
				try {
					// Fetch driver matching config from database
					const matchingConfig =
						await BusinessConfigurationService.getDriverMatchingConfig(
							svc.db,
							svc.kv,
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
						excludedDriverIds: [],
						isRetry: false,
					});

					logger.info(
						{ orderId: order.id },
						"[ScheduledOrderCron] Driver matching job enqueued for scheduled order",
					);

					// Broadcast to driver pool room via WebSocket for real-time driver matching
					// Uses queue-based delayed broadcast to allow WebSocket clients time to connect
					await ProcessingQueueService.enqueueWebSocketBroadcast(
						{
							roomName: DRIVER_POOL_KEY,
							action: "MATCHING",
							target: "SYSTEM",
							data: {
								detail: {
									payment: null,
									order: {
										...order,
										status: "MATCHING",
									},
									transaction: null,
								},
							},
						},
						{ delaySeconds: BUSINESS_CONSTANTS.BROADCAST_DELAY_SECONDS },
					);

					logger.info(
						{ orderId: order.id },
						"[ScheduledOrderCron] Broadcast enqueued to driver pool for scheduled order",
					);
				} catch (matchingError) {
					// Log but don't fail the order - the rebroadcast cron will handle stuck orders
					logger.error(
						{ error: matchingError, orderId: order.id },
						"[ScheduledOrderCron] Failed to enqueue driver matching job - rebroadcast cron will handle",
					);
				}
			} catch (error) {
				logger.error(
					{ error, orderId: order.id },
					"[ScheduledOrderCron] Failed to process scheduled order",
				);
			}
		}

		// Also send reminder notifications for orders coming up soon
		// (within MATCHING_LEAD_TIME_MINUTES * 2 but not yet at matching time)
		const reminderWindowStart = new Date(
			now.getTime() + SCHEDULING_CONFIG.MATCHING_LEAD_TIME_MINUTES * 60 * 1000,
		);
		const reminderWindowEnd = new Date(
			now.getTime() +
				SCHEDULING_CONFIG.MATCHING_LEAD_TIME_MINUTES * 2 * 60 * 1000,
		);

		const upcomingOrders = await svc.db.query.order.findMany({
			where: (f, op) =>
				op.and(
					eq(f.status, "SCHEDULED"),
					op.gte(f.scheduledMatchingAt, reminderWindowStart),
					lte(f.scheduledMatchingAt, reminderWindowEnd),
				),
			limit: 100,
		});

		let remindersSent = 0;

		for (const order of upcomingOrders) {
			try {
				const scheduledTime = order.scheduledAt
					? new Date(order.scheduledAt).toLocaleTimeString("en-US", {
							hour: "2-digit",
							minute: "2-digit",
						})
					: "soon";

				const minutesUntil = order.scheduledAt
					? Math.round(
							(new Date(order.scheduledAt).getTime() - now.getTime()) /
								(60 * 1000),
						)
					: SCHEDULING_CONFIG.MATCHING_LEAD_TIME_MINUTES * 2;

				await repo.notification.sendNotificationToUserId({
					fromUserId: "system",
					toUserId: order.userId,
					title: "Upcoming Scheduled Ride",
					body: `Your ${order.type.toLowerCase()} is scheduled for ${scheduledTime} (in ~${minutesUntil} minutes). Make sure you're ready!`,
					data: {
						type: "SCHEDULED_ORDER_REMINDER",
						orderId: order.id,
						orderType: order.type,
						deeplink: `akademove://order/${order.id}`,
					},
				});

				remindersSent++;

				logger.debug(
					{ orderId: order.id, minutesUntil },
					"[ScheduledOrderCron] Sent reminder notification",
				);
			} catch (reminderError) {
				logger.warn(
					{ error: reminderError, orderId: order.id },
					"[ScheduledOrderCron] Failed to send reminder notification",
				);
			}
		}

		logger.info(
			{
				processedOrders,
				notifiedOrders,
				remindersSent,
				totalReadyOrders: readyOrders.length,
				totalUpcomingOrders: upcomingOrders.length,
			},
			"[ScheduledOrderCron] Completed scheduled order processing",
		);

		return new Response(
			`Scheduled order cron completed. Processed: ${processedOrders}, Notified: ${notifiedOrders}, Reminders: ${remindersSent}`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error },
			"[ScheduledOrderCron] Failed to process scheduled orders",
		);
		return new Response("Scheduled order cron failed", { status: 500 });
	}
}

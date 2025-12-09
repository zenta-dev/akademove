import type { ExecutionContext } from "@cloudflare/workers-types";
import { env } from "cloudflare:workers";
import { and, eq, lte } from "drizzle-orm";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { log } from "@/utils";
import { SCHEDULING_CONFIG } from "./services/order-scheduling-service";

/**
 * Scheduled handler for processing scheduled orders
 * Called by Cloudflare Workers cron trigger
 *
 * Tasks:
 * 1. Find orders with status='SCHEDULED' where scheduledMatchingAt <= now
 * 2. Update status to 'MATCHING'
 * 3. Send push notification to user that their scheduled ride is being matched
 *
 * Note: The actual driver matching is triggered when the user's app reconnects
 * to the WebSocket or via the order status update broadcast.
 */
export async function handleScheduledOrderCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		log.info({}, "[ScheduledOrderCron] Starting scheduled order processing");

		const svc = getServices();
		const managers = getManagers();
		const repo = getRepositories(svc, managers);

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

		log.info(
			{ orderCount: readyOrders.length },
			"[ScheduledOrderCron] Found scheduled orders ready for matching",
		);

		for (const order of readyOrders) {
			try {
				await svc.db.transaction(async (tx) => {
					// Update order status to MATCHING
					await tx
						.update(tables.order)
						.set({
							status: "MATCHING",
							updatedAt: now,
						})
						.where(eq(tables.order.id, order.id));

					log.info(
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

					log.info(
						{ orderId: order.id, userId: order.userId },
						"[ScheduledOrderCron] Sent matching notification to user",
					);
				} catch (notificationError) {
					// Don't fail the order processing if notification fails
					log.error(
						{ error: notificationError, orderId: order.id },
						"[ScheduledOrderCron] Failed to send notification, but order was updated",
					);
				}
			} catch (error) {
				log.error(
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

				log.debug(
					{ orderId: order.id, minutesUntil },
					"[ScheduledOrderCron] Sent reminder notification",
				);
			} catch (reminderError) {
				log.warn(
					{ error: reminderError, orderId: order.id },
					"[ScheduledOrderCron] Failed to send reminder notification",
				);
			}
		}

		log.info(
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
		log.error(
			{ error },
			"[ScheduledOrderCron] Failed to process scheduled orders",
		);
		return new Response("Scheduled order cron failed", { status: 500 });
	}
}

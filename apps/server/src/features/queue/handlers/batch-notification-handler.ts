/**
 * Batch Notification Handler
 *
 * Handles BATCH_NOTIFICATION queue messages.
 * Sends notifications to multiple drivers for order broadcasting.
 */

import type { BatchNotificationJob } from "@repo/schema/queue";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleBatchNotification(
	job: BatchNotificationJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload } = job;
	const { orderId, driverUserIds, notification } = payload;

	logger.info(
		{ orderId, driverCount: driverUserIds.length },
		"[BatchNotificationHandler] Processing batch notification",
	);

	if (driverUserIds.length === 0) {
		logger.warn(
			{ orderId },
			"[BatchNotificationHandler] No drivers to notify - skipping",
		);
		return;
	}

	try {
		await context.repo.notification.sendNotificationToUserIds({
			fromUserId: "system",
			toUserIds: driverUserIds,
			title: notification.title,
			body: notification.body,
			data: notification.data,
			android: {
				priority: "high",
				notification: { clickAction: "DRIVER_OPEN_ORDER_DETAIL" },
			},
			apns: {
				payload: { aps: { category: "ORDER_DETAIL", sound: "default" } },
			},
		});

		logger.info(
			{ orderId, notifiedCount: driverUserIds.length },
			"[BatchNotificationHandler] Batch notification sent",
		);
	} catch (error) {
		logger.error(
			{ error, orderId, driverCount: driverUserIds.length },
			"[BatchNotificationHandler] Failed to send batch notification",
		);
		throw error;
	}
}

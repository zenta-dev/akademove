/**
 * Push Notification Handler
 *
 * Handles PUSH_NOTIFICATION queue messages.
 * Sends FCM notifications to individual users.
 */

import type { PushNotificationJob } from "@repo/schema/queue";
import type {
	AndroidConfig,
	ApnsConfig,
	WebpushConfig,
} from "firebase-admin/messaging";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

/**
 * Convert queue payload android config to Firebase AndroidConfig
 */
function buildAndroidConfig(
	android: PushNotificationJob["payload"]["android"],
): AndroidConfig | undefined {
	if (!android) return undefined;

	return {
		priority: android.priority,
		notification: android.notification
			? {
					clickAction: android.notification.clickAction,
					channelId: android.notification.channelId,
				}
			: undefined,
	};
}

/**
 * Convert queue payload apns config to Firebase ApnsConfig
 */
function buildApnsConfig(
	apns: PushNotificationJob["payload"]["apns"],
): ApnsConfig | undefined {
	if (!apns) return undefined;

	return {
		payload: {
			aps: apns.payload?.aps
				? {
						category: apns.payload.aps.category,
						sound: apns.payload.aps.sound,
						badge: apns.payload.aps.badge,
					}
				: {},
		},
	};
}

/**
 * Convert queue payload webpush config to Firebase WebpushConfig
 */
function buildWebpushConfig(
	webpush: PushNotificationJob["payload"]["webpush"],
): WebpushConfig | undefined {
	if (!webpush) return undefined;

	return {
		fcmOptions: webpush.fcmOptions
			? {
					link: webpush.fcmOptions.link,
				}
			: undefined,
	};
}

export async function handlePushNotification(
	job: PushNotificationJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload } = job;

	logger.debug(
		{ toUserId: payload.toUserId, title: payload.title },
		"[PushNotificationHandler] Processing notification",
	);

	try {
		await context.repo.notification.sendNotificationToUserId({
			fromUserId: payload.fromUserId ?? "system",
			toUserId: payload.toUserId,
			title: payload.title,
			body: payload.body,
			data: payload.data,
			android: buildAndroidConfig(payload.android),
			apns: buildApnsConfig(payload.apns),
			webpush: buildWebpushConfig(payload.webpush),
		});

		logger.info(
			{ toUserId: payload.toUserId },
			"[PushNotificationHandler] Notification sent successfully",
		);
	} catch (error) {
		logger.error(
			{ error, toUserId: payload.toUserId },
			"[PushNotificationHandler] Failed to send notification",
		);
		throw error;
	}
}

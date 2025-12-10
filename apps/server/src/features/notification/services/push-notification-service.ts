/**
 * PushNotificationService - Handles push notification delivery via Firebase
 *
 * SOLID Principles:
 * - SRP: Single responsibility for sending push notifications
 * - OCP: Open for extension with new notification providers
 * - DIP: Depends on IFirebaseService interface
 */

import type {
	InsertFCMNotificationLog,
	InsertUserNotification,
} from "@repo/schema/notification";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import type {
	FirebaseAdminService,
	NotificationPayload,
} from "@/core/services/firebase";
import { logger } from "@/utils/logger";

export interface SendNotificationOptions extends NotificationPayload {
	fromUserId: string;
	toUserId?: string;
	toUserIds?: string[];
}

export interface NotificationResult {
	messageIds: string[];
	logs: InsertFCMNotificationLog[];
	userNotifications: InsertUserNotification[];
}

/**
 * Interface for FCM token provider
 * Allows dependency injection for testing and flexibility
 */
export interface IFCMTokenProvider {
	listByUserId(
		userId: string,
		opts?: PartialWithTx,
	): Promise<Array<{ token: string }>>;
	listByUserIds(
		userIds: string[],
		opts?: PartialWithTx,
	): Promise<Array<{ token: string }>>;
}

/**
 * PushNotificationService
 *
 * Responsibilities:
 * - Send push notifications to individual users
 * - Send push notifications to multiple users
 * - Send push notifications to topics
 * - Handle Firebase messaging errors
 * - Prepare notification logs for persistence
 */
export class PushNotificationService {
	constructor(private readonly firebaseAdmin: FirebaseAdminService) {}

	/**
	 * Send push notification to a single user
	 *
	 * @param params - Notification parameters
	 * @param tokenProvider - Provider to fetch user's FCM tokens
	 * @param opts - Transaction options
	 * @returns Notification result with message IDs and logs
	 */
	async sendToUser(
		params: SendNotificationOptions & { toUserId: string },
		tokenProvider: IFCMTokenProvider,
		opts?: PartialWithTx,
	): Promise<NotificationResult> {
		const { toUserId, fromUserId } = params;

		try {
			logger.debug(
				{ toUserId },
				"[PushNotificationService] Fetching FCM tokens",
			);

			const tokenResults = await tokenProvider.listByUserId(toUserId, opts);

			if (!tokenResults.length) {
				logger.warn(
					{ toUserId },
					"[PushNotificationService] No FCM tokens found",
				);
				return {
					messageIds: [],
					logs: [],
					userNotifications: [],
				};
			}

			logger.info(
				{ toUserId, tokenCount: tokenResults.length },
				"[PushNotificationService] Sending notifications",
			);

			const messageIds = await Promise.all(
				tokenResults.map((t) =>
					this.firebaseAdmin.sendNotification({ ...params, token: t.token }),
				),
			);

			const sentAt = new Date();

			const logs: InsertFCMNotificationLog[] = messageIds.map((messageId) => ({
				...params,
				userId: fromUserId,
				messageId,
				status: "SUCCESS",
				sentAt,
			}));

			const userNotifications: InsertUserNotification[] = messageIds.map(
				(messageId) => ({
					...params,
					messageId,
					userId: toUserId,
					isRead: false,
				}),
			);

			logger.info(
				{ toUserId, messageCount: messageIds.length },
				"[PushNotificationService] Notifications sent successfully",
			);

			return { messageIds, logs, userNotifications };
		} catch (error) {
			logger.error(
				{ error, toUserId },
				"[PushNotificationService] Failed to send notification",
			);

			const msg = error instanceof Error ? error.message : "Unknown error";

			const failLog: InsertFCMNotificationLog = {
				...params,
				userId: fromUserId,
				status: "FAILED",
				sentAt: new Date(),
				error: msg,
			};

			const userNotification: InsertUserNotification = {
				...params,
				userId: toUserId,
				isRead: false,
			};

			return {
				messageIds: [],
				logs: [failLog],
				userNotifications: [userNotification],
			};
		}
	}

	/**
	 * Send push notification to multiple users
	 *
	 * @param params - Notification parameters
	 * @param tokenProvider - Provider to fetch users' FCM tokens
	 * @param opts - Transaction options
	 * @returns Notification result with message IDs and logs
	 */
	async sendToUsers(
		params: SendNotificationOptions & { toUserIds: string[] },
		tokenProvider: IFCMTokenProvider,
		opts?: PartialWithTx,
	): Promise<NotificationResult> {
		const { toUserIds, fromUserId } = params;

		try {
			logger.debug(
				{ userCount: toUserIds.length },
				"[PushNotificationService] Fetching FCM tokens for multiple users",
			);

			const tokenResults = await tokenProvider.listByUserIds(toUserIds, opts);

			if (!tokenResults.length) {
				logger.warn(
					{ userCount: toUserIds.length },
					"[PushNotificationService] No FCM tokens found",
				);
				return {
					messageIds: [],
					logs: [],
					userNotifications: [],
				};
			}

			logger.info(
				{ userCount: toUserIds.length, tokenCount: tokenResults.length },
				"[PushNotificationService] Sending notifications to multiple users",
			);

			const messageIds = await Promise.all(
				tokenResults.map((t) =>
					this.firebaseAdmin.sendNotification({ ...params, token: t.token }),
				),
			);

			const sentAt = new Date();

			const logs: InsertFCMNotificationLog[] = messageIds.map((messageId) => ({
				...params,
				userId: fromUserId,
				messageId,
				status: "SUCCESS",
				sentAt,
			}));

			const userNotifications: InsertUserNotification[] = toUserIds.flatMap(
				(userId) =>
					messageIds.map((messageId) => ({
						...params,
						messageId,
						userId,
						isRead: false,
					})),
			);

			logger.info(
				{ userCount: toUserIds.length, messageCount: messageIds.length },
				"[PushNotificationService] Notifications sent successfully",
			);

			return { messageIds, logs, userNotifications };
		} catch (error) {
			logger.error(
				{ error, userCount: toUserIds.length },
				"[PushNotificationService] Failed to send notifications",
			);

			const msg = error instanceof Error ? error.message : "Unknown error";

			const failLog: InsertFCMNotificationLog = {
				...params,
				userId: fromUserId,
				status: "FAILED",
				sentAt: new Date(),
				error: msg,
			};

			const userNotifications: InsertUserNotification[] = toUserIds.map(
				(userId) => ({
					...params,
					userId,
					isRead: false,
				}),
			);

			return {
				messageIds: [],
				logs: [failLog],
				userNotifications,
			};
		}
	}

	/**
	 * Send push notification to a topic
	 *
	 * @param params - Notification parameters with topic
	 * @returns Message ID from Firebase
	 * @throws {RepositoryError} When Firebase messaging fails
	 */
	async sendToTopic(
		params: NotificationPayload & { topic: string },
	): Promise<string> {
		try {
			logger.debug(
				{ topic: params.topic },
				"[PushNotificationService] Sending to topic",
			);

			const messageId = await this.firebaseAdmin.sendToTopic(params);

			logger.info(
				{ topic: params.topic, messageId },
				"[PushNotificationService] Topic notification sent",
			);

			return messageId;
		} catch (error) {
			logger.error(
				{ error, topic: params.topic },
				"[PushNotificationService] Failed to send topic notification",
			);

			const msg = error instanceof Error ? error.message : "Unknown error";
			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	/**
	 * Subscribe a device token to a topic
	 *
	 * @param token - FCM device token
	 * @param topic - Topic name
	 * @returns Subscription result from Firebase
	 */
	async subscribeToTopic(token: string, topic: string) {
		try {
			logger.debug({ topic }, "[PushNotificationService] Subscribing to topic");

			const result = await this.firebaseAdmin.subscribeToTopic(token, topic);

			logger.info({ topic }, "[PushNotificationService] Subscribed to topic");

			return result;
		} catch (error) {
			logger.error(
				{ error, topic },
				"[PushNotificationService] Failed to subscribe to topic",
			);

			const msg = error instanceof Error ? error.message : "Unknown error";
			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	/**
	 * Unsubscribe a device token from a topic
	 *
	 * @param token - FCM device token
	 * @param topic - Topic name
	 * @returns Unsubscription result from Firebase
	 */
	async unsubscribeFromTopic(token: string, topic: string) {
		try {
			logger.debug(
				{ topic },
				"[PushNotificationService] Unsubscribing from topic",
			);

			const result = await this.firebaseAdmin.unsubscribeFromTopic(
				token,
				topic,
			);

			logger.info(
				{ topic },
				"[PushNotificationService] Unsubscribed from topic",
			);

			return result;
		} catch (error) {
			logger.error(
				{ error, topic },
				"[PushNotificationService] Failed to unsubscribe from topic",
			);

			const msg = error instanceof Error ? error.message : "Unknown error";
			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}
}

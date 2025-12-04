import type { NotificationPayload } from "@/core/services/firebase";

/**
 * Service responsible for topic notification operations
 *
 * @responsibility Prepare user notifications from topic subscribers
 */
export class NotificationTopicService {
	/**
	 * Prepare user notifications for all topic subscribers
	 */
	static prepareUserNotifications(
		topicUsers: Array<{ userId: string }>,
		payload: NotificationPayload,
		messageId: string,
	): Array<
		NotificationPayload & { userId: string; messageId: string; isRead: boolean }
	> {
		return topicUsers.map((t) => ({
			...payload,
			userId: t.userId,
			messageId,
			isRead: false,
		}));
	}

	/**
	 * Extract error message from unknown error type
	 */
	static extractErrorMessage(error: unknown): string {
		return error instanceof Error ? error.message : "Unknown error";
	}
}

/**
 * NotificationRepository - Refactored to use PushNotificationService
 *
 * SOLID Principles Applied:
 * - SRP: Delegates notification sending to PushNotificationService
 * - DIP: Depends on PushNotificationService abstraction
 * - OCP: Open for extension with new notification providers
 */

import { m } from "@repo/i18n";
import {
	type FCMNotificationLog,
	FCMNotificationLogKeySchema,
	type FCMToken,
	type FCMTopicSubscription,
	type InsertFCMNotificationLog,
	type InsertFCMTopicSubscription,
	type InsertUserNotification,
	type UpdateUserNotification,
	type UserNotification,
	UserNotificationKeySchema,
} from "@repo/schema/notification";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { nullsToUndefined } from "@repo/shared";
import { and, count, eq, gt, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	OrderByOperation,
	PartialWithTx,
	WithUserId,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { NotificationPayload } from "@/core/services/firebase";
import type { KeyValueService } from "@/core/services/kv";
import type {
	FCMNotificationLogDatabase,
	FCMTokenDatabase,
	FCMTopicSubscriptionDatabase,
	UserNotificationDatabase,
} from "@/core/tables/notification";
import { logger } from "@/utils/logger";
import type { ListNotificationQuery } from "./notification-spec";
import {
	NotificationTopicService,
	type PushNotificationService,
} from "./services";

interface SendNotificationOptions extends NotificationPayload {
	fromUserId: string;
}

/**
 * NotificationRepository
 *
 * Responsibilities:
 * - Coordinate notification sending via PushNotificationService
 * - Persist FCM tokens, logs, and user notifications
 * - Manage topic subscriptions
 * - List user notifications with pagination
 */
export class NotificationRepository {
	#pushNotificationService: PushNotificationService;
	#fcmToken: FCMTokenRepository;
	#fcmTopic: FCMTopicSubscriptionRepository;
	#fcmNotificationLog: FCMNotificationLogRepository;
	#userNotification: UserNotificationRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		pushNotificationService: PushNotificationService,
	) {
		this.#pushNotificationService = pushNotificationService;
		this.#fcmToken = new FCMTokenRepository(db, kv);
		this.#fcmTopic = new FCMTopicSubscriptionRepository(db, kv);
		this.#fcmNotificationLog = new FCMNotificationLogRepository(db, kv);
		this.#userNotification = new UserNotificationRepository(db, kv);
	}

	/**
	 * Send push notification to a single user
	 * Delegates to PushNotificationService and persists results
	 */
	async sendNotificationToUserId(
		params: SendNotificationOptions & {
			toUserId: string;
		},
		opts?: PartialWithTx,
	): Promise<string[]> {
		const { toUserId } = params;

		try {
			// Delegate to PushNotificationService
			const result = await this.#pushNotificationService.sendToUser(
				{ ...params, toUserId },
				this.#fcmToken,
				opts,
			);

			// Persist logs and user notifications
			await Promise.all([
				result.logs.length > 0 &&
					this.#fcmNotificationLog.createBatch(result.logs, opts),
				result.userNotifications.length > 0 &&
					this.#userNotification.createBatch(result.userNotifications, opts),
			]);

			logger.info(
				{ toUserId, messageCount: result.messageIds.length },
				"[NotificationRepository] Notification sent to user",
			);

			return result.messageIds;
		} catch (error) {
			logger.error(
				{ error, toUserId },
				"[NotificationRepository] Failed to send notification to user",
			);
			throw error;
		}
	}

	/**
	 * Send push notification to multiple users
	 * Delegates to PushNotificationService and persists results
	 */
	async sendNotificationToUserIds(
		params: SendNotificationOptions & {
			toUserIds: string[];
		},
		opts?: PartialWithTx,
	): Promise<string[]> {
		const { toUserIds } = params;

		try {
			// Delegate to PushNotificationService
			const result = await this.#pushNotificationService.sendToUsers(
				{ ...params, toUserIds },
				this.#fcmToken,
				opts,
			);

			// Persist logs and user notifications
			await Promise.all([
				result.logs.length > 0 &&
					this.#fcmNotificationLog.createBatch(result.logs, opts),
				result.userNotifications.length > 0 &&
					this.#userNotification.createBatch(result.userNotifications, opts),
			]);

			logger.info(
				{ toUserIds, messageCount: result.messageIds.length },
				"[NotificationRepository] Notification sent to users",
			);

			return result.messageIds;
		} catch (error) {
			logger.error(
				{ error, toUserIds },
				"[NotificationRepository] Failed to send notification to users",
			);
			throw error;
		}
	}

	/**
	 * Send push notification to a topic (broadcast)
	 * Delegates to PushNotificationService and persists results
	 */
	async sendToTopic(
		params: NotificationPayload & { topic: string; userId: string },
		opts?: PartialWithTx,
	): Promise<string> {
		const { userId, topic, ...payload } = params;

		try {
			// Send notification and get topic subscribers
			const [messageId, topicUsers] = await Promise.all([
				this.#pushNotificationService.sendToTopic({ ...payload, topic }),
				this.#fcmTopic.listByTopic(topic, opts),
			]);

			const sentAt = new Date();

			// Use NotificationTopicService to prepare user notifications
			const userNotifications =
				NotificationTopicService.prepareUserNotifications(
					topicUsers,
					payload,
					messageId,
				);

			// Persist log and user notifications
			await Promise.all([
				this.#fcmNotificationLog.create(
					{
						...payload,
						userId,
						messageId,
						status: "SUCCESS",
						sentAt,
					},
					opts,
				),
				userNotifications.length > 0 &&
					this.#userNotification.createBatch(userNotifications, opts),
			]);

			logger.info(
				{ topic, subscribers: topicUsers.length, messageId },
				"[NotificationRepository] Notification sent to topic",
			);

			return messageId;
		} catch (error) {
			logger.error(
				{ error, topic },
				"[NotificationRepository] Failed to send notification to topic",
			);

			// Use NotificationTopicService to extract error message
			const msg = NotificationTopicService.extractErrorMessage(error);

			// Log failure
			const topicUsers = await this.#fcmTopic.listByTopic(topic, opts);

			// Use NotificationTopicService to prepare user notifications for failure case
			const userNotifications =
				NotificationTopicService.prepareUserNotifications(
					topicUsers,
					payload,
					"",
				);

			await Promise.all([
				this.#fcmNotificationLog.create(
					{
						...payload,
						userId,
						status: "FAILED",
						sentAt: new Date(),
						error: msg,
					},
					opts,
				),
				userNotifications.length > 0 &&
					this.#userNotification.createBatch(userNotifications, opts),
			]);

			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	/**
	 * List user notifications with pagination
	 */
	async list(
		query: ListNotificationQuery & WithUserId,
		opts?: PartialWithTx,
	): Promise<ListResult<UserNotification>> {
		return await this.#userNotification.list(query, opts);
	}

	/**
	 * Get unread notification count for a user
	 */
	async getUnreadCount(userId: string, opts?: PartialWithTx): Promise<number> {
		return await this.#userNotification.countUnread(userId, opts);
	}

	/**
	 * Mark a notification as read
	 */
	async markAsRead(
		params: { id: string; userId: string },
		opts?: PartialWithTx,
	): Promise<UserNotification> {
		return await this.#userNotification.markAsRead(params, opts);
	}

	/**
	 * Mark all notifications as read for a user
	 */
	async markAllAsRead(userId: string, opts?: PartialWithTx): Promise<number> {
		return await this.#userNotification.markAllAsRead(userId, opts);
	}

	/**
	 * Delete a notification
	 */
	async deleteNotification(
		params: { id: string; userId: string },
		opts?: PartialWithTx,
	): Promise<void> {
		return await this.#userNotification.deleteById(params, opts);
	}

	/**
	 * Subscribe user's FCM token to a topic
	 */
	async subscribeToTopic(
		params: {
			token: string;
			topic: string;
			userId: string;
		},
		opts?: PartialWithTx,
	) {
		const [res] = await Promise.all([
			this.#pushNotificationService.subscribeToTopic(
				params.token,
				params.topic,
			),
			this.#fcmTopic.subscribe(params, opts),
		]);

		logger.info(
			{ userId: params.userId, topic: params.topic },
			"[NotificationRepository] Subscribed to topic",
		);

		return res;
	}

	/**
	 * Unsubscribe user's FCM token from a topic
	 */
	async unsubscribeFromTopic(
		params: {
			token: string;
			topic: string;
			userId: string;
		},
		opts?: PartialWithTx,
	) {
		const [res] = await Promise.all([
			this.#pushNotificationService.unsubscribeFromTopic(
				params.token,
				params.topic,
			),
			this.#fcmTopic.unsubscribe(params, opts),
		]);

		logger.info(
			{ userId: params.userId, topic: params.topic },
			"[NotificationRepository] Unsubscribed from topic",
		);

		return res;
	}

	/**
	 * Save FCM token for a user
	 */
	async saveToken(
		params: { userId: string; token: string },
		opts?: PartialWithTx,
	) {
		return await this.#fcmToken.saveToken(params, opts);
	}

	/**
	 * Remove FCM token
	 */
	async removeByToken(params: { token: string }, opts?: PartialWithTx) {
		return await this.#fcmToken.removeByToken(params, opts);
	}
}

/**
 * FCMTokenRepository - Implements IFCMTokenProvider interface
 * Manages FCM device tokens for push notifications
 */
class FCMTokenRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("fcmToken", kv, db);
	}

	static composeEntity(item: FCMTokenDatabase): FCMToken {
		return item;
	}

	async listByUserId(
		userId: string,
		opts?: PartialWithTx,
	): Promise<FCMToken[]> {
		try {
			const tx = opts?.tx ?? this.db;
			const fallback = async () => {
				const res = await tx.query.fcmToken.findMany({
					where: (f, op) => op.eq(f.userId, userId),
				});

				if (res.length > 0) {
					await this.setCache(userId, res, {
						expirationTtl: CACHE_TTLS["1h"],
					});
				}

				return res;
			};
			const res = await this.getCache(userId, { fallback });

			return res.map(FCMTokenRepository.composeEntity);
		} catch (error) {
			throw this.handleError(error, "list by user id");
		}
	}

	async listByUserIds(
		userIds: string[],
		opts?: PartialWithTx,
	): Promise<FCMToken[]> {
		try {
			const tx = opts?.tx ?? this.db;
			const res = await tx.query.fcmToken.findMany({
				where: (f, op) => op.inArray(f.userId, userIds),
			});

			return res.map(FCMTokenRepository.composeEntity);
		} catch (error) {
			throw this.handleError(error, "list by user ids");
		}
	}

	async saveToken(
		params: { userId: string; token: string },
		opts?: PartialWithTx,
	): Promise<FCMToken> {
		try {
			const { userId, token } = params;

			const tx = opts?.tx ?? this.db;

			const [res] = await tx
				.insert(tables.fcmToken)
				.values({ userId, token })
				.onConflictDoUpdate({
					target: tables.fcmToken.token,
					set: {
						userId,
						updatedAt: new Date(),
					},
				})
				.returning();

			return FCMTokenRepository.composeEntity(res);
		} catch (error) {
			throw this.handleError(error, "save token");
		}
	}

	async getByToken(token: string, opts?: PartialWithTx): Promise<FCMToken> {
		try {
			const tx = opts?.tx ?? this.db;

			const fallback = async () => {
				const res = await tx.query.fcmToken.findFirst({
					where: (f, op) => op.eq(f.token, token),
				});

				if (res) {
					await this.setCache(token, res, { expirationTtl: CACHE_TTLS["1h"] });
				}

				return res;
			};

			const res = await this.getCache(token, { fallback });

			if (!res) {
				throw new RepositoryError(m.error_failed_find_by_token());
			}

			return FCMTokenRepository.composeEntity(res);
		} catch (error) {
			throw this.handleError(error, "get by token");
		}
	}

	async removeByUserId(userId: string, opts?: PartialWithTx): Promise<void> {
		try {
			const tx = opts?.tx ?? this.db;

			await Promise.all([
				tx.delete(tables.fcmToken).where(eq(tables.fcmToken.userId, userId)),
				this.deleteCache(userId),
			]);
		} catch (error) {
			throw this.handleError(error, "remove by user id");
		}
	}

	async removeByToken(
		params: { token: string },
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			const tx = opts?.tx ?? this.db;

			await tx
				.delete(tables.fcmToken)
				.where(eq(tables.fcmToken.token, params.token));
		} catch (error) {
			throw this.handleError(error, "remove by token");
		}
	}
}

/**
 * FCMTopicSubscriptionRepository
 * Manages topic subscriptions for push notifications
 */
class FCMTopicSubscriptionRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("fcmTopicSubscription", kv, db);
	}

	static composeEntity(
		item: FCMTopicSubscriptionDatabase,
	): FCMTopicSubscription {
		return item;
	}

	async listByTopic(
		topic: string,
		opts?: PartialWithTx,
	): Promise<FCMTopicSubscription[]> {
		try {
			const tx = opts?.tx ?? this.db;

			const fallback = async () => {
				const res = await tx.query.fcmTopicSubscription.findMany({
					where: (f, op) => op.eq(f.topic, topic),
				});

				if (res) {
					await this.setCache(topic, res, { expirationTtl: CACHE_TTLS["1h"] });
				}

				return res;
			};

			const res = await this.getCache(topic, { fallback });

			return res.map(FCMTopicSubscriptionRepository.composeEntity);
		} catch (error) {
			throw this.handleError(error, "list by topic");
		}
	}

	async subscribe(
		item: InsertFCMTopicSubscription,
		opts?: PartialWithTx,
	): Promise<FCMTopicSubscription | undefined> {
		try {
			const tx = opts?.tx ?? this.db;

			const [res] = await Promise.all([
				tx
					.insert(tables.fcmTopicSubscription)
					.values({ ...item, id: v7() })
					.onConflictDoNothing()
					.returning(),
				this.deleteCache(item.topic),
			]);

			// onConflictDoNothing may return empty array if conflict occurred
			if (!res || res.length === 0) {
				return undefined;
			}

			return FCMTopicSubscriptionRepository.composeEntity(res[0]);
		} catch (error) {
			throw this.handleError(error, "subscribe");
		}
	}

	async unsubscribe(
		item: InsertFCMTopicSubscription,
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			const tx = opts?.tx ?? this.db;

			await Promise.all([
				tx
					.delete(tables.fcmTopicSubscription)
					.where(
						and(
							eq(tables.fcmTopicSubscription.userId, item.userId),
							eq(tables.fcmTopicSubscription.token, item.token),
							eq(tables.fcmTopicSubscription.topic, item.topic),
						),
					),
				this.deleteCache(item.topic),
			]);
		} catch (error) {
			throw this.handleError(error, "unsubscribe");
		}
	}
}

/**
 * FCMNotificationLogRepository
 * Manages FCM notification logs for audit trail
 */
class FCMNotificationLogRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("fcmNotificationLog", kv, db);
	}

	static composeEntity(item: FCMNotificationLogDatabase): FCMNotificationLog {
		return nullsToUndefined(item);
	}

	async list(
		query?: UnifiedPaginationQuery & WithUserId,
		opts?: PartialWithTx,
	): Promise<ListResult<FCMNotificationLog>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				sortBy,
				order = "asc",
				userId,
			} = query ?? {};

			if (!userId) {
				throw new RepositoryError(m.error_list_fcm_must_have_user_id(), {
					code: "BAD_REQUEST",
				});
			}

			const orderBy = (
				f: typeof tables.fcmNotificationLog._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = FCMNotificationLogKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [eq(tables.fcmNotificationLog.userId, userId)];

			const tx = opts?.tx ?? this.db;

			if (cursor) {
				clauses.push(gt(tables.fcmNotificationLog.sentAt, new Date(cursor)));

				const res = await tx.query.fcmNotificationLog.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(FCMNotificationLogRepository.composeEntity);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const [res, [totalCountRes]] = await Promise.all([
					tx.query.fcmNotificationLog.findMany({
						where: (_, op) => op.and(...clauses),
						orderBy,
						offset,
						limit,
					}),
					tx
						.select({ count: count(tables.fcmNotificationLog.id) })
						.from(tables.fcmNotificationLog)
						.where(and(...clauses)),
				]);

				const rows = res.map(FCMNotificationLogRepository.composeEntity);

				const totalPages = Math.ceil(totalCountRes.count / limit);

				return { rows, totalPages };
			}

			const res = await tx.query.fcmNotificationLog.findMany({
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map(FCMNotificationLogRepository.composeEntity);

			return { rows };
		} catch (error) {
			throw this.handleError(error, "list");
		}
	}

	async create(
		item: InsertFCMNotificationLog,
		opts?: PartialWithTx,
	): Promise<FCMNotificationLog> {
		try {
			const tx = opts?.tx ?? this.db;

			const [res] = await tx
				.insert(tables.fcmNotificationLog)
				.values({
					...item,
					id: v7(),
				})
				.returning();

			return FCMNotificationLogRepository.composeEntity(res);
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async createBatch(
		item: InsertFCMNotificationLog[],
		opts?: PartialWithTx,
	): Promise<FCMNotificationLog[]> {
		try {
			const values = item.map((e) => ({ ...e, id: v7() }));

			const tx = opts?.tx ?? this.db;
			const res = await tx
				.insert(tables.fcmNotificationLog)
				.values(values)
				.returning();

			return res.map(FCMNotificationLogRepository.composeEntity);
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}
}

/**
 * UserNotificationRepository
 * Manages user-facing notification records
 */
class UserNotificationRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("userNotification", kv, db);
	}

	static composeEntity(item: UserNotificationDatabase): UserNotification {
		return nullsToUndefined(item);
	}

	async list(
		query?: ListNotificationQuery & WithUserId,
		opts?: PartialWithTx,
	): Promise<ListResult<UserNotification>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				sortBy,
				order = "asc",
				userId,
				read = "all",
			} = query ?? {};

			if (!userId) {
				throw new RepositoryError(m.error_list_fcm_must_have_user_id(), {
					code: "BAD_REQUEST",
				});
			}

			const orderBy = (
				f: typeof tables.userNotification._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = UserNotificationKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [eq(tables.userNotification.userId, userId)];
			switch (read) {
				case "unread":
					clauses.push(eq(tables.userNotification.isRead, false));
					break;
				case "readed":
					clauses.push(eq(tables.userNotification.isRead, true));
					break;
			}

			const tx = opts?.tx ?? this.db;

			if (cursor) {
				clauses.push(gt(tables.userNotification.createdAt, new Date(cursor)));

				const res = await tx.query.userNotification.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(UserNotificationRepository.composeEntity);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const [res, [totalCountRes]] = await Promise.all([
					tx.query.userNotification.findMany({
						where: (_, op) => op.and(...clauses),
						orderBy,
						offset,
						limit,
					}),
					tx
						.select({ count: count(tables.userNotification.id) })
						.from(tables.userNotification)
						.where(and(...clauses)),
				]);

				const rows = res.map(UserNotificationRepository.composeEntity);

				const totalPages = Math.ceil(totalCountRes.count / limit);

				return { rows, totalPages };
			}

			const res = await tx.query.userNotification.findMany({
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map(UserNotificationRepository.composeEntity);

			return { rows };
		} catch (error) {
			throw this.handleError(error, "list");
		}
	}

	async create(
		item: InsertUserNotification,
		opts?: PartialWithTx,
	): Promise<UserNotification> {
		try {
			const tx = opts?.tx ?? this.db;
			const [[res]] = await Promise.all([
				tx
					.insert(tables.userNotification)
					.values({ ...item, id: v7() })
					.returning(),
				this.deleteCache(`unread:${item.userId}`),
			]);

			return UserNotificationRepository.composeEntity(res);
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async createBatch(
		items: InsertUserNotification[],
		opts?: PartialWithTx,
	): Promise<UserNotification[]> {
		try {
			const deletePromises: Promise<void>[] = [];
			const tx = opts?.tx ?? this.db;
			const values = items.map((item) => {
				deletePromises.push(this.deleteCache(`unread:${item.userId}`));
				return { ...item, id: v7() };
			});

			const [rows] = await Promise.all([
				tx.insert(tables.userNotification).values(values).returning(),
				...deletePromises,
			]);

			return rows.map(UserNotificationRepository.composeEntity);
		} catch (error) {
			throw this.handleError(error, "create batch");
		}
	}

	async update(
		id: string,
		item: UpdateUserNotification,
		opts?: PartialWithTx,
	): Promise<UserNotification> {
		try {
			const tx = opts?.tx ?? this.db;
			const [[res]] = await Promise.all([
				tx
					.update(tables.userNotification)
					.set(item)
					.where(eq(tables.userNotification.id, id))
					.returning(),
				item.userId && this.deleteCache(`unread:${item.userId}`),
			]);

			return UserNotificationRepository.composeEntity(res);
		} catch (error) {
			throw this.handleError(error, "create batch");
		}
	}

	async countUnread(userId: string, opts?: PartialWithTx): Promise<number> {
		try {
			const key = `unread:${userId}`;

			const tx = opts?.tx ?? this.db;

			const fallback = async () => {
				const [res] = await tx
					.select({
						count: count(tables.userNotification.id),
					})
					.from(tables.userNotification)
					.where(
						and(
							eq(tables.userNotification.userId, userId),
							eq(tables.userNotification.isRead, false),
						),
					);

				await this.setCache(key, res);

				return res;
			};

			const res = await this.getCache(key, { fallback });

			return res.count;
		} catch (error) {
			throw this.handleError(error, "count unread");
		}
	}

	async markAsRead(
		params: { id: string; userId: string },
		opts?: PartialWithTx,
	): Promise<UserNotification> {
		try {
			const tx = opts?.tx ?? this.db;
			const [[res]] = await Promise.all([
				tx
					.update(tables.userNotification)
					.set({ isRead: true, readAt: new Date() })
					.where(
						and(
							eq(tables.userNotification.id, params.id),
							eq(tables.userNotification.userId, params.userId),
						),
					)
					.returning(),
				this.deleteCache(`unread:${params.userId}`),
			]);

			if (!res) {
				throw new RepositoryError(m.error_user_not_found(), {
					code: "NOT_FOUND",
				});
			}

			return UserNotificationRepository.composeEntity(res);
		} catch (error) {
			throw this.handleError(error, "mark as read");
		}
	}

	async markAllAsRead(userId: string, opts?: PartialWithTx): Promise<number> {
		try {
			const tx = opts?.tx ?? this.db;
			const result = await tx
				.update(tables.userNotification)
				.set({ isRead: true, readAt: new Date() })
				.where(
					and(
						eq(tables.userNotification.userId, userId),
						eq(tables.userNotification.isRead, false),
					),
				)
				.returning({ id: tables.userNotification.id });

			await this.deleteCache(`unread:${userId}`);

			return result.length;
		} catch (error) {
			throw this.handleError(error, "mark all as read");
		}
	}

	async deleteById(
		params: { id: string; userId: string },
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			const tx = opts?.tx ?? this.db;
			await Promise.all([
				tx
					.delete(tables.userNotification)
					.where(
						and(
							eq(tables.userNotification.id, params.id),
							eq(tables.userNotification.userId, params.userId),
						),
					),
				this.deleteCache(`unread:${params.userId}`),
			]);
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}
}

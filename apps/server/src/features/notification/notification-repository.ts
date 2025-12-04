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
import type {
	FirebaseAdminService,
	NotificationPayload,
	SendToTopicOptions,
} from "@/core/services/firebase";
import type { KeyValueService } from "@/core/services/kv";
import type {
	FCMNotificationLogDatabase,
	FCMTokenDatabase,
	FCMTopicSubscriptionDatabase,
	UserNotificationDatabase,
} from "@/core/tables/notification";
import { log } from "@/utils";
import type { ListNotificationQuery } from "./notification-spec";

interface SendNotificationOptions extends NotificationPayload {
	fromUserId: string;
}

export class NotificationRepository {
	#firebaseAdmin: FirebaseAdminService;
	#fcmToken: FCMTokenRepository;
	#fcmTopic: FCMTopicSubscriptionRepository;
	#fcmNotificationLog: FCMNotificationLogRepository;
	#userNotification: UserNotificationRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		firebaseAdmin: FirebaseAdminService,
	) {
		this.#firebaseAdmin = firebaseAdmin;
		this.#fcmToken = new FCMTokenRepository(db, kv);
		this.#fcmTopic = new FCMTopicSubscriptionRepository(db, kv);
		this.#fcmNotificationLog = new FCMNotificationLogRepository(db, kv);
		this.#userNotification = new UserNotificationRepository(db, kv);
	}

	async sendNotificationToUserId(
		params: SendNotificationOptions & {
			toUserId: string;
		},
		opts?: PartialWithTx,
	): Promise<string[]> {
		const { toUserId, fromUserId } = params;

		try {
			const tokenResults = await this.#fcmToken.listByUserId(toUserId, opts);
			log.info({ tokenResults }, "FCM tokens found for user");
			if (!tokenResults.length) return [];

			const messageIds = await Promise.all(
				tokenResults.map((t) =>
					this.#firebaseAdmin.sendNotification({ ...params, token: t.token }),
				),
			);
			log.info({ messageIds }, "FCM messages sent to tokens");

			const sentAt = new Date();

			const notificationLogs: InsertFCMNotificationLog[] = messageIds.map(
				(messageId) => ({
					...params,
					userId: fromUserId,
					messageId,
					status: "SUCCESS",
					sentAt,
				}),
			);

			const userNotification: InsertUserNotification[] = messageIds.map(
				(messageId) => ({
					...params,
					messageId,
					userId: toUserId,
					isRead: false,
				}),
			);

			await Promise.all([
				this.#fcmNotificationLog.createBatch(notificationLogs, opts),
				this.#userNotification.createBatch(userNotification, opts),
			]);

			return messageIds;
		} catch (error) {
			log.error({ error }, "Failed to send notification by token");

			const msg = error instanceof Error ? error.message : "Unknown error";

			const failLog: InsertFCMNotificationLog = {
				...params,
				userId: fromUserId,
				status: "FAILED",
				sentAt: new Date(),
				error: msg,
			};

			await Promise.all([
				this.#fcmNotificationLog.create(failLog, opts),
				this.#userNotification.create(
					{
						...params,
						userId: toUserId,
						isRead: false,
					},
					opts,
				),
			]);

			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}
	async sendNotificationToUserIds(
		params: SendNotificationOptions & {
			toUserIds: string[];
		},
		opts?: PartialWithTx,
	): Promise<string[]> {
		const { toUserIds, fromUserId } = params;

		try {
			const tokenResults = await this.#fcmToken.listByUserIds(toUserIds, opts);
			if (!tokenResults.length) return [];

			const messageIds = await Promise.all(
				tokenResults.map((t) =>
					this.#firebaseAdmin.sendNotification({ ...params, token: t.token }),
				),
			);

			const sentAt = new Date();

			const notificationLogs: InsertFCMNotificationLog[] = messageIds.map(
				(messageId) => ({
					...params,
					userId: fromUserId,
					messageId,
					status: "SUCCESS",
					sentAt,
				}),
			);

			const userNotifications: InsertUserNotification[] = [];
			for (const userId of toUserIds) {
				for (const messageId of messageIds) {
					userNotifications.push({
						...params,
						userId,
						messageId,
						isRead: false,
					});
				}
			}

			await Promise.all([
				this.#fcmNotificationLog.createBatch(notificationLogs, opts),
				this.#userNotification.createBatch(userNotifications, opts),
			]);

			return messageIds;
		} catch (error) {
			log.error({ error }, "Failed to send notification by token");

			const msg = error instanceof Error ? error.message : "Unknown error";

			const failLog: InsertFCMNotificationLog = {
				...params,
				userId: fromUserId,
				status: "FAILED",
				sentAt: new Date(),
				error: msg,
			};

			const failNotifications: InsertUserNotification[] = toUserIds.map(
				(userId) => ({
					...params,
					userId,
					isRead: false,
				}),
			);

			await Promise.all([
				this.#fcmNotificationLog.create(failLog, opts),
				this.#userNotification.createBatch(failNotifications, opts),
			]);

			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	async sendToTopic(
		params: SendToTopicOptions & WithUserId,
		opts?: PartialWithTx,
	): Promise<string> {
		try {
			const [messageId, topicUsers] = await Promise.all([
				this.#firebaseAdmin.sendToTopic(params),
				this.#fcmTopic.listByTopic(params.topic, opts),
			]);

			if (!topicUsers.length) return messageId;

			const userNotifications = topicUsers.map((t) => ({
				...params,
				userId: t.userId,
				messageId,
				isRead: false,
			}));

			await Promise.all([
				this.#fcmNotificationLog.create(
					{
						...params,
						status: "SUCCESS",
						sentAt: new Date(),
					},
					opts,
				),
				this.#userNotification.createBatch(userNotifications, opts),
			]);

			return messageId;
		} catch (error) {
			log.error({ error }, "Failed to send notification by topic");

			const msg = error instanceof Error ? error.message : "Unknown error";

			const topicUsers = await this.#fcmTopic.listByTopic(params.topic, opts);

			const userNotifications = topicUsers.map((t) => ({
				...params,
				userId: t.userId,
				isRead: false,
			}));

			await Promise.all([
				this.#fcmNotificationLog.create(
					{
						...params,
						status: "FAILED",
						sentAt: new Date(),
						error: msg,
					},
					opts,
				),
				this.#userNotification.createBatch(userNotifications, opts),
			]);

			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	async list(
		query: ListNotificationQuery & WithUserId,
		opts?: PartialWithTx,
	): Promise<ListResult<UserNotification>> {
		return await this.#userNotification.list(query, opts);
	}

	async subscribeToTopic(
		params: {
			token: string;
			topic: string;
			userId: string;
		},
		opts?: PartialWithTx,
	) {
		const [res] = await Promise.all([
			this.#firebaseAdmin.subscribeToTopic(params.token, params.topic),
			this.#fcmTopic.subscribe(params, opts),
		]);

		return res;
	}

	async unsubscribeFromTopic(
		params: {
			token: string;
			topic: string;
			userId: string;
		},
		opts?: PartialWithTx,
	) {
		const [res] = await Promise.all([
			this.#firebaseAdmin.unsubscribeFromTopic(params.token, params.topic),
			this.#fcmTopic.unsubscribe(params, opts),
		]);

		return res;
	}

	async saveToken(
		params: { userId: string; token: string },
		opts?: PartialWithTx,
	) {
		return await this.#fcmToken.saveToken(params, opts);
	}

	async removeByToken(params: { token: string }, opts?: PartialWithTx) {
		return await this.#fcmToken.removeByToken(params, opts);
	}
}

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
	): Promise<FCMTopicSubscription> {
		try {
			const tx = opts?.tx ?? this.db;

			const [[res]] = await Promise.all([
				tx
					.insert(tables.fcmTopicSubscription)
					.values({ ...item, id: v7() })
					.onConflictDoNothing()
					.returning(),
				this.deleteCache(item.topic),
			]);

			return FCMTopicSubscriptionRepository.composeEntity(res);
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

				const [res, totalCount] = await Promise.all([
					tx.query.fcmNotificationLog.findMany({
						where: (_, op) => op.and(...clauses),
						orderBy,
						offset,
						limit,
					}),
					this.getTotalRow(opts),
				]);

				const rows = res.map(FCMNotificationLogRepository.composeEntity);

				const totalPages = Math.ceil(totalCount / limit);

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

				const [res, totalCount] = await Promise.all([
					tx.query.userNotification.findMany({
						where: (_, op) => op.and(...clauses),
						orderBy,
						offset,
						limit,
					}),
					this.getTotalRow(opts),
				]);

				const rows = res.map(UserNotificationRepository.composeEntity);

				const totalPages = Math.ceil(totalCount / limit);

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
}

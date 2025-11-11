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
		opts: SendNotificationOptions & {
			toUserId: string;
		},
	): Promise<string[]> {
		const { toUserId, fromUserId } = opts;

		try {
			const tokenResults = await this.#fcmToken.listByUserId(toUserId);
			if (!tokenResults.length) return [];

			const messageIds = await Promise.all(
				tokenResults.map((t) =>
					this.#firebaseAdmin.sendNotification({ ...opts, token: t.token }),
				),
			);

			const sentAt = new Date();

			const notificationLogs: InsertFCMNotificationLog[] = messageIds.map(
				(messageId) => ({
					...opts,
					userId: fromUserId,
					messageId,
					status: "success",
					sentAt,
				}),
			);

			await Promise.all([
				this.#fcmNotificationLog.createBatch(notificationLogs),
				this.#userNotification.create({
					...opts,
					userId: toUserId,
					isRead: false,
				}),
			]);

			return messageIds;
		} catch (error) {
			log.error({ error }, "Failed to send notification by token");

			const msg = error instanceof Error ? error.message : "Unknown error";

			const failLog: InsertFCMNotificationLog = {
				...opts,
				userId: fromUserId,
				status: "failed",
				sentAt: new Date(),
				error: msg,
			};

			await Promise.all([
				this.#fcmNotificationLog.create(failLog),
				this.#userNotification.create({
					...opts,
					userId: toUserId,
					isRead: false,
				}),
			]);

			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}
	async sendNotificationToUserIds(
		opts: SendNotificationOptions & {
			toUserIds: string[];
		},
	): Promise<string[]> {
		const { toUserIds, fromUserId } = opts;

		try {
			const tokenResults = await this.#fcmToken.listByUserIds(toUserIds);
			if (!tokenResults.length) return [];

			const messageIds = await Promise.all(
				tokenResults.map((t) =>
					this.#firebaseAdmin.sendNotification({ ...opts, token: t.token }),
				),
			);

			const sentAt = new Date();

			const notificationLogs: InsertFCMNotificationLog[] = messageIds.map(
				(messageId) => ({
					...opts,
					userId: fromUserId,
					messageId,
					status: "success",
					sentAt,
				}),
			);

			const userNotifications: InsertUserNotification[] = [];
			for (const userId of toUserIds) {
				for (const messageId of messageIds) {
					userNotifications.push({ ...opts, userId, messageId, isRead: false });
				}
			}

			await Promise.all([
				this.#fcmNotificationLog.createBatch(notificationLogs),
				this.#userNotification.createBatch(userNotifications),
			]);

			return messageIds;
		} catch (error) {
			log.error({ error }, "Failed to send notification by token");

			const msg = error instanceof Error ? error.message : "Unknown error";

			const failLog: InsertFCMNotificationLog = {
				...opts,
				userId: fromUserId,
				status: "failed",
				sentAt: new Date(),
				error: msg,
			};

			const failNotifications: InsertUserNotification[] = toUserIds.map(
				(userId) => ({
					...opts,
					userId,
					isRead: false,
				}),
			);

			await Promise.all([
				this.#fcmNotificationLog.create(failLog),
				this.#userNotification.createBatch(failNotifications),
			]);

			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	async sendToTopic(opts: SendToTopicOptions & WithUserId): Promise<string> {
		try {
			const [messageId, topicUsers] = await Promise.all([
				this.#firebaseAdmin.sendToTopic(opts),
				this.#fcmTopic.listByTopic(opts.topic),
			]);

			if (!topicUsers.length) return messageId;

			const userNotifications = topicUsers.map((t) => ({
				...opts,
				userId: t.userId,
				messageId,
				isRead: false,
			}));

			await Promise.all([
				this.#fcmNotificationLog.create({
					...opts,
					status: "success",
					sentAt: new Date(),
				}),
				this.#userNotification.createBatch(userNotifications),
			]);

			return messageId;
		} catch (error) {
			log.error({ error }, "Failed to send notification by topic");

			const msg = error instanceof Error ? error.message : "Unknown error";

			const topicUsers = await this.#fcmTopic.listByTopic(opts.topic);

			const userNotifications = topicUsers.map((t) => ({
				...opts,
				userId: t.userId,
				isRead: false,
			}));

			await Promise.all([
				this.#fcmNotificationLog.create({
					...opts,
					status: "failed",
					sentAt: new Date(),
					error: msg,
				}),
				this.#userNotification.createBatch(userNotifications),
			]);

			throw new RepositoryError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	async list(
		query: ListNotificationQuery & WithUserId,
	): Promise<ListResult<UserNotification>> {
		return await this.#userNotification.list(query);
	}

	async subscribeToTopic(opts: {
		token: string;
		topic: string;
		userId: string;
	}) {
		const [res] = await Promise.all([
			this.#firebaseAdmin.subscribeToTopic(opts.token, opts.topic),
			this.#fcmTopic.subscribe(opts),
		]);

		return res;
	}

	async unsubscribeFromTopic(opts: {
		token: string;
		topic: string;
		userId: string;
	}) {
		const [res] = await Promise.all([
			this.#firebaseAdmin.unsubscribeFromTopic(opts.token, opts.topic),
			this.#fcmTopic.unsubscribe(opts),
		]);

		return res;
	}

	async saveToken(opts: { userId: string; token: string }) {
		return await this.#fcmToken.saveToken(opts);
	}

	async removeByToken(opts: { token: string }) {
		return await this.#fcmToken.removeByToken(opts);
	}
}

class FCMTokenRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("fcmToken", kv, db);
	}

	static composeEntity(item: FCMTokenDatabase): FCMToken {
		return item;
	}

	async listByUserId(userId: string): Promise<FCMToken[]> {
		try {
			const fallback = async () => {
				const res = await this.db.query.fcmToken.findMany({
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

	async listByUserIds(userIds: string[]): Promise<FCMToken[]> {
		try {
			const res = await this.db.query.fcmToken.findMany({
				where: (f, op) => op.inArray(f.userId, userIds),
			});

			return res.map(FCMTokenRepository.composeEntity);
		} catch (error) {
			throw this.handleError(error, "list by user ids");
		}
	}

	async saveToken(opts: { userId: string; token: string }) {
		try {
			const { userId, token } = opts;

			const [res] = await this.db
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

	async getByToken(token: string): Promise<FCMToken> {
		try {
			const fallback = async () => {
				const res = await this.db.query.fcmToken.findFirst({
					where: (f, op) => op.eq(f.token, token),
				});

				if (res) {
					await this.setCache(token, res, { expirationTtl: CACHE_TTLS["1h"] });
				}

				return res;
			};

			const res = await this.getCache(token, { fallback });

			if (!res) {
				throw new RepositoryError("Failed to find by token");
			}

			return FCMTokenRepository.composeEntity(res);
		} catch (error) {
			throw this.handleError(error, "get by token");
		}
	}

	async removeByUserId(userId: string): Promise<void> {
		try {
			await Promise.all([
				this.db
					.delete(tables.fcmToken)
					.where(eq(tables.fcmToken.userId, userId)),
				this.deleteCache(userId),
			]);
		} catch (error) {
			throw this.handleError(error, "remove by user id");
		}
	}

	async removeByToken(opts: { token: string }): Promise<void> {
		try {
			await this.db
				.delete(tables.fcmToken)
				.where(eq(tables.fcmToken.token, opts.token));
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

	async listByTopic(topic: string): Promise<FCMTopicSubscription[]> {
		try {
			const fallback = async () => {
				const res = await this.db.query.fcmTopicSubscription.findMany({
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
	): Promise<FCMTopicSubscription> {
		try {
			const [[res]] = await Promise.all([
				this.db
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

	async unsubscribe(item: InsertFCMTopicSubscription): Promise<void> {
		try {
			await Promise.all([
				this.db
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
				throw new RepositoryError("List fcm notif log must have user id", {
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

			if (cursor) {
				clauses.push(gt(tables.fcmNotificationLog.sentAt, new Date(cursor)));

				const res = await this.db.query.fcmNotificationLog.findMany({
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
					this.db.query.fcmNotificationLog.findMany({
						where: (_, op) => op.and(...clauses),
						orderBy,
						offset,
						limit,
					}),
					this.getTotalRow(),
				]);

				const rows = res.map(FCMNotificationLogRepository.composeEntity);

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.fcmNotificationLog.findMany({
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

	async create(item: InsertFCMNotificationLog): Promise<FCMNotificationLog> {
		try {
			const [res] = await this.db
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
	): Promise<FCMNotificationLog[]> {
		try {
			const values = item.map((e) => ({ ...e, id: v7() }));
			const res = await this.db
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
				throw new RepositoryError("List fcm notif log must have user id", {
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

			if (cursor) {
				clauses.push(gt(tables.userNotification.createdAt, new Date(cursor)));

				const res = await this.db.query.userNotification.findMany({
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
					this.db.query.userNotification.findMany({
						where: (_, op) => op.and(...clauses),
						orderBy,
						offset,
						limit,
					}),
					this.getTotalRow(),
				]);

				const rows = res.map(UserNotificationRepository.composeEntity);

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.userNotification.findMany({
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

	async create(item: InsertUserNotification): Promise<UserNotification> {
		try {
			const [[res]] = await Promise.all([
				this.db
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
	): Promise<UserNotification[]> {
		try {
			const deletePromises: Promise<void>[] = [];
			const values = items.map((item) => {
				deletePromises.push(this.deleteCache(`unread:${item.userId}`));
				return { ...item, id: v7() };
			});

			const [rows] = await Promise.all([
				this.db.insert(tables.userNotification).values(values).returning(),
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
	): Promise<UserNotification> {
		try {
			const [[res]] = await Promise.all([
				this.db
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

	async countUnread(userId: string): Promise<number> {
		try {
			const key = `unread:${userId}`;

			const fallback = async () => {
				const [res] = await this.db
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

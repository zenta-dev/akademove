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
import { nullsToUndefined, omit } from "@repo/shared";
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
import type { KeyValueService } from "@/core/services/kv";
import type {
	FCMNotificationLogDatabase,
	FCMTokenDatabase,
	FCMTopicSubscriptionDatabase,
	UserNotificationDatabase,
} from "@/core/tables/notification";

export class FCMTokenRepository extends BaseRepository {
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
						expirationTtl: CACHE_TTLS["24h"],
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
			throw this.handleError(error, "list by user id");
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

	async removeByToken(token: string): Promise<void> {
		try {
			await this.db
				.delete(tables.fcmToken)
				.where(eq(tables.fcmToken.token, token));
		} catch (error) {
			throw this.handleError(error, "remove by token");
		}
	}
}

export class FCMTopicSubscriptionRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("fcmTopicSubscription", kv, db);
	}

	static composeEntity(
		item: FCMTopicSubscriptionDatabase,
	): FCMTopicSubscription {
		return item;
	}

	async subscribe(
		item: InsertFCMTopicSubscription,
	): Promise<FCMTopicSubscription> {
		try {
			const [res] = await this.db
				.insert(tables.fcmTopicSubscription)
				.values({ ...item, id: v7() })
				.onConflictDoNothing()
				.returning();

			return FCMTopicSubscriptionRepository.composeEntity(res);
		} catch (error) {
			throw this.handleError(error, "subscribe");
		}
	}

	async unsubscribe(item: InsertFCMTopicSubscription): Promise<void> {
		try {
			await this.db
				.delete(tables.fcmTopicSubscription)
				.where(
					and(
						eq(tables.fcmTopicSubscription.userId, item.userId),
						eq(tables.fcmTopicSubscription.token, item.token),
						eq(tables.fcmTopicSubscription.topic, item.topic),
					),
				);
		} catch (error) {
			throw this.handleError(error, "unsubscribe");
		}
	}
}

export class FCMNotificationLogRepository extends BaseRepository {
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
}

export class UserNotificationRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("userNotification", kv, db);
	}

	static composeEntity(item: UserNotificationDatabase): UserNotification {
		return nullsToUndefined(item);
	}

	async list(
		query?: UnifiedPaginationQuery &
			WithUserId & { read: "all" | "unread" | "readed" },
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
		item: Omit<InsertUserNotification, "userId"> & { userIds: string[] },
	): Promise<UserNotification[]> {
		try {
			const omitted = omit(item, ["userIds"]);
			const deletePromises: Promise<void>[] = [];
			const values = item.userIds.map((userId) => {
				deletePromises.push(this.deleteCache(`unread:${userId}`));
				return { ...omitted, userId, id: v7() };
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

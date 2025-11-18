import {
	type InsertUserBadge,
	type UpdateUserBadge,
	type UserBadge,
	UserBadgeKeySchema,
} from "@repo/schema/badge";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { nullsToUndefined } from "@repo/shared";
import { eq, gt, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { DetailedUserBadgeDatabase } from "@/core/tables/badge";
import { BadgeRepository } from "../main/badge-main-repository";

export class UserBadgeRepository extends BaseRepository {
	readonly #storage: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super("userBadge", kv, db);
		this.#storage = storage;
	}

	static composeEntity(
		item: DetailedUserBadgeDatabase,
		storage: StorageService,
	): UserBadge {
		const data: UserBadge = nullsToUndefined(item);
		if (item.badge) {
			data.badge = BadgeRepository.composeEntity(item.badge, storage);
		}
		return data;
	}

	async #getFromDB(id: string, opts?: WithTx): Promise<UserBadge | undefined> {
		const tx = opts?.tx ?? this.db;
		const result = await tx.query.userBadge.findFirst({
			with: { badge: true },
			where: (f, op) => op.eq(f.id, id),
		});

		return result
			? UserBadgeRepository.composeEntity(result, this.#storage)
			: undefined;
	}

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<UserBadge>> {
		try {
			const { cursor, page, limit = 10, sortBy, order = "asc" } = query ?? {};

			const orderBy = (
				f: typeof tables.userBadge._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = UserBadgeKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (cursor) {
				clauses.push(gt(tables.userBadge.createdAt, new Date(cursor)));

				const res = await this.db.query.userBadge.findMany({
					with: { badge: true },
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map((r) =>
					UserBadgeRepository.composeEntity(r, this.#storage),
				);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const res = await this.db.query.userBadge.findMany({
					with: { badge: true },
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = res.map((r) =>
					UserBadgeRepository.composeEntity(r, this.#storage),
				);

				const totalCount = await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.userBadge.findMany({
				with: { badge: true },
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map((r) =>
				UserBadgeRepository.composeEntity(r, this.#storage),
			);

			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<UserBadge> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError("Failed to get badge from db");
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};

			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(item: InsertUserBadge, opts?: WithTx): Promise<UserBadge> {
		try {
			const tx = opts?.tx ?? this.db;
			const [operation, badge] = await Promise.all([
				tx
					.insert(tables.userBadge)
					.values({
						...item,
						id: v7(),
						createdAt: new Date(),
					})
					.returning()
					.then(([r]) => r),
				tx.query.badge.findFirst({
					where: (f, op) => op.eq(f.id, item.badgeId),
				}),
			]);

			if (!badge) {
				throw new RepositoryError(`Badge with id ${item.badgeId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const result = UserBadgeRepository.composeEntity(
				{ ...operation, badge },
				this.#storage,
			);
			await this.setCache(result.id, result);
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		item: UpdateUserBadge,
		opts?: WithTx,
	): Promise<UserBadge> {
		try {
			const tx = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`User badge with id "${id}" not found`);

			const [operation, badge] = await Promise.all([
				tx
					.update(tables.userBadge)
					.set({
						...item,
					})
					.where(eq(tables.userBadge.id, id))
					.returning()
					.then(([r]) => r),

				tx.query.badge.findFirst({
					where: (f, op) => op.eq(f.id, item.badgeId ?? existing.badgeId),
				}),
			]);

			if (!badge) {
				throw new RepositoryError(`Badge with id ${item.badgeId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const result = UserBadgeRepository.composeEntity(
				{ ...operation, badge },
				this.#storage,
			);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.userBadge)
				.where(eq(tables.userBadge.id, id))
				.returning({ id: tables.userBadge.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}
}

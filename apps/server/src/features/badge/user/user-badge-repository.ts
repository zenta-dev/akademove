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
import type { ListResult, OrderByOperation } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { UserBadgeDatabase } from "@/core/tables/badge";

export class UserBadgeRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("userBadge", kv, db);
	}

	static composeEntity(item: UserBadgeDatabase): UserBadge {
		return nullsToUndefined(item);
	}

	async #getFromDB(id: string): Promise<UserBadge | undefined> {
		const result = await this.db.query.userBadge.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});

		return result ? UserBadgeRepository.composeEntity(result) : undefined;
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
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(UserBadgeRepository.composeEntity);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const res = await this.db.query.userBadge.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = res.map(UserBadgeRepository.composeEntity);

				const totalCount = await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.userBadge.findMany({
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map(UserBadgeRepository.composeEntity);

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

	async create(item: InsertUserBadge): Promise<UserBadge> {
		try {
			const [operation] = await this.db
				.insert(tables.userBadge)
				.values({
					...item,
					id: v7(),
					createdAt: new Date(),
				})
				.returning();

			const result = UserBadgeRepository.composeEntity(operation);
			await this.setCache(result.id, result);
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateUserBadge): Promise<UserBadge> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`User badge with id "${id}" not found`);

			const [operation] = await this.db
				.update(tables.userBadge)
				.set({
					...item,
				})
				.where(eq(tables.userBadge.id, id))
				.returning();

			const result = UserBadgeRepository.composeEntity(operation);
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

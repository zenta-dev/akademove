import {
	type Badge,
	BadgeKeySchema,
	type InsertBadge,
	type UpdateBadge,
} from "@repo/schema/badge";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { nullsToUndefined } from "@repo/shared";
import { count, eq, gt, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { BadgeDatabase } from "@/core/tables/badge";
import { log } from "@/utils";

export class BadgeRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("badge", kv, db);
	}

	static composeEntity(item: BadgeDatabase): Badge {
		return nullsToUndefined(item);
	}

	async #getFromDB(id: string): Promise<Badge | undefined> {
		const result = await this.db.query.badge.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});

		return result ? BadgeRepository.composeEntity(result) : undefined;
	}

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.badge.id) })
				.from(tables.badge)
				.where(ilike(tables.badge.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Badge>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
			} = query ?? {};

			const orderBy = (
				f: typeof tables.badge._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = BadgeKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search) clauses.push(ilike(tables.badge.name, `%${query}%`));

			if (cursor) {
				clauses.push(gt(tables.badge.createdAt, new Date(cursor)));

				const res = await this.db.query.badge.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(BadgeRepository.composeEntity);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const res = await this.db.query.badge.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = res.map(BadgeRepository.composeEntity);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.badge.findMany({
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map(BadgeRepository.composeEntity);

			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<Badge> {
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

	async create(item: InsertBadge): Promise<Badge> {
		try {
			const [operation] = await this.db
				.insert(tables.badge)
				.values({
					...item,
					id: v7(),
					createdAt: new Date(),
				})
				.returning();

			const result = BadgeRepository.composeEntity(operation);
			await this.setCache(result.id, result);
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateBadge): Promise<Badge> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Badge with id "${id}" not found`);

			const [operation] = await this.db
				.update(tables.badge)
				.set({
					...item,
				})
				.where(eq(tables.badge.id, id))
				.returning();

			const result = BadgeRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.badge)
				.where(eq(tables.badge.id, id))
				.returning({ id: tables.badge.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}
}

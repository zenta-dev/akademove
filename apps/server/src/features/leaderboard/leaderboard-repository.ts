import { m } from "@repo/i18n";
import {
	type InsertLeaderboard,
	type Leaderboard,
	LeaderboardKeySchema,
	type UpdateLeaderboard,
} from "@repo/schema/leaderboard";
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
import type { LeaderboardDatabase } from "@/core/tables/leaderboard";
import { log } from "@/utils";

export class LeaderboardRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("leaderboard", kv, db);
	}

	static composeEntity(item: LeaderboardDatabase): Leaderboard {
		return nullsToUndefined(item);
	}

	async #getFromDB(id: string): Promise<Leaderboard | undefined> {
		const result = await this.db.query.leaderboard.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});

		return result ? LeaderboardRepository.composeEntity(result) : undefined;
	}

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.leaderboard.id) })
				.from(tables.leaderboard)
				.where(ilike(tables.leaderboard.category, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Leaderboard>> {
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
				f: typeof tables.leaderboard._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = LeaderboardKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search)
				clauses.push(ilike(tables.leaderboard.category, `%${query}%`));

			if (cursor) {
				clauses.push(gt(tables.leaderboard.createdAt, new Date(cursor)));

				const res = await this.db.query.leaderboard.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(LeaderboardRepository.composeEntity);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const res = await this.db.query.leaderboard.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = res.map(LeaderboardRepository.composeEntity);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.leaderboard.findMany({
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map(LeaderboardRepository.composeEntity);

			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<Leaderboard> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError(m.error_failed_get_leaderboard());
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};

			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(item: InsertLeaderboard): Promise<Leaderboard> {
		try {
			const [operation] = await this.db
				.insert(tables.leaderboard)
				.values({
					...item,
					id: v7(),
					createdAt: new Date(),
				})
				.returning();

			const result = LeaderboardRepository.composeEntity(operation);
			await this.setCache(result.id, result);
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateLeaderboard): Promise<Leaderboard> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Leaderboard with id "${id}" not found`);

			const [operation] = await this.db
				.update(tables.leaderboard)
				.set({
					...item,
				})
				.where(eq(tables.leaderboard.id, id))
				.returning();

			const result = LeaderboardRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.leaderboard)
				.where(eq(tables.leaderboard.id, id))
				.returning({ id: tables.leaderboard.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}
}

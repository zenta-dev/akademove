import { m } from "@repo/i18n";
import type {
	InsertLeaderboard,
	Leaderboard,
	UpdateLeaderboard,
} from "@repo/schema/leaderboard";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { nullsToUndefined } from "@repo/shared";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	OrderByOperation,
	PartialWithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { LeaderboardDatabase } from "@/core/tables/leaderboard";
import { LeaderboardListQueryService } from "./services/leaderboard-list-query-service";

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

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Leaderboard>> {
		try {
			// Extract pagination parameters
			const { cursor, page, limit, search, sortBy, order } =
				LeaderboardListQueryService.extractPaginationParams(query);

			// Generate ORDER BY clause
			const orderBy = (
				f: typeof tables.leaderboard._.columns,
				op: OrderByOperation,
			) => {
				const validField = LeaderboardListQueryService.parseSortField(sortBy);
				if (validField) {
					const field = f[validField as keyof typeof f];
					return op[order](field);
				}
				return op[order](f.id);
			};

			// Generate WHERE clauses
			const clauses = LeaderboardListQueryService.generateWhereClauses({
				search,
				cursor,
			});

			// Cursor-based pagination
			if (cursor) {
				const res = await this.db.query.leaderboard.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(LeaderboardRepository.composeEntity);

				return { rows };
			}

			// Page-based pagination
			if (page) {
				const res = await this.db.query.leaderboard.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset: LeaderboardListQueryService.calculatePagination({
						page,
						limit,
						totalCount: 0,
					}).offset,
					limit,
				});

				const rows = res.map(LeaderboardRepository.composeEntity);

				// Get total count based on search
				const totalCount = search
					? await LeaderboardListQueryService.getSearchCount(this.db, search)
					: await this.getTotalRow();

				const { totalPages } = LeaderboardListQueryService.calculatePagination({
					page,
					limit,
					totalCount,
				});

				return { rows, totalPages };
			}

			// Default: no pagination
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

	async create(
		item: InsertLeaderboard,
		opts?: PartialWithTx,
	): Promise<Leaderboard> {
		try {
			const [operation] = await (opts?.tx ?? this.db)
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

	async update(
		id: string,
		item: UpdateLeaderboard,
		opts?: PartialWithTx,
	): Promise<Leaderboard> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Leaderboard with id "${id}" not found`);

			const [operation] = await (opts?.tx ?? this.db)
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

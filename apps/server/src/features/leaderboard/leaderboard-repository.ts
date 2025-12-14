import { m } from "@repo/i18n";
import type {
	InsertLeaderboard,
	Leaderboard,
	LeaderboardQuery,
	LeaderboardWithDriver,
	UpdateLeaderboard,
} from "@repo/schema/leaderboard";
import { nullsToUndefined } from "@repo/shared";
import { and, eq } from "drizzle-orm";
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
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
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

	/**
	 * Fetch driver info for leaderboard entries
	 */
	async #fetchDriverInfo(
		driverIds: string[],
	): Promise<Map<string, LeaderboardWithDriver["driver"]>> {
		const driverMap = new Map<string, LeaderboardWithDriver["driver"]>();

		if (driverIds.length === 0) return driverMap;

		try {
			const drivers = await this.db.query.driver.findMany({
				where: (f, op) =>
					op.inArray(
						f.id,
						driverIds.filter((id): id is string => id !== undefined),
					),
				with: {
					user: true,
				},
			});

			for (const driver of drivers) {
				if (driver.user) {
					driverMap.set(driver.id, {
						id: driver.id,
						name: driver.user.name,
						image: driver.user.image ?? undefined,
						rating: toNumberSafe(driver.rating),
					});
				}
			}
		} catch (error) {
			logger.error(
				{ error, driverIds },
				"[LeaderboardRepository] Failed to fetch driver info",
			);
		}

		return driverMap;
	}

	/**
	 * Fetch previous rank for leaderboard entries (from previous period)
	 */
	async #fetchPreviousRanks(
		entries: Leaderboard[],
	): Promise<Map<string, number>> {
		const rankMap = new Map<string, number>();

		if (entries.length === 0) return rankMap;

		try {
			// Get the first entry to determine current period
			const sample = entries[0];
			if (!sample) return rankMap;

			// Find previous period entries for same category
			const previousEntries = await this.db.query.leaderboard.findMany({
				where: (f, op) =>
					and(
						op.eq(f.category, sample.category),
						op.eq(f.period, sample.period),
						op.lt(f.periodStart, sample.periodStart),
					),
				orderBy: (f, op) => op.desc(f.periodStart),
				limit: entries.length * 2, // Get enough to cover all drivers
			});

			// Create a map of driverId -> previous rank
			for (const entry of previousEntries) {
				if (entry.driverId && !rankMap.has(entry.driverId)) {
					rankMap.set(entry.driverId, entry.rank);
				}
			}
		} catch (error) {
			logger.error(
				{ error },
				"[LeaderboardRepository] Failed to fetch previous ranks",
			);
		}

		return rankMap;
	}

	async list(
		query?: LeaderboardQuery,
	): Promise<ListResult<LeaderboardWithDriver>> {
		try {
			// Extract pagination parameters
			const {
				cursor,
				page,
				limit,
				sortBy,
				order,
				category,
				period,
				includeDriver,
			} = LeaderboardListQueryService.extractPaginationParams(query);

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
				// Default sort by rank ascending
				return op.asc(f.rank);
			};

			// Generate WHERE clauses
			const clauses = LeaderboardListQueryService.generateWhereClauses({
				category,
				period,
				cursor,
			});

			let rows: Leaderboard[];
			let totalPages: number | undefined;

			// Cursor-based pagination
			if (cursor) {
				const res = await this.db.query.leaderboard.findMany({
					where: clauses.length > 0 ? (_, op) => op.and(...clauses) : undefined,
					orderBy,
					limit: limit + 1,
				});

				rows = res.map(LeaderboardRepository.composeEntity);
			}
			// Page-based pagination
			else if (page) {
				const totalCount = await LeaderboardListQueryService.getFilteredCount(
					this.db,
					{ category, period },
				);

				const { offset, totalPages: pages } =
					LeaderboardListQueryService.calculatePagination({
						page,
						limit,
						totalCount,
					});

				const res = await this.db.query.leaderboard.findMany({
					where: clauses.length > 0 ? (_, op) => op.and(...clauses) : undefined,
					orderBy,
					offset,
					limit,
				});

				rows = res.map(LeaderboardRepository.composeEntity);
				totalPages = pages;
			}
			// Default: no pagination, just limit
			else {
				const res = await this.db.query.leaderboard.findMany({
					where: clauses.length > 0 ? (_, op) => op.and(...clauses) : undefined,
					orderBy,
					limit,
				});

				rows = res.map(LeaderboardRepository.composeEntity);
			}

			// Enhance with driver info if requested
			let result: LeaderboardWithDriver[] = rows;

			if (includeDriver) {
				const driverIds = rows
					.map((r) => r.driverId)
					.filter((id): id is string => id !== undefined);

				const [driverMap, previousRankMap] = await Promise.all([
					this.#fetchDriverInfo(driverIds),
					this.#fetchPreviousRanks(rows),
				]);

				result = rows.map((entry) => ({
					...entry,
					driver: entry.driverId ? driverMap.get(entry.driverId) : undefined,
					previousRank: entry.driverId
						? previousRankMap.get(entry.driverId)
						: undefined,
				}));
			}

			return { rows: result, totalPages };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	/**
	 * Get current user's rankings across all categories/periods
	 */
	async getMyRankings(
		userId: string,
		query?: { category?: string; period?: string },
	): Promise<LeaderboardWithDriver[]> {
		try {
			const clauses = LeaderboardListQueryService.generateWhereClauses({
				category: query?.category as LeaderboardWithDriver["category"],
				period: query?.period as LeaderboardWithDriver["period"],
				userId,
			});

			const res = await this.db.query.leaderboard.findMany({
				where: clauses.length > 0 ? (_, op) => op.and(...clauses) : undefined,
				orderBy: (f, op) => [
					op.asc(f.category),
					op.asc(f.period),
					op.asc(f.rank),
				],
			});

			const rows = res.map(LeaderboardRepository.composeEntity);

			// Fetch driver info for current user
			const driverIds = rows
				.map((r) => r.driverId)
				.filter((id): id is string => id !== undefined);

			const [driverMap, previousRankMap] = await Promise.all([
				this.#fetchDriverInfo(driverIds),
				this.#fetchPreviousRanks(rows),
			]);

			return rows.map((entry) => ({
				...entry,
				driver: entry.driverId ? driverMap.get(entry.driverId) : undefined,
				previousRank: entry.driverId
					? previousRankMap.get(entry.driverId)
					: undefined,
			}));
		} catch (error) {
			throw this.handleError(error, "get my rankings");
		}
	}

	async getById(
		id: string,
		options?: { includeDriver?: boolean },
	): Promise<LeaderboardWithDriver> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError(m.error_failed_get_leaderboard());
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};

			const result = await this.getCache(id, { fallback });

			// Enhance with driver info if requested
			if (options?.includeDriver && result.driverId) {
				const driverMap = await this.#fetchDriverInfo([result.driverId]);
				const previousRankMap = await this.#fetchPreviousRanks([result]);

				return {
					...result,
					driver: driverMap.get(result.driverId),
					previousRank: previousRankMap.get(result.driverId),
				};
			}

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

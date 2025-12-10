import { LeaderboardKeySchema } from "@repo/schema/leaderboard";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { count, gt, ilike, type SQL } from "drizzle-orm";
import type { DatabaseService } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Service responsible for building list queries for leaderboards
 *
 * @responsibility Generate WHERE clauses, count queries, and pagination logic for leaderboard listing
 */
export class LeaderboardListQueryService {
	/**
	 * Parse and validate sort field
	 */
	static parseSortField(sortBy?: string): string | undefined {
		if (!sortBy) return undefined;

		const parsed = LeaderboardKeySchema.safeParse(sortBy);
		return parsed.success ? parsed.data : undefined;
	}

	/**
	 * Generate WHERE clauses for leaderboard listing
	 */
	static generateWhereClauses(options: {
		search?: string;
		cursor?: string;
	}): SQL[] {
		const { search, cursor } = options;
		const clauses: SQL[] = [];

		if (search) {
			clauses.push(ilike(tables.leaderboard.category, `%${search}%`));
		}

		if (cursor) {
			clauses.push(gt(tables.leaderboard.createdAt, new Date(cursor)));
		}

		return clauses;
	}

	/**
	 * Get count of leaderboards matching search query
	 */
	static async getSearchCount(
		db: DatabaseService,
		search: string,
	): Promise<number> {
		try {
			const [dbResult] = await db
				.select({ count: count(tables.leaderboard.id) })
				.from(tables.leaderboard)
				.where(ilike(tables.leaderboard.category, `%${search}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			logger.error(
				{ search, error },
				"[LeaderboardListQueryService] Failed to get search count",
			);
			return 0;
		}
	}

	/**
	 * Calculate pagination values
	 */
	static calculatePagination(options: {
		page: number;
		limit: number;
		totalCount: number;
	}): {
		offset: number;
		totalPages: number;
	} {
		const { page, limit, totalCount } = options;
		const offset = (page - 1) * limit;
		const totalPages = Math.ceil(totalCount / limit);

		return { offset, totalPages };
	}

	/**
	 * Extract pagination parameters from query with defaults
	 */
	static extractPaginationParams(query?: UnifiedPaginationQuery): {
		cursor?: string;
		page?: number;
		limit: number;
		search?: string;
		sortBy?: string;
		order: "asc" | "desc";
	} {
		return {
			cursor: query?.cursor,
			page: query?.page,
			limit: query?.limit ?? 10,
			search: query?.query,
			sortBy: query?.sortBy,
			order: query?.order ?? "asc",
		};
	}
}

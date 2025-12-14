import type {
	LeaderboardCategory,
	LeaderboardPeriod,
	LeaderboardQuery,
} from "@repo/schema/leaderboard";
import { LeaderboardKeySchema } from "@repo/schema/leaderboard";
import { and, count, eq, gt, type SQL } from "drizzle-orm";
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
		category?: LeaderboardCategory;
		period?: LeaderboardPeriod;
		userId?: string;
		cursor?: string;
	}): SQL[] {
		const { category, period, userId, cursor } = options;
		const clauses: SQL[] = [];

		if (category) {
			clauses.push(eq(tables.leaderboard.category, category));
		}

		if (period) {
			clauses.push(eq(tables.leaderboard.period, period));
		}

		if (userId) {
			clauses.push(eq(tables.leaderboard.userId, userId));
		}

		if (cursor) {
			clauses.push(gt(tables.leaderboard.createdAt, new Date(cursor)));
		}

		return clauses;
	}

	/**
	 * Get count of leaderboards matching filters
	 */
	static async getFilteredCount(
		db: DatabaseService,
		options: {
			category?: LeaderboardCategory;
			period?: LeaderboardPeriod;
			userId?: string;
		},
	): Promise<number> {
		try {
			const clauses = LeaderboardListQueryService.generateWhereClauses(options);

			const [dbResult] = await db
				.select({ count: count(tables.leaderboard.id) })
				.from(tables.leaderboard)
				.where(clauses.length > 0 ? and(...clauses) : undefined);

			return dbResult?.count ?? 0;
		} catch (error) {
			logger.error(
				{ options, error },
				"[LeaderboardListQueryService] Failed to get filtered count",
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
	static extractPaginationParams(query?: LeaderboardQuery): {
		category?: LeaderboardCategory;
		period?: LeaderboardPeriod;
		cursor?: string;
		page?: number;
		limit: number;
		sortBy?: string;
		order: "asc" | "desc";
		includeDriver: boolean;
	} {
		return {
			category: query?.category,
			period: query?.period,
			cursor: query?.cursor,
			page: query?.page,
			limit: query?.limit ?? 10,
			sortBy: query?.sortBy ?? "rank",
			order: query?.order ?? "asc",
			includeDriver: query?.includeDriver ?? false,
		};
	}
}

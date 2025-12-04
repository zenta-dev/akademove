import { DriverScheduleKeySchema } from "@repo/schema/driver";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { count, gt, ilike, type SQL } from "drizzle-orm";
import type { DatabaseService } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { log } from "@/utils";

/**
 * Service responsible for building list queries for driver schedules
 *
 * @responsibility Generate WHERE clauses, count queries, and pagination logic for schedule listing
 */
export class DriverScheduleListQueryService {
	/**
	 * Parse and validate sort field
	 */
	static parseSortField(sortBy?: string): string | undefined {
		if (!sortBy) return undefined;

		const parsed = DriverScheduleKeySchema.safeParse(sortBy);
		return parsed.success ? parsed.data : undefined;
	}

	/**
	 * Generate WHERE clauses for schedule listing
	 */
	static generateWhereClauses(options: {
		search?: string;
		cursor?: string;
	}): SQL[] {
		const { search, cursor } = options;
		const clauses: SQL[] = [];

		if (search) {
			clauses.push(ilike(tables.driverSchedule.name, `%${search}%`));
		}

		if (cursor) {
			clauses.push(gt(tables.driverSchedule.createdAt, new Date(cursor)));
		}

		return clauses;
	}

	/**
	 * Get count of schedules matching search query
	 */
	static async getSearchCount(
		db: DatabaseService,
		search: string,
	): Promise<number> {
		try {
			const [dbResult] = await db
				.select({ count: count(tables.driverSchedule.id) })
				.from(tables.driverSchedule)
				.where(ilike(tables.driverSchedule.name, `%${search}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error(
				{ search, error },
				"[DriverScheduleListQueryService] Failed to get search count",
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

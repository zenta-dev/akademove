import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { TransactionKeySchema } from "@repo/schema/transaction";

/**
 * Service responsible for building list queries for transactions
 *
 * @responsibility Pagination calculation and query validation for transaction listing
 */
export class TransactionListQueryService {
	/**
	 * Parse and validate sort field
	 */
	static parseSortField(sortBy?: string): string | undefined {
		if (!sortBy) return undefined;

		const parsed = TransactionKeySchema.safeParse(sortBy);
		return parsed.success ? parsed.data : undefined;
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
	 * Validate query parameters
	 */
	static validateQuery(
		query?: UnifiedPaginationQuery & { userId?: string },
	): boolean {
		return Boolean(query?.userId);
	}

	/**
	 * Extract pagination parameters from query with defaults
	 */
	static extractPaginationParams(
		query?: UnifiedPaginationQuery & { userId?: string },
	): {
		cursor?: string;
		page?: number;
		limit: number;
		sortBy?: string;
		order: "asc" | "desc";
		userId?: string;
	} {
		return {
			cursor: query?.cursor,
			page: query?.page,
			limit: query?.limit ?? 10,
			sortBy: query?.sortBy,
			order: query?.order ?? "asc",
			userId: query?.userId,
		};
	}
}

/**
 * UserListQueryService
 *
 * SOLID Principles Applied:
 * - SRP: Handles only user list query building and pagination logic
 * - OCP: Open for extension with new filter/sort strategies
 * - DIP: Depends on abstractions (SQL types, not concrete implementations)
 */

import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { UserKeySchema } from "@repo/schema/user";
import { gt, ne, type SQL } from "drizzle-orm";
import type { OrderByOperation } from "@/core/interface";
import { tables } from "@/core/services/db";

interface ListQueryParams extends UnifiedPaginationQuery {
	requesterId?: string;
	query?: string;
}

/**
 * UserListQueryService
 *
 * Static service for building user list queries:
 * - Where clause generation
 * - Order by clause generation
 * - Pagination calculations
 */
export class UserListQueryService {
	/**
	 * Generate WHERE clauses for user listing
	 * Filters out the requester and optionally applies cursor-based pagination
	 *
	 * @param params - Query parameters
	 * @returns Array of SQL WHERE clauses
	 */
	static generateWhereClauses(params: ListQueryParams): SQL[] {
		const clauses: SQL[] = [];
		const { requesterId, cursor } = params;

		// Exclude requester from results
		if (requesterId) {
			clauses.push(ne(tables.user.id, requesterId));
		}

		// Cursor-based pagination
		if (cursor) {
			clauses.push(gt(tables.user.updatedAt, new Date(cursor)));
		}

		return clauses;
	}

	/**
	 * Generate ORDER BY clause for user listing
	 * Supports dynamic sorting by any user field
	 *
	 * @param sortBy - Field name to sort by
	 * @param order - Sort direction (asc/desc)
	 * @returns Order by operation callback
	 */
	static generateOrderBy(
		sortBy: string | undefined,
		order: "asc" | "desc" = "asc",
	): (
		f: typeof tables.user._.columns,
		op: OrderByOperation,
	) => ReturnType<OrderByOperation["asc" | "desc"]> {
		return (
			f: typeof tables.user._.columns,
			op: OrderByOperation,
		): ReturnType<OrderByOperation["asc" | "desc"]> => {
			if (sortBy) {
				const parsed = UserKeySchema.safeParse(sortBy);
				const field = parsed.success ? f[parsed.data] : f.id;
				return op[order](field);
			}
			return op[order](f.id);
		};
	}

	/**
	 * Calculate pagination metadata
	 *
	 * @param totalCount - Total number of records
	 * @param limit - Records per page
	 * @returns Total number of pages
	 */
	static calculateTotalPages(totalCount: number, limit: number): number {
		return Math.ceil(totalCount / limit);
	}

	/**
	 * Calculate pagination offset for page-based pagination
	 *
	 * @param page - Current page number (1-indexed)
	 * @param limit - Records per page
	 * @returns Offset value for database query
	 */
	static calculateOffset(page: number, limit: number): number {
		return (page - 1) * limit;
	}

	/**
	 * Validate and normalize pagination parameters
	 * Ensures limit is within acceptable bounds
	 *
	 * @param limit - Requested limit
	 * @returns Normalized limit value
	 */
	static normalizePaginationLimit(limit: number | undefined): number {
		const MIN_LIMIT = 1;
		const MAX_LIMIT = 100;
		const DEFAULT_LIMIT = 10;

		if (!limit) return DEFAULT_LIMIT;

		if (limit < MIN_LIMIT) return MIN_LIMIT;
		if (limit > MAX_LIMIT) return MAX_LIMIT;

		return limit;
	}

	/**
	 * Determine pagination strategy from query parameters
	 *
	 * @param params - Query parameters
	 * @returns Pagination strategy: "cursor" | "page" | "simple"
	 */
	static getPaginationStrategy(
		params: ListQueryParams,
	): "cursor" | "page" | "simple" {
		if (params.cursor) return "cursor";
		if (params.page) return "page";
		return "simple";
	}
}

/**
 * UserSearchService
 *
 * SOLID Principles Applied:
 * - SRP: Handles only user search and query counting logic
 * - OCP: Open for extension with new search strategies
 */

import { count, ilike, type SQL } from "drizzle-orm";
import type { DatabaseService } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * UserSearchService
 *
 * Static service for user search operations:
 * - Query count calculation
 * - Search clause generation
 */
export class UserSearchService {
	/**
	 * Get count of users matching a search query
	 * Searches in user names using ILIKE pattern matching
	 *
	 * @param db - Database service instance
	 * @param query - Search query string
	 * @returns Count of matching users (0 if error occurs)
	 */
	static async getQueryCount(
		db: DatabaseService,
		query: string,
	): Promise<number> {
		try {
			const [dbResult] = await db
				.select({ count: count(tables.user.id) })
				.from(tables.user)
				.where(ilike(tables.user.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			logger.error(
				{ query, error },
				"[UserSearchService] Failed to get query count",
			);
			return 0;
		}
	}

	/**
	 * Generate search clause for user name filtering
	 * Uses case-insensitive ILIKE pattern matching
	 *
	 * @param searchQuery - Search query string
	 * @returns SQL clause for WHERE condition
	 */
	static generateSearchClause(searchQuery: string): SQL {
		return ilike(tables.user.name, `%${searchQuery}%`);
	}

	/**
	 * Validate and sanitize search query
	 * Prevents SQL injection and excessive wildcards
	 *
	 * @param query - Raw search query
	 * @returns Sanitized query string
	 */
	static sanitizeSearchQuery(query: string): string {
		// Trim whitespace
		const trimmed = query.trim();

		// Limit length to prevent performance issues
		const maxLength = 100;
		if (trimmed.length > maxLength) {
			logger.warn(
				{ originalLength: trimmed.length, maxLength },
				"[UserSearchService] Search query truncated",
			);
			return trimmed.slice(0, maxLength);
		}

		// Remove null bytes and control characters
		// biome-ignore lint/suspicious/noControlCharactersInRegex: Intentional sanitization of control characters
		return trimmed.replace(/[\x00-\x1F\x7F]/g, "");
	}
}

/**
 * ReviewSearchService
 *
 * SOLID Principles Applied:
 * - SRP: Handles only review search and query counting logic
 * - OCP: Open for extension with new search strategies
 */

import { count, ilike, type SQL } from "drizzle-orm";
import type { DatabaseService } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { log } from "@/utils";

/**
 * ReviewSearchService
 *
 * Static service for review search operations:
 * - Query count calculation
 * - Search clause generation for comments
 */
export class ReviewSearchService {
	/**
	 * Get count of reviews matching a search query
	 * Searches in review comments using ILIKE pattern matching
	 *
	 * @param db - Database service instance
	 * @param query - Search query string
	 * @returns Count of matching reviews (0 if error occurs)
	 */
	static async getQueryCount(
		db: DatabaseService,
		query: string,
	): Promise<number> {
		try {
			const [dbResult] = await db
				.select({ count: count(tables.review.id) })
				.from(tables.review)
				.where(ilike(tables.review.comment, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error(
				{ query, error },
				"[ReviewSearchService] Failed to get query count",
			);
			return 0;
		}
	}

	/**
	 * Generate search clause for review comment filtering
	 * Uses case-insensitive ILIKE pattern matching
	 *
	 * @param searchQuery - Search query string
	 * @returns SQL clause for WHERE condition
	 */
	static generateSearchClause(searchQuery: string): SQL {
		return ilike(tables.review.comment, `%${searchQuery}%`);
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
		const maxLength = 200; // Reviews can be longer than user names
		if (trimmed.length > maxLength) {
			log.warn(
				{ originalLength: trimmed.length, maxLength },
				"[ReviewSearchService] Search query truncated",
			);
			return trimmed.slice(0, maxLength);
		}

		// Remove null bytes and control characters
		// biome-ignore lint/suspicious/noControlCharactersInRegex: intentionally removing control characters
		return trimmed.replace(/[\x00-\x1F\x7F]/g, "");
	}
}

import type { ListQuickMessageQuery } from "@repo/schema/quick-message";

/**
 * Service responsible for managing cache keys and invalidation patterns
 * for quick message templates
 */
export class QuickMessageCacheService {
	/**
	 * Generate cache key for listing quick messages based on query filters
	 * @param query - Query filters for quick messages
	 * @returns Cache key string
	 */
	static generateListCacheKey(query: ListQuickMessageQuery): string {
		const { role, orderType, locale, status } = query;
		return `quick-messages:${role ?? "all"}:${orderType ?? "all"}:${locale ?? "all"}:${status ?? "all"}`;
	}

	/**
	 * Generate cache invalidation patterns for a specific template
	 * Useful when creating/updating a template to invalidate relevant cached lists
	 * @param role - User role for the template
	 * @param orderType - Order type for the template (optional)
	 * @param locale - Locale for the template
	 * @returns Array of cache key patterns to invalidate
	 */
	static generateInvalidationPatterns(
		role: string,
		orderType: string | null | undefined,
		locale: string,
	): string[] {
		return [
			`quick-messages:${role}:${orderType ?? "all"}:${locale}:*`,
			"quick-messages:all:*",
		];
	}

	/**
	 * Generate wildcard pattern for deleting all quick message caches
	 * Useful for bulk operations or updates that affect all templates
	 * @returns Wildcard cache key pattern
	 */
	static generateWildcardPattern(): string {
		return "quick-messages:*";
	}
}

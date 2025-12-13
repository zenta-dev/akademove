/**
 * Service responsible for chat cache key management
 */
export class ChatCacheService {
	/**
	 * Generate cache key for order messages list
	 * @param orderId - Order ID
	 * @returns Cache key string
	 */
	static generateMessagesCacheKey(orderId: string): string {
		return `order:${orderId}:messages`;
	}

	/**
	 * Generate cache key for message count
	 * @param orderId - Order ID
	 * @returns Cache key string
	 */
	static generateCountCacheKey(orderId: string): string {
		return `order:${orderId}:count`;
	}

	/**
	 * Generate cache key for unread message count per user
	 * @param orderId - Order ID
	 * @param userId - User ID
	 * @returns Cache key string
	 */
	static generateUnreadCountCacheKey(orderId: string, userId: string): string {
		return `order:${orderId}:unread:${userId}`;
	}
}

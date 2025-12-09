import { randomBytes } from "node:crypto";

/**
 * Service responsible for user ban management
 *
 * Handles:
 * - Ban expiration calculation
 * - Unban detection from update payload
 * - Ban duration formatting
 *
 * @example
 * ```typescript
 * // Calculate ban expiration from duration
 * const banExpires = UserBanService.calculateBanExpiration(7 * 24 * 60 * 60 * 1000); // 7 days
 * // Returns: Date 7 days from now
 *
 * // Check if update is an unban operation
 * const isUnban = UserBanService.isUnbanOperation(updatePayload);
 * // Returns: true if payload only contains 'id' field
 * ```
 */
export class UserBanService {
	/**
	 * Calculates ban expiration date from duration in milliseconds
	 *
	 * @param durationMs - Duration in milliseconds (e.g., 7 days = 7 * 24 * 60 * 60 * 1000)
	 * @returns Expiration date or null for permanent ban
	 */
	static calculateBanExpiration(
		durationMs: number | null | undefined,
	): Date | null {
		if (!durationMs) return null;
		return new Date(Date.now() + durationMs);
	}

	/**
	 * Creates ban data object for database update
	 *
	 * @param reason - Ban reason
	 * @param expiresIn - Duration in milliseconds
	 * @returns Ban data object
	 */
	static createBanData(reason: string, expiresIn?: number | null) {
		return {
			banned: true,
			banReason: reason,
			banExpires: UserBanService.calculateBanExpiration(expiresIn),
		};
	}

	/**
	 * Creates unban data object for database update
	 *
	 * @returns Unban data object
	 */
	static createUnbanData() {
		return {
			banned: false,
			banReason: null,
			banExpires: null,
		};
	}

	/**
	 * Detects if update payload is an unban operation
	 *
	 * Unban operations only contain 'id' field in the payload
	 *
	 * @param payload - Update payload
	 * @returns true if this is an unban operation
	 */
	static isUnbanOperation(payload: Record<string, unknown>): boolean {
		return "id" in payload && Object.keys(payload).length === 1;
	}

	/**
	 * Checks if ban is expired
	 *
	 * @param banExpires - Ban expiration date
	 * @returns true if ban has expired
	 */
	static isBanExpired(banExpires: Date | null | undefined): boolean {
		if (!banExpires) return false;
		return new Date() > banExpires;
	}

	/**
	 * Formats ban duration for display
	 *
	 * @param durationMs - Duration in milliseconds
	 * @returns Human-readable duration (e.g., "7 days", "permanent")
	 */
	static formatBanDuration(durationMs: number | null | undefined): string {
		if (!durationMs) return "permanent";

		const days = Math.floor(durationMs / (24 * 60 * 60 * 1000));
		const hours = Math.floor(
			(durationMs % (24 * 60 * 60 * 1000)) / (60 * 60 * 1000),
		);

		if (days > 0) {
			return hours > 0 ? `${days} days ${hours} hours` : `${days} days`;
		}
		return `${hours} hours`;
	}
}

/**
 * Service responsible for user account ID generation
 *
 * Handles:
 * - Cryptographically secure random ID generation
 * - Account ID format consistency
 *
 * @example
 * ```typescript
 * const userId = UserIdService.generate();
 * // Returns: 32-character hex string
 * ```
 */
export class UserIdService {
	/**
	 * Generates a cryptographically secure random ID
	 *
	 * Uses 16 random bytes converted to 32-character hex string
	 *
	 * @returns Random ID string (32 hex characters)
	 */
	static generate(): string {
		return randomBytes(16).toString("hex");
	}

	/**
	 * Validates if string is a valid user ID format
	 *
	 * @param id - ID to validate
	 * @returns true if valid format (32 hex characters)
	 */
	static isValid(id: string): boolean {
		return /^[0-9a-f]{32}$/.test(id);
	}
}

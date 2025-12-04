import { getFileExtension } from "@repo/shared";

/**
 * Service responsible for badge icon key management
 *
 * Handles:
 * - Icon key generation with code-based naming (badgeCode.ext)
 * - Storage bucket constants
 * - Key resolution for create/update operations
 *
 * @example
 * ```typescript
 * // Generate icon key for new badge
 * const iconKey = BadgeIconService.generateIconKey('first-ride', iconFile);
 * if (iconKey) {
 *   await storage.upload({
 *     bucket: BadgeIconService.BUCKET,
 *     key: iconKey,
 *     file: iconFile
 *   });
 * }
 *
 * // Resolve key for update operation
 * const updatedKey = BadgeIconService.resolveUpdateIconKey(
 *   'first-ride',
 *   existingKey,
 *   newIconFile
 * );
 * ```
 */
export class BadgeIconService {
	/**
	 * Bucket name for badge icons (public)
	 */
	static readonly BUCKET = "badges";

	/**
	 * Generates icon key for a badge
	 *
	 * Format: {badgeCode}.{extension}
	 * Example: first-ride.png
	 *
	 * @param badgeCode - Unique badge code (e.g., "first-ride", "elite-driver")
	 * @param iconFile - Icon file (File/Blob object)
	 * @returns Icon key or undefined if no file provided
	 */
	static generateIconKey(
		badgeCode: string,
		iconFile: File | undefined,
	): string | undefined {
		if (!iconFile) return undefined;
		const extension = getFileExtension(iconFile);
		return `${badgeCode}.${extension}`;
	}

	/**
	 * Resolves icon key for update operation
	 *
	 * - If new icon provided: generate new key with current code
	 * - If no new icon: keep existing key
	 *
	 * @param badgeCode - Current badge code
	 * @param existingKey - Current icon key (if any)
	 * @param newIconFile - New icon file (if updating)
	 * @returns Icon key to use
	 */
	static resolveUpdateIconKey(
		badgeCode: string,
		existingKey: string | undefined,
		newIconFile: File | undefined,
	): string | undefined {
		if (newIconFile) {
			return BadgeIconService.generateIconKey(badgeCode, newIconFile);
		}
		return existingKey;
	}

	/**
	 * Checks if icon upload is needed
	 *
	 * @param iconFile - Icon file to check
	 * @returns true if upload is needed
	 */
	static shouldUpload(iconFile: File | undefined): boolean {
		return iconFile !== undefined;
	}

	/**
	 * Checks if icon deletion is needed
	 *
	 * @param existingKey - Existing icon key
	 * @returns true if deletion is needed
	 */
	static shouldDelete(existingKey: string | undefined): boolean {
		return existingKey !== undefined;
	}
}

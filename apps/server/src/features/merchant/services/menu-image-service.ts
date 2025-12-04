import { getFileExtension } from "@repo/shared";

/**
 * Service responsible for merchant menu image key management
 *
 * Handles:
 * - Image key generation with standard naming convention (MM-{id}.{ext})
 * - Image key extraction from file objects
 * - Determining if image upload is needed
 *
 * @example
 * ```typescript
 * // Generate image key for new menu item
 * const imageKey = MenuImageService.generateImageKey(menuId, imageFile);
 * if (imageKey) {
 *   await storage.upload({ bucket, key: imageKey, file: imageFile });
 * }
 *
 * // Determine key for update (reuse existing or generate new)
 * const imageKey = MenuImageService.resolveUpdateImageKey(menuId, existingKey, newImageFile);
 * ```
 */
export class MenuImageService {
	/**
	 * Bucket name for merchant menu images
	 */
	static readonly BUCKET = "merchant-menu";

	/**
	 * Generates image key for a merchant menu item
	 *
	 * Format: MM-{id}.{extension}
	 *
	 * @param menuId - Menu item ID
	 * @param imageFile - Image file (File/Blob object)
	 * @returns Image key or undefined if no file provided
	 */
	static generateImageKey(
		menuId: string,
		imageFile: File | undefined,
	): string | undefined {
		if (!imageFile) return undefined;
		const extension = getFileExtension(imageFile);
		return `MM-${menuId}.${extension}`;
	}

	/**
	 * Resolves image key for update operation
	 *
	 * - If new image provided: generate new key
	 * - If no new image: keep existing key
	 *
	 * @param menuId - Menu item ID
	 * @param existingKey - Current image key (if any)
	 * @param newImageFile - New image file (if updating image)
	 * @returns Image key to use
	 */
	static resolveUpdateImageKey(
		menuId: string,
		existingKey: string | undefined,
		newImageFile: File | undefined,
	): string | undefined {
		if (newImageFile) {
			return MenuImageService.generateImageKey(menuId, newImageFile);
		}
		return existingKey;
	}

	/**
	 * Checks if image upload is needed
	 *
	 * @param imageFile - Image file to check
	 * @returns true if upload is needed
	 */
	static shouldUpload(imageFile: File | undefined): boolean {
		return imageFile !== undefined;
	}

	/**
	 * Checks if image deletion is needed
	 *
	 * @param existingKey - Existing image key
	 * @returns true if deletion is needed
	 */
	static shouldDelete(existingKey: string | undefined): boolean {
		return existingKey !== undefined;
	}
}

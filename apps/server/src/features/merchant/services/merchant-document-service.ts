import { getFileExtension } from "@repo/shared";

/**
 * Service responsible for merchant document and image key management
 *
 * Handles:
 * - Document key generation with standard naming convention (M-{id}.{ext})
 * - Image key generation with standard naming convention (M-{id}.{ext})
 * - Storage bucket constants for merchant documents and images
 * - Key resolution for create/update operations
 *
 * @example
 * ```typescript
 * // Generate keys for new merchant
 * const docKey = MerchantDocumentService.generateDocumentKey(merchantId, documentFile);
 * const imageKey = MerchantDocumentService.generateImageKey(merchantId, imageFile);
 *
 * // Upload to appropriate buckets
 * if (docKey) {
 *   await storage.upload({
 *     bucket: MerchantDocumentService.PRIV_BUCKET,
 *     key: docKey,
 *     file: documentFile
 *   });
 * }
 *
 * // Resolve keys for update operation
 * const updatedDocKey = MerchantDocumentService.resolveUpdateDocumentKey(
 *   merchantId,
 *   existingDocKey,
 *   newDocFile
 * );
 * ```
 */
export class MerchantDocumentService {
	/**
	 * Bucket name for private merchant documents (legal/verification docs)
	 */
	static readonly PRIV_BUCKET = "merchant-priv";

	/**
	 * Bucket name for public merchant images (profile/logo images)
	 */
	static readonly PUB_BUCKET = "merchant";

	/**
	 * Generates document key for merchant verification documents
	 *
	 * Format: M-{id}.{extension}
	 * Stored in private bucket for security
	 *
	 * @param merchantId - Merchant ID
	 * @param documentFile - Document file (File/Blob object)
	 * @returns Document key or undefined if no file provided
	 */
	static generateDocumentKey(
		merchantId: string,
		documentFile: File | undefined,
	): string | undefined {
		if (!documentFile) return undefined;
		const extension = getFileExtension(documentFile);
		return `M-${merchantId}.${extension}`;
	}

	/**
	 * Generates image key for merchant profile/logo images
	 *
	 * Format: M-{id}.{extension}
	 * Stored in public bucket for display
	 *
	 * @param merchantId - Merchant ID
	 * @param imageFile - Image file (File/Blob object)
	 * @returns Image key or undefined if no file provided
	 */
	static generateImageKey(
		merchantId: string,
		imageFile: File | undefined,
	): string | undefined {
		if (!imageFile) return undefined;
		const extension = getFileExtension(imageFile);
		return `M-${merchantId}.${extension}`;
	}

	/**
	 * Resolves document key for update operation
	 *
	 * - If new document provided: generate new key
	 * - If no new document: keep existing key
	 *
	 * @param merchantId - Merchant ID
	 * @param existingKey - Current document key (if any)
	 * @param newDocumentFile - New document file (if updating)
	 * @returns Document key to use
	 */
	static resolveUpdateDocumentKey(
		merchantId: string,
		existingKey: string | undefined,
		newDocumentFile: File | undefined,
	): string | undefined {
		if (newDocumentFile) {
			return MerchantDocumentService.generateDocumentKey(
				merchantId,
				newDocumentFile,
			);
		}
		return existingKey;
	}

	/**
	 * Resolves image key for update operation
	 *
	 * - If new image provided: generate new key
	 * - If no new image: keep existing key
	 *
	 * @param merchantId - Merchant ID
	 * @param existingKey - Current image key (if any)
	 * @param newImageFile - New image file (if updating)
	 * @returns Image key to use
	 */
	static resolveUpdateImageKey(
		merchantId: string,
		existingKey: string | undefined,
		newImageFile: File | undefined,
	): string | undefined {
		if (newImageFile) {
			return MerchantDocumentService.generateImageKey(merchantId, newImageFile);
		}
		return existingKey;
	}

	/**
	 * Checks if file upload is needed
	 *
	 * @param file - File to check
	 * @returns true if upload is needed
	 */
	static shouldUpload(file: File | undefined): boolean {
		return file !== undefined;
	}

	/**
	 * Checks if file deletion is needed
	 *
	 * @param existingKey - Existing file key
	 * @returns true if deletion is needed
	 */
	static shouldDelete(existingKey: string | undefined): boolean {
		return existingKey !== undefined;
	}
}

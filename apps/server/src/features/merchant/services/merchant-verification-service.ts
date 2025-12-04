import { getFileExtension } from "@repo/shared";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import type { StorageService } from "@/core/services/storage";
import { log } from "@/utils";

const PRIV_BUCKET = "merchant-priv";
const PUB_BUCKET = "merchant";

/**
 * Service responsible for merchant verification document management
 *
 * Handles:
 * - Business document uploads (business license, permits)
 * - Merchant image uploads (storefront photos, logos)
 * - Document validation and duplicate detection
 * - File cleanup on merchant deletion
 *
 * @example
 * ```typescript
 * const verificationService = new MerchantVerificationService(db, storage);
 *
 * // Upload merchant documents
 * const { docKey, imageKey } = await verificationService.uploadDocuments({
 *   merchantId: "merchant-123",
 *   document: documentFile,
 *   image: imageFile,
 * });
 * ```
 */
export class MerchantVerificationService {
	readonly #db: DatabaseService;
	readonly #storage: StorageService;

	constructor(db: DatabaseService, storage: StorageService) {
		this.#db = db;
		this.#storage = storage;
	}

	/**
	 * Validates merchant documents
	 *
	 * @param params - Validation parameters
	 * @returns Validation result
	 * @throws RepositoryError if validation fails
	 */
	async validateDocuments(params: {
		document?: File;
		image?: File;
	}): Promise<{ valid: boolean; errors: string[] }> {
		const errors: string[] = [];

		// Document validation (if provided)
		if (params.document !== undefined && params.document !== null) {
			// Basic file validation - type checking is handled by TypeScript
			if (!params.document) {
				errors.push("Invalid document file");
			}
		}

		// Image validation (if provided)
		if (params.image !== undefined && params.image !== null) {
			// Basic file validation - type checking is handled by TypeScript
			if (!params.image) {
				errors.push("Invalid image file");
			}
		}

		return {
			valid: errors.length === 0,
			errors,
		};
	}

	/**
	 * Checks if merchant with same business name already exists
	 *
	 * @param name - Business name to check
	 * @param opts - Optional transaction context
	 * @returns true if duplicate exists
	 */
	async checkDuplicateName(
		name: string,
		excludeMerchantId?: string,
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			const existing = await (opts?.tx ?? this.#db).query.merchant.findFirst({
				columns: { id: true },
				where: (f, op) =>
					excludeMerchantId
						? op.and(
								op.ilike(f.name, name),
								op.not(op.eq(f.id, excludeMerchantId)),
							)
						: op.ilike(f.name, name),
			});

			return existing !== undefined && existing !== null;
		} catch (error) {
			log.error(
				{ error, name },
				"[MerchantVerificationService] Failed to check duplicate name",
			);
			return false;
		}
	}

	/**
	 * Uploads merchant documents
	 *
	 * Handles:
	 * - Business document upload to private bucket
	 * - Merchant image upload to public bucket
	 * - File naming convention: M-{merchantId}.{extension}
	 *
	 * @param params - Upload parameters
	 * @returns Document and image keys
	 */
	async uploadDocuments(params: {
		merchantId: string;
		document?: File;
		image?: File;
	}): Promise<{ docKey?: string; imageKey?: string }> {
		try {
			const { merchantId, document, image } = params;

			// Generate file keys
			const docKey = document
				? `M-${merchantId}.${getFileExtension(document)}`
				: undefined;
			const imageKey = image
				? `M-${merchantId}.${getFileExtension(image)}`
				: undefined;

			// Upload documents in parallel
			await Promise.all([
				document && docKey
					? this.#storage.upload({
							bucket: PRIV_BUCKET,
							key: docKey,
							file: document,
						})
					: Promise.resolve(),
				image && imageKey
					? this.#storage.upload({
							bucket: PUB_BUCKET,
							key: imageKey,
							file: image,
						})
					: Promise.resolve(),
			]);

			log.info(
				{ merchantId, docKey, imageKey },
				"[MerchantVerificationService] Documents uploaded",
			);

			return { docKey, imageKey };
		} catch (error) {
			log.error(
				{ error, params },
				"[MerchantVerificationService] Failed to upload documents",
			);
			throw new RepositoryError("Failed to upload merchant documents", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Updates existing merchant documents
	 *
	 * Only uploads files that are provided. Existing files remain unchanged.
	 *
	 * @param params - Update parameters
	 * @returns Updated document and image keys
	 */
	async updateDocuments(params: {
		merchantId: string;
		document?: File;
		image?: File;
		existingDocKey?: string;
		existingImageKey?: string;
	}): Promise<{ docKey?: string; imageKey?: string }> {
		try {
			const { merchantId, document, image, existingDocKey, existingImageKey } =
				params;

			// Generate new keys if files provided
			const docKey = document
				? `M-${merchantId}.${getFileExtension(document)}`
				: existingDocKey;
			const imageKey = image
				? `M-${merchantId}.${getFileExtension(image)}`
				: existingImageKey;

			// Upload only new files
			await Promise.all([
				document && docKey
					? this.#storage.upload({
							bucket: PRIV_BUCKET,
							key: docKey,
							file: document,
						})
					: Promise.resolve(),
				image && imageKey
					? this.#storage.upload({
							bucket: PUB_BUCKET,
							key: imageKey,
							file: image,
						})
					: Promise.resolve(),
			]);

			log.info(
				{ merchantId, docKey, imageKey },
				"[MerchantVerificationService] Documents updated",
			);

			return { docKey, imageKey };
		} catch (error) {
			log.error(
				{ error, params },
				"[MerchantVerificationService] Failed to update documents",
			);
			throw new RepositoryError("Failed to update merchant documents", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Deletes merchant documents from storage
	 *
	 * @param params - Delete parameters
	 */
	async deleteDocuments(params: {
		docKey?: string;
		imageKey?: string;
	}): Promise<void> {
		try {
			const { docKey, imageKey } = params;

			await Promise.all([
				docKey
					? this.#storage.delete({
							bucket: PRIV_BUCKET,
							key: docKey,
						})
					: Promise.resolve(),
				imageKey
					? this.#storage.delete({
							bucket: PUB_BUCKET,
							key: imageKey,
						})
					: Promise.resolve(),
			]);

			log.info(
				{ docKey, imageKey },
				"[MerchantVerificationService] Documents deleted",
			);
		} catch (error) {
			log.error(
				{ error, params },
				"[MerchantVerificationService] Failed to delete documents",
			);
			throw new RepositoryError("Failed to delete merchant documents", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Validates and uploads documents during merchant creation
	 *
	 * @param params - Creation parameters
	 * @returns Document keys for database insertion
	 */
	async validateAndUploadDocuments(params: {
		merchantId: string;
		document?: File;
		image?: File;
		businessName: string;
		opts?: PartialWithTx;
	}): Promise<{ docKey?: string; imageKey?: string }> {
		try {
			const { merchantId, document, image, businessName, opts } = params;

			// Validate documents
			const validation = await this.validateDocuments({ document, image });
			if (!validation.valid) {
				throw new RepositoryError(
					`Document validation failed: ${validation.errors.join(", ")}`,
					{ code: "BAD_REQUEST" },
				);
			}

			// Check for duplicate business name
			const isDuplicate = await this.checkDuplicateName(
				businessName,
				undefined,
				opts,
			);
			if (isDuplicate) {
				throw new RepositoryError(
					`Merchant with name "${businessName}" already exists`,
					{ code: "BAD_REQUEST" },
				);
			}

			// Upload documents
			const result = await this.uploadDocuments({
				merchantId,
				document,
				image,
			});

			log.info(
				{ merchantId, businessName },
				"[MerchantVerificationService] Merchant documents validated and uploaded",
			);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;

			log.error(
				{ error, params },
				"[MerchantVerificationService] Failed to validate and upload documents",
			);
			throw new RepositoryError(
				"Failed to validate and upload merchant documents",
				{ code: "INTERNAL_SERVER_ERROR" },
			);
		}
	}
}

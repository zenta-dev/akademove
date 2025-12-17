import { v7 } from "uuid";
import { RepositoryError } from "@/core/error";
import type { StorageService } from "@/core/services/storage";
import { logger } from "@/utils/logger";

/**
 * DeliveryProofService - Handles proof of delivery operations
 *
 * Responsibilities:
 * - Upload proof photos to S3
 * - Get presigned URLs for viewing proofs
 *
 * @example
 * ```typescript
 * const service = new DeliveryProofService(storageService);
 *
 * // Upload proof
 * const url = await service.uploadProof({
 *   orderId: "order-123",
 *   file: proofFile,
 *   userId: "user-456",
 * });
 * ```
 */
export class DeliveryProofService {
	constructor(private readonly storageService: StorageService) {}

	/**
	 * Upload proof photo to S3
	 *
	 * @param params - Upload parameters
	 * @returns S3 URL of uploaded proof
	 * @throws {RepositoryError} When upload fails
	 */
	async uploadProof(params: {
		orderId: string;
		file: File;
		userId: string;
	}): Promise<string> {
		try {
			const { orderId, file, userId } = params;

			// Generate unique key
			const timestamp = Date.now();
			const uniqueId = v7();
			const extension = file.name.split(".").pop() || "jpg";
			const key = `delivery-proofs/${orderId}/${timestamp}-${uniqueId}.${extension}`;

			logger.info(
				{ orderId, userId, key, size: file.size },
				"[DeliveryProofService] Uploading proof",
			);

			// Upload to S3
			const url = await this.storageService.upload({
				bucket: "delivery-proofs",
				key,
				file,
				userId,
				isPublic: false, // Private - only accessible via presigned URL
			});

			logger.info(
				{ orderId, url },
				"[DeliveryProofService] Proof uploaded successfully",
			);

			return url;
		} catch (error) {
			logger.error(
				{ error, orderId: params.orderId },
				"[DeliveryProofService] Upload failed",
			);
			throw new RepositoryError("Failed to upload proof of delivery", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Get presigned URL for viewing proof
	 *
	 * @param proofUrl - S3 URL of proof
	 * @returns Presigned URL valid for 15 minutes
	 */
	async getProofPresignedUrl(proofUrl: string): Promise<string> {
		try {
			// Extract bucket and key from URL
			const url = new URL(proofUrl);
			const pathParts = url.pathname.split("/");
			const bucket = pathParts[1] as "delivery-proofs";
			const key = pathParts.slice(2).join("/");

			const presignedUrl = await this.storageService.getPresignedUrl({
				bucket,
				key,
				expiresIn: 900, // 15 minutes
			});

			logger.debug(
				{ proofUrl },
				"[DeliveryProofService] Generated presigned URL",
			);

			return presignedUrl;
		} catch (error) {
			logger.error(
				{ error, proofUrl },
				"[DeliveryProofService] Failed to generate presigned URL",
			);
			throw new RepositoryError("Failed to get proof URL", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Upload delivery item photo to S3
	 * This is used by drivers to document the item they picked up for delivery
	 *
	 * @param params - Upload parameters
	 * @returns S3 URL of uploaded photo
	 * @throws {RepositoryError} When upload fails
	 */
	async uploadDeliveryItemPhoto(params: {
		orderId: string;
		file: File;
		userId: string;
	}): Promise<string> {
		try {
			const { orderId, file, userId } = params;

			// Generate unique key
			const timestamp = Date.now();
			const uniqueId = v7();
			const extension = file.name.split(".").pop() || "jpg";
			const key = `delivery-item-photos/${orderId}/${timestamp}-${uniqueId}.${extension}`;

			logger.info(
				{ orderId, userId, key, size: file.size },
				"[DeliveryProofService] Uploading delivery item photo",
			);

			// Upload to S3
			const url = await this.storageService.upload({
				bucket: "delivery-proofs",
				key,
				file,
				userId,
				isPublic: false, // Private - only accessible via presigned URL
			});

			logger.info(
				{ orderId, url },
				"[DeliveryProofService] Delivery item photo uploaded successfully",
			);

			return url;
		} catch (error) {
			logger.error(
				{ error, orderId: params.orderId },
				"[DeliveryProofService] Delivery item photo upload failed",
			);
			throw new RepositoryError("Failed to upload delivery item photo", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Upload order attachment to S3
	 * This is used by users to upload document files for Printing merchants
	 *
	 * @param params - Upload parameters
	 * @returns S3 URL of uploaded attachment
	 * @throws {RepositoryError} When upload fails
	 */
	async uploadOrderAttachment(params: {
		file: File;
		userId: string;
	}): Promise<string> {
		try {
			const { file, userId } = params;

			// Generate unique key
			const timestamp = Date.now();
			const uniqueId = v7();
			const extension = file.name.split(".").pop() || "pdf";
			const key = `order-attachments/${userId}/${timestamp}-${uniqueId}.${extension}`;

			logger.info(
				{ userId, key, size: file.size, fileName: file.name },
				"[DeliveryProofService] Uploading order attachment",
			);

			// Upload to S3
			const url = await this.storageService.upload({
				bucket: "delivery-proofs",
				key,
				file,
				userId,
				isPublic: false, // Private - only accessible via presigned URL
			});

			logger.info(
				{ userId, url },
				"[DeliveryProofService] Order attachment uploaded successfully",
			);

			return url;
		} catch (error) {
			logger.error(
				{ error, userId: params.userId },
				"[DeliveryProofService] Order attachment upload failed",
			);
			throw new RepositoryError("Failed to upload order attachment", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Upload user delivery item photo to S3
	 * This is used by USERS to upload a photo of the item BEFORE placing a delivery order
	 * Drivers can see this photo when they receive the order offer to know what item they'll be delivering
	 *
	 * @param params - Upload parameters
	 * @returns S3 URL of uploaded photo
	 * @throws {RepositoryError} When upload fails
	 */
	async uploadUserDeliveryItemPhoto(params: {
		file: File;
		userId: string;
	}): Promise<string> {
		try {
			const { file, userId } = params;

			// Generate unique key
			const timestamp = Date.now();
			const uniqueId = v7();
			const extension = file.name.split(".").pop() || "jpg";
			const key = `user-delivery-item-photos/${userId}/${timestamp}-${uniqueId}.${extension}`;

			logger.info(
				{ userId, key, size: file.size, fileName: file.name },
				"[DeliveryProofService] Uploading user delivery item photo",
			);

			// Upload to S3
			const url = await this.storageService.upload({
				bucket: "delivery-proofs",
				key,
				file,
				userId,
				isPublic: false, // Private - only accessible via presigned URL
			});

			logger.info(
				{ userId, url },
				"[DeliveryProofService] User delivery item photo uploaded successfully",
			);

			return url;
		} catch (error) {
			logger.error(
				{ error, userId: params.userId },
				"[DeliveryProofService] User delivery item photo upload failed",
			);
			throw new RepositoryError("Failed to upload delivery item photo", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}
}

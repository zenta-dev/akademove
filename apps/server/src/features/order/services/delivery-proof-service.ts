import { v7 } from "uuid";
import { RepositoryError } from "@/core/error";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { logger } from "@/utils/logger";

/**
 * DeliveryProofService - Handles proof of delivery operations
 *
 * Responsibilities:
 * - Generate OTP for delivery verification
 * - Upload proof photos to S3
 * - Verify OTP matches
 *
 * @example
 * ```typescript
 * const service = new DeliveryProofService(storageService, db, kv);
 *
 * // Generate OTP
 * const otp = service.generateOTP();
 *
 * // Upload proof
 * const url = await service.uploadProof({
 *   orderId: "order-123",
 *   file: proofFile,
 *   userId: "user-456",
 * });
 *
 * // Verify OTP
 * const isValid = service.verifyOTP("123456", "123456");
 * ```
 */
export class DeliveryProofService {
	static readonly OTP_LENGTH = 6;

	constructor(
		private readonly storageService: StorageService,
		private readonly db: DatabaseService,
		private readonly kv: KeyValueService,
	) {}

	/**
	 * Generate 6-digit OTP for delivery verification
	 *
	 * @returns 6-digit OTP string
	 */
	generateOTP(): string {
		const min = 100000;
		const max = 999999;
		const otp = Math.floor(Math.random() * (max - min + 1)) + min;

		logger.debug("[DeliveryProofService] Generated OTP");

		return otp.toString();
	}

	/**
	 * Check if order requires OTP verification based on value.
	 * The threshold is fetched from database configuration.
	 *
	 * @param totalPrice - Order total price in IDR
	 * @returns true if OTP required
	 */
	async requiresOTP(totalPrice: number): Promise<boolean> {
		const threshold =
			await BusinessConfigurationService.getHighValueOrderThreshold(
				this.db,
				this.kv,
			);
		return totalPrice >= threshold;
	}

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
	 * Verify OTP matches expected value
	 *
	 * @param provided - OTP provided by user
	 * @param expected - Expected OTP from database
	 * @returns true if OTP matches
	 */
	verifyOTP(provided: string, expected: string): boolean {
		if (!provided || !expected) {
			logger.warn("[DeliveryProofService] Missing OTP values");
			return false;
		}

		// Normalize (trim and remove spaces)
		const normalizedProvided = provided.trim().replace(/\s/g, "");
		const normalizedExpected = expected.trim().replace(/\s/g, "");

		const isValid = normalizedProvided === normalizedExpected;

		logger.info(
			{ isValid },
			"[DeliveryProofService] OTP verification completed",
		);

		return isValid;
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
}

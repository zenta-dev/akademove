import { getFileExtension } from "@repo/shared";

/**
 * Service responsible for driver document key management
 *
 * Handles:
 * - Document key generation with standard naming conventions
 * - Storage bucket constants
 * - Key resolution for create/update operations
 *
 * Key formats:
 * - Student Card: SC-{id}.{ext}
 * - Driver License: DL-{id}.{ext}
 * - Vehicle Certificate: VC-{id}.{ext}
 *
 * @example
 * ```typescript
 * // Generate keys for new driver
 * const keys = DriverDocumentService.generateKeys(driverId, {
 *   studentCard: file1,
 *   driverLicense: file2,
 *   vehicleCertificate: file3
 * });
 *
 * // Generate single key
 * const scKey = DriverDocumentService.generateStudentCardKey(driverId, file);
 *
 * // Resolve keys for update
 * const updatedKey = DriverDocumentService.resolveUpdateKey(
 *   driverId,
 *   existingKey,
 *   newFile,
 *   'SC'
 * );
 * ```
 */
export class DriverDocumentService {
	/**
	 * Bucket name for driver documents
	 */
	static readonly BUCKET = "driver";

	/**
	 * Generates student card key
	 *
	 * Format: SC-{id}.{extension}
	 *
	 * @param driverId - Driver ID
	 * @param file - Student card file
	 * @returns Key or undefined if no file provided
	 */
	static generateStudentCardKey(
		driverId: string,
		file: File | undefined,
	): string | undefined {
		if (!file) return undefined;
		const extension = getFileExtension(file);
		return `SC-${driverId}.${extension}`;
	}

	/**
	 * Generates driver license key
	 *
	 * Format: DL-{id}.{extension}
	 *
	 * @param driverId - Driver ID
	 * @param file - Driver license file
	 * @returns Key or undefined if no file provided
	 */
	static generateDriverLicenseKey(
		driverId: string,
		file: File | undefined,
	): string | undefined {
		if (!file) return undefined;
		const extension = getFileExtension(file);
		return `DL-${driverId}.${extension}`;
	}

	/**
	 * Generates vehicle certificate key
	 *
	 * Format: VC-{id}.{extension}
	 *
	 * @param driverId - Driver ID
	 * @param file - Vehicle certificate file
	 * @returns Key or undefined if no file provided
	 */
	static generateVehicleCertificateKey(
		driverId: string,
		file: File | undefined,
	): string | undefined {
		if (!file) return undefined;
		const extension = getFileExtension(file);
		return `VC-${driverId}.${extension}`;
	}

	/**
	 * Generates all document keys at once
	 *
	 * @param driverId - Driver ID
	 * @param files - Document files
	 * @returns Object with all keys (undefined for missing files)
	 */
	static generateKeys(
		driverId: string,
		files: {
			studentCard: File;
			driverLicense: File;
			vehicleCertificate: File;
		},
	): {
		studentCard: string;
		driverLicense: string;
		vehicleCertificate: string;
	} {
		return {
			studentCard: `SC-${driverId}.${getFileExtension(files.studentCard)}`,
			driverLicense: `DL-${driverId}.${getFileExtension(files.driverLicense)}`,
			vehicleCertificate: `VC-${driverId}.${getFileExtension(files.vehicleCertificate)}`,
		};
	}

	/**
	 * Resolves key for update operation based on prefix
	 *
	 * - If new file provided: generate new key
	 * - If no new file: keep existing key
	 *
	 * @param driverId - Driver ID
	 * @param existingKey - Current key (if any)
	 * @param newFile - New file (if updating)
	 * @param prefix - Key prefix (SC, DL, or VC)
	 * @returns Key to use
	 */
	static resolveUpdateKey(
		driverId: string,
		existingKey: string | undefined,
		newFile: File | undefined,
		prefix: "SC" | "DL" | "VC",
	): string | undefined {
		if (newFile) {
			const extension = getFileExtension(newFile);
			return `${prefix}-${driverId}.${extension}`;
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

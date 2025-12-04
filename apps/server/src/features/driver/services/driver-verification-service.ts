import type { InsertDriver } from "@repo/schema/driver";
import { v7 } from "uuid";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import type { StorageService } from "@/core/services/storage";
import { log } from "@/utils";
import { DriverDocumentService } from "./driver-document-service";

/**
 * Service responsible for driver verification and document management
 *
 * Handles:
 * - Document upload (student card, license, vehicle certificate)
 * - Duplicate detection (student ID, license plate)
 * - File key generation and storage
 *
 * @example
 * ```typescript
 * const verificationService = new DriverVerificationService(db, storage);
 *
 * // Validate and upload documents
 * const fileKeys = await verificationService.validateAndUploadDocuments({
 *   studentId: "12345678",
 *   licensePlate: "B1234XYZ",
 *   studentCard: file1,
 *   driverLicense: file2,
 *   vehicleCertificate: file3
 * });
 * ```
 */
export class DriverVerificationService {
	readonly #db: DatabaseService;
	readonly #storage: StorageService;

	constructor(db: DatabaseService, storage: StorageService) {
		this.#db = db;
		this.#storage = storage;
	}

	/**
	 * Validates student ID and license plate uniqueness
	 *
	 * Checks database for existing drivers with same:
	 * - Student ID (student card number)
	 * - License plate (vehicle registration)
	 *
	 * @param data - Driver data to validate
	 * @param opts - Optional transaction context
	 * @throws RepositoryError if duplicate found
	 */
	async validateUniqueness(
		data: { studentId: number; licensePlate: string },
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			const tx = opts?.tx ?? this.#db;

			const existingDriver = await tx.query.driver.findFirst({
				columns: { studentId: true, licensePlate: true },
				where: (f, op) =>
					op.or(
						op.eq(f.studentId, data.studentId),
						op.eq(f.licensePlate, data.licensePlate),
					),
			});

			if (!existingDriver) {
				return;
			}

			if (existingDriver.studentId === data.studentId) {
				throw new RepositoryError("Student ID already registered", {
					code: "CONFLICT",
				});
			}

			if (existingDriver.licensePlate === data.licensePlate) {
				throw new RepositoryError("License Plate already registered", {
					code: "CONFLICT",
				});
			}
		} catch (error) {
			if (error instanceof RepositoryError) throw error;

			log.error(
				{ error, data },
				"[DriverVerificationService] Failed to validate uniqueness",
			);
			throw new RepositoryError("Failed to validate driver uniqueness", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Generates file keys for driver documents
	 *
	 * Delegates to DriverDocumentService for key generation
	 *
	 * @param files - Document files
	 * @param driverId - Optional driver ID (generates new if not provided)
	 * @returns File keys for storage
	 */
	generateFileKeys(
		files: {
			studentCard: File;
			driverLicense: File;
			vehicleCertificate: File;
		},
		driverId?: string,
	): {
		id: string;
		studentCard: string;
		driverLicense: string;
		vehicleCertificate: string;
	} {
		const id = driverId ?? v7();
		const keys = DriverDocumentService.generateKeys(id, files);

		return {
			id,
			...keys,
		};
	}

	/**
	 * Uploads driver documents to storage
	 *
	 * Uploads in parallel:
	 * - Student card (KTM)
	 * - Driver license (SIM)
	 * - Vehicle certificate (STNK)
	 *
	 * @param fileKeys - Generated file keys
	 * @param files - Document files to upload
	 * @returns Promise resolving when all uploads complete
	 */
	async uploadDocuments(
		fileKeys: {
			studentCard: string;
			driverLicense: string;
			vehicleCertificate: string;
		},
		files: {
			studentCard: File;
			driverLicense: File;
			vehicleCertificate: File;
		},
	): Promise<void> {
		try {
			await Promise.all([
				this.#storage.upload({
					bucket: DriverDocumentService.BUCKET,
					key: fileKeys.studentCard,
					file: files.studentCard,
				}),
				this.#storage.upload({
					bucket: DriverDocumentService.BUCKET,
					key: fileKeys.driverLicense,
					file: files.driverLicense,
				}),
				this.#storage.upload({
					bucket: DriverDocumentService.BUCKET,
					key: fileKeys.vehicleCertificate,
					file: files.vehicleCertificate,
				}),
			]);

			log.info(
				{ fileKeys },
				"[DriverVerificationService] Uploaded driver documents",
			);
		} catch (error) {
			log.error(
				{ error, fileKeys },
				"[DriverVerificationService] Failed to upload documents",
			);
			throw new RepositoryError("Failed to upload driver documents", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Updates driver documents (replaces existing files)
	 *
	 * Only uploads provided files (partial update support)
	 *
	 * @param driverId - Driver ID
	 * @param files - Document files to update (partial)
	 * @returns Promise resolving when all uploads complete
	 */
	async updateDocuments(
		driverId: string,
		files: Partial<{
			studentCard: File;
			driverLicense: File;
			vehicleCertificate: File;
		}>,
	): Promise<void> {
		try {
			const scKey = DriverDocumentService.generateStudentCardKey(
				driverId,
				files.studentCard,
			);
			const dlKey = DriverDocumentService.generateDriverLicenseKey(
				driverId,
				files.driverLicense,
			);
			const vcKey = DriverDocumentService.generateVehicleCertificateKey(
				driverId,
				files.vehicleCertificate,
			);

			const uploads = [
				files.studentCard &&
					scKey &&
					this.#storage.upload({
						bucket: DriverDocumentService.BUCKET,
						key: scKey,
						file: files.studentCard,
					}),
				files.driverLicense &&
					dlKey &&
					this.#storage.upload({
						bucket: DriverDocumentService.BUCKET,
						key: dlKey,
						file: files.driverLicense,
					}),
				files.vehicleCertificate &&
					vcKey &&
					this.#storage.upload({
						bucket: DriverDocumentService.BUCKET,
						key: vcKey,
						file: files.vehicleCertificate,
					}),
			].filter(Boolean);

			await Promise.all(uploads);

			log.info(
				{ driverId, updatedFields: Object.keys(files) },
				"[DriverVerificationService] Updated driver documents",
			);
		} catch (error) {
			log.error(
				{ error, driverId },
				"[DriverVerificationService] Failed to update documents",
			);
			throw new RepositoryError("Failed to update driver documents", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Deletes driver documents from storage
	 *
	 * @param fileKeys - File keys to delete
	 * @returns Promise resolving when all deletes complete
	 */
	async deleteDocuments(fileKeys: {
		studentCard: string;
		driverLicense: string;
		vehicleCertificate: string;
	}): Promise<void> {
		try {
			await Promise.all([
				this.#storage.delete({
					bucket: DriverDocumentService.BUCKET,
					key: fileKeys.studentCard,
				}),
				this.#storage.delete({
					bucket: DriverDocumentService.BUCKET,
					key: fileKeys.driverLicense,
				}),
				this.#storage.delete({
					bucket: DriverDocumentService.BUCKET,
					key: fileKeys.vehicleCertificate,
				}),
			]);

			log.info(
				{ fileKeys },
				"[DriverVerificationService] Deleted driver documents",
			);
		} catch (error) {
			log.error(
				{ error, fileKeys },
				"[DriverVerificationService] Failed to delete documents",
			);
			throw new RepositoryError("Failed to delete driver documents", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Validates and uploads documents in a single operation
	 *
	 * Workflow:
	 * 1. Validate uniqueness (student ID, license plate)
	 * 2. Generate file keys
	 * 3. Upload documents to storage
	 *
	 * @param data - Driver data with documents
	 * @param opts - Optional transaction context
	 * @returns File keys for database insertion
	 */
	async validateAndUploadDocuments(
		data: Pick<
			InsertDriver,
			| "studentId"
			| "licensePlate"
			| "studentCard"
			| "driverLicense"
			| "vehicleCertificate"
		>,
		opts?: PartialWithTx,
	): Promise<{
		id: string;
		studentCard: string;
		driverLicense: string;
		vehicleCertificate: string;
	}> {
		try {
			// Step 1: Validate uniqueness
			await this.validateUniqueness(
				{ studentId: data.studentId, licensePlate: data.licensePlate },
				opts,
			);

			// Step 2: Generate file keys
			const fileKeys = this.generateFileKeys({
				studentCard: data.studentCard,
				driverLicense: data.driverLicense,
				vehicleCertificate: data.vehicleCertificate,
			});

			// Step 3: Upload documents
			await this.uploadDocuments(fileKeys, {
				studentCard: data.studentCard,
				driverLicense: data.driverLicense,
				vehicleCertificate: data.vehicleCertificate,
			});

			return fileKeys;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;

			log.error(
				{ error, data: { studentId: data.studentId } },
				"[DriverVerificationService] Failed to validate and upload documents",
			);
			throw new RepositoryError(
				"Failed to validate and upload driver documents",
				{ code: "INTERNAL_SERVER_ERROR" },
			);
		}
	}
}

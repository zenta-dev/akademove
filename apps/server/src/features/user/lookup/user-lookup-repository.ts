import type { Phone } from "@repo/schema/common";
import type { UserLookupResult } from "@repo/schema/user";
import { BaseRepository } from "@/core/base";
import type { PartialWithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { S3StorageService, type StorageService } from "@/core/services/storage";
import { logger } from "@/utils/logger";

export class UserLookupRepository extends BaseRepository {
	readonly #storage: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		// Use "user" as the cache prefix since we're looking up users
		super("user", kv, db);
		this.#storage = storage;
	}

	/**
	 * Masks a phone number for privacy, showing only the last 4 digits
	 * e.g., 81234567890 -> "****7890"
	 */
	static maskPhoneNumber(phoneNumber: number): string {
		const phoneStr = phoneNumber.toString();
		if (phoneStr.length <= 4) {
			return phoneStr;
		}
		const maskedPart = "*".repeat(phoneStr.length - 4);
		const visiblePart = phoneStr.slice(-4);
		return `${maskedPart}${visiblePart}`;
	}

	/**
	 * Parses a phone number string into a Phone object
	 * Supports formats: "081234567890", "81234567890", "+6281234567890", "6281234567890"
	 */
	static parsePhoneNumber(phoneString: string): Phone | null {
		// Remove all non-digit characters except leading +
		let cleaned = phoneString.replace(/[^\d+]/g, "");

		// Remove leading + if present
		if (cleaned.startsWith("+")) {
			cleaned = cleaned.substring(1);
		}

		// Handle Indonesian country code
		if (cleaned.startsWith("62")) {
			// Country code already present: +62 or 62
			const number = cleaned.substring(2);
			const parsedNumber = Number.parseInt(number, 10);
			if (Number.isNaN(parsedNumber)) return null;
			return { countryCode: "ID", number: parsedNumber };
		}
		if (cleaned.startsWith("0")) {
			// Local format: 081234567890 -> 81234567890
			const number = cleaned.substring(1);
			const parsedNumber = Number.parseInt(number, 10);
			if (Number.isNaN(parsedNumber)) return null;
			return { countryCode: "ID", number: parsedNumber };
		}
		// Assume it's already just the number part (without country code)
		const parsedNumber = Number.parseInt(cleaned, 10);
		if (Number.isNaN(parsedNumber)) return null;
		return { countryCode: "ID", number: parsedNumber };
	}

	/**
	 * Find user by phone number for wallet transfer lookup
	 * Returns minimal user info with masked phone for privacy
	 */
	async findByPhone(
		phoneString: string,
		requesterId: string,
		opts?: PartialWithTx,
	): Promise<UserLookupResult | null> {
		try {
			const phone = UserLookupRepository.parsePhoneNumber(phoneString);
			if (!phone) {
				logger.debug(
					{ phoneString },
					"[UserLookup] Invalid phone number format",
				);
				return null;
			}

			const cacheKey = `lookup:phone:${phone.countryCode}:${phone.number}`;

			const fallback = async () => {
				const tx = opts?.tx ?? this.db;

				const result = await tx.query.user.findFirst({
					columns: {
						id: true,
						name: true,
						phone: true,
						image: true,
					},
					where: (f, op) => op.eq(f.phone, phone),
				});

				if (!result) {
					logger.debug({ phone }, "[UserLookup] User not found by phone");
					return null;
				}

				// Don't return self
				if (result.id === requesterId) {
					logger.debug({ requesterId }, "[UserLookup] Cannot lookup self");
					return null;
				}

				// Generate presigned URL for image if exists
				let imageUrl: string | undefined;
				if (result.image) {
					try {
						imageUrl = await this.#storage.getPresignedUrl({
							bucket: "user",
							key: result.image,
							expiresIn: S3StorageService.SEVEN_DAY_PRESIGNED_URL_EXPIRY,
						});
					} catch {
						// Image might not exist, continue without it
					}
				}

				const composed: UserLookupResult = {
					id: result.id,
					name: result.name,
					phone: result.phone
						? {
								countryCode: result.phone.countryCode,
								maskedNumber: UserLookupRepository.maskPhoneNumber(
									result.phone.number,
								),
							}
						: undefined,
					image: imageUrl,
				};

				// Cache for 5 minutes
				await this.setCache(cacheKey, composed, { expirationTtl: 300 });

				return composed;
			};

			return await this.getCache(cacheKey, { fallback });
		} catch (error) {
			throw this.handleError(error, "find by phone");
		}
	}
}

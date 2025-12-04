import { m } from "@repo/i18n";
import type { Phone } from "@repo/schema/common";
import { getFileExtension } from "@repo/shared";
import { RepositoryError } from "@/core/error";

/**
 * Service responsible for user profile management logic
 */
export class UserProfileService {
	static readonly BUCKET = "user";

	/**
	 * Validate and normalize phone number
	 * @param phone - Phone object with countryCode and number
	 * @returns Normalized phone object
	 * @throws RepositoryError if phone is invalid
	 */
	static validatePhone(phone: Partial<Phone>): Phone {
		const cc = phone.countryCode;
		const num = phone.number;

		if (!cc || num === undefined) {
			throw new RepositoryError(m.error_invalid_phone_values(), {
				code: "BAD_REQUEST",
			});
		}

		return { countryCode: cc, number: num };
	}

	/**
	 * Generate photo key for user profile image
	 * @param userId - User ID
	 * @param photo - Photo file
	 * @returns Photo key string or undefined
	 */
	static generatePhotoKey(
		userId: string,
		photo: File | undefined,
	): string | undefined {
		if (!photo) return undefined;

		const extension = getFileExtension(photo);
		return `PP-${userId}.${extension}`;
	}

	/**
	 * Check if photo should be uploaded
	 * @param photo - Photo file
	 * @returns True if photo exists and should be uploaded
	 */
	static shouldUploadPhoto(photo: File | undefined): boolean {
		return photo !== undefined;
	}
}

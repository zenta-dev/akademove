import { m } from "@repo/i18n";
import { RepositoryError } from "@/core/error";
import type { PasswordManager } from "@/utils/password";

/**
 * Service responsible for password validation and change operations
 */
export class PasswordChangeService {
	/**
	 * Validate password change request
	 * @param newPassword - New password
	 * @param confirmNewPassword - Confirmation of new password
	 * @throws RepositoryError if passwords don't match
	 */
	static validatePasswordMatch(
		newPassword: string,
		confirmNewPassword: string,
	): void {
		if (newPassword !== confirmNewPassword) {
			throw new RepositoryError(m.error_password_not_match(), {
				code: "BAD_REQUEST",
			});
		}
	}

	/**
	 * Verify old password is correct
	 * @param pm - Password manager instance
	 * @param storedHash - Stored password hash
	 * @param providedPassword - Password provided by user
	 * @throws RepositoryError if password is invalid
	 */
	static verifyOldPassword(
		pm: PasswordManager,
		storedHash: string,
		providedPassword: string,
	): void {
		const isValidPassword = pm.verify(storedHash, providedPassword);
		if (!isValidPassword) {
			throw new RepositoryError(m.error_invalid_credentials(), {
				code: "UNAUTHORIZED",
			});
		}
	}

	/**
	 * Hash new password
	 * @param pm - Password manager instance
	 * @param newPassword - New password to hash
	 * @returns Hashed password
	 */
	static hashPassword(pm: PasswordManager, newPassword: string): string {
		return pm.hash(newPassword);
	}
}

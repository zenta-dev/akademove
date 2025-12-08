import { randomInt } from "node:crypto";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { AuthError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { MailService } from "@/core/services/mail";
import { log } from "@/utils";
import type { PasswordManager } from "@/utils/password";

/**
 * Forgot password request
 */
export interface ForgotPasswordRequest {
	email: string;
}

/**
 * Reset password request
 */
export interface ResetPasswordRequest {
	email: string;
	code: string;
	newPassword: string;
}

/**
 * Dependencies for password reset operations
 */
export interface PasswordResetDeps {
	findUserByEmail: (email: string) => Promise<
		| {
				id: string;
				name: string;
				email: string;
		  }
		| undefined
	>;
	deleteCache: (userId: string) => Promise<void>;
}

/**
 * Service responsible for password reset flow
 *
 * Handles:
 * - Forgot password (OTP code generation)
 * - OTP code generation and storage
 * - Code validation and expiration
 * - Password reset execution
 * - Email notifications
 *
 * @example
 * ```typescript
 * const passwordResetService = new PasswordResetService(db, pw, mail);
 *
 * // Forgot password - sends OTP code via email
 * await passwordResetService.forgotPassword(
 *   { email },
 *   { findUserByEmail }
 * );
 *
 * // Reset password with OTP code
 * await passwordResetService.resetPassword(
 *   { email, code, newPassword },
 *   { deleteCache }
 * );
 * ```
 */
export class PasswordResetService {
	readonly #db: DatabaseService;
	readonly #pw: PasswordManager;
	readonly #mail: MailService;

	readonly #RESET_CODE_EXPIRY_MINUTES = 15;

	constructor(db: DatabaseService, pw: PasswordManager, mail: MailService) {
		this.#db = db;
		this.#pw = pw;
		this.#mail = mail;
	}

	/**
	 * Generates 6-digit OTP code and sends email
	 *
	 * Process:
	 * 1. Find user by email
	 * 2. Delete any existing reset codes for this email
	 * 3. Generate secure random 6-digit OTP code
	 * 4. Store code in verification table with 15-minute expiry
	 * 5. Send reset email with OTP code to user
	 *
	 * @param request - Email address
	 * @param deps - User lookup function
	 * @returns true if successful
	 * @throws AuthError if email not found
	 */
	async forgotPassword(
		request: ForgotPasswordRequest,
		deps: PasswordResetDeps,
	): Promise<boolean> {
		try {
			const user = await deps.findUserByEmail(request.email);

			if (!user) {
				throw new AuthError("Email not registered", { code: "NOT_FOUND" });
			}

			// Delete any existing reset codes for this email
			await this.#db
				.delete(tables.verification)
				.where(eq(tables.verification.identifier, request.email));

			// Generate 6-digit OTP code
			const code = randomInt(100000, 999999).toString();
			const expiresAt = new Date(
				Date.now() + this.#RESET_CODE_EXPIRY_MINUTES * 60 * 1000,
			);

			await this.#db.insert(tables.verification).values({
				id: v7(),
				identifier: request.email,
				value: code,
				expiresAt,
			});

			await this.#mail.sendResetPassword({
				to: user.email,
				code,
				userName: user.name,
			});

			log.info(
				{ userId: user.id, email: user.email },
				"[PasswordResetService] Password reset OTP sent",
			);

			return true;
		} catch (error) {
			log.error(
				{ error, email: request.email },
				"[PasswordResetService] Forgot password failed",
			);
			throw error;
		}
	}

	/**
	 * Validates OTP code and resets password
	 *
	 * Process:
	 * 1. Find verification code by email and code (not expired)
	 * 2. Find user by email
	 * 3. Hash new password with scrypt
	 * 4. Update account password in transaction
	 * 5. Delete verification code
	 * 6. Invalidate user session cache
	 *
	 * @param request - Email, OTP code, and new password
	 * @param deps - Cache deletion function
	 * @returns true if successful
	 * @throws AuthError if code invalid/expired or user not found
	 */
	async resetPassword(
		request: ResetPasswordRequest,
		deps: Pick<PasswordResetDeps, "deleteCache">,
		opts?: WithTx,
	): Promise<boolean> {
		try {
			const verification = await (
				opts?.tx ?? this.#db
			).query.verification.findFirst({
				where: (f, op) =>
					op.and(
						op.eq(f.identifier, request.email),
						op.eq(f.value, request.code),
						op.gt(f.expiresAt, new Date()),
					),
			});

			if (!verification) {
				throw new AuthError("Invalid or expired OTP code", {
					code: "BAD_REQUEST",
				});
			}

			const user = await (opts?.tx ?? this.#db).query.user.findFirst({
				columns: { id: true, email: true },
				with: {
					accounts: {
						columns: { id: true },
						where: (f, op) => op.eq(f.providerId, "credentials"),
					},
				},
				where: (f, op) => op.eq(f.email, request.email),
			});

			if (!user?.accounts[0]) {
				throw new AuthError("User account not found", { code: "NOT_FOUND" });
			}

			const hashedPassword = this.#pw.hash(request.newPassword);

			await (opts?.tx ?? this.#db).transaction(async (tx) => {
				await Promise.all([
					tx
						.update(tables.account)
						.set({ password: hashedPassword })
						.where(eq(tables.account.id, user.accounts[0].id)),
					tx
						.delete(tables.verification)
						.where(eq(tables.verification.id, verification.id)),
				]);
			});

			await deps.deleteCache(user.id);

			log.info(
				{ userId: user.id, email: user.email },
				"[PasswordResetService] Password reset successful",
			);

			return true;
		} catch (error) {
			log.error({ error }, "[PasswordResetService] Reset password failed");
			throw error;
		}
	}
}

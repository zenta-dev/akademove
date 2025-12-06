import { env } from "cloudflare:workers";
import { randomBytes } from "node:crypto";
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
	token: string;
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
 * - Forgot password (email link generation)
 * - Reset token generation and storage
 * - Token validation and expiration
 * - Password reset execution
 * - Email notifications
 *
 * @example
 * ```typescript
 * const passwordResetService = new PasswordResetService(db, pw, mail);
 *
 * // Forgot password
 * await passwordResetService.forgotPassword(
 *   { email },
 *   { findUserByEmail }
 * );
 *
 * // Reset password
 * await passwordResetService.resetPassword(
 *   { token, newPassword },
 *   { deleteCache }
 * );
 * ```
 */
export class PasswordResetService {
	readonly #db: DatabaseService;
	readonly #pw: PasswordManager;
	readonly #mail: MailService;

	readonly #RESET_TOKEN_EXPIRY_HOURS = 1;

	constructor(db: DatabaseService, pw: PasswordManager, mail: MailService) {
		this.#db = db;
		this.#pw = pw;
		this.#mail = mail;
	}

	/**
	 * Generates reset token and sends email
	 *
	 * Process:
	 * 1. Find user by email
	 * 2. Generate secure random token (32 bytes)
	 * 3. Store token in verification table with 1-hour expiry
	 * 4. Send reset email with link to user
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

			const token = randomBytes(16).toString("hex");
			const expiresAt = new Date(
				Date.now() + this.#RESET_TOKEN_EXPIRY_HOURS * 60 * 60 * 1000,
			);

			await this.#db.insert(tables.verification).values({
				id: v7(),
				identifier: request.email,
				value: token,
				expiresAt,
			});

			const resetUrl = `${env.CORS_ORIGIN}/auth/reset-password?token=${token}`;

			await this.#mail.sendResetPassword({
				to: user.email,
				url: resetUrl,
				userName: user.name,
			});

			log.info(
				{ userId: user.id, email: user.email },
				"[PasswordResetService] Password reset email sent",
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
	 * Validates token and resets password
	 *
	 * Process:
	 * 1. Find verification token (not expired)
	 * 2. Find user by email from token
	 * 3. Hash new password with scrypt
	 * 4. Update account password in transaction
	 * 5. Delete verification token
	 * 6. Invalidate user session cache
	 *
	 * @param request - Token and new password
	 * @param deps - Cache deletion function
	 * @returns true if successful
	 * @throws AuthError if token invalid/expired or user not found
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
					op.and(op.eq(f.value, request.token), op.gt(f.expiresAt, new Date())),
			});

			if (!verification) {
				throw new AuthError("Invalid or expired reset token", {
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
				where: (f, op) => op.eq(f.email, verification.identifier),
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

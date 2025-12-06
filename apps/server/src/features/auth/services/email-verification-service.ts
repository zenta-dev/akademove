import { env } from "cloudflare:workers";
import { randomBytes } from "node:crypto";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { AuthError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { MailService } from "@/core/services/mail";
import { log } from "@/utils";

/**
 * Send email verification request
 */
export interface SendEmailVerificationRequest {
	email: string;
}

/**
 * Verify email request
 */
export interface VerifyEmailRequest {
	token: string;
}

/**
 * Dependencies for email verification operations
 */
export interface EmailVerificationDeps {
	findUserByEmail: (email: string) => Promise<
		| {
				id: string;
				name: string;
				email: string;
				emailVerified: boolean;
		  }
		| undefined
	>;
	deleteCache: (userId: string) => Promise<void>;
}

/**
 * Service responsible for email verification flow
 *
 * Handles:
 * - Send verification email (email link generation)
 * - Verification token generation and storage
 * - Token validation and expiration
 * - Email verification execution
 * - Email notifications
 *
 * @example
 * ```typescript
 * const emailVerificationService = new EmailVerificationService(db, mail);
 *
 * // Send verification email
 * await emailVerificationService.sendEmailVerification(
 *   { email },
 *   { findUserByEmail }
 * );
 *
 * // Verify email
 * await emailVerificationService.verifyEmail(
 *   { token },
 *   { deleteCache }
 * );
 * ```
 */
export class EmailVerificationService {
	readonly #db: DatabaseService;
	readonly #mail: MailService;

	readonly #VERIFICATION_TOKEN_EXPIRY_HOURS = 24;

	constructor(db: DatabaseService, mail: MailService) {
		this.#db = db;
		this.#mail = mail;
	}

	/**
	 * Generates verification token and sends email
	 *
	 * Process:
	 * 1. Find user by email
	 * 2. Check if email is already verified
	 * 3. Generate secure random token (32 bytes)
	 * 4. Store token in verification table with 24-hour expiry
	 * 5. Send verification email with link to user
	 *
	 * @param request - Email address
	 * @param deps - User lookup function
	 * @returns true if successful
	 * @throws AuthError if email not found or already verified
	 */
	async sendEmailVerification(
		request: SendEmailVerificationRequest,
		deps: EmailVerificationDeps,
	): Promise<boolean> {
		try {
			const user = await deps.findUserByEmail(request.email);

			if (!user) {
				throw new AuthError("Email not registered", { code: "NOT_FOUND" });
			}

			if (user.emailVerified) {
				throw new AuthError("Email is already verified", {
					code: "BAD_REQUEST",
				});
			}

			const token = randomBytes(16).toString("hex");
			const expiresAt = new Date(
				Date.now() + this.#VERIFICATION_TOKEN_EXPIRY_HOURS * 60 * 60 * 1000,
			);

			await this.#db.insert(tables.verification).values({
				id: v7(),
				identifier: request.email,
				value: token,
				expiresAt,
			});

			const verificationUrl = `${env.CORS_ORIGIN}/auth/verify-email?token=${token}`;

			await this.#mail.sendEmailVerification({
				to: user.email,
				url: verificationUrl,
				userName: user.name,
			});

			log.info(
				{ userId: user.id, email: user.email },
				"[EmailVerificationService] Email verification sent",
			);

			return true;
		} catch (error) {
			log.error(
				{ error, email: request.email },
				"[EmailVerificationService] Send email verification failed",
			);
			throw error;
		}
	}

	/**
	 * Validates token and verifies email
	 *
	 * Process:
	 * 1. Find verification token (not expired)
	 * 2. Find user by email from token
	 * 3. Check if email is already verified
	 * 4. Update user emailVerified flag in transaction
	 * 5. Delete verification token
	 * 6. Invalidate user session cache
	 *
	 * @param request - Token
	 * @param deps - Cache deletion function
	 * @returns true if successful
	 * @throws AuthError if token invalid/expired or user not found
	 */
	async verifyEmail(
		request: VerifyEmailRequest,
		deps: Pick<EmailVerificationDeps, "deleteCache">,
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
				throw new AuthError("Invalid or expired verification token", {
					code: "BAD_REQUEST",
				});
			}

			const user = await (opts?.tx ?? this.#db).query.user.findFirst({
				columns: { id: true, email: true, emailVerified: true },
				where: (f, op) => op.eq(f.email, verification.identifier),
			});

			if (!user) {
				throw new AuthError("User not found", { code: "NOT_FOUND" });
			}

			if (user.emailVerified) {
				throw new AuthError("Email is already verified", {
					code: "BAD_REQUEST",
				});
			}

			await (opts?.tx ?? this.#db).transaction(async (tx) => {
				await Promise.all([
					tx
						.update(tables.user)
						.set({ emailVerified: true })
						.where(eq(tables.user.id, user.id)),
					tx
						.delete(tables.verification)
						.where(eq(tables.verification.id, verification.id)),
				]);
			});

			await deps.deleteCache(user.id);

			log.info(
				{ userId: user.id, email: user.email },
				"[EmailVerificationService] Email verification successful",
			);

			return true;
		} catch (error) {
			log.error({ error }, "[EmailVerificationService] Verify email failed");
			throw error;
		}
	}
}

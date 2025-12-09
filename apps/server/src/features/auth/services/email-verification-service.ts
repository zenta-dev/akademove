import { randomInt } from "node:crypto";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { AuthError } from "@/core/error";
import type { PartialWithTx, WithTx } from "@/core/interface";
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
	email: string;
	code: string;
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
 * - Send verification email (OTP code generation)
 * - OTP code generation and storage
 * - Code validation and expiration
 * - Email verification execution
 * - Email notifications
 *
 * @example
 * ```typescript
 * const emailVerificationService = new EmailVerificationService(db, mail);
 *
 * // Send verification email with OTP
 * await emailVerificationService.sendEmailVerification(
 *   { email },
 *   { findUserByEmail }
 * );
 *
 * // Verify email with OTP code
 * await emailVerificationService.verifyEmail(
 *   { email, code },
 *   { deleteCache }
 * );
 * ```
 */
export class EmailVerificationService {
	readonly #db: DatabaseService;
	readonly #mail: MailService;

	readonly #VERIFICATION_CODE_EXPIRY_MINUTES = 15;

	constructor(db: DatabaseService, mail: MailService) {
		this.#db = db;
		this.#mail = mail;
	}

	/**
	 * Generates 6-digit OTP code and sends email
	 *
	 * Process:
	 * 1. Find user by email
	 * 2. Check if email is already verified
	 * 3. Delete any existing verification codes for this email
	 * 4. Generate secure random 6-digit OTP code
	 * 5. Store code in verification table with 15-minute expiry
	 * 6. Send verification email with OTP code to user
	 *
	 * @param request - Email address
	 * @param deps - User lookup function
	 * @returns true if successful
	 * @throws AuthError if email not found or already verified
	 */
	async sendEmailVerification(
		request: SendEmailVerificationRequest,
		deps: EmailVerificationDeps,
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			const db = opts?.tx ?? this.#db;
			const user = await deps.findUserByEmail(request.email);

			if (!user) {
				throw new AuthError("Email not registered", { code: "NOT_FOUND" });
			}

			if (user.emailVerified) {
				throw new AuthError("Email is already verified", {
					code: "BAD_REQUEST",
				});
			}

			// Delete any existing verification codes for this email
			await db
				.delete(tables.verification)
				.where(eq(tables.verification.identifier, request.email));

			// Generate 6-digit OTP code
			const code = randomInt(100000, 999999).toString();
			const expiresAt = new Date(
				Date.now() + this.#VERIFICATION_CODE_EXPIRY_MINUTES * 60 * 1000,
			);

			await db.insert(tables.verification).values({
				id: v7(),
				identifier: request.email,
				value: code,
				expiresAt,
			});

			await this.#mail.sendEmailVerification({
				to: user.email,
				code,
				userName: user.name,
			});

			log.info(
				{ userId: user.id, email: user.email },
				"[EmailVerificationService] Email verification OTP sent",
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
	 * Validates OTP code and verifies email
	 *
	 * Process:
	 * 1. Find verification code by email and code (not expired)
	 * 2. Find user by email
	 * 3. Check if email is already verified
	 * 4. Update user emailVerified flag in transaction
	 * 5. Delete verification code
	 * 6. Invalidate user session cache
	 *
	 * @param request - Email and OTP code
	 * @param deps - Cache deletion function
	 * @returns true if successful
	 * @throws AuthError if code invalid/expired or user not found
	 */
	async verifyEmail(
		request: VerifyEmailRequest,
		deps: Pick<EmailVerificationDeps, "deleteCache">,
		opts?: WithTx,
	): Promise<boolean> {
		try {
			const db = opts?.tx ?? this.#db;
			const verification = await db.query.verification.findFirst({
				where: (f, op) =>
					op.and(
						op.eq(f.identifier, request.email),
						op.eq(f.value, request.code),
						op.gt(f.expiresAt, new Date()),
					),
			});

			if (!verification) {
				throw new AuthError("Invalid or expired verification code", {
					code: "BAD_REQUEST",
				});
			}

			const user = await db.query.user.findFirst({
				columns: { id: true, email: true, emailVerified: true },
				where: (f, op) => op.eq(f.email, request.email),
			});

			if (!user) {
				throw new AuthError("User not found", { code: "NOT_FOUND" });
			}

			if (user.emailVerified) {
				throw new AuthError("Email is already verified", {
					code: "BAD_REQUEST",
				});
			}

			await db.transaction(async (tx) => {
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

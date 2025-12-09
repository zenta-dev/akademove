import type {
	ForgotPassword,
	ResetPassword,
	SendEmailVerification,
	SignIn,
	SignUp,
	SignUpDriver,
	SignUpMerchant,
	VerifyEmail,
} from "@repo/schema/auth";
import type { ClientAgent, Phone } from "@repo/schema/common";
import type { UserRole } from "@repo/schema/user";
import { eq, type SQL } from "drizzle-orm";
import { BaseRepository } from "@/core/base";
import type { PartialWithTx, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MailService } from "@/core/services/mail";
import type { StorageService } from "@/core/services/storage";
import type { JwtManager } from "@/utils/jwt";
import type { PasswordManager } from "@/utils/password";
import {
	EmailVerificationService,
	PasswordResetService,
	SessionService,
	UserRegistrationService,
} from "./services";

/**
 * Repository responsible for authentication operations
 *
 * Delegates to:
 * - SessionService: Sign in, session management, token rotation, sign out
 * - UserRegistrationService: User/driver/merchant registration
 * - PasswordResetService: Forgot password, reset password flows
 *
 * This repository acts as a coordinator, bridging the handler layer
 * with the service layer while maintaining cache operations.
 */
export class AuthRepository extends BaseRepository {
	readonly #sessionService: SessionService;
	readonly #registrationService: UserRegistrationService;
	readonly #passwordResetService: PasswordResetService;
	readonly #emailVerificationService: EmailVerificationService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
		jwt: JwtManager,
		pw: PasswordManager,
		mail: MailService,
	) {
		super("user", kv, db);

		// Initialize services
		this.#sessionService = new SessionService(jwt, pw, storage, kv);
		this.#registrationService = new UserRegistrationService(db, pw, storage);
		this.#passwordResetService = new PasswordResetService(db, pw, mail);
		this.#emailVerificationService = new EmailVerificationService(db, mail);
	}

	/**
	 * Authenticates user and generates session token
	 *
	 * Delegates to SessionService.signIn()
	 *
	 * @param params - Email, password, and optional client agent
	 * @returns Token and user data
	 */
	async signIn(
		params: SignIn & { clientAgent?: ClientAgent },
		opts?: PartialWithTx,
	) {
		const db = opts?.tx ?? this.db;
		try {
			return await this.#sessionService.signIn(params, {
				getUserWithAccount: async (email: string) => {
					return await db.query.user.findFirst({
						with: {
							accounts: {
								columns: { password: true },
								where: (f, op) => op.eq(f.providerId, "credentials"),
							},
							userBadges: { with: { badge: true } },
						},
						where: (f, op) => op.eq(f.email, email),
					});
				},
				getUserById: async (id: string) => {
					return await db.query.user.findFirst({
						with: {
							userBadges: { with: { badge: true } },
						},
						where: (f, op) => op.eq(f.id, id),
					});
				},
				getCache: async <T>(key: string) => {
					return await this.getCache<T>(key);
				},
				setCache: async <T>(key: string, value: T) => {
					await this.setCache(key, value);
				},
				deleteCache: async (key: string) => {
					await this.deleteCache(key);
				},
			});
		} catch (error) {
			throw this.handleError(error, "sign in");
		}
	}

	/**
	 * Registers new user
	 *
	 * Delegates to UserRegistrationService.signUp()
	 *
	 * @param params - User registration data
	 * @param opts - Optional transaction context
	 * @returns Newly created user
	 */
	async signUp(params: SignUp & { role?: UserRole }, opts?: PartialWithTx) {
		try {
			return await this.#registrationService.signUp(
				params,
				{
					checkDuplicateUser: async (email: string, phone: Phone | null) => {
						const clauses: SQL[] = [eq(tables.user.email, email)];
						if (phone) {
							clauses.push(eq(tables.user.phone, phone));
						}
						return await (opts?.tx ?? this.db).query.user.findFirst({
							columns: { email: true, phone: true },
							where: (_f, op) => op.or(...clauses),
						});
					},
				},
				opts,
			);
		} catch (error) {
			throw this.handleError(error, "sign up");
		}
	}

	/**
	 * Registers new driver
	 *
	 * Delegates to UserRegistrationService.signUpDriver()
	 *
	 * @param params - Driver registration data
	 * @param opts - Optional transaction context
	 * @returns Newly created driver user
	 */
	async signUpDriver(params: SignUpDriver, opts?: PartialWithTx) {
		try {
			return await this.#registrationService.signUpDriver(
				params,
				{
					checkDuplicateUser: async (email: string, phone: Phone | null) => {
						const clauses: SQL[] = [eq(tables.user.email, email)];
						if (phone) {
							clauses.push(eq(tables.user.phone, phone));
						}
						return await (opts?.tx ?? this.db).query.user.findFirst({
							columns: { email: true, phone: true },
							where: (_f, op) => op.or(...clauses),
						});
					},
				},
				opts,
			);
		} catch (error) {
			throw this.handleError(error, "sign up driver");
		}
	}

	/**
	 * Registers new merchant
	 *
	 * Delegates to UserRegistrationService.signUpMerchant()
	 *
	 * @param params - Merchant registration data
	 * @param opts - Optional transaction context
	 * @returns Newly created merchant user
	 */
	async signUpMerchant(params: SignUpMerchant, opts?: PartialWithTx) {
		try {
			return await this.#registrationService.signUpMerchant(
				params,
				{
					checkDuplicateUser: async (email: string, phone: Phone | null) => {
						const clauses: SQL[] = [eq(tables.user.email, email)];
						if (phone) {
							clauses.push(eq(tables.user.phone, phone));
						}
						return await (opts?.tx ?? this.db).query.user.findFirst({
							columns: { email: true, phone: true },
							where: (_f, op) => op.or(...clauses),
						});
					},
				},
				opts,
			);
		} catch (error) {
			throw this.handleError(error, "sign up merchant");
		}
	}

	/**
	 * Signs out user by invalidating cached session
	 *
	 * Delegates to SessionService.signOut()
	 *
	 * @param token - JWT token to invalidate
	 * @returns true if successful
	 */
	async signOut(token: string) {
		try {
			return await this.#sessionService.signOut(token, {
				deleteCache: async (key: string) => {
					await this.deleteCache(key);
				},
			});
		} catch (error) {
			throw this.handleError(error, "sign out");
		}
	}

	/**
	 * Retrieves session data from JWT token
	 *
	 * Delegates to SessionService.getSession()
	 *
	 * @param token - JWT token string
	 * @returns Session data with optional new token (if rotated)
	 */
	async getSession(token: string) {
		try {
			return await this.#sessionService.getSession(token, {
				getUserWithAccount: async (email: string) => {
					return await this.db.query.user.findFirst({
						with: {
							accounts: {
								columns: { password: true },
								where: (f, op) => op.eq(f.providerId, "credentials"),
							},
							userBadges: { with: { badge: true } },
						},
						where: (f, op) => op.eq(f.email, email),
					});
				},
				getUserById: async (id: string) => {
					return await this.db.query.user.findFirst({
						with: {
							userBadges: { with: { badge: true } },
						},
						where: (f, op) => op.eq(f.id, id),
					});
				},
				getCache: async <T>(key: string) => {
					return await this.getCache<T>(key);
				},
				setCache: async <T>(key: string, value: T) => {
					await this.setCache(key, value);
				},
				deleteCache: async (key: string) => {
					await this.deleteCache(key);
				},
			});
		} catch (error) {
			throw this.handleError(error, "get session");
		}
	}

	/**
	 * Generates reset token and sends email
	 *
	 * Delegates to PasswordResetService.forgotPassword()
	 *
	 * @param params - Email address
	 * @returns true if successful
	 */
	async forgotPassword(params: ForgotPassword) {
		try {
			return await this.#passwordResetService.forgotPassword(params, {
				findUserByEmail: async (email: string) => {
					return await this.db.query.user.findFirst({
						columns: { id: true, name: true, email: true },
						where: (f, op) => op.eq(f.email, email),
					});
				},
				deleteCache: async (userId: string) => {
					await this.deleteCache(userId);
				},
			});
		} catch (error) {
			throw this.handleError(error, "forgot password");
		}
	}

	/**
	 * Validates token and resets password
	 *
	 * Delegates to PasswordResetService.resetPassword()
	 *
	 * @param params - Token and new password
	 * @returns true if successful
	 */
	async resetPassword(params: ResetPassword) {
		try {
			return await this.#passwordResetService.resetPassword(params, {
				deleteCache: async (userId: string) => {
					await this.deleteCache(userId);
				},
			});
		} catch (error) {
			throw this.handleError(error, "reset password");
		}
	}

	/**
	 * Generates verification token and sends email
	 *
	 * Delegates to EmailVerificationService.sendEmailVerification()
	 *
	 * @param params - Email address
	 * @returns true if successful
	 */
	async sendEmailVerification(
		params: SendEmailVerification,
		opts: PartialWithTx,
	) {
		try {
			return await this.#emailVerificationService.sendEmailVerification(
				params,
				{
					findUserByEmail: async (email: string) => {
						const db = opts?.tx ?? this.db;
						return await db.query.user.findFirst({
							columns: {
								id: true,
								name: true,
								email: true,
								emailVerified: true,
							},
							where: (f, op) => op.eq(f.email, email),
						});
					},
					deleteCache: async (userId: string) => {
						await this.deleteCache(userId);
					},
				},
				opts,
			);
		} catch (error) {
			throw this.handleError(error, "send email verification");
		}
	}

	/**
	 * Validates OTP code and verifies email
	 *
	 * Delegates to EmailVerificationService.verifyEmail()
	 *
	 * @param params - Email and OTP code
	 * @returns true if successful
	 */
	async verifyEmail(params: VerifyEmail, opts: WithTx) {
		try {
			return await this.#emailVerificationService.verifyEmail(
				params,
				{
					deleteCache: async (userId: string) => {
						await this.deleteCache(userId);
					},
				},
				opts,
			);
		} catch (error) {
			throw this.handleError(error, "verify email");
		}
	}
}

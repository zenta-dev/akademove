import type { ClientAgent } from "@repo/schema/common";
import type { User } from "@repo/schema/user";
import { omit } from "@repo/shared";
import { AuthError } from "@/core/error";
import type { KeyValueService } from "@/core/services/kv";
import { S3StorageService, type StorageService } from "@/core/services/storage";
import type { UserDatabase } from "@/core/tables/auth";
import type { DetailedUserBadgeDatabase } from "@/core/tables/badge";
import { UserAdminRepository } from "@/features/user/admin/user-admin-repository";
import type { JwtManager, TokenPayload } from "@/utils/jwt";
import { logger } from "@/utils/logger";
import type { PasswordManager } from "@/utils/password";

/**
 * Sign in request parameters
 */
export interface SignInRequest {
	email: string;
	password: string;
	clientAgent?: ClientAgent;
}

/**
 * Sign in result with token and user data
 */
export interface SignInResult {
	token: string;
	user: User;
}

/**
 * Session data with optional token rotation
 */
export interface SessionData {
	user: User;
	token?: string;
	payload: TokenPayload;
}

/**
 * User with badges from database
 */
export type UserWithBadges = UserDatabase & {
	userBadges: DetailedUserBadgeDatabase[];
};

/**
 * Dependencies for session operations
 */
export interface SessionDeps {
	getUserWithAccount: (email: string) => Promise<unknown | undefined>;
	getUserById: (id: string) => Promise<UserWithBadges | undefined>;
	getCache: <T>(key: string) => Promise<T | undefined>;
	setCache: <T>(key: string, value: T) => Promise<void>;
	deleteCache: (key: string) => Promise<void>;
}

/**
 * Service responsible for session management
 *
 * Handles:
 * - User authentication (sign in)
 * - JWT token generation and verification
 * - Session caching and retrieval
 * - Automatic token rotation
 * - Sign out (cache invalidation)
 *
 * @example
 * ```typescript
 * const sessionService = new SessionService(jwt, password, storage);
 *
 * // Sign in
 * const result = await sessionService.signIn(
 *   { email, password, clientAgent },
 *   { getUserWithAccount, getCache, setCache }
 * );
 *
 * // Get session
 * const session = await sessionService.getSession(token, {
 *   getUserById, getCache, setCache
 * });
 * ```
 */
export class SessionService {
	readonly #jwt: JwtManager;
	readonly #pw: PasswordManager;
	readonly #storage: StorageService;

	readonly #JWT_EXPIRY = "7d";

	constructor(
		jwt: JwtManager,
		pw: PasswordManager,
		storage: StorageService,
		_kv: KeyValueService, // Reserved for future use (e.g., session blacklisting)
	) {
		this.#jwt = jwt;
		this.#pw = pw;
		this.#storage = storage;
	}

	/**
	 * Authenticates user and generates session token
	 *
	 * Process:
	 * 1. Fetch user by email with credentials account
	 * 2. Verify password using scrypt comparison
	 * 3. Compose user entity with presigned URLs
	 * 4. Generate JWT token with 7-day expiry
	 * 5. Cache user data for fast session retrieval
	 *
	 * @param request - Sign in credentials
	 * @param deps - Repository functions for user lookup and caching
	 * @returns Token and user data
	 * @throws AuthError if email not found or password invalid
	 */
	async signIn(
		request: SignInRequest,
		deps: SessionDeps,
	): Promise<SignInResult> {
		try {
			const user = await deps.getUserWithAccount(request.email);

			if (
				!user ||
				typeof user !== "object" ||
				!("accounts" in user) ||
				!Array.isArray(user.accounts) ||
				!user.accounts[0]
			) {
				throw new AuthError("Email not registered", { code: "NOT_FOUND" });
			}

			const account = user.accounts[0] as { password: string | null };
			const isValidPassword = this.#pw.verify(
				account.password ?? "",
				request.password,
			);

			if (!isValidPassword) {
				throw new AuthError("Invalid credentials", { code: "UNAUTHORIZED" });
			}

			const userWithoutAccounts = omit(
				user as UserWithBadges & { accounts: unknown[] },
				["accounts"],
			) as UserWithBadges;
			const composedUser = await UserAdminRepository.composeEntity(
				userWithoutAccounts,
				this.#storage,
				{ expiresIn: S3StorageService.SEVEN_DAY_PRESIGNED_URL_EXPIRY },
			);

			const [token] = await Promise.all([
				this.#jwt.sign({
					id: composedUser.id,
					role: composedUser.role,
					expiration: this.#JWT_EXPIRY,
					clientAgent: request.clientAgent,
				}),
				deps.setCache(composedUser.id, composedUser),
			]);

			logger.info(
				{ userId: composedUser.id, email: composedUser.email },
				"[SessionService] User signed in successfully",
			);

			return {
				token,
				user: composedUser,
			};
		} catch (error) {
			logger.error(
				{ error, email: request.email },
				"[SessionService] Sign in failed",
			);
			throw error;
		}
	}

	/**
	 * Retrieves session data from JWT token
	 *
	 * Process:
	 * 1. Verify JWT signature and expiration
	 * 2. Check cache for user data (fast path)
	 * 3. If cache miss, fetch from database and cache
	 * 4. Check if token rotation needed (12 hours before expiry)
	 * 5. Generate new token if rotation threshold reached
	 *
	 * @param token - JWT token string
	 * @param deps - Repository functions for user lookup and caching
	 * @returns Session data with optional new token
	 * @throws AuthError if token invalid or user not found
	 */
	async getSession(token: string, deps: SessionDeps): Promise<SessionData> {
		try {
			const payload = await this.#jwt.verify(token);

			// Try cache first
			let user = await deps.getCache<User>(payload.id);

			// Cache miss - fetch from database
			if (!user) {
				const res = await deps.getUserById(payload.id);
				if (!res) {
					throw new AuthError("User not found", { code: "UNAUTHORIZED" });
				}
				user = await UserAdminRepository.composeEntity(res, this.#storage, {
					expiresIn: S3StorageService.SEVEN_DAY_PRESIGNED_URL_EXPIRY,
				});
				await deps.setCache(user.id, user);
			}

			// Rotate token if expiring soon (12 hours threshold)
			let newToken: string | undefined;
			if (payload.shouldRotate) {
				newToken = await this.#jwt.sign({
					id: user.id,
					role: user.role,
					expiration: this.#JWT_EXPIRY,
				});
				logger.debug(
					{ userId: user.id },
					"[SessionService] Token rotated due to approaching expiry",
				);
			}

			return {
				user,
				token: newToken,
				payload,
			};
		} catch (error) {
			logger.error({ error }, "[SessionService] Get session failed");
			throw error;
		}
	}

	/**
	 * Signs out user by invalidating cached session
	 *
	 * @param token - JWT token to invalidate
	 * @param deps - Cache deletion function
	 * @returns true if successful
	 * @throws AuthError if token invalid
	 */
	async signOut(
		token: string,
		deps: Pick<SessionDeps, "deleteCache">,
	): Promise<boolean> {
		try {
			const payload = await this.#jwt.verify(token);
			await deps.deleteCache(payload.id);

			logger.info({ userId: payload.id }, "[SessionService] User signed out");
			return true;
		} catch (error) {
			logger.error({ error }, "[SessionService] Sign out failed");
			throw error;
		}
	}
}

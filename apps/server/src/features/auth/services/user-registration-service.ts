import { randomBytes } from "node:crypto";
import type { Phone } from "@repo/schema";
import type { SignUp, SignUpDriver, SignUpMerchant } from "@repo/schema/auth";
import type { User, UserRole } from "@repo/schema/user";
import { getFileExtension } from "@repo/shared";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { StorageService } from "@/core/services/storage";
import { UserAdminRepository } from "@/features/user/admin/user-admin-repository";
import { logger } from "@/utils/logger";
import type { PasswordManager } from "@/utils/password";

/**
 * Sign up result
 */
export interface SignUpResult {
	user: User;
}

/**
 * Dependencies for user registration
 */
export interface UserRegistrationDeps {
	checkDuplicateUser: (
		email: string,
		phone: Phone | null,
	) => Promise<
		| {
				email: string;
				phone: Phone | null;
		  }
		| undefined
	>;
}

const BUCKET = "user";

/**
 * Service responsible for user registration
 *
 * Handles:
 * - Duplicate email/phone validation
 * - Password hashing
 * - User creation (USER, DRIVER, MERCHANT roles)
 * - Profile photo upload
 * - Wallet initialization
 * - Account creation (credentials provider)
 *
 * @example
 * ```typescript
 * const registrationService = new UserRegistrationService(db, pw, storage);
 *
 * // Sign up user
 * const { user } = await registrationService.signUp(
 *   { email, password, name, phone, photo },
 *   { checkDuplicateUser },
 *   { tx }
 * );
 *
 * // Sign up driver
 * const { user } = await registrationService.signUpDriver(params, deps, opts);
 * ```
 */
export class UserRegistrationService {
	readonly #db: DatabaseService;
	readonly #pw: PasswordManager;
	readonly #storage: StorageService;

	constructor(
		db: DatabaseService,
		pw: PasswordManager,
		storage: StorageService,
	) {
		this.#db = db;
		this.#pw = pw;
		this.#storage = storage;
	}

	#generateId(): string {
		return randomBytes(16).toString("hex");
	}

	/**
	 * Registers new user with given role
	 *
	 * Process:
	 * 1. Check for duplicate email/phone
	 * 2. Hash password with scrypt
	 * 3. Generate user ID and photo key
	 * 4. Insert user into database
	 * 5. Create credentials account
	 * 6. Initialize wallet with zero balance
	 * 7. Upload profile photo to S3 (if provided)
	 * 8. Return composed user entity
	 *
	 * @param params - Sign up data
	 * @param deps - Duplicate check function
	 * @param opts - Transaction context (optional)
	 * @returns Newly created user
	 * @throws RepositoryError if email/phone already registered
	 */
	async signUp(
		params: SignUp & { role?: UserRole },
		deps: UserRegistrationDeps,
		opts?: PartialWithTx,
	): Promise<SignUpResult> {
		try {
			const existingUser = await deps.checkDuplicateUser(
				params.email,
				params.phone,
			);

			if (existingUser) {
				if (existingUser.email === params.email) {
					throw new RepositoryError("Email already registered", {
						code: "CONFLICT",
					});
				}
				if (existingUser.phone?.number === params.phone?.number) {
					throw new RepositoryError("Phone already registered", {
						code: "CONFLICT",
					});
				}
			}

			const hashedPassword = this.#pw.hash(params.password);
			const userId = this.#generateId();

			let photoKey: string | undefined;
			if (params.photo) {
				const extension = getFileExtension(params.photo);
				photoKey = `PP-${userId}.${extension}`;
			}

			const [user] = await (opts?.tx ?? this.#db)
				.insert(tables.user)
				.values({
					...params,
					id: userId,
					role: params.role ?? "USER",
					image: photoKey,
				})
				.returning();

			// Perform DB inserts first (within potential transaction)
			await Promise.all([
				(opts?.tx ?? this.#db).insert(tables.account).values({
					id: this.#generateId(),
					accountId: this.#generateId(),
					userId: user.id,
					providerId: "credentials",
					password: hashedPassword,
				}),
				(opts?.tx ?? this.#db).insert(tables.wallet).values({
					id: v7(),
					userId: user.id,
					balance: "0",
				}),
			]);

			// Upload photo to S3 AFTER DB inserts succeed
			// If S3 upload fails, we log error but don't rollback DB (user can re-upload)
			if (photoKey && params.photo) {
				try {
					await this.#storage.upload({
						bucket: BUCKET,
						key: photoKey,
						file: params.photo,
					});
				} catch (uploadError) {
					logger.error(
						{ uploadError, userId: user.id, photoKey },
						"[UserRegistrationService] Failed to upload profile photo, user will need to re-upload",
					);
					// Clear the image reference since upload failed
					await (opts?.tx ?? this.#db)
						.update(tables.user)
						.set({ image: null })
						.where(eq(tables.user.id, user.id));
				}
			}

			logger.info(
				{ userId: user.id, email: user.email, role: user.role },
				"[UserRegistrationService] User registered successfully",
			);

			return {
				user: await UserAdminRepository.composeEntity(
					{ ...user, userBadges: [] },
					this.#storage,
				),
			};
		} catch (error) {
			logger.error(
				{ error, email: params.email },
				"[UserRegistrationService] Sign up failed",
			);
			throw error;
		}
	}

	/**
	 * Registers new driver (convenience method)
	 *
	 * @param params - Driver sign up data
	 * @param deps - Duplicate check function
	 * @param opts - Transaction context (optional)
	 * @returns Newly created driver user
	 */
	async signUpDriver(
		params: SignUpDriver,
		deps: UserRegistrationDeps,
		opts?: PartialWithTx,
	): Promise<SignUpResult> {
		return await this.signUp({ ...params, role: "DRIVER" }, deps, opts);
	}

	/**
	 * Registers new merchant (convenience method)
	 *
	 * @param params - Merchant sign up data
	 * @param deps - Duplicate check function
	 * @param opts - Transaction context (optional)
	 * @returns Newly created merchant user
	 */
	async signUpMerchant(
		params: SignUpMerchant,
		deps: UserRegistrationDeps,
		opts?: PartialWithTx,
	): Promise<SignUpResult> {
		return await this.signUp({ ...params, role: "MERCHANT" }, deps, opts);
	}
}

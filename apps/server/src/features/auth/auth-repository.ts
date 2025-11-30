import { randomBytes } from "node:crypto";
import { m } from "@repo/i18n";
import type {
	ForgotPassword,
	ResetPassword,
	SignIn,
	SignUp,
	SignUpDriver,
	SignUpMerchant,
} from "@repo/schema/auth";
import type { ClientAgent } from "@repo/schema/common";
import type { UserRole } from "@repo/schema/user";
import { getFileExtension, omit } from "@repo/shared";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { AuthError, RepositoryError } from "@/core/error";
import {
	type DatabaseService,
	type DatabaseTransaction,
	tables,
} from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { S3StorageService, type StorageService } from "@/core/services/storage";
import type { JwtManager } from "@/utils/jwt";
import type { PasswordManager } from "@/utils/password";
import { UserAdminRepository } from "../user/admin/user-admin-repository";

const BUCKET = "user";

export class AuthRepository extends BaseRepository {
	readonly #storage: StorageService;
	readonly #jwt: JwtManager;
	readonly #pw: PasswordManager;

	readonly #JWT_EXPIRY = "7d";

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
		jwt: JwtManager,
		pw: PasswordManager,
	) {
		super("user", kv, db);
		this.#storage = storage;
		this.#jwt = jwt;
		this.#pw = pw;
	}

	#generateId(): string {
		return randomBytes(32).toString("hex");
	}

	async signIn(params: SignIn & { clientAgent?: ClientAgent }) {
		try {
			const user = await this.db.query.user.findFirst({
				with: {
					accounts: {
						columns: { password: true },
						where: (f, op) => op.eq(f.providerId, "credentials"),
					},
					userBadges: { with: { badge: true } },
				},
				where: (f, op) => op.eq(f.email, params.email),
			});

			if (!user?.accounts[0]) {
				throw new AuthError(m.email_not_registered(), { code: "NOT_FOUND" });
			}

			const isValidPassword = this.#pw.verify(
				user.accounts[0].password ?? "",
				params.password,
			);

			if (!isValidPassword) {
				throw new AuthError(m.invalid_credentials(), { code: "UNAUTHORIZED" });
			}

			const composedUser = await UserAdminRepository.composeEntity(
				omit(user, ["accounts"]),
				this.#storage,
				{ expiresIn: S3StorageService.SEVEN_DAY_PRESIGNED_URL_EXPIRY },
			);

			const [token, _] = await Promise.all([
				this.#jwt.sign({
					id: composedUser.id,
					role: composedUser.role,
					expiration: this.#JWT_EXPIRY,
					clientAgent: params.clientAgent,
				}),
				this.setCache(composedUser.id, composedUser),
			]);
			return {
				token,
				user: composedUser,
			};
		} catch (error) {
			throw this.handleError(error, "sign in");
		}
	}

	async signUp(
		params: SignUp & { role?: UserRole },
		opts?: { tx?: DatabaseTransaction },
	) {
		try {
			const existingUser = await (opts?.tx ?? this.db).query.user.findFirst({
				columns: { email: true, phone: true },
				where: (f, op) =>
					op.or(op.eq(f.email, params.email), op.eq(f.phone, params.phone)),
			});

			if (existingUser) {
				if (
					existingUser.email === params.email ||
					existingUser.phone === params.phone
				) {
					throw new RepositoryError("Email or phone Plate already registered", {
						code: "CONFLICT",
					});
				}
				if (existingUser.email === params.email) {
					throw new RepositoryError("Email already registered", {
						code: "CONFLICT",
					});
				}
				if (existingUser.phone === params.phone) {
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

			const [user] = await (opts?.tx ?? this.db)
				.insert(tables.user)
				.values({
					...params,
					id: userId,
					role: params.role ?? "USER",
					image: photoKey,
				})
				.returning();

			const promises: Promise<unknown>[] = [
				(opts?.tx ?? this.db).insert(tables.account).values({
					id: this.#generateId(),
					accountId: this.#generateId(),
					userId: user.id,
					providerId: "credentials",
					password: hashedPassword,
				}),
				(opts?.tx ?? this.db).insert(tables.wallet).values({
					id: v7(),
					userId: user.id,
					balance: "0",
				}),
			];

			if (photoKey && params.photo) {
				promises.push(
					this.#storage.upload({
						bucket: BUCKET,
						key: photoKey,
						file: params.photo,
					}),
				);
			}

			await Promise.all(promises);

			return {
				user: await UserAdminRepository.composeEntity(
					{ ...user, userBadges: [] },
					this.#storage,
				),
			};
		} catch (error) {
			throw this.handleError(error, "sign up");
		}
	}

	async signUpDriver(
		params: SignUpDriver,
		opts?: { tx?: DatabaseTransaction },
	) {
		try {
			const { user } = await this.signUp({ ...params, role: "DRIVER" }, opts);
			return { user };
		} catch (error) {
			throw this.handleError(error, "sign up driver");
		}
	}

	async signUpMerchant(
		params: SignUpMerchant,
		opts?: { tx?: DatabaseTransaction },
	) {
		try {
			const { user } = await this.signUp({ ...params, role: "MERCHANT" }, opts);
			return { user };
		} catch (error) {
			throw this.handleError(error, "sign up merchant");
		}
	}

	async signOut(token: string) {
		try {
			const payload = await this.#jwt.verify(token);
			await this.deleteCache(payload.id);
			return true;
		} catch (error) {
			throw this.handleError(error, "sign out");
		}
	}

	async getSession(token: string) {
		try {
			const payload = await this.#jwt.verify(token);

			const fallback = async () => {
				const res = await this.db.query.user.findFirst({
					with: {
						userBadges: { with: { badge: true } },
					},
					where: (f, op) => op.eq(f.id, payload.id),
				});
				if (!res) {
					throw new AuthError("User not found", { code: "UNAUTHORIZED" });
				}
				const user = await UserAdminRepository.composeEntity(
					res,
					this.#storage,
					{
						expiresIn: S3StorageService.SEVEN_DAY_PRESIGNED_URL_EXPIRY,
					},
				);
				await this.setCache(user.id, user);
				return user;
			};

			const user = await this.getCache(payload.id, { fallback });

			let newToken: string | undefined;
			if (payload.shouldRotate) {
				newToken = await this.#jwt.sign({
					id: user.id,
					role: user.role,
					expiration: this.#JWT_EXPIRY,
				});
			}

			return {
				user,
				token: newToken,
				payload,
			};
		} catch (error) {
			throw this.handleError(error, "get session");
		}
	}

	async forgotPassword(_params: ForgotPassword) {
		// TODO: Implement this
		throw new RepositoryError("UNIMPLEMENTED");
	}

	async resetPassword(_params: ResetPassword) {
		// TODO: Implement this
		throw new RepositoryError("UNIMPLEMENTED");
	}
}

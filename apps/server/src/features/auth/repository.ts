import { randomBytes } from "node:crypto";
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
import { FEATURE_TAGS } from "@/core/constants";
import { AuthError, BaseError, RepositoryError } from "@/core/error";
import {
	type DatabaseService,
	type DatabaseTransaction,
	tables,
} from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { UserDatabase } from "@/core/tables/auth";
import { log } from "@/utils";
import type { JwtManager } from "@/utils/jwt";
import { PasswordManager } from "@/utils/password";

export class AuthRepository {
	readonly #db: DatabaseService;
	readonly #kv: KeyValueService;
	readonly #storage: StorageService;
	readonly #jwt: JwtManager;
	readonly #pw: PasswordManager;

	readonly #JWT_EXPIRY = "7d";

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
		jwt: JwtManager,
	) {
		this.#db = db;
		this.#kv = kv;
		this.#storage = storage;
		this.#jwt = jwt;
		this.#pw = new PasswordManager();
	}

	private async composeUser(
		user: UserDatabase,
		options?: { expiresIn?: number },
	) {
		if (user.image) {
			user.image = await this.#storage.getPresignedUrl({
				bucket: "user",
				key: user.image,
				expiresIn: options?.expiresIn,
			});
		}
		return user;
	}

	private composeKey(id: string) {
		return `${FEATURE_TAGS.AUTH}:${FEATURE_TAGS.USER}:${id}`;
	}

	private generateId(): string {
		return randomBytes(32).toString("hex");
	}

	async signIn(params: SignIn & { clientAgent?: ClientAgent }) {
		log.debug(params, `${this.signIn.name} body`);

		try {
			const user = await this.#db.query.user.findFirst({
				with: {
					accounts: {
						columns: { password: true },
						where: (f, op) => op.eq(f.providerId, "credentials"),
					},
				},
				where: (f, op) => op.eq(f.email, params.email),
			});

			if (!user?.accounts[0]) {
				throw new AuthError("Invalid credentials", { code: "UNAUTHORIZED" });
			}

			const isValidPassword = this.#pw.verify(
				user.accounts[0].password ?? "",
				params.password,
			);

			if (!isValidPassword) {
				throw new AuthError("Invalid credentials", { code: "UNAUTHORIZED" });
			}

			const omittedUser = omit(user, ["accounts"]);
			const [token, _] = await Promise.all([
				this.#jwt.sign({
					id: omittedUser.id,
					role: omittedUser.role,
					expiration: this.#JWT_EXPIRY,
					clientAgent: params.clientAgent,
				}),
				this.#kv.put(this.composeKey(user.id), omittedUser),
			]);
			log.debug(omittedUser, `${this.signIn.name} success`);
			return {
				token,
				user: await this.composeUser(omittedUser, { expiresIn: 604800 }),
			};
		} catch (error) {
			log.error(error, `${this.signIn.name} failed`);
			if (error instanceof BaseError) throw error;
			throw new AuthError("An error occured", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async signUp(
		params: SignUp & { role?: UserRole },
		opts?: { tx?: DatabaseTransaction },
	) {
		log.debug(params, `${this.signUp.name} body`);

		try {
			const existingUser = await (opts?.tx ?? this.#db).query.user.findFirst({
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
			const userId = this.generateId();

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
					role: params.role ?? "user",
					image: photoKey,
				})
				.returning();

			const promises: Promise<unknown>[] = [
				(opts?.tx ?? this.#db).insert(tables.account).values({
					id: this.generateId(),
					accountId: this.generateId(),
					userId: user.id,
					providerId: "credentials",
					password: hashedPassword,
				}),
				(opts?.tx ?? this.#db).insert(tables.wallet).values({
					id: v7(),
					userId: user.id,
					balance: "0",
				}),
			];

			if (photoKey && params.photo) {
				promises.push(
					this.#storage.upload({
						bucket: "user",
						key: photoKey,
						file: params.photo,
					}),
				);
			}

			await Promise.all(promises);

			return { user: await this.composeUser(user) };
		} catch (error) {
			log.error(error, `${this.signUp.name} failed`);
			if (error instanceof BaseError) throw error;
			throw new AuthError("An error occured", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async signUpDriver(
		params: SignUpDriver,
		opts?: { tx?: DatabaseTransaction },
	) {
		try {
			const { user } = await this.signUp({ ...params, role: "driver" }, opts);
			return { user };
		} catch (error) {
			log.error(error, `${this.signUpDriver.name} failed`);
			if (error instanceof BaseError) throw error;
			throw new AuthError("An error occured", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async signUpMerchant(
		params: SignUpMerchant,
		opts?: { tx?: DatabaseTransaction },
	) {
		try {
			const { user } = await this.signUp({ ...params, role: "merchant" }, opts);
			return { user };
		} catch (error) {
			log.error(error, `${this.signUpMerchant.name} failed`);
			if (error instanceof BaseError) throw error;
			throw new AuthError("An error occured", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async signOut(token: string) {
		log.debug(`${this.signOut.name} | JWT => ${token.substring(0, 20)}...`);

		try {
			const payload = await this.#jwt.verify(token);
			await this.#kv.delete(this.composeKey(payload.id));
			log.debug(`${this.signOut.name} success`);
			return true;
		} catch (error) {
			log.error(error, `${this.signOut.name} failed`);
			if (error instanceof BaseError) throw error;
			throw new AuthError("Invalid or expired token", {
				code: "UNAUTHORIZED",
			});
		}
	}

	async getSession(token: string) {
		log.debug(
			{ jwt: `${token.substring(0, 20)}...` },
			`${this.getSession.name} | JWT => `,
		);

		try {
			const payload = await this.#jwt.verify(token);
			const user = await this.#kv.get(this.composeKey(payload.id), {
				fallback: async () =>
					await this.#db.query.user.findFirst({
						where: (f, op) => op.eq(f.id, payload.id),
					}),
			});

			if (!user) {
				throw new AuthError("User not found", { code: "UNAUTHORIZED" });
			}

			let newToken: string | undefined;
			if (payload.shouldRotate) {
				newToken = await this.#jwt.sign({
					id: user.id,
					role: user.role,
					expiration: this.#JWT_EXPIRY,
				});
			}

			return {
				user: await this.composeUser(user),
				token: newToken,
				payload,
			};
		} catch (error) {
			log.error(error, `${this.getSession.name} failed`);
			if (error instanceof BaseError) throw error;
			throw new AuthError("Invalid or expired token", {
				code: "UNAUTHORIZED",
			});
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

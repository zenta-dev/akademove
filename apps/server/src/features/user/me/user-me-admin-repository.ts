import type { UpdateUser, UpdateUserPassword, User } from "@repo/schema/user";
import { and, eq } from "drizzle-orm";
import { BaseRepository } from "@/core/base";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { PasswordManager } from "@/utils/password";
import { UserAdminRepository } from "../admin/user-admin-repository";

export class UserMeRepository extends BaseRepository {
	readonly #storage: StorageService;
	readonly #pw: PasswordManager;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
		pw: PasswordManager,
	) {
		super("user", kv, db);
		this.#storage = storage;
		this.#pw = pw;
	}

	async #getFromDB(
		id: string,
		opts?: PartialWithTx,
	): Promise<User | undefined> {
		const tx = opts?.tx ?? this.db;

		const result = await tx.query.user.findFirst({
			with: {
				userBadgePivots: {
					columns: {},
					with: { badge: true },
				},
			},
			where: (f, op) => op.eq(f.id, id),
		});
		return result
			? UserAdminRepository.composeEntity(result, this.#storage)
			: undefined;
	}

	async get(id: string, opts?: PartialWithTx): Promise<User> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);
				if (!res) throw new RepositoryError("Failed to get driver from DB");
				await this.setCache(id, res);
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async update(
		id: string,
		item: UpdateUser,
		opts?: PartialWithTx,
	): Promise<User> {
		try {
			const existing = await this.get(id, opts);

			if (!existing) {
				throw new RepositoryError(`User with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const tx = opts?.tx ?? this.db;

			await tx.update(tables.user).set(item).where(eq(tables.user.id, id));

			const fresh = await this.#getFromDB(id, opts);
			if (!fresh) {
				throw new RepositoryError(`User with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}
			await this.setCache(id, fresh);

			return fresh;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async changePassword(
		id: string,
		item: UpdateUserPassword,
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			if (item.password !== item.confirmPassword) {
				throw new RepositoryError("Password didnt same", {
					code: "BAD_REQUEST",
				});
			}
			const tx = opts?.tx ?? this.db;

			const [existing, account] = await Promise.all([
				this.get(id, opts),
				tx.query.account.findFirst({
					where: (f, op) => op.eq(f.userId, id),
				}),
			]);

			if (!existing) {
				throw new RepositoryError(`User with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}
			if (!account) {
				throw new RepositoryError(`Account with user id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const hashedPassword = this.#pw.hash(item.password);

			const res = await tx
				.update(tables.account)
				.set({ password: hashedPassword })
				.where(
					and(
						eq(tables.account.userId, id),
						eq(tables.account.providerId, "credentials"),
					),
				);

			const ok = res.length > 0;

			if (!ok) {
				throw new RepositoryError("Failed to update password", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			return ok;
		} catch (error) {
			throw this.handleError(error, "change password");
		}
	}
}

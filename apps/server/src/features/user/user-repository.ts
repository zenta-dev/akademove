import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { InsertUser, UpdateUser, User } from "@repo/schema/user";
import { eq, gt, ne, type SQL } from "drizzle-orm";
import { BaseRepository } from "@/core/base";
import { FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { UserDatabase } from "@/core/tables/auth";
import { log } from "@/utils";

const BUCKET = "user";

export class UserRepository extends BaseRepository {
	#db: DatabaseService;
	#storage: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super(FEATURE_TAGS.USER, kv);
		this.#db = db;
		this.#storage = storage;
	}

	static async composeEntity(
		user: UserDatabase,
		storage: StorageService,
		options?: { expiresIn?: number },
	): Promise<User> {
		let image: string | undefined;
		if (user.image) {
			image = await storage.getPresignedUrl({
				bucket: BUCKET,
				key: user.image,
				expiresIn: options?.expiresIn,
			});
		}
		return {
			...user,
			image,
			banReason: user.banReason ?? undefined,
			banExpires: user.banExpires ?? undefined,
			gender: user.gender ?? undefined,
		};
	}

	async #getFromDB(id: string): Promise<User | undefined> {
		const result = await this.#db.query.user.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result
			? UserRepository.composeEntity(result, this.#storage)
			: undefined;
	}

	async list(
		query?: UnifiedPaginationQuery & { requesterId: string },
	): Promise<User[]> {
		try {
			let stmt = this.#db.query.user.findMany();

			if (query) {
				const { cursor, page, limit = 10 } = query;
				const clauses: SQL[] = [];
				if (cursor) {
					clauses.push(gt(tables.user.createdAt, new Date(cursor)));
				}
				if (query.requesterId) {
					clauses.push(ne(tables.user.id, query.requesterId));
				}

				if (cursor) {
					stmt = this.#db.query.user.findMany({
						where: (_f, op) => op.and(...clauses),
						limit: limit + 1,
					});
				}

				if (page) {
					const offset = (page - 1) * limit;
					stmt = this.#db.query.user.findMany({ offset, limit });
				}
			}

			const result = await stmt;
			const promises = result.map((r) =>
				UserRepository.composeEntity(r, this.#storage),
			);

			return Promise.all(promises);
		} catch (error) {
			log.error(error);
			throw new RepositoryError("Failed to list users");
		}
	}

	async get(id: string): Promise<User> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
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

	async create(_item: InsertUser): Promise<User & { password: string }> {
		throw new Error("UNIMPLEMETED");
		// try {
		// 	const { user } = await this.#auth.api.createUser({ body: item });

		// 	const result = UserRepository.composeEntity({,this.#storage
		// 		...user,
		// 		role: (user.role ?? "user") as UserRole,
		// 		image: user.image ?? null,
		// 		banned: user.banned ?? false,
		// 		banReason: user.banReason ?? null,
		// 		banExpires: user.banExpires ?? null,
		// 	});

		// 	return { ...result, password: item.password };
		// } catch (error) {
		// 	if (error instanceof BaseError)
		// 		throw new RepositoryError(error.message, { code: error.code });
		// 	throw new RepositoryError("Failed to create user");
		// }
	}

	async update(
		_id: string,
		_item: UpdateUser,
		_opts: PartialWithTx,
		_header: Headers,
	): Promise<User> {
		throw new Error("UNIMPLEMETED");
		// try {
		// 	const existing = await this.#getFromDB(id);
		// 	if (!existing)
		// 		throw new RepositoryError(`User with id "${id}" not found`);

		// 	let result = existing;

		// 	// Handle role updates
		// 	if ("role" in item) {
		// 		const { user } = await this.#auth.api.setRole({
		// 			body: { userId: id, role: item.role },
		// 			headers,
		// 		});
		// 		result = UserRepository.composeEntity({,this.#storage
		// 			...user,
		// 			role: (user.role ?? "user") as UserRole,
		// 			image: user.image ?? null,
		// 			banned: user.banned ?? false,
		// 			banReason: user.banReason ?? null,
		// 			banExpires: user.banExpires ?? null,
		// 		});
		// 	}

		// 	if ("password" in item) {
		// 		const { status } = await this.#auth.api.setUserPassword({
		// 			body: { userId: id, newPassword: item.password },
		// 			headers,
		// 		});
		// 		if (!status)
		// 			throw new RepositoryError("Failed to update user password");
		// 	}

		// 	if ("banReason" in item) {
		// 		await this.#auth.api.banUser({
		// 			body: { userId: id, ...item },
		// 			headers,
		// 		});
		// 		result.banned = true;
		// 		result.banReason = item.banReason;
		// 		if (item.banExpiresIn)
		// 			result.banExpires = new Date(Date.now() + item.banExpiresIn);
		// 	} else if (item.unban === true) {
		// 		await this.#auth.api.unbanUser({ body: { userId: id }, headers });
		// 		result.banned = false;
		// 		result.banReason = undefined;
		// 		result.banExpires = undefined;
		// 	}

		// 	await this.#auth.api.revokeUserSessions({
		// 		body: { userId: id },
		// 		headers,
		// 	});
		// 	return result;
		// } catch (error) {
		// 	log.error(error);
		// 	throw new RepositoryError(`Failed to update user with id "${id}"`);
		// }
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.#db
				.delete(tables.user)
				.where(eq(tables.user.id, id))
				.returning({ id: tables.user.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			log.error(error);
			throw new RepositoryError(`Failed to delete user with id "${id}"`);
		}
	}
}

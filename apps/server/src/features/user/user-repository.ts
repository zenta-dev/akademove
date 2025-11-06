import type { InsertUser, UpdateUser, User } from "@repo/schema/user";
import { eq } from "drizzle-orm";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { UserDatabase } from "@/core/tables/auth";
import { log } from "@/utils";

export class UserRepository {
	#db: DatabaseService;

	constructor(db: DatabaseService) {
		this.#db = db;
	}

	#composeEntity(_item: UserDatabase): User {
		throw new Error("UNIMPLEMETED");
		// return {
		// 	...item,
		// 	image: item.image ?? undefined,
		// 	banReason: item.banReason ?? undefined,
		// 	banExpires: item.banExpires ?? undefined,
		// };
	}

	async #getFromDB(id: string): Promise<User | undefined> {
		const result = await this.#db.query.user.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? this.#composeEntity(result) : undefined;
	}

	async list(requesterId: string, opts?: GetAllOptions): Promise<User[]> {
		try {
			let stmt = this.#db.query.user.findMany();

			if (opts) {
				const { cursor, page, limit = 10 } = opts;

				if (cursor) {
					stmt = this.#db.query.user.findMany({
						where: (f, op) =>
							op.and(
								op.gt(f.createdAt, new Date(cursor)),
								op.ne(f.id, requesterId),
							),
						limit: limit + 1,
					});
				}

				if (page) {
					const offset = (page - 1) * limit;
					stmt = this.#db.query.user.findMany({ offset, limit });
				}
			}

			const result = await stmt;
			return result.map((r) => this.#composeEntity(r));
		} catch (error) {
			log.error(error);
			throw new RepositoryError("Failed to list users");
		}
	}

	async get(id: string): Promise<User> {
		try {
			const result = await this.#getFromDB(id);
			if (!result) throw new RepositoryError(`User with id "${id}" not found`);
			return result;
		} catch (error) {
			log.error(error);
			throw new RepositoryError(`Failed to get user by id "${id}"`);
		}
	}

	async create(_item: InsertUser): Promise<User & { password: string }> {
		throw new Error("UNIMPLEMETED");
		// try {
		// 	const { user } = await this.#auth.api.createUser({ body: item });

		// 	const result = this.#composeEntity({
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
		_headers: Headers,
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
		// 		result = this.#composeEntity({
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
			await this.#db
				.delete(tables.user)
				.where(eq(tables.user.id, id))
				.returning({ id: tables.user.id });
		} catch (error) {
			log.error(error);
			throw new RepositoryError(`Failed to delete user with id "${id}"`);
		}
	}
}

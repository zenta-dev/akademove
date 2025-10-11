import type { InsertUser, UpdateUser, User, UserRole } from "@repo/schema/user";
import { eq } from "drizzle-orm";
import { BaseError, RepositoryError } from "@/core/error";
import type { GetAllOptions } from "@/core/interface";
import { log } from "@/core/logger";
import { type DatabaseService, tables } from "@/core/services/db";
import type { UserDatabase } from "@/core/tables/auth";

export const createUserRepository = (
	db: DatabaseService,
	// auth: AuthService,
) => {
	function _composeEntity(item: UserDatabase): User {
		return {
			...item,
			image: item.image ?? undefined,
			banReason: item.banReason ?? undefined,
			banExpires: item.banExpires ?? undefined,
		};
	}
	async function _getFromDB(id: string): Promise<User | undefined> {
		const result = await db.query.user.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function list(userId: string, opts?: GetAllOptions): Promise<User[]> {
		try {
			let stmt = db.query.user.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.user.findMany({
						where: (f, op) =>
							op.and(op.gt(f.createdAt, new Date(cursor)), op.ne(f.id, userId)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.user.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError("Failed to listing users");
		}
	}

	async function get(id: string) {
		try {
			const result = await _getFromDB(id);

			if (!result) throw new RepositoryError("Failed get user from db");

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to get user by id "${id}"`);
		}
	}

	async function create(
		item: InsertUser,
	): Promise<User & { password: string }> {
		try {
			const { user } = await auth.api.createUser({
				body: item,
			});

			const result = _composeEntity({
				...user,
				role: (user.role ?? "user") as UserRole,
				image: user.image ?? null,
				banned: user.banned ?? false,
				banReason: user.banReason ?? null,
				banExpires: user.banExpires ?? null,
			});

			return { ...result, password: item.password };
		} catch (error) {
			if (error instanceof BaseError) {
				throw new RepositoryError(error.message, {
					code: error.code,
				});
			}
			throw new RepositoryError(
				error instanceof Error ? error.message : "Failed to create user",
			);
		}
	}

	async function update(
		id: string,
		item: UpdateUser,
		headers: Headers,
	): Promise<User> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`User with id "${id}" not found`);
			}

			let result: User = existing;

			if ("role" in item) {
				const { user } = await auth.api.setRole({
					body: { userId: id, role: item.role },
					headers,
				});
				result = _composeEntity({
					...user,
					role: (user.role ?? "user") as UserRole,
					image: user.image ?? null,
					banned: user.banned ?? false,
					banReason: user.banReason ?? null,
					banExpires: user.banExpires ?? null,
				});
			}
			if ("password" in item) {
				const { status } = await auth.api.setUserPassword({
					body: { userId: id, newPassword: item.password },
					headers,
				});
				if (!status) {
					throw new RepositoryError("Failed to update user password");
				}
			}
			if ("banReason" in item) {
				await auth.api.banUser({
					body: { userId: id, ...item },
					headers,
				});
				result.banned = true;
				result.banReason = item.banReason;
				if (item.banExpiresIn) {
					result.banExpires = Date.now() + item.banExpiresIn;
				}
			}
			if ("id" in item) {
				await auth.api.banUser({
					body: { userId: item.id },
					headers,
				});
				result.banned = false;
				result.banReason = undefined;
				result.banExpires = undefined;
			}

			await auth.api.revokeUserSessions({ body: { userId: id }, headers });

			if (!result) throw new RepositoryError("Failed to update user");
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update user with id "${id}"`);
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			await db
				.delete(tables.user)
				.where(eq(tables.user.id, id))
				.returning({ id: tables.user.id });
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to delete user with id "${id}"`);
		}
	}

	return { list, get, create, update, remove };
};

export type UserRepository = ReturnType<typeof createUserRepository>;

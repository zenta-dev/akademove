import type { InsertUser, UpdateUser, User, UserRole } from "@repo/schema/user";
import { APIError } from "better-auth";
import { eq } from "drizzle-orm";
import { RepositoryError } from "@/core/error";
import type { BaseRepository, GetAllOptions } from "@/core/interface";
import type { AuthInstance } from "@/core/services/auth";
import { type DatabaseInstance, tables } from "@/core/services/db";

export class UserRepository implements BaseRepository<User> {
	constructor(
		private readonly db: DatabaseInstance,
		private readonly auth: AuthInstance,
	) {}

	private composeUser(
		val: Omit<User, "banExpires" | "updatedAt" | "createdAt"> & {
			banExpires: Date | null;
			createdAt: Date;
			updatedAt: Date;
		},
	): User {
		return {
			...val,
			banExpires: val.banExpires?.getTime() ?? null,
			createdAt: val.createdAt.getTime(),
			updatedAt: val.updatedAt.getTime(),
		};
	}

	private async getUserFromDb(id: string): Promise<User | undefined> {
		const result = await this.db.query.user.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return this.composeUser(result);
		return result;
	}

	async getAll(opts: GetAllOptions, userId: string): Promise<User[]> {
		try {
			let stmt = this.db.query.user.findMany({
				where: (f, op) => op.ne(f.id, userId),
			});
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = this.db.query.user.findMany({
						where: (f, op) =>
							op.and(op.gt(f.createdAt, new Date(cursor)), op.ne(f.id, userId)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.user.findMany({
						offset,
						limit,
						where: (f, op) => op.ne(f.id, userId),
					});
				}
			}
			const result = await stmt;
			return result.map((v) => this.composeUser(v));
		} catch (error) {
			throw new RepositoryError("Failed to get all user", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async getById(id: string): Promise<User | undefined> {
		try {
			const result = await this.getUserFromDb(id);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get user by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async create(item: InsertUser): Promise<User & { password: string }> {
		try {
			const { user } = await this.auth.api.createUser({
				body: item,
			});

			const result = this.composeUser({
				...user,
				role: (user.role ?? "user") as UserRole,
				image: user.image ?? null,
				banned: user.banned ?? false,
				banReason: user.banReason ?? null,
				banExpires: user.banExpires ?? null,
			});

			return { ...result, password: item.password };
		} catch (error) {
			if (error instanceof APIError) {
				throw new RepositoryError(error.message, {
					code: error.body?.code,
					prevError: error instanceof Error ? error : undefined,
				});
			}
			throw new RepositoryError(
				error instanceof Error ? error.message : "Failed to create user",
				{
					prevError: error instanceof Error ? error : undefined,
				},
			);
		}
	}

	async update(
		id: string,
		item: UpdateUser,
		reqHeader?: Record<string, string>,
	): Promise<User> {
		try {
			const existing = await this.getUserFromDb(id);
			if (!existing) {
				throw new RepositoryError(`User with id "${id}" not found`);
			}

			let result: User = existing;

			const headers = new Headers();
			if (reqHeader) {
				for (const [k, v] of Object.entries(reqHeader)) {
					headers.set(k, v);
				}
			}
			if ("role" in item) {
				const { user } = await this.auth.api.setRole({
					body: { userId: id, role: item.role },
					headers,
				});
				result = this.composeUser({
					...user,
					role: (user.role ?? "user") as UserRole,
					image: user.image ?? null,
					banned: user.banned ?? false,
					banReason: user.banReason ?? null,
					banExpires: user.banExpires ?? null,
				});
			}
			if ("password" in item) {
				const { status } = await this.auth.api.setUserPassword({
					body: { userId: id, newPassword: item.password },
					headers,
				});
				if (!status) {
					throw new RepositoryError("Failed to update user password");
				}
			}
			if ("banReason" in item) {
				await this.auth.api.banUser({
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
				await this.auth.api.banUser({
					body: { userId: item.id },
					headers,
				});
				result.banned = false;
				result.banReason = null;
				result.banExpires = null;
			}

			await this.auth.api.revokeUserSessions({ body: { userId: id }, headers });

			if (!result) throw new RepositoryError("Failed to update user");
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update user with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async delete(id: string): Promise<void> {
		try {
			await this.db
				.delete(tables.user)
				.where(eq(tables.user.id, id))
				.returning();
		} catch (error) {
			throw new RepositoryError(`Failed to delete user with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

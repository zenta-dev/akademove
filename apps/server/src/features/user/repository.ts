import type { InsertUser, UpdateUser, User } from "@repo/schema/user";
import { eq } from "drizzle-orm";
import { v4 } from "uuid";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	BaseRepository,
	GetAllOptions,
	GetOptions,
} from "@/core/interface";
import { type DatabaseInstance, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";

export class UserRepository implements BaseRepository<User> {
	constructor(
		private readonly db: DatabaseInstance,
		private readonly kv: KeyValueService,
	) {}

	private composeUser(
		val: Omit<User, "updatedAt" | "createdAt"> & {
			createdAt: Date;
			updatedAt: Date;
		},
	): User {
		return {
			...val,
			createdAt: val.createdAt.getTime(),
			updatedAt: val.updatedAt.getTime(),
		};
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.USER}${id}`;
	}

	private async getCache(id: string): Promise<User | undefined> {
		try {
			return await this.kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async setCache(id: string, data: User | undefined): Promise<void> {
		if (data) {
			try {
				await this.kv.put(this.composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["1h"],
				});
			} catch {}
		}
	}

	private async getUserFromDb(id: string): Promise<User | undefined> {
		const result = await this.db.query.user.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return this.composeUser(result);
		return result;
	}

	async getAll(opts?: GetAllOptions): Promise<User[]> {
		try {
			let stmt = this.db.query.user.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = this.db.query.user.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.user.findMany({
						offset,
						limit,
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

	async getById(id: string, opts?: GetOptions): Promise<User | undefined> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getCache(id);
				if (cached) return cached;
			}

			const result = await this.getUserFromDb(id);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get user by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async create(item: InsertUser): Promise<User> {
		try {
			const id = v4();
			const value = {
				...item,
				createdAt: new Date(),
				updatedAt: new Date(),
				id,
			};

			const [operation] = await this.db
				.insert(tables.user)
				.values(value)
				.returning();

			const result = this.composeUser(operation);
			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create user", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async update(id: string, item: UpdateUser): Promise<User> {
		try {
			const existing = await this.getUserFromDb(id);
			if (!existing) {
				throw new RepositoryError(`User with id "${id}" not found`);
			}
			const value = {
				...existing,
				...item,
				createdAt: new Date(existing.createdAt),
				updatedAt: new Date(),
				id,
			};

			const [operation] = await this.db
				.update(tables.user)
				.set(value)
				.where(eq(tables.user.id, id))
				.returning();

			const result = this.composeUser(operation);

			await this.setCache(id, result);

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
			const result = await this.db
				.delete(tables.user)
				.where(eq(tables.user.id, id))
				.returning();

			if (result.length > 0) {
				try {
					await this.kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete user with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

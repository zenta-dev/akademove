import type { Driver, InsertDriver, UpdateDriver } from "@repo/schema/driver";
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

export class DriverRepository implements BaseRepository<Driver> {
	constructor(
		private readonly db: DatabaseInstance,
		private readonly kv: KeyValueService,
	) {}

	private composeDriver(
		val: Omit<Driver, "lastLocationUpdate" | "createdAt"> & {
			lastLocationUpdate: Date | null;
			createdAt: Date;
		},
	): Driver {
		return {
			...val,
			lastLocationUpdate: val.lastLocationUpdate?.getTime() ?? null,
			createdAt: val.createdAt.getTime(),
		};
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.DRIVER}${id}`;
	}

	private async getCache(id: string): Promise<Driver | undefined> {
		try {
			return await this.kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async setCache(id: string, data: Driver | undefined): Promise<void> {
		if (data) {
			try {
				await this.kv.put(this.composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	private async getDriverFromDb(id: string): Promise<Driver | undefined> {
		const result = await this.db.query.driver.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return this.composeDriver(result);
		return result;
	}

	async getAll(opts?: GetAllOptions): Promise<Driver[]> {
		try {
			let stmt = this.db.query.driver.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = this.db.query.driver.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.driver.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map((v) => this.composeDriver(v));
		} catch (error) {
			throw new RepositoryError("Failed to get all driver", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async getById(id: string, opts?: GetOptions): Promise<Driver | undefined> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getCache(id);
				if (cached) return cached;
			}

			const result = await this.getDriverFromDb(id);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get driver by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async create(item: InsertDriver & { userId: string }): Promise<Driver> {
		try {
			const id = v4();
			const value = { ...item, id };

			const [operation] = await this.db
				.insert(tables.driver)
				.values(value)
				.returning();

			const result = this.composeDriver(operation);
			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create driver", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async update(id: string, item: UpdateDriver): Promise<Driver> {
		try {
			const existing = await this.getDriverFromDb(id);
			if (!existing) {
				throw new RepositoryError(`Driver with id "${id}" not found`);
			}
			const value = {
				...existing,
				...item,
				lastLocationUpdate: new Date(existing.createdAt),
				createdAt: new Date(existing.createdAt),
				id,
			};

			const [operation] = await this.db
				.update(tables.driver)
				.set(value)
				.where(eq(tables.driver.id, id))
				.returning();

			const result = this.composeDriver(operation);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update driver with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async delete(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.driver)
				.where(eq(tables.driver.id, id))
				.returning();

			if (result.length > 0) {
				try {
					await this.kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete driver with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

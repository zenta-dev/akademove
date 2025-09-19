import type { Driver, InsertDriver, UpdateDriver } from "@repo/schema/driver";
import { eq } from "drizzle-orm";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { DriverDatabase } from "@/core/tables/driver";

export const createDriverRepository = (
	db: DatabaseService,
	kv: KeyValueService,
) => {
	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.DRIVER}${id}`;
	}

	function _composeEntity(item: DriverDatabase): Driver {
		return {
			...item,
			currentLocation: item.currentLocation ?? undefined,
			lastLocationUpdate: item.lastLocationUpdate?.getTime(),
			createdAt: item.createdAt?.getTime(),
		};
	}

	async function _getFromKV(id: string): Promise<Driver | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(id: string): Promise<Driver | undefined> {
		const result = await db.query.driver.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function _setCache(id: string, data: Driver | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<Driver[]> {
		try {
			let stmt = db.query.driver.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.driver.findMany({
						where: (f, op) => op.gt(f.lastLocationUpdate, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.driver.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			throw new RepositoryError("Failed to listing drivers", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function get(id: string, opts?: GetOptions) {
		try {
			if (opts?.fromCache) {
				const cached = await _getFromKV(id);
				if (cached) return cached;
			}

			const result = await _getFromDB(id);

			if (!result) throw new RepositoryError("Failed get driver from db");

			await _setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get driver by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function create(
		item: InsertDriver & { userId: string },
	): Promise<Driver> {
		try {
			const [operation] = await db
				.insert(tables.driver)
				.values(item)
				.returning();

			const result = _composeEntity(operation);
			await _setCache(result.id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create driver", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function update(id: string, item: UpdateDriver): Promise<Driver> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Driver with id "${id}" not found`);
			}

			const [operation] = await db
				.update(tables.driver)
				.set({
					...existing,
					...item,
					createdAt: new Date(existing.createdAt),
					lastLocationUpdate: item.isOnline ? new Date() : null,
				})
				.where(eq(tables.driver.id, id))
				.returning();

			const result = _composeEntity(operation);

			await _setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update driver with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const result = await db
				.delete(tables.driver)
				.where(eq(tables.driver.id, id))
				.returning({ id: tables.driver.id });

			if (result.length > 0) {
				try {
					await kv.delete(_composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete driver with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	return { list, get, create, update, remove };
};

export type DriverRepository = ReturnType<typeof createDriverRepository>;

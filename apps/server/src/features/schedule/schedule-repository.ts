import type {
	DriverSchedule,
	InsertDriverSchedule,
	UpdateDriverSchedule,
} from "@repo/schema/driver";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { DriverScheduleDatabase } from "@/core/tables/driver";
import { log } from "@/utils";

export class DriverScheduleRepository {
	#db: DatabaseService;
	#kv: KeyValueService;

	constructor(db: DatabaseService, kv: KeyValueService) {
		this.#db = db;
		this.#kv = kv;
	}

	#composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.DRIVER}${id}`;
	}

	#composeEntity(item: DriverScheduleDatabase): DriverSchedule {
		return {
			...item,
			specificDate: item.specificDate ?? undefined,
		};
	}

	async #getFromKV(id: string): Promise<DriverSchedule | undefined> {
		try {
			return await this.#kv.get(this.#composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async #getFromDB(id: string): Promise<DriverSchedule | undefined> {
		const result = await this.#db.query.driverSchedule.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? this.#composeEntity(result) : undefined;
	}

	async #setCache(id: string, data: DriverSchedule | undefined): Promise<void> {
		if (!data) return;
		try {
			await this.#kv.put(this.#composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {
			// ignore cache write failures
		}
	}

	async list(opts?: GetAllOptions): Promise<DriverSchedule[]> {
		try {
			let stmt = this.#db.query.driverSchedule.findMany();

			if (opts) {
				const { cursor, page, limit } = opts;

				if (cursor) {
					stmt = this.#db.query.driverSchedule.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}

				if (page) {
					const offset = (page - 1) * limit;
					stmt = this.#db.query.driverSchedule.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return result.map((r) => this.#composeEntity(r));
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list schedules");
		}
	}

	async get(id: string, opts?: GetOptions): Promise<DriverSchedule> {
		try {
			if (opts?.fromCache) {
				const cached = await this.#getFromKV(id);
				if (cached) return cached;
			}

			const result = await this.#getFromDB(id);
			if (!result) throw new RepositoryError("Failed to get schedule from db");

			await this.#setCache(id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get schedule by id "${id}"`);
		}
	}

	async create(
		item: InsertDriverSchedule & { userId: string },
	): Promise<DriverSchedule> {
		try {
			const [operation] = await this.#db
				.insert(tables.driverSchedule)
				.values({
					...item,
					id: v7(),
					specificDate: item.specificDate ? new Date(item.specificDate) : null,
				})
				.returning();

			const result = this.#composeEntity(operation);
			await this.#setCache(result.id, result);

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to create schedule");
		}
	}

	async update(
		id: string,
		item: UpdateDriverSchedule,
	): Promise<DriverSchedule> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Schedule with id "${id}" not found`);

			const [operation] = await this.#db
				.update(tables.driverSchedule)
				.set({
					...existing,
					...item,
					specificDate: item.specificDate
						? new Date(item.specificDate)
						: existing.specificDate
							? new Date(existing.specificDate)
							: null,
					createdAt: new Date(existing.createdAt),
					updatedAt: new Date(),
				})
				.where(eq(tables.driverSchedule.id, id))
				.returning();

			const result = this.#composeEntity(operation);
			await this.#setCache(id, result);
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update schedule with id "${id}"`);
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.#db
				.delete(tables.driverSchedule)
				.where(eq(tables.driverSchedule.id, id))
				.returning({ id: tables.driverSchedule.id });

			if (result.length > 0) {
				try {
					await this.#kv.delete(this.#composeCacheKey(id));
				} catch {
					// ignore cache delete failures
				}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to delete schedule with id "${id}"`);
		}
	}
}

import type {
	InsertSchedule,
	Schedule,
	UpdateSchedule,
} from "@repo/schema/schedule";
import { eq } from "drizzle-orm";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ScheduleDatabase } from "@/core/tables/schedule";

export const createScheduleRepository = (
	db: DatabaseService,
	kv: KeyValueService,
) => {
	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.SCHEDULE}${id}`;
	}

	function _composeEntity(item: ScheduleDatabase): Schedule {
		return {
			...item,
			specificDate: item.specificDate?.getTime() ?? null,
			createdAt: item.createdAt.getTime(),
			updatedAt: item.updatedAt.getTime(),
		};
	}

	async function _getFromKV(id: string): Promise<Schedule | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(id: string): Promise<Schedule | undefined> {
		const result = await db.query.schedule.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function _setCache(id: string, data: Schedule | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<Schedule[]> {
		try {
			let stmt = db.query.schedule.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.schedule.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.schedule.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			throw new RepositoryError("Failed to listing schedules", {
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

			if (!result) throw new RepositoryError("Failed get schedule from db");

			await _setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get schedule by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function create(
		item: InsertSchedule & { userId: string },
	): Promise<Schedule> {
		try {
			const [operation] = await db
				.insert(tables.schedule)
				.values({
					...item,
					specificDate: item.specificDate ? new Date(item.specificDate) : null,
				})
				.returning();

			const result = _composeEntity(operation);
			await _setCache(result.id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create schedule", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function update(id: string, item: UpdateSchedule): Promise<Schedule> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Schedule with id "${id}" not found`);
			}

			const [operation] = await db
				.update(tables.schedule)
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
				.where(eq(tables.schedule.id, id))
				.returning();

			const result = _composeEntity(operation);

			await _setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update schedule with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const result = await db
				.delete(tables.schedule)
				.where(eq(tables.schedule.id, id))
				.returning({ id: tables.schedule.id });

			if (result.length > 0) {
				try {
					await kv.delete(_composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete schedule with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	return { list, get, create, update, remove };
};

export type ScheduleRepository = ReturnType<typeof createScheduleRepository>;

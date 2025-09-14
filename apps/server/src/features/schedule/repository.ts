import type {
	InsertSchedule,
	Schedule,
	UpdateSchedule,
} from "@repo/schema/schedule";
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

export class ScheduleRepository implements BaseRepository<Schedule> {
	constructor(
		private readonly db: DatabaseInstance,
		private readonly kv: KeyValueService,
	) {}

	private composeSchedule(
		val: Omit<Schedule, "specificDate" | "updatedAt" | "createdAt"> & {
			specificDate: Date | null;
			createdAt: Date;
			updatedAt: Date;
		},
	): Schedule {
		return {
			...val,
			specificDate: val.specificDate?.getTime() ?? null,
			createdAt: val.createdAt.getTime(),
			updatedAt: val.updatedAt.getTime(),
		};
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.SCHEDULE}${id}`;
	}

	private async getCache(id: string): Promise<Schedule | undefined> {
		try {
			return await this.kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async setCache(
		id: string,
		data: Schedule | undefined,
	): Promise<void> {
		if (data) {
			try {
				await this.kv.put(this.composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["1h"],
				});
			} catch {}
		}
	}

	private async getScheduleFromDb(id: string): Promise<Schedule | undefined> {
		const result = await this.db.query.schedule.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return this.composeSchedule(result);
		return result;
	}

	async getAll(opts?: GetAllOptions): Promise<Schedule[]> {
		try {
			let stmt = this.db.query.schedule.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = this.db.query.schedule.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.schedule.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map((v) => this.composeSchedule(v));
		} catch (error) {
			throw new RepositoryError("Failed to get all schedule", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async getById(id: string, opts?: GetOptions): Promise<Schedule | undefined> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getCache(id);
				if (cached) return cached;
			}

			const result = await this.getScheduleFromDb(id);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get schedule by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async create(item: InsertSchedule): Promise<Schedule> {
		try {
			const id = v4();
			const value = {
				...item,
				specificDate: item.specificDate ? new Date(item.specificDate) : null,
				id,
			};

			const [operation] = await this.db
				.insert(tables.schedule)
				.values(value)
				.returning();

			const result = this.composeSchedule(operation);
			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create schedule", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async update(id: string, item: UpdateSchedule): Promise<Schedule> {
		try {
			const existing = await this.getScheduleFromDb(id);
			if (!existing) {
				throw new RepositoryError(`Schedule with id "${id}" not found`);
			}
			const value = {
				...existing,
				...item,
				specificDate: item.specificDate
					? new Date(item.specificDate)
					: existing.specificDate
						? new Date(existing.specificDate)
						: null,
				createdAt: new Date(existing.createdAt),
				updatedAt: new Date(),
				id,
			};

			const [operation] = await this.db
				.update(tables.schedule)
				.set(value)
				.where(eq(tables.schedule.id, id))
				.returning();

			const result = this.composeSchedule(operation);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update schedule with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async delete(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.schedule)
				.where(eq(tables.schedule.id, id))
				.returning();

			if (result.length > 0) {
				try {
					await this.kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete schedule with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

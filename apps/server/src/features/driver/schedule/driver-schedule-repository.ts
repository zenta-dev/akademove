import type {
	DriverSchedule,
	InsertDriverSchedule,
	UpdateDriverSchedule,
} from "@repo/schema/driver";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { DriverScheduleDatabase } from "@/core/tables/driver";

export class DriverScheduleRepository extends BaseRepository {
	#db: DatabaseService;

	constructor(db: DatabaseService, kv: KeyValueService) {
		super(FEATURE_TAGS.DRIVER_SCHEDULE, kv);
		this.#db = db;
	}

	static composeEntity(item: DriverScheduleDatabase): DriverSchedule {
		return {
			...item,
			specificDate: item.specificDate ?? undefined,
		};
	}

	async #getFromDB(id: string): Promise<DriverSchedule | undefined> {
		const result = await this.#db.query.driverSchedule.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? DriverScheduleRepository.composeEntity(result) : undefined;
	}

	async list(query?: UnifiedPaginationQuery): Promise<DriverSchedule[]> {
		try {
			let stmt = this.#db.query.driverSchedule.findMany();

			if (query) {
				const { cursor, page, limit } = query;

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
			return result.map((r) => DriverScheduleRepository.composeEntity(r));
		} catch (error) {
			throw this.handleError(error, "list");
		}
	}

	async get(id: string): Promise<DriverSchedule> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res)
					throw new RepositoryError("Failed to get driver schedule from DB");
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
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

			const result = DriverScheduleRepository.composeEntity(operation);
			await this.setCache(result.id, result, {
				expirationTtl: CACHE_TTLS["24h"],
			});

			return result;
		} catch (error) {
			throw this.handleError(error, "create");
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

			const result = DriverScheduleRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.#db
				.delete(tables.driverSchedule)
				.where(eq(tables.driverSchedule.id, id))
				.returning({ id: tables.driverSchedule.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "remove");
		}
	}
}

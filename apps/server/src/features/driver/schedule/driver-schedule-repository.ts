import { m } from "@repo/i18n";
import {
	type DriverSchedule,
	DriverScheduleKeySchema,
	type InsertDriverSchedule,
	type UpdateDriverSchedule,
} from "@repo/schema/driver";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { count, eq, gt, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { DriverScheduleDatabase } from "@/core/tables/driver";
import { log } from "@/utils";

export class DriverScheduleRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("driverSchedule", kv, db);
	}

	static composeEntity(item: DriverScheduleDatabase): DriverSchedule {
		return {
			...item,
			specificDate: item.specificDate ?? undefined,
		};
	}

	async #getFromDB(id: string): Promise<DriverSchedule | undefined> {
		const result = await this.db.query.driverSchedule.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? DriverScheduleRepository.composeEntity(result) : undefined;
	}

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.driverSchedule.id) })
				.from(tables.driverSchedule)
				.where(ilike(tables.driverSchedule.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(
		query?: UnifiedPaginationQuery,
	): Promise<ListResult<DriverSchedule>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
			} = query ?? {};

			const orderBy = (
				f: typeof tables.driverSchedule._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = DriverScheduleKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search) clauses.push(ilike(tables.driverSchedule.name, `%${query}%`));

			if (cursor) {
				clauses.push(gt(tables.driverSchedule.createdAt, new Date(cursor)));

				const res = await this.db.query.driverSchedule.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(DriverScheduleRepository.composeEntity);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const res = await this.db.query.driverSchedule.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = res.map(DriverScheduleRepository.composeEntity);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.driverSchedule.findMany({
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map(DriverScheduleRepository.composeEntity);

			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<DriverSchedule> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res)
					throw new RepositoryError(m.error_failed_get_driver_schedule());
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
			const [operation] = await this.db
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

			const [operation] = await this.db
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
			const result = await this.db
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

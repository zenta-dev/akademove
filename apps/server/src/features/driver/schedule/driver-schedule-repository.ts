import { m } from "@repo/i18n";
import type {
	DriverSchedule,
	InsertDriverSchedule,
	UpdateDriverSchedule,
} from "@repo/schema/driver";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	OrderByOperation,
	PartialWithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { DriverScheduleDatabase } from "@/core/tables/driver";
import { DriverScheduleListQueryService } from "./services/driver-schedule-list-query-service";

// Extended query type that includes driverId filter
interface DriverScheduleListQuery extends UnifiedPaginationQuery {
	driverId?: string;
}

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

	async list(
		query?: DriverScheduleListQuery,
	): Promise<ListResult<DriverSchedule>> {
		try {
			// Extract pagination parameters
			const { cursor, page, limit, search, sortBy, order } =
				DriverScheduleListQueryService.extractPaginationParams(query);

			// Extract driverId filter
			const driverId = query?.driverId;

			// Generate ORDER BY clause
			const orderBy = (
				f: typeof tables.driverSchedule._.columns,
				op: OrderByOperation,
			) => {
				const validField =
					DriverScheduleListQueryService.parseSortField(sortBy);
				if (validField) {
					const field = f[validField as keyof typeof f];
					return op[order](field);
				}
				return op[order](f.id);
			};

			// Generate WHERE clauses
			const clauses = DriverScheduleListQueryService.generateWhereClauses({
				search,
				cursor,
				driverId,
			});

			// Cursor-based pagination
			if (cursor) {
				const res = await this.db.query.driverSchedule.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(DriverScheduleRepository.composeEntity);

				return { rows };
			}

			// Page-based pagination
			if (page) {
				const res = await this.db.query.driverSchedule.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset: DriverScheduleListQueryService.calculatePagination({
						page,
						limit,
						totalCount: 0,
					}).offset,
					limit,
				});

				const rows = res.map(DriverScheduleRepository.composeEntity);

				// Get total count based on search and driverId
				const totalCount =
					search || driverId
						? await DriverScheduleListQueryService.getFilteredCount(this.db, {
								search,
								driverId,
							})
						: await this.getTotalRow();

				const { totalPages } =
					DriverScheduleListQueryService.calculatePagination({
						page,
						limit,
						totalCount,
					});

				return { rows, totalPages };
			}

			// Default: no pagination
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
		opts?: PartialWithTx,
	): Promise<DriverSchedule> {
		try {
			const db = opts?.tx ?? this.db;
			const [operation] = await db
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
		opts?: PartialWithTx,
	): Promise<DriverSchedule> {
		try {
			const db = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Schedule with id "${id}" not found`);

			const [operation] = await db
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

	async remove(id: string, opts?: PartialWithTx): Promise<void> {
		try {
			const db = opts?.tx ?? this.db;
			const result = await db
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

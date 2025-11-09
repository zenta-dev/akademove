import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import {
	type InsertReport,
	type Report,
	ReportKeySchema,
	type UpdateReport,
} from "@repo/schema/report";
import { count, eq, gt, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReportDatabase } from "@/core/tables/report";
import { log } from "@/utils";

export class ReportRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super(FEATURE_TAGS.REPORT, "report", kv, db);
	}

	static composeEntity(item: ReportDatabase): Report {
		return {
			...item,
			orderId: item.orderId ?? undefined,
			evidenceUrl: item.evidenceUrl ?? undefined,
			handledById: item.handledById ?? undefined,
			resolution: item.resolution ?? undefined,
			resolvedAt: item.resolvedAt ?? undefined,
		};
	}

	async #getFromDB(id: string): Promise<Report | undefined> {
		const result = await this.db.query.report.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? ReportRepository.composeEntity(result) : undefined;
	}

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.report.id) })
				.from(tables.report)
				.where(ilike(tables.report.description, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Report>> {
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
				f: typeof tables.report._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = ReportKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search) clauses.push(ilike(tables.report.description, `%${search}%`));
			if (cursor) {
				clauses.push(gt(tables.report.reportedAt, new Date(cursor)));

				const result = await this.db.query.report.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = result.map(ReportRepository.composeEntity);
				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const result = await this.db.query.report.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = result.map(ReportRepository.composeEntity);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await this.db.query.report.findMany({
				where: (_f, op) => op.and(...clauses),
				orderBy,
				limit,
			});
			const rows = result.map(ReportRepository.composeEntity);
			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<Report> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError("Failed to get driver from DB");
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(item: InsertReport & { userId: string }): Promise<Report> {
		try {
			const [operation] = await this.db
				.insert(tables.report)
				.values({ ...item, id: v7() })
				.returning();

			const result = ReportRepository.composeEntity(operation);
			await this.setCache(result.id, result);

			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateReport): Promise<Report> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Report with id "${id}" not found`);

			const [operation] = await this.db
				.update(tables.report)
				.set({
					...item,
					reportedAt: new Date(existing.reportedAt),
					resolvedAt:
						item.status === "resolved"
							? new Date()
							: existing.resolvedAt
								? new Date(existing.resolvedAt)
								: null,
				})
				.where(eq(tables.report.id, id))
				.returning();

			const result = ReportRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.report)
				.where(eq(tables.report.id, id))
				.returning({ id: tables.report.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "remove");
		}
	}
}

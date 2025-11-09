import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { InsertReport, Report, UpdateReport } from "@repo/schema/report";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReportDatabase } from "@/core/tables/report";

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

	async list(query?: UnifiedPaginationQuery): Promise<Report[]> {
		try {
			let stmt = this.db.query.report.findMany();

			if (query) {
				const { cursor, page, limit } = query;

				if (cursor) {
					stmt = this.db.query.report.findMany({
						where: (f, op) => op.gt(f.reportedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}

				if (page) {
					const offset = (page - 1) * limit;
					stmt = this.db.query.report.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return result.map((r) => ReportRepository.composeEntity(r));
		} catch (error) {
			throw this.handleError(error, "list");
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

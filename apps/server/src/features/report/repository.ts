import type { InsertReport, Report, UpdateReport } from "@repo/schema/report";
import { eq } from "drizzle-orm";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { log } from "@/core/logger";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReportDatabase } from "@/core/tables/report";

export const createReportRepository = (
	db: DatabaseService,
	kv: KeyValueService,
) => {
	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.REPORT}${id}`;
	}

	function _composeEntity(item: ReportDatabase): Report {
		return {
			...item,
			orderId: item.orderId ?? undefined,
			evidenceUrl: item.evidenceUrl ?? undefined,
			handledById: item.handledById ?? undefined,
			resolution: item.resolution ?? undefined,
			resolvedAt: item.resolvedAt ?? undefined,
		};
	}

	async function _getFromKV(id: string): Promise<Report | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(id: string): Promise<Report | undefined> {
		const result = await db.query.report.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function _setCache(id: string, data: Report | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<Report[]> {
		try {
			let stmt = db.query.report.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.report.findMany({
						where: (f, op) => op.gt(f.reportedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.report.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError("Failed to listing reports");
		}
	}

	async function get(id: string, opts?: GetOptions) {
		try {
			if (opts?.fromCache) {
				const cached = await _getFromKV(id);
				if (cached) return cached;
			}

			const result = await _getFromDB(id);

			if (!result) throw new RepositoryError("Failed get report from db");

			await _setCache(id, result);

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to get report by id "${id}"`);
		}
	}

	async function create(
		item: InsertReport & { userId: string },
	): Promise<Report> {
		try {
			const [operation] = await db
				.insert(tables.report)
				.values(item)
				.returning();

			const result = _composeEntity(operation);
			await _setCache(result.id, result);

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError("Failed to create report");
		}
	}

	async function update(id: string, item: UpdateReport): Promise<Report> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Report with id "${id}" not found`);
			}

			const [operation] = await db
				.update(tables.report)
				.set({
					...existing,
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

			const result = _composeEntity(operation);

			await _setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update report with id "${id}"`);
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const result = await db
				.delete(tables.report)
				.where(eq(tables.report.id, id))
				.returning({ id: tables.report.id });

			if (result.length > 0) {
				try {
					await kv.delete(_composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to delete report with id "${id}"`);
		}
	}

	return { list, get, create, update, remove };
};

export type ReportRepository = ReturnType<typeof createReportRepository>;

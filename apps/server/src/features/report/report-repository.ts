import type { InsertReport, Report, UpdateReport } from "@repo/schema/report";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReportDatabase } from "@/core/tables/report";
import { log } from "@/utils";

export class ReportRepository {
	#db: DatabaseService;
	#kv: KeyValueService;

	constructor(db: DatabaseService, kv: KeyValueService) {
		this.#db = db;
		this.#kv = kv;
	}

	#composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.REPORT}${id}`;
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

	async #getFromKV(id: string): Promise<Report | undefined> {
		try {
			return await this.#kv.get(this.#composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async #getFromDB(id: string): Promise<Report | undefined> {
		const result = await this.#db.query.report.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? ReportRepository.composeEntity(result) : undefined;
	}

	async #setCache(id: string, data: Report | undefined): Promise<void> {
		if (!data) return;
		try {
			await this.#kv.put(this.#composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {
			// ignore cache failures
		}
	}

	async list(opts?: GetAllOptions): Promise<Report[]> {
		try {
			let stmt = this.#db.query.report.findMany();

			if (opts) {
				const { cursor, page, limit } = opts;

				if (cursor) {
					stmt = this.#db.query.report.findMany({
						where: (f, op) => op.gt(f.reportedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}

				if (page) {
					const offset = (page - 1) * limit;
					stmt = this.#db.query.report.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return result.map((r) => ReportRepository.composeEntity(r));
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list reports");
		}
	}

	async get(id: string, opts?: GetOptions): Promise<Report> {
		try {
			if (opts?.fromCache) {
				const cached = await this.#getFromKV(id);
				if (cached) return cached;
			}

			const result = await this.#getFromDB(id);
			if (!result) throw new RepositoryError("Failed to get report from db");

			await this.#setCache(id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get report by id "${id}"`);
		}
	}

	async create(item: InsertReport & { userId: string }): Promise<Report> {
		try {
			const [operation] = await this.#db
				.insert(tables.report)
				.values({ ...item, id: v7() })
				.returning();

			const result = ReportRepository.composeEntity(operation);
			await this.#setCache(result.id, result);

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to create report");
		}
	}

	async update(id: string, item: UpdateReport): Promise<Report> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Report with id "${id}" not found`);

			const [operation] = await this.#db
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

			const result = ReportRepository.composeEntity(operation);
			await this.#setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update report with id "${id}"`);
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.#db
				.delete(tables.report)
				.where(eq(tables.report.id, id))
				.returning({ id: tables.report.id });

			if (result.length > 0) {
				try {
					await this.#kv.delete(this.#composeCacheKey(id));
				} catch {
					// ignore cache deletion errors
				}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to delete report with id "${id}"`);
		}
	}
}

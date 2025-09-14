import type { InsertReport, Report, UpdateReport } from "@repo/schema/report";
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

export class ReportRepository implements BaseRepository<Report> {
	constructor(
		private readonly db: DatabaseInstance,
		private readonly kv: KeyValueService,
	) {}

	private composeReport(
		val: Omit<Report, "reportedAt" | "resolvedAt"> & {
			reportedAt: Date;
			resolvedAt: Date | null;
		},
	): Report {
		return {
			...val,
			reportedAt: val.reportedAt.getTime(),
			resolvedAt: val.resolvedAt?.getTime() ?? null,
		};
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.REPORT}${id}`;
	}

	private async getCache(id: string): Promise<Report | undefined> {
		try {
			return await this.kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async setCache(id: string, data: Report | undefined): Promise<void> {
		if (data) {
			try {
				await this.kv.put(this.composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["1h"],
				});
			} catch {}
		}
	}

	private async getReportFromDb(id: string): Promise<Report | undefined> {
		const result = await this.db.query.report.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return this.composeReport(result);
		return result;
	}

	async getAll(opts?: GetAllOptions): Promise<Report[]> {
		try {
			let stmt = this.db.query.report.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = this.db.query.report.findMany({
						where: (f, op) => op.gt(f.reportedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.report.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map((v) => this.composeReport(v));
		} catch (error) {
			throw new RepositoryError("Failed to get all report", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async getById(id: string, opts?: GetOptions): Promise<Report | undefined> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getCache(id);
				if (cached) return cached;
			}

			const result = await this.getReportFromDb(id);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get report by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async create(item: InsertReport): Promise<Report> {
		try {
			const id = v4();
			const value = {
				...item,
				usedCount: 0,
				reportedAt: new Date(),
				id,
			};

			const [operation] = await this.db
				.insert(tables.report)
				.values(value)
				.returning();

			const result = this.composeReport(operation);
			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create report", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async update(id: string, item: UpdateReport): Promise<Report> {
		try {
			const existing = await this.getReportFromDb(id);
			if (!existing) {
				throw new RepositoryError(`Report with id "${id}" not found`);
			}
			const value = {
				...existing,
				...item,
				reportedAt: new Date(existing.reportedAt),
				resolvedAt: existing.resolvedAt ? new Date(existing.resolvedAt) : null,
				id,
			};

			const [operation] = await this.db
				.update(tables.report)
				.set(value)
				.where(eq(tables.report.id, id))
				.returning();

			const result = this.composeReport(operation);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update report with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async delete(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.report)
				.where(eq(tables.report.id, id))
				.returning();

			if (result.length > 0) {
				try {
					await this.kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete report with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

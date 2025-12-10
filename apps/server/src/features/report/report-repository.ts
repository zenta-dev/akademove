import { m } from "@repo/i18n";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { InsertReport, Report, UpdateReport } from "@repo/schema/report";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	ORPCContext,
	OrderByOperation,
	PartialWithTx,
} from "@/core/interface";
import { AuditService } from "@/core/services/audit";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReportDatabase } from "@/core/tables/report";
import { logger } from "@/utils/logger";
import { ReportListQueryService, ReportStatusService } from "./services";

export class ReportRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("report", kv, db);
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

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Report>> {
		try {
			// Extract pagination parameters
			const { cursor, page, limit, search, sortBy, order } =
				ReportListQueryService.extractPaginationParams(query);

			// Generate ORDER BY clause
			const orderBy = (
				f: typeof tables.report._.columns,
				op: OrderByOperation,
			) => {
				const validField = ReportListQueryService.parseSortField(sortBy);
				if (validField) {
					const field = f[validField as keyof typeof f];
					return op[order](field);
				}
				return op[order](f.id);
			};

			// Generate WHERE clauses
			const clauses = ReportListQueryService.generateWhereClauses({
				search,
				cursor,
			});

			// Cursor-based pagination
			if (cursor) {
				const result = await this.db.query.report.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = result.map(ReportRepository.composeEntity);
				return { rows };
			}

			// Page-based pagination
			if (page) {
				const result = await this.db.query.report.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					offset: ReportListQueryService.calculatePagination({
						page,
						limit,
						totalCount: 0,
					}).offset,
					limit,
				});

				const rows = result.map(ReportRepository.composeEntity);

				// Get total count based on search
				const totalCount = search
					? await ReportListQueryService.getSearchCount(this.db, search)
					: await this.getTotalRow();

				const { totalPages } = ReportListQueryService.calculatePagination({
					page,
					limit,
					totalCount,
				});

				return { rows, totalPages };
			}

			// Default: no pagination
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
				if (!res) throw new RepositoryError(m.error_failed_get_driver());
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(item: InsertReport): Promise<Report> {
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

	async update(
		id: string,
		item: UpdateReport,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<Report> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Report with id "${id}" not found`);

			// Calculate resolvedAt timestamp (delegated to service)
			const resolvedAt = ReportStatusService.calculateResolvedAt(
				item.status,
				existing.resolvedAt,
			);

			const [operation] = await this.db
				.update(tables.report)
				.set({
					...item,
					reportedAt: new Date(existing.reportedAt),
					resolvedAt,
				})
				.where(eq(tables.report.id, id))
				.returning();

			const result = ReportRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			// Audit log
			if (context?.user) {
				await AuditService.logChange(
					{
						tableName: "report",
						recordId: id,
						operation: "UPDATE",
						oldData: existing,
						newData: operation,
						updatedById: context.user.id,
						metadata: AuditService.extractMetadata(context),
					},
					context,
					opts,
				);

				logger.info(
					{ reportId: id, userId: context.user.id, status: item.status },
					"[ReportRepository] Report updated and audited",
				);
			}

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

	async startInvestigation(
		id: string,
		notes: string,
		handledById: string,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<Report> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError("Report not found", { code: "NOT_FOUND" });
			}

			if (existing.status !== "PENDING") {
				throw new RepositoryError("Only pending reports can be investigated", {
					code: "BAD_REQUEST",
				});
			}

			const [operation] = await this.db
				.update(tables.report)
				.set({
					status: "INVESTIGATING",
					resolution: notes,
					handledById,
					reportedAt: new Date(existing.reportedAt),
				})
				.where(eq(tables.report.id, id))
				.returning();

			const result = ReportRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			// Audit log
			if (context?.user) {
				await AuditService.logChange(
					{
						tableName: "report",
						recordId: id,
						operation: "UPDATE",
						oldData: existing,
						newData: operation,
						updatedById: context.user.id,
						metadata: {
							...AuditService.extractMetadata(context),
							reason: `Started investigation: ${notes}`,
						},
					},
					context,
					opts,
				);
			}

			logger.info(
				{ reportId: id, handledById },
				"[ReportRepository] Started investigation and audited",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "start investigation");
		}
	}

	async resolve(
		id: string,
		resolution: string,
		handledById: string,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<Report> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError("Report not found", { code: "NOT_FOUND" });
			}

			if (existing.status === "RESOLVED" || existing.status === "DISMISSED") {
				throw new RepositoryError("Report is already closed", {
					code: "BAD_REQUEST",
				});
			}

			const [operation] = await this.db
				.update(tables.report)
				.set({
					status: "RESOLVED",
					resolution,
					handledById,
					resolvedAt: new Date(),
					reportedAt: new Date(existing.reportedAt),
				})
				.where(eq(tables.report.id, id))
				.returning();

			const result = ReportRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			// Audit log
			if (context?.user) {
				await AuditService.logChange(
					{
						tableName: "report",
						recordId: id,
						operation: "UPDATE",
						oldData: existing,
						newData: operation,
						updatedById: context.user.id,
						metadata: {
							...AuditService.extractMetadata(context),
							reason: `Resolved: ${resolution}`,
						},
					},
					context,
					opts,
				);
			}

			logger.info(
				{ reportId: id, handledById },
				"[ReportRepository] Resolved report and audited",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "resolve");
		}
	}

	async dismiss(
		id: string,
		reason: string,
		handledById: string,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<Report> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError("Report not found", { code: "NOT_FOUND" });
			}

			if (existing.status === "RESOLVED" || existing.status === "DISMISSED") {
				throw new RepositoryError("Report is already closed", {
					code: "BAD_REQUEST",
				});
			}

			const [operation] = await this.db
				.update(tables.report)
				.set({
					status: "DISMISSED",
					resolution: reason,
					handledById,
					resolvedAt: new Date(),
					reportedAt: new Date(existing.reportedAt),
				})
				.where(eq(tables.report.id, id))
				.returning();

			const result = ReportRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			// Audit log
			if (context?.user) {
				await AuditService.logChange(
					{
						tableName: "report",
						recordId: id,
						operation: "UPDATE",
						oldData: existing,
						newData: operation,
						updatedById: context.user.id,
						metadata: {
							...AuditService.extractMetadata(context),
							reason: `Dismissed: ${reason}`,
						},
					},
					context,
					opts,
				);
			}

			logger.info(
				{ reportId: id, handledById },
				"[ReportRepository] Dismissed report and audited",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "dismiss");
		}
	}
}

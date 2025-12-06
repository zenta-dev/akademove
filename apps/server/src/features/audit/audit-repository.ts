import { and, asc, desc, eq, gte, lte, type SQL } from "drizzle-orm";
import type { ListResult, PartialWithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { AllowedLoggedTable } from "@/core/tables/common";
import { log } from "@/utils";
import type { AuditLog } from "./audit-spec";

export interface AuditLogFilters {
	tableName?: AllowedLoggedTable;
	recordId?: string;
	operation?: "INSERT" | "UPDATE" | "DELETE";
	updatedById?: string;
	startDate?: Date;
	endDate?: Date;
	page?: number;
	limit?: number;
	sortBy?: string;
	order?: "asc" | "desc";
}

export class AuditRepository {
	constructor(private readonly db: DatabaseService) {}

	private getAuditTable(tableName: AllowedLoggedTable) {
		switch (tableName) {
			case "account_deletion":
				return tables.accountDeletionAuditLog;
			case "configurations":
				return tables.configurationAuditLog;
			case "coupon":
				return tables.couponAuditLog;
			case "contact":
				return tables.contactAuditLog;
			case "report":
				return tables.reportAuditLog;
			case "user":
				return tables.userAuditLog;
			case "wallet":
				return tables.walletAuditLog;
		}
	}

	async list(
		filters: AuditLogFilters,
		opts?: PartialWithTx,
	): Promise<ListResult<AuditLog>> {
		try {
			const {
				tableName,
				recordId,
				operation,
				updatedById,
				startDate,
				endDate,
				page = 1,
				limit = 50,
				order = "desc",
			} = filters;

			// If tableName is specified, query that specific audit table
			if (tableName) {
				const auditTable = this.getAuditTable(tableName);

				const clauses: SQL[] = [eq(auditTable.tableName, tableName)];

				if (recordId) clauses.push(eq(auditTable.recordId, recordId));
				if (operation) clauses.push(eq(auditTable.operation, operation));
				if (updatedById) clauses.push(eq(auditTable.updatedById, updatedById));
				if (startDate) clauses.push(gte(auditTable.updatedAt, startDate));
				if (endDate) clauses.push(lte(auditTable.updatedAt, endDate));

				const offset = (page - 1) * limit;
				const orderBy =
					order === "desc"
						? desc(auditTable.updatedAt)
						: asc(auditTable.updatedAt);

				const [result, countResult] = await Promise.all([
					(opts?.tx ?? this.db)
						.select()
						.from(auditTable)
						.where(and(...clauses))
						.orderBy(orderBy)
						.offset(offset)
						.limit(limit),
					(opts?.tx ?? this.db)
						.select({ count: auditTable.id })
						.from(auditTable)
						.where(and(...clauses)),
				]);

				const totalRecords = countResult.length;
				const totalPages = Math.ceil(totalRecords / limit);

				return {
					rows: result as unknown[] as AuditLog[],
					totalPages,
				};
			}

			// If no tableName specified, query all audit tables and combine results
			const allTables: AllowedLoggedTable[] = [
				"account_deletion",
				"configurations",
				"contact",
				"coupon",
				"report",
				"user",
				"wallet",
			];

			// Query all tables without limit to ensure proper global pagination
			const allResults = await Promise.all(
				allTables.map(async (table) => {
					const auditTable = this.getAuditTable(table);

					const clauses: SQL[] = [eq(auditTable.tableName, table)];

					if (recordId) clauses.push(eq(auditTable.recordId, recordId));
					if (operation) clauses.push(eq(auditTable.operation, operation));
					if (updatedById)
						clauses.push(eq(auditTable.updatedById, updatedById));
					if (startDate) clauses.push(gte(auditTable.updatedAt, startDate));
					if (endDate) clauses.push(lte(auditTable.updatedAt, endDate));

					const result = await (opts?.tx ?? this.db)
						.select()
						.from(auditTable)
						.where(and(...clauses));

					return result as unknown[] as AuditLog[];
				}),
			);

			// Combine and sort all results
			const combined = allResults.flat();
			combined.sort((a, b) => {
				const dateA = new Date(a.updatedAt).getTime();
				const dateB = new Date(b.updatedAt).getTime();
				return order === "desc" ? dateB - dateA : dateA - dateB;
			});

			// Apply pagination to combined results
			const totalRecords = combined.length;
			const totalPages = Math.ceil(totalRecords / limit);
			const offset = (page - 1) * limit;
			const paginated = combined.slice(offset, offset + limit);

			return { rows: paginated, totalPages };
		} catch (error) {
			log.error(
				{ error, filters },
				"[AuditRepository] Failed to list audit logs",
			);
			throw error;
		}
	}

	async getByRecordId(
		tableName: AllowedLoggedTable,
		recordId: string,
		opts?: PartialWithTx,
	): Promise<AuditLog[]> {
		try {
			const auditTable = this.getAuditTable(tableName);

			const result = await (opts?.tx ?? this.db)
				.select()
				.from(auditTable)
				.where(
					and(
						eq(auditTable.tableName, tableName),
						eq(auditTable.recordId, recordId),
					),
				)
				.orderBy(desc(auditTable.updatedAt));

			return result as unknown[] as AuditLog[];
		} catch (error) {
			log.error(
				{ error, tableName, recordId },
				"[AuditRepository] Failed to get audit logs by record ID",
			);
			throw error;
		}
	}
}

import type { AllowedLoggedTable } from "@/core/tables/common";
import type { ORPCContext, PartialWithTx } from "../interface";
import { tables } from "./db";

export interface AuditMetadata {
	ipAddress?: string;
	userAgent?: string;
	sessionId?: string;
	reason?: string;
}

export interface AuditLogEntry {
	tableName: AllowedLoggedTable;
	recordId: string;
	operation: "INSERT" | "UPDATE" | "DELETE";
	oldData: unknown | null;
	newData: unknown | null;
	updatedById: string;
	metadata?: AuditMetadata;
}

/**
 * Centralized audit logging service
 * Provides consistent audit trail across all features
 */
export class AuditService {
	/**
	 * Log a change to the audit log
	 * @param entry - The audit log entry
	 * @param opts - Optional transaction context
	 * @param context - ORPC context containing db service
	 */
	static async logChange(
		entry: AuditLogEntry,
		context: ORPCContext,
		opts?: PartialWithTx,
	): Promise<void> {
		const auditTable = AuditService.getAuditTable(entry.tableName);

		const auditEntry = {
			tableName: entry.tableName,
			recordId: entry.recordId,
			operation: entry.operation,
			oldData: entry.oldData,
			newData: entry.newData,
			updatedById: entry.updatedById,
			ipAddress: entry.metadata?.ipAddress,
			userAgent: entry.metadata?.userAgent,
			sessionId: entry.metadata?.sessionId,
			reason: entry.metadata?.reason,
			updatedAt: new Date(),
		};

		await (opts?.tx ?? context.svc.db)
			.insert(auditTable)
			.values(auditEntry as never);
	}

	/**
	 * Extract audit metadata from ORPC context
	 * @param context - ORPC context containing request information
	 * @returns Audit metadata object
	 */
	static extractMetadata(context: ORPCContext): AuditMetadata {
		const ipAddress =
			context.req.headers.get("x-forwarded-for") ||
			context.req.headers.get("x-real-ip") ||
			undefined;

		const userAgent = context.req.headers.get("user-agent") || undefined;

		return {
			ipAddress,
			userAgent,
			sessionId: context.token,
		};
	}

	/**
	 * Get the appropriate audit table for a given table name
	 * @param tableName - Name of the table being audited
	 * @returns Audit table reference
	 */
	private static getAuditTable(tableName: AllowedLoggedTable) {
		switch (tableName) {
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
}

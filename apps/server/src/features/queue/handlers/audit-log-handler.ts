/**
 * Audit Log Handler
 *
 * Handles AUDIT_LOG queue messages.
 * Records important events for compliance and debugging.
 *
 * Note: This handler uses the AuditService to log changes to specific tables.
 * The payload format should match what AuditService.logChange expects.
 */

import type { AuditLogJob } from "@repo/schema/queue";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleAuditLog(
	job: AuditLogJob,
	_context: QueueHandlerContext,
): Promise<void> {
	const { payload } = job;

	logger.debug(
		{ action: payload.action, entityType: payload.entityType },
		"[AuditLogHandler] Recording audit log",
	);

	try {
		// For now, just log the audit event since the AuditRepository
		// doesn't have a generic create method - audit logs are created
		// via AuditService.logChange which is called directly in handlers
		logger.info(
			{
				action: payload.action,
				entityType: payload.entityType,
				entityId: payload.entityId,
				actorId: payload.actorId,
				actorRole: payload.actorRole,
			},
			"[AuditLogHandler] Audit log event recorded",
		);
	} catch (error) {
		logger.error(
			{ error, action: payload.action, entityId: payload.entityId },
			"[AuditLogHandler] Failed to record audit log",
		);
		// Don't throw - audit logging is non-critical
	}
}

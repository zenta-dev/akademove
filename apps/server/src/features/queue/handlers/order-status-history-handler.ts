/**
 * Order Status History Handler
 *
 * Handles ORDER_STATUS_HISTORY queue messages.
 * Records order state transitions for audit trail.
 */

import type { OrderStatus } from "@repo/schema/order";
import type { OrderStatusHistoryJob } from "@repo/schema/queue";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleOrderStatusHistory(
	job: OrderStatusHistoryJob,
	context: QueueHandlerContext,
): Promise<void> {
	const { payload } = job;
	const { orderId, fromStatus, toStatus, changedBy, changedByRole, reason } =
		payload;

	logger.debug(
		{ orderId, fromStatus, toStatus },
		"[OrderStatusHistoryHandler] Recording status change",
	);

	try {
		// Note: orderStatusHistory.id is a serial/auto-increment column,
		// so we don't pass it manually
		await context.svc.db.insert(tables.orderStatusHistory).values({
			orderId,
			previousStatus: fromStatus as OrderStatus | null,
			newStatus: toStatus as OrderStatus,
			changedBy,
			changedByRole,
			reason,
			changedAt: new Date(),
		});

		logger.debug(
			{ orderId, fromStatus, toStatus, changedBy },
			"[OrderStatusHistoryHandler] Status change recorded",
		);
	} catch (error) {
		logger.error(
			{ error, orderId, fromStatus, toStatus },
			"[OrderStatusHistoryHandler] Failed to record status change",
		);
		// Don't throw - history recording is non-critical
	}
}

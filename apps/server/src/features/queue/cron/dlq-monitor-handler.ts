import type { ExecutionContext } from "@cloudflare/workers-types";
import { eq } from "drizzle-orm";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import { logger } from "@/utils/logger";

/**
 * DLQ message threshold for alerts
 * Alert admins when DLQ has this many or more messages
 */
const DLQ_ALERT_THRESHOLD = 1;

/**
 * DLQ Monitor Cron Handler
 * Schedule: Every hour (0 * * * *)
 *
 * Purpose:
 * - Monitor the Dead Letter Queue (DLQ) for failed messages
 * - Alert admin users when there are messages in the DLQ
 * - These messages represent failed operations that need investigation
 *
 * Messages end up in the DLQ when:
 * 1. Queue handlers fail after all retry attempts
 * 2. Message processing times out
 * 3. Unhandled exceptions in queue handlers
 *
 * Note: Cloudflare Queues do not have a direct API to count messages.
 * This cron relies on a dlq:message_count key being updated by queue handlers
 * when messages are moved to the DLQ.
 */
export async function handleDlqMonitorCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info({}, "[DlqMonitorCron] Starting DLQ monitoring check");

		const svc = getServices();
		const managers = getManagers();
		const repo = getRepositories(svc, managers);
		const now = new Date();

		// Try to get DLQ message count from KV
		// This key should be incremented by queue handlers when messages fail
		let dlqMessageCount = 0;
		try {
			const countData = await svc.kv.get<{ count: number }>(
				"dlq:message_count",
				{
					fallback: async () => ({ count: 0 }),
				},
			);
			dlqMessageCount = countData.count;
		} catch {
			// If key doesn't exist or fails, assume 0 messages
			logger.debug({}, "[DlqMonitorCron] No DLQ message count found in KV");
		}

		if (dlqMessageCount < DLQ_ALERT_THRESHOLD) {
			logger.info(
				{ dlqMessageCount },
				"[DlqMonitorCron] DLQ message count below threshold",
			);
			return new Response(
				"DLQ monitor completed. " +
					dlqMessageCount +
					" messages in DLQ (below threshold of " +
					DLQ_ALERT_THRESHOLD +
					").",
				{ status: 200 },
			);
		}

		logger.warn(
			{ dlqMessageCount, threshold: DLQ_ALERT_THRESHOLD },
			"[DlqMonitorCron] DLQ message count above threshold - alerting admins",
		);

		// Find admin users to notify
		const adminUsers = await svc.db.query.user.findMany({
			where: (f, _op) => eq(f.role, "ADMIN"),
			columns: {
				id: true,
				name: true,
				email: true,
			},
		});

		// Notify admin users about DLQ messages
		for (const admin of adminUsers) {
			try {
				await repo.notification.sendNotificationToUserId({
					fromUserId: admin.id, // System notification from self
					toUserId: admin.id,
					title: "DLQ Alert - Failed Messages Detected",
					body:
						"There are " +
						dlqMessageCount +
						" messages in the Dead Letter Queue that require investigation. Check the queue dashboard for details.",
					data: {
						type: "DLQ_ALERT",
						messageCount: dlqMessageCount.toString(),
						deeplink: "akademove://admin/monitoring/dlq",
					},
				});
			} catch (notifyError) {
				logger.warn(
					{ error: notifyError, adminId: admin.id },
					"[DlqMonitorCron] Failed to notify admin about DLQ messages",
				);
			}
		}

		logger.info(
			{
				dlqMessageCount,
				adminsNotified: adminUsers.length,
				duration: Date.now() - now.getTime(),
			},
			"[DlqMonitorCron] Completed DLQ monitoring check",
		);

		return new Response(
			"DLQ monitor completed. Alerted " +
				adminUsers.length +
				" admins about " +
				dlqMessageCount +
				" DLQ messages.",
			{ status: 200 },
		);
	} catch (error) {
		logger.error({ error }, "[DlqMonitorCron] Failed to monitor DLQ");
		return new Response("DLQ monitor failed", { status: 500 });
	}
}

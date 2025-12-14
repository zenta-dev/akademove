import type { ExecutionContext } from "@cloudflare/workers-types";
import { and, eq, lt } from "drizzle-orm";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Report escalation threshold in days
 * PENDING reports older than this will be escalated
 */
const ESCALATION_THRESHOLD_DAYS = 7;

/**
 * Report Escalation Cron Handler
 * Schedule: Every hour (0 * * * *)
 *
 * Purpose:
 * - Escalate PENDING reports that have not been handled in 7+ days
 * - Change status to INVESTIGATING to flag them for immediate attention
 * - Send notifications to admin users about escalated reports
 *
 * This ensures no reports are forgotten and all user concerns are addressed.
 */
export async function handleReportEscalationCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info({}, "[ReportEscalationCron] Starting report escalation check");

		const svc = getServices();
		const managers = getManagers();
		const repo = getRepositories(svc, managers);
		const now = new Date();
		let escalatedCount = 0;

		// Calculate the escalation threshold date
		const escalationThreshold = new Date(
			now.getTime() - ESCALATION_THRESHOLD_DAYS * 24 * 60 * 60 * 1000,
		);

		// Find PENDING reports older than the threshold
		const oldPendingReports = await svc.db.query.report.findMany({
			where: (f, _op) =>
				and(eq(f.status, "PENDING"), lt(f.reportedAt, escalationThreshold)),
			columns: {
				id: true,
				reporterId: true,
				targetUserId: true,
				category: true,
				description: true,
				reportedAt: true,
			},
			with: {
				reporter: {
					columns: {
						id: true,
						name: true,
						email: true,
					},
				},
			},
			limit: 100, // Process up to 100 reports per cron run
		});

		if (oldPendingReports.length === 0) {
			logger.info({}, "[ReportEscalationCron] No reports to escalate");
			return new Response(
				"Report escalation check completed. No reports to escalate.",
				{ status: 200 },
			);
		}

		logger.info(
			{ count: oldPendingReports.length, escalationThreshold },
			"[ReportEscalationCron] Found reports to escalate",
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

		// Escalate reports
		for (const report of oldPendingReports) {
			try {
				await svc.db.transaction(async (tx) => {
					await tx
						.update(tables.report)
						.set({ status: "INVESTIGATING" })
						.where(eq(tables.report.id, report.id));
				});

				escalatedCount++;

				// Notify admin users about the escalated report
				for (const admin of adminUsers) {
					try {
						await repo.notification.sendNotificationToUserId({
							fromUserId: report.reporterId,
							toUserId: admin.id,
							title: "Report Escalated - Needs Attention",
							body: `Report #${report.id.slice(0, 8)} (${report.category}) has been pending for ${ESCALATION_THRESHOLD_DAYS}+ days and requires immediate attention.`,
							data: {
								type: "REPORT_ESCALATED",
								reportId: report.id,
								deeplink: `akademove://admin/reports/${report.id}`,
							},
						});
					} catch (notifyError) {
						logger.warn(
							{ error: notifyError, adminId: admin.id, reportId: report.id },
							"[ReportEscalationCron] Failed to notify admin about escalated report",
						);
					}
				}

				logger.info(
					{
						reportId: report.id,
						category: report.category,
						reportedAt: report.reportedAt,
						daysOld: Math.round(
							(now.getTime() - report.reportedAt.getTime()) /
								(24 * 60 * 60 * 1000),
						),
					},
					"[ReportEscalationCron] Escalated report",
				);
			} catch (error) {
				logger.error(
					{ error, reportId: report.id },
					"[ReportEscalationCron] Failed to escalate report",
				);
			}
		}

		logger.info(
			{
				escalatedCount,
				totalPending: oldPendingReports.length,
				adminsNotified: adminUsers.length,
				duration: Date.now() - now.getTime(),
			},
			"[ReportEscalationCron] Completed report escalation check",
		);

		return new Response(
			`Report escalation completed. Escalated ${escalatedCount} reports.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error },
			"[ReportEscalationCron] Failed to escalate reports",
		);
		return new Response("Report escalation failed", { status: 500 });
	}
}

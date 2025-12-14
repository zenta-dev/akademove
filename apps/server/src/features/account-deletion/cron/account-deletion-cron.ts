import type { ExecutionContext } from "@cloudflare/workers-types";
import { and, eq, isNotNull, lt } from "drizzle-orm";
import { getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Grace period in days before approved account deletions are processed
 * Users have this many days to reconsider after approval before deletion is completed
 */
const DELETION_GRACE_PERIOD_DAYS = 7;

/**
 * Account Deletion Processing Cron Handler
 * Schedule: Daily at 2 AM (0 2 * * *)
 *
 * Purpose:
 * - Process APPROVED account deletion requests after the grace period
 * - Delete user accounts and associated data for requests approved more than 7 days ago
 * - Mark deletion requests as COMPLETED
 *
 * This ensures users have time to reconsider, and approved deletions are processed automatically.
 */
export async function handleAccountDeletionCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info(
			{},
			"[AccountDeletionCron] Starting account deletion processing",
		);

		const svc = getServices();
		const now = new Date();
		let processedCount = 0;
		let errorCount = 0;

		// Calculate the cutoff date (grace period days ago)
		const cutoffDate = new Date(
			now.getTime() - DELETION_GRACE_PERIOD_DAYS * 24 * 60 * 60 * 1000,
		);

		// Find APPROVED deletion requests that have passed the grace period
		const pendingDeletions = await svc.db.query.accountDeletion.findMany({
			where: (f, _op) =>
				and(
					eq(f.status, "APPROVED"),
					isNotNull(f.reviewedAt),
					lt(f.reviewedAt, cutoffDate),
				),
			columns: {
				id: true,
				userId: true,
				email: true,
				fullName: true,
				accountType: true,
				reviewedAt: true,
			},
			limit: 50, // Process up to 50 deletions per cron run
		});

		if (pendingDeletions.length === 0) {
			logger.info(
				{},
				"[AccountDeletionCron] No pending account deletions to process",
			);
			return new Response(
				"Account deletion processing completed. No pending deletions.",
				{ status: 200 },
			);
		}

		logger.info(
			{ count: pendingDeletions.length, cutoffDate },
			"[AccountDeletionCron] Found approved deletions to process",
		);

		for (const deletion of pendingDeletions) {
			try {
				await svc.db.transaction(async (tx) => {
					// Delete the user if they still exist
					// Note: The cascade on the user table should clean up related data
					if (deletion.userId) {
						await tx
							.delete(tables.user)
							.where(eq(tables.user.id, deletion.userId));

						logger.info(
							{
								deletionId: deletion.id,
								userId: deletion.userId,
								email: deletion.email,
								accountType: deletion.accountType,
							},
							"[AccountDeletionCron] Deleted user account",
						);
					}

					// Mark the deletion request as completed
					await tx
						.update(tables.accountDeletion)
						.set({
							status: "COMPLETED",
							completedAt: now,
						})
						.where(eq(tables.accountDeletion.id, deletion.id));

					processedCount++;

					logger.info(
						{
							deletionId: deletion.id,
							email: deletion.email,
							fullName: deletion.fullName,
							accountType: deletion.accountType,
						},
						"[AccountDeletionCron] Completed account deletion request",
					);
				});
			} catch (error) {
				errorCount++;
				logger.error(
					{ error, deletionId: deletion.id, userId: deletion.userId },
					"[AccountDeletionCron] Failed to process account deletion",
				);
			}
		}

		logger.info(
			{
				processedCount,
				errorCount,
				totalPending: pendingDeletions.length,
				duration: Date.now() - now.getTime(),
			},
			"[AccountDeletionCron] Completed account deletion processing",
		);

		return new Response(
			`Account deletion processing completed. Processed ${processedCount} deletions, ${errorCount} errors.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error },
			"[AccountDeletionCron] Failed to process account deletions",
		);
		return new Response("Account deletion processing failed", { status: 500 });
	}
}

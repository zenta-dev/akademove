import type { ExecutionContext } from "@cloudflare/workers-types";
import { and, eq, isNotNull, lt } from "drizzle-orm";
import { getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Payment Expiry Cron Handler
 * Schedule: Every hour (0 * * * *)
 *
 * Purpose:
 * - Mark PENDING payments as EXPIRED when their `expiresAt` timestamp has passed
 * - This ensures stale payment attempts are cleaned up properly
 *
 * This handles cases where:
 * 1. User abandons payment flow
 * 2. VA/QRIS payment expires without completion
 * 3. Payment gateway doesn't send webhook for expired payments
 */
export async function handlePaymentExpiryCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info({}, "[PaymentExpiryCron] Starting expired payment cleanup");

		const svc = getServices();
		const now = new Date();
		let expiredCount = 0;

		// Find and mark expired payments in a single transaction
		await svc.db.transaction(async (tx) => {
			// Find PENDING payments that have expired
			const expiredPayments = await tx.query.payment.findMany({
				where: (f, op) =>
					and(
						eq(f.status, "PENDING"),
						isNotNull(f.expiresAt),
						lt(f.expiresAt, now),
					),
				columns: {
					id: true,
					transactionId: true,
					amount: true,
					method: true,
					expiresAt: true,
				},
				limit: 200, // Process up to 200 payments per cron run
			});

			if (expiredPayments.length === 0) {
				logger.info({}, "[PaymentExpiryCron] No expired payments found");
				return;
			}

			logger.info(
				{ count: expiredPayments.length },
				"[PaymentExpiryCron] Found expired payments to mark",
			);

			// Mark expired payments
			for (const payment of expiredPayments) {
				try {
					await tx
						.update(tables.payment)
						.set({ status: "EXPIRED" })
						.where(eq(tables.payment.id, payment.id));

					expiredCount++;

					logger.info(
						{
							paymentId: payment.id,
							transactionId: payment.transactionId,
							amount: payment.amount,
							method: payment.method,
							expiresAt: payment.expiresAt,
						},
						"[PaymentExpiryCron] Marked payment as expired",
					);
				} catch (error) {
					logger.error(
						{ error, paymentId: payment.id },
						"[PaymentExpiryCron] Failed to mark payment as expired",
					);
				}
			}
		});

		logger.info(
			{ expiredCount, duration: Date.now() - now.getTime() },
			"[PaymentExpiryCron] Completed expired payment cleanup",
		);

		return new Response(
			`Payment expiry cleanup completed. Marked ${expiredCount} payments as expired.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error },
			"[PaymentExpiryCron] Failed to mark expired payments",
		);
		return new Response("Payment expiry cleanup failed", { status: 500 });
	}
}

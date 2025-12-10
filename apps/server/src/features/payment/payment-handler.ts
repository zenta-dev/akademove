import { env } from "cloudflare:workers";
import { createHash } from "node:crypto";
import { m } from "@repo/i18n";
import { RepositoryError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import type { PayoutStatus } from "@/core/services/payment";
import { OrderQueueService } from "@/core/services/queue";
import { logger } from "@/utils/logger";
import { PaymentSpec } from "./payment-spec";

const { pub } = createORPCRouter(PaymentSpec);

/**
 * Verify Midtrans webhook signature to prevent fake webhook attacks
 * @see https://docs.midtrans.com/docs/http-notification-webhooks#verifying-notification-authenticity
 */
function verifyMidtransSignature(payload: {
	order_id: string;
	status_code: string;
	gross_amount: string;
	signature_key: string;
}): boolean {
	const serverKey = env.MIDTRANS_SERVER_KEY;
	if (!serverKey) {
		logger.error("MIDTRANS_SERVER_KEY not configured");
		return false;
	}

	const { order_id, status_code, gross_amount, signature_key } = payload;

	// Construct signature string: SHA512(order_id+status_code+gross_amount+ServerKey)
	const signatureString = `${order_id}${status_code}${gross_amount}${serverKey}`;
	const calculatedSignature = createHash("sha512")
		.update(signatureString)
		.digest("hex");

	const isValid = calculatedSignature === signature_key;

	if (!isValid) {
		logger.warn(
			{
				received: signature_key,
				calculated: calculatedSignature,
				order_id,
			},
			"[PaymentHandler] Invalid Midtrans webhook signature",
		);
	}

	return isValid;
}

/**
 * Map Midtrans Iris payout status to our internal PayoutStatus
 * @see https://iris-docs.midtrans.com/#payout-status
 */
function mapIrisPayoutStatus(status: string): PayoutStatus {
	const statusLower = status.toLowerCase();
	switch (statusLower) {
		case "queued":
			return "queued";
		case "processed":
		case "processing":
			return "processed";
		case "completed":
		case "done":
			return "completed";
		case "failed":
		case "rejected":
		case "error":
			return "failed";
		default:
			logger.warn(
				{ status },
				"[PaymentHandler] Unknown Iris payout status, defaulting to queued",
			);
			return "queued";
	}
}

/**
 * Map Iris payout status to transaction status
 */
function mapPayoutStatusToTransactionStatus(
	payoutStatus: PayoutStatus,
): "PENDING" | "SUCCESS" | "FAILED" {
	switch (payoutStatus) {
		case "completed":
			return "SUCCESS";
		case "failed":
			return "FAILED";
		default:
			return "PENDING";
	}
}

export const PaymentHandler = pub.router({
	webhookMidtrans: pub.webhookMidtrans.handler(async ({ input: { body } }) => {
		// CRITICAL: Verify webhook signature before processing
		const isValidSignature = verifyMidtransSignature({
			order_id: body.order_id,
			status_code: body.status_code,
			gross_amount: body.gross_amount,
			signature_key: body.signature_key,
		});

		if (!isValidSignature) {
			throw new RepositoryError(
				"Invalid webhook signature - potential security breach",
				{ code: "UNAUTHORIZED" },
			);
		}

		// Enqueue webhook for async processing
		// This allows fast response to Midtrans while processing happens in background
		await OrderQueueService.enqueuePaymentWebhook({
			webhookBody: body,
			provider: "MIDTRANS",
			receivedAt: new Date(),
		});

		logger.info(
			{ orderId: body.order_id, status: body.transaction_status },
			"[PaymentHandler] Payment webhook enqueued for processing",
		);

		return {
			status: 200,
			body: { message: m.server_webhook_processed(), data: null },
		};
	}),

	/**
	 * Webhook handler for Midtrans Iris payout/disbursement status updates
	 * This is called by Midtrans when a withdrawal payout status changes
	 *
	 * @see https://iris-docs.midtrans.com/#notification
	 */
	webhookMidtransPayout: pub.webhookMidtransPayout.handler(
		async ({ context, input: { body } }) => {
			// Extract payout notification data
			// Iris webhook payload structure is different from Core API
			const referenceNo = body.reference_no as string | undefined;
			const status = body.status as string | undefined;
			const amount = body.amount as string | undefined;
			const beneficiaryName = body.beneficiary_name as string | undefined;
			const beneficiaryBank = body.beneficiary_bank as string | undefined;
			const errorMessage = body.error_message as string | undefined;

			if (!referenceNo || !status) {
				logger.warn(
					{ body },
					"[PaymentHandler] Invalid Iris payout webhook - missing reference_no or status",
				);
				throw new RepositoryError("Invalid webhook payload", {
					code: "BAD_REQUEST",
				});
			}

			logger.info(
				{
					referenceNo,
					status,
					amount,
					beneficiaryName,
					beneficiaryBank,
				},
				"[PaymentHandler] Received Iris payout webhook",
			);

			// Map Iris status to our internal status
			const payoutStatus = mapIrisPayoutStatus(status);
			const transactionStatus =
				mapPayoutStatusToTransactionStatus(payoutStatus);

			// Update the transaction status in database
			// The reference_no is our transaction ID
			await context.svc.db.transaction(async (tx) => {
				const opts = { tx };

				// Find the transaction by ID (reference_no is our transaction ID)
				const transaction = await context.repo.transaction.get(
					referenceNo,
					opts,
				);

				if (!transaction) {
					logger.warn(
						{ referenceNo },
						"[PaymentHandler] Payout webhook - transaction not found",
					);
					// Don't throw error - Midtrans might retry
					return;
				}

				// Only process if transaction is still pending
				if (transaction.status !== "PENDING") {
					logger.info(
						{ referenceNo, currentStatus: transaction.status },
						"[PaymentHandler] Payout webhook - transaction already processed",
					);
					return;
				}

				// If payout failed, refund the balance back to user's wallet
				if (transactionStatus === "FAILED") {
					await context.repo.wallet.atomicAdd(
						{
							walletId: transaction.walletId,
							amount: transaction.amount,
						},
						opts,
					);

					logger.info(
						{
							referenceNo,
							walletId: transaction.walletId,
							amount: transaction.amount,
						},
						"[PaymentHandler] Payout failed - refunded balance to wallet",
					);
				}

				// Update transaction status and metadata
				await context.repo.transaction.update(
					referenceNo,
					{
						status: transactionStatus,
						metadata: {
							...(transaction.metadata as Record<string, unknown>),
							payoutStatus,
							payoutErrorMessage: errorMessage,
							payoutWebhookReceivedAt: new Date().toISOString(),
						},
					},
					opts,
				);

				logger.info(
					{
						referenceNo,
						oldStatus: transaction.status,
						newStatus: transactionStatus,
						payoutStatus,
					},
					"[PaymentHandler] Payout webhook - transaction status updated",
				);

				// TODO: Send push notification to user about withdrawal status
				// await context.repo.notification.sendWithdrawalStatusNotification(...)
			});

			return {
				status: 200,
				body: { message: m.server_webhook_processed(), data: null },
			};
		},
	),
});

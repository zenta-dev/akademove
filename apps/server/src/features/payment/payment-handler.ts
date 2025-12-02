import { env } from "cloudflare:workers";
import { createHash } from "node:crypto";
import { m } from "@repo/i18n";
import { RepositoryError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import { log } from "@/utils";
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
		log.error("MIDTRANS_SERVER_KEY not configured");
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
		log.warn(
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

export const PaymentHandler = pub.router({
	webhookMidtrans: pub.webhookMidtrans.handler(
		async ({ context, input: { body } }) => {
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

			return await context.svc.db.transaction(async (tx) => {
				await context.repo.payment.handleWebhookMidtrans({
					body,
					tx,
				});

				return {
					status: 200,
					body: { message: m.server_webhook_processed(), data: null },
				};
			});
		},
	),
});

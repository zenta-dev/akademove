import { createORPCRouter } from "@/core/router/orpc";
import { PaymentSpec } from "./payment-spec";

const { pub } = createORPCRouter(PaymentSpec);

export const PaymentHandler = pub.router({
	webhookMidtrans: pub.webhookMidtrans.handler(
		async ({ context, input: { body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				await context.repo.payment.handleWebhookMidtrans({
					body,
					tx,
				});

				return {
					status: 200,
					body: { message: "Get wallet success", data: null },
				};
			});
		},
	),
});

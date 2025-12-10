import { oc } from "@orpc/contract";
import { EmptySchema } from "@repo/schema/common";
import { WebhookRequestSchema } from "@repo/schema/payment";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const PaymentSpec = {
	webhookMidtrans: oc
		.route({
			tags: [FEATURE_TAGS.PAYMENT],
			method: "POST",
			path: "/webhook/midtrans",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: WebhookRequestSchema,
			}),
		)
		.output(
			createSuccesSchema(EmptySchema, "Successfully retrieved users data"),
		),
	webhookMidtransPayout: oc
		.route({
			tags: [FEATURE_TAGS.PAYMENT],
			method: "POST",
			path: "/webhook/midtrans/payout",
			summary: "Midtrans Iris Payout Webhook",
			description:
				"Webhook endpoint for Midtrans Iris payout/disbursement status updates",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: WebhookRequestSchema,
			}),
		)
		.output(
			createSuccesSchema(EmptySchema, "Payout webhook processed successfully"),
		),
};

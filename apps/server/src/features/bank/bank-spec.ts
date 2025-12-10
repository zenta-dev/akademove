import { oc } from "@orpc/contract";
import {
	BankValidationRequestSchema,
	BankValidationResponseSchema,
} from "@repo/schema/payment";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const BankSpec = {
	validateAccount: oc
		.route({
			tags: [FEATURE_TAGS.PAYMENT],
			method: "POST",
			path: "/validate",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description:
				"Validate a bank account using Midtrans Iris API. Returns account holder name if valid.",
		})
		.input(
			z.object({
				body: BankValidationRequestSchema,
			}),
		)
		.output(
			createSuccesSchema(
				BankValidationResponseSchema,
				"Bank account validation result",
			),
		),
};

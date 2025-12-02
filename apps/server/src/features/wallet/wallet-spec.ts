import { oc } from "@orpc/contract";
import {
	PaymentSchema,
	PayRequestSchema,
	TopUpRequestSchema,
	TransferRequestSchema,
	WithdrawRequestSchema,
} from "@repo/schema/payment";
import {
	WalletMonthlySummaryQuerySchema,
	WalletMonthlySummaryResponseSchema,
	WalletSchema,
} from "@repo/schema/wallet";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const WalletSpec = {
	get: oc
		.route({
			tags: [FEATURE_TAGS.WALLET],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object())
		.output(
			createSuccesSchema(WalletSchema, "Successfully retrieved users data"),
		),
	getMonthlySummary: oc
		.route({
			tags: [FEATURE_TAGS.WALLET],
			method: "GET",
			path: "/summary",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: WalletMonthlySummaryQuerySchema }))
		.output(
			createSuccesSchema(
				WalletMonthlySummaryResponseSchema,
				"Successfully retrieved users data",
			),
		),
	topUp: oc
		.route({
			tags: [FEATURE_TAGS.WALLET],
			method: "POST",
			path: "/topup",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: TopUpRequestSchema,
			}),
		)
		.output(
			createSuccesSchema(PaymentSchema, "Successfully retrieved users data"),
		),
	pay: oc
		.route({
			tags: [FEATURE_TAGS.WALLET],
			method: "POST",
			path: "/pay",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: PayRequestSchema,
			}),
		)
		.output(
			createSuccesSchema(PaymentSchema, "Successfully retrieved users data"),
		),
	transfer: oc
		.route({
			tags: [FEATURE_TAGS.WALLET],
			method: "POST",
			path: "/transfer",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: TransferRequestSchema,
			}),
		)
		.output(
			createSuccesSchema(PaymentSchema, "Successfully retrieved users data"),
		),
	withdraw: oc
		.route({
			tags: [FEATURE_TAGS.WALLET],
			method: "POST",
			path: "/withdraw",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: WithdrawRequestSchema,
			}),
		)
		.output(createSuccesSchema(PaymentSchema, "Withdrawal request submitted")),
};

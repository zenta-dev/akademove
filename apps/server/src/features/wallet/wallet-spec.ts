import { oc } from "@orpc/contract";
import {
	PaymentSchema,
	PayRequestSchema,
	SavedBankAccountSchema,
	TopUpRequestSchema,
	TransferRequestSchema,
	TransferResponseSchema,
	WithdrawRequestSchema,
} from "@repo/schema/payment";
import {
	CommissionReportQuerySchema,
	CommissionReportResponseSchema,
	WalletMonthlySummaryQuerySchema,
	WalletMonthlySummaryResponseSchema,
	WalletSchema,
} from "@repo/schema/wallet";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const WalletSpec = {
	get: oc
		.route({
			tags: [FEATURE_TAGS.wallet],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object())
		.output(
			createSuccesSchema(WalletSchema, "Successfully retrieved wallet data"),
		),
	getMonthlySummary: oc
		.route({
			tags: [FEATURE_TAGS.wallet],
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
			tags: [FEATURE_TAGS.wallet],
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
			tags: [FEATURE_TAGS.wallet],
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
			tags: [FEATURE_TAGS.wallet],
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
			createSuccesSchema(
				TransferResponseSchema,
				"Transfer completed successfully",
			),
		),
	withdraw: oc
		.route({
			tags: [FEATURE_TAGS.wallet],
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
	getSavedBankAccount: oc
		.route({
			tags: [FEATURE_TAGS.wallet],
			method: "GET",
			path: "/bank",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description:
				"Get saved bank account details from driver/merchant profile for pre-filling withdrawal forms",
		})
		.input(z.object())
		.output(
			createSuccesSchema(
				SavedBankAccountSchema,
				"Successfully retrieved saved bank account",
			),
		),
	getCommissionReport: oc
		.route({
			tags: [FEATURE_TAGS.wallet],
			method: "GET",
			path: "/commission-report",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description:
				"Get commission report for drivers with balance summary, chart data, and transaction history",
		})
		.input(z.object({ query: CommissionReportQuerySchema }))
		.output(
			createSuccesSchema(
				CommissionReportResponseSchema,
				"Successfully retrieved commission report",
			),
		),
};

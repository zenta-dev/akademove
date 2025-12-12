import { oc } from "@orpc/contract";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import {
	PaymentSchema,
	SavedBankAccountSchema,
	TopUpRequestSchema,
	TransferRequestSchema,
	TransferResponseSchema,
	WithdrawRequestSchema,
} from "@repo/schema/payment";
import { TransactionSchema } from "@repo/schema/transaction";
import {
	WalletMonthlySummaryQuerySchema,
	WalletMonthlySummaryResponseSchema,
	WalletSchema,
} from "@repo/schema/wallet";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const MerchantWalletSpec = {
	getWallet: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT, FEATURE_TAGS.wallet],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Get merchant wallet by merchant ID",
		})
		.input(z.object({ params: z.object({ merchantId: z.string() }) }))
		.output(
			createSuccesSchema(
				WalletSchema,
				"Successfully retrieved merchant wallet",
			),
		),
	getMonthlySummary: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT, FEATURE_TAGS.wallet],
			method: "GET",
			path: "/summary",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Get merchant wallet monthly summary",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
				query: WalletMonthlySummaryQuerySchema,
			}),
		)
		.output(
			createSuccesSchema(
				WalletMonthlySummaryResponseSchema,
				"Successfully retrieved merchant wallet summary",
			),
		),
	getTransactions: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT, FEATURE_TAGS.wallet],
			method: "GET",
			path: "/transactions",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Get merchant wallet transactions",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
				query: UnifiedPaginationQuerySchema,
			}),
		)
		.output(
			createSuccesSchema(
				z.array(TransactionSchema),
				"Successfully retrieved merchant transactions",
			),
		),
	topUp: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT, FEATURE_TAGS.wallet],
			method: "POST",
			path: "/topup",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Top up merchant wallet",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
				body: TopUpRequestSchema,
			}),
		)
		.output(
			createSuccesSchema(
				PaymentSchema,
				"Successfully initiated merchant top up",
			),
		),
	transfer: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT, FEATURE_TAGS.wallet],
			method: "POST",
			path: "/transfer",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Transfer from merchant wallet to another user",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
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
			tags: [FEATURE_TAGS.MERCHANT, FEATURE_TAGS.wallet],
			method: "POST",
			path: "/withdraw",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Withdraw from merchant wallet to bank account",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
				body: WithdrawRequestSchema,
			}),
		)
		.output(createSuccesSchema(PaymentSchema, "Withdrawal request submitted")),
	getSavedBankAccount: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT, FEATURE_TAGS.wallet],
			method: "GET",
			path: "/bank",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description:
				"Get saved bank account details from merchant profile for pre-filling withdrawal forms",
		})
		.input(z.object({ params: z.object({ merchantId: z.string() }) }))
		.output(
			createSuccesSchema(
				SavedBankAccountSchema,
				"Successfully retrieved saved bank account",
			),
		),
};

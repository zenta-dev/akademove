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

export const DriverWalletSpec = {
	getWallet: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER, FEATURE_TAGS.wallet],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Get driver wallet by driver ID",
		})
		.input(z.object({ params: z.object({ driverId: z.string() }) }))
		.output(
			createSuccesSchema(WalletSchema, "Successfully retrieved driver wallet"),
		),
	getMonthlySummary: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER, FEATURE_TAGS.wallet],
			method: "GET",
			path: "/summary",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Get driver wallet monthly summary",
		})
		.input(
			z.object({
				params: z.object({ driverId: z.string() }),
				query: WalletMonthlySummaryQuerySchema,
			}),
		)
		.output(
			createSuccesSchema(
				WalletMonthlySummaryResponseSchema,
				"Successfully retrieved driver wallet summary",
			),
		),
	getTransactions: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER, FEATURE_TAGS.wallet],
			method: "GET",
			path: "/transactions",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Get driver wallet transactions",
		})
		.input(
			z.object({
				params: z.object({ driverId: z.string() }),
				query: UnifiedPaginationQuerySchema,
			}),
		)
		.output(
			createSuccesSchema(
				z.array(TransactionSchema),
				"Successfully retrieved driver transactions",
			),
		),
	topUp: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER, FEATURE_TAGS.wallet],
			method: "POST",
			path: "/topup",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Top up driver wallet",
		})
		.input(
			z.object({
				params: z.object({ driverId: z.string() }),
				body: TopUpRequestSchema,
			}),
		)
		.output(
			createSuccesSchema(PaymentSchema, "Successfully initiated driver top up"),
		),
	transfer: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER, FEATURE_TAGS.wallet],
			method: "POST",
			path: "/transfer",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Transfer from driver wallet to another user",
		})
		.input(
			z.object({
				params: z.object({ driverId: z.string() }),
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
			tags: [FEATURE_TAGS.DRIVER, FEATURE_TAGS.wallet],
			method: "POST",
			path: "/withdraw",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description: "Withdraw from driver wallet to bank account",
		})
		.input(
			z.object({
				params: z.object({ driverId: z.string() }),
				body: WithdrawRequestSchema,
			}),
		)
		.output(createSuccesSchema(PaymentSchema, "Withdrawal request submitted")),
	getSavedBankAccount: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER, FEATURE_TAGS.wallet],
			method: "GET",
			path: "/bank",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description:
				"Get saved bank account details from driver profile for pre-filling withdrawal forms",
		})
		.input(z.object({ params: z.object({ driverId: z.string() }) }))
		.output(
			createSuccesSchema(
				SavedBankAccountSchema,
				"Successfully retrieved saved bank account",
			),
		),
};

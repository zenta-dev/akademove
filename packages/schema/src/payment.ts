import * as z from "zod";
import {
	BankProviderSchema,
	DateSchema,
	type SchemaRegistries,
} from "./common.js";
import { PAYMENT_METHOD, PAYMENT_PROVIDER } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";
import { TransactionStatusSchema } from "./transaction.js";

export const PaymentProviderSchema = z.enum(PAYMENT_PROVIDER);
export type PaymentProvider = z.infer<typeof PaymentProviderSchema>;

export const PaymentMethodSchema = z.enum(PAYMENT_METHOD);
export type PaymentMethod = z.infer<typeof PaymentMethodSchema>;

export const VANumberSchema = z.object({
	bank: z.string(),
	va_number: z.string(),
});
export type VANumber = z.infer<typeof VANumberSchema>;

export const PaymentSchema = z.object({
	id: z.uuid(),
	transactionId: z.uuid(),
	provider: PaymentProviderSchema,
	method: PaymentMethodSchema,
	bankProvider: BankProviderSchema.optional(),
	amount: z.coerce.number(),
	status: TransactionStatusSchema,
	externalId: z.string().optional(),
	paymentUrl: z.string().optional(),
	va_number: VANumberSchema.optional(),
	metadata: z.any().optional(),
	expiresAt: DateSchema.optional(),
	payload: z.any().optional(),
	response: z.any().optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Payment = z.infer<typeof PaymentSchema>;

export const PaymentKeySchema = extractSchemaKeysAsEnum(PaymentSchema);

export const InsertPaymentSchema = PaymentSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
});
export type InsertPayment = z.infer<typeof InsertPaymentSchema>;

export const UpdatePaymentSchema = PaymentSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
}).partial();
export type UpdatePayment = z.infer<typeof UpdatePaymentSchema>;

export const TopUpRequestSchema = PaymentSchema.pick({
	amount: true,
	provider: true,
}).safeExtend({ method: PaymentMethodSchema.exclude(["wallet"]) });
export type TopUpRequest = z.infer<typeof TopUpRequestSchema>;

export const PayRequestSchema = PaymentSchema.pick({
	amount: true,
}).safeExtend({ referenceId: z.string().optional() });
export type PayRequest = z.infer<typeof PayRequestSchema>;

export const TransferRequestSchema = PaymentSchema.pick({
	amount: true,
}).safeExtend({
	recipientUserId: z.string().describe("The user ID of the recipient"),
	note: z.string().optional().describe("Optional note for the transfer"),
});
export type TransferRequest = z.infer<typeof TransferRequestSchema>;

export const TransferResponseSchema = z.object({
	transactionId: z.string(),
	amount: z.coerce.number(),
	status: TransactionStatusSchema,
	recipientName: z.string(),
	recipientUserId: z.string(),
	note: z.string().optional(),
	createdAt: DateSchema,
});
export type TransferResponse = z.infer<typeof TransferResponseSchema>;

export const WithdrawRequestSchema = z.object({
	amount: z.coerce.number().positive(),
	bankProvider: BankProviderSchema,
	accountNumber: z.string(),
	accountName: z.string().optional(),
	/** If true, save bank details to user's driver/merchant profile for future use */
	saveBank: z.boolean().optional(),
});
export type WithdrawRequest = z.infer<typeof WithdrawRequestSchema>;

/**
 * Payout status from Midtrans Iris
 * @see https://iris-docs.midtrans.com/#payout-status
 */
export const PayoutStatusSchema = z.enum([
	"queued",
	"processed",
	"completed",
	"failed",
]);
export type PayoutStatus = z.infer<typeof PayoutStatusSchema>;

/**
 * Withdrawal response schema
 * Returned after initiating a withdrawal to bank account
 */
export const WithdrawResponseSchema = z.object({
	id: z.string().uuid(),
	transactionId: z.string().uuid(),
	provider: PaymentProviderSchema,
	method: PaymentMethodSchema,
	amount: z.coerce.number(),
	status: TransactionStatusSchema,
	bankProvider: BankProviderSchema,
	payoutReferenceNo: z.string().optional(),
	payoutStatus: PayoutStatusSchema.optional(),
	metadata: z.record(z.string(), z.unknown()).optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type WithdrawResponse = z.infer<typeof WithdrawResponseSchema>;

export const WebhookRequestSchema = z.record(z.string(), z.any());
export type WebhookRequest = z.infer<typeof WebhookRequestSchema>;

// Bank Account Validation Schemas (for Midtrans Iris API)
export const BankValidationRequestSchema = z.object({
	bankProvider: BankProviderSchema,
	accountNumber: z.string().min(5).max(20),
});
export type BankValidationRequest = z.infer<typeof BankValidationRequestSchema>;

export const BankValidationResponseSchema = z.object({
	isValid: z.boolean(),
	accountName: z.string().nullable(),
	bankCode: z.string(),
	accountNumber: z.string(),
});
export type BankValidationResponse = z.infer<
	typeof BankValidationResponseSchema
>;

// Saved Bank Account Schema (for pre-filling withdrawal forms)
export const SavedBankAccountSchema = z.object({
	hasSavedBank: z.boolean(),
	bankProvider: BankProviderSchema.optional(),
	accountNumber: z.string().optional(),
	accountName: z.string().optional(),
});
export type SavedBankAccount = z.infer<typeof SavedBankAccountSchema>;

export const PaymentSchemaRegistries = {
	PaymentProvider: { schema: PaymentProviderSchema, strategy: "output" },
	PaymentMethod: { schema: PaymentMethodSchema, strategy: "output" },
	VANumber: { schema: VANumberSchema, strategy: "output" },
	Payment: { schema: PaymentSchema, strategy: "output" },
	InsertPayment: { schema: InsertPaymentSchema, strategy: "input" },
	UpdatePayment: { schema: UpdatePaymentSchema, strategy: "input" },
	TopUpRequest: { schema: TopUpRequestSchema, strategy: "input" },
	PayRequest: { schema: PayRequestSchema, strategy: "input" },
	TransferRequest: { schema: TransferRequestSchema, strategy: "input" },
	TransferResponse: { schema: TransferResponseSchema, strategy: "output" },
	WithdrawRequest: { schema: WithdrawRequestSchema, strategy: "input" },
	WithdrawResponse: { schema: WithdrawResponseSchema, strategy: "output" },
	PayoutStatus: { schema: PayoutStatusSchema, strategy: "output" },
	WebhookRequest: { schema: WebhookRequestSchema, strategy: "input" },
	PaymentKey: { schema: PaymentKeySchema, strategy: "input" },
	BankValidationRequest: {
		schema: BankValidationRequestSchema,
		strategy: "input",
	},
	BankValidationResponse: {
		schema: BankValidationResponseSchema,
		strategy: "output",
	},
	SavedBankAccount: {
		schema: SavedBankAccountSchema,
		strategy: "output",
	},
} satisfies SchemaRegistries;

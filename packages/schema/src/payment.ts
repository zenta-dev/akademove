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
	amount: z.number(),
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
}).safeExtend({ walletId: z.uuid() });
export type TransferRequest = z.infer<typeof TransferRequestSchema>;

export const WithdrawRequestSchema = z.object({
	amount: z.number().positive(),
	bankProvider: BankProviderSchema,
	accountNumber: z.string(),
	accountName: z.string().optional(),
});
export type WithdrawRequest = z.infer<typeof WithdrawRequestSchema>;

export const WebhookRequestSchema = z.record(z.string(), z.any());
export type WebhookRequest = z.infer<typeof WebhookRequestSchema>;

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
	WithdrawRequest: { schema: WithdrawRequestSchema, strategy: "input" },
	WebhookRequest: { schema: WebhookRequestSchema, strategy: "input" },
	PaymentKey: { schema: PaymentKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

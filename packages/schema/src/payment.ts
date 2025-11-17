import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.ts";
import { PAYMENT_METHOD, PAYMENT_PROVIDER } from "./constants.ts";
import { extractSchemaKeysAsEnum } from "./enum.helper.ts";
import { TransactionStatusSchema } from "./transaction.ts";

export const PaymentProviderSchema = z.enum(PAYMENT_PROVIDER);
export type PaymentProvider = z.infer<typeof PaymentProviderSchema>;

export const PaymentMethodSchema = z.enum(PAYMENT_METHOD);
export type PaymentMethod = z.infer<typeof PaymentMethodSchema>;

export const PaymentSchema = z.object({
	id: z.uuid(),
	transactionId: z.uuid(),
	provider: PaymentProviderSchema,
	method: PaymentMethodSchema,
	amount: z.number(),
	status: TransactionStatusSchema,
	externalId: z.string().optional(),
	paymentUrl: z.string().optional(),
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
}).extend({ method: PaymentMethodSchema.exclude(["WALLET"]) });
export type TopUpRequest = z.infer<typeof TopUpRequestSchema>;

export const PayRequestSchema = PaymentSchema.pick({
	amount: true,
}).extend({ referenceId: z.string().optional() });
export type PayRequest = z.infer<typeof PayRequestSchema>;

export const TransferRequestSchema = PaymentSchema.pick({
	amount: true,
}).extend({ walletId: z.uuid() });
export type WebhookRequest = z.infer<typeof WebhookRequestSchema>;

export const WebhookRequestSchema = z.record(z.string(), z.any());

export const PaymentSchemaRegistries = {
	PaymentProvider: { schema: PaymentProviderSchema, strategy: "output" },
	PaymentMethod: { schema: PaymentMethodSchema, strategy: "output" },
	Payment: { schema: PaymentSchema, strategy: "output" },
	InsertPayment: { schema: InsertPaymentSchema, strategy: "input" },
	UpdatePayment: { schema: UpdatePaymentSchema, strategy: "input" },
	TopUpRequest: { schema: TopUpRequestSchema, strategy: "input" },
	PayRequest: { schema: PayRequestSchema, strategy: "input" },
	TransferRequest: { schema: TransferRequestSchema, strategy: "input" },
	WebhookRequest: { schema: WebhookRequestSchema, strategy: "input" },
	PaymentKey: { schema: PaymentKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

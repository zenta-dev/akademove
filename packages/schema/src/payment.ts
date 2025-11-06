import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.ts";
import { PAYMENT_METHOD, PAYMENT_PROVIDER } from "./constants.ts";
import { TransactionStatusSchema } from "./transaction.ts";

export const PaymentProviderSchema = z.enum(PAYMENT_PROVIDER);
export const PaymentMethodSchema = z.enum(PAYMENT_METHOD);

export const PaymentSchema = z
	.object({
		id: z.uuid(),
		transactionId: z.uuid().optional(),
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
	})
	.meta({ title: "Payment" });

export const TopUpRequestSchema = PaymentSchema.pick({
	amount: true,
	provider: true,
})
	.extend({
		method: PaymentMethodSchema.exclude(["WALLET"]),
	})
	.meta({ title: "TopUpRequest" });

export const PayRequestSchema = PaymentSchema.pick({
	amount: true,
})
	.extend({
		referenceId: z.string().optional(),
	})
	.meta({ title: "PayRequest" });

export const TransferRequestSchema = PaymentSchema.pick({
	amount: true,
})
	.extend({
		walletId: z.uuid(),
	})
	.meta({ title: "TransferRequest" });

export const WebhookRequestSchema = z
	.record(z.string(), z.any())
	.meta({ title: "WebhookRequest" });

export type PaymentProvider = z.infer<typeof PaymentProviderSchema>;
export type PaymentMethod = z.infer<typeof PaymentMethodSchema>;
export type Payment = z.infer<typeof PaymentSchema>;
export type TopUpRequest = z.infer<typeof TopUpRequestSchema>;
export type PayRequest = z.infer<typeof PayRequestSchema>;
export type WebhookRequest = z.infer<typeof WebhookRequestSchema>;

export const PaymentSchemaRegistries = {
	PaymentProvider: { schema: PaymentProviderSchema, strategy: "output" },
	PaymentMethod: { schema: PaymentMethodSchema, strategy: "output" },
	Payment: { schema: PaymentSchema, strategy: "output" },
	TopUpRequest: { schema: TopUpRequestSchema, strategy: "input" },
	PayRequest: { schema: PayRequestSchema, strategy: "input" },
	TransferRequest: { schema: TransferRequestSchema, strategy: "input" },
	WebhookRequest: { schema: WebhookRequestSchema, strategy: "input" },
} satisfies SchemaRegistries;

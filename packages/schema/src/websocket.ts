import * as z from "zod";
import type { SchemaRegistries } from "./common.ts";
import { PlaceOrderResponseSchema } from "./order.ts";
import { PaymentSchema } from "./payment.ts";
import { CoordinateSchema } from "./position.ts";
import { TransactionSchema } from "./transaction.ts";
import { WalletSchema } from "./wallet.ts";

export const WSEnvelopeSenderSchema = z.enum(["server", "client"]);

const OrderEnvelopeTypes = [
	"order:request",
	"order:matching",
	"order:cancelled",
	"order:accepted",
	"order:unavailable",
] as const;
const DriverEnvelopeTypes = ["driver:location_update"] as const;
const WalletEnvelopeTypes = [
	"wallet:top_up_success",
	"wallet:top_up_failed",
] as const;
const PaymentEnvelopeTypes = ["payment:success", "payment:failed"] as const;

export const WSEnvelopeTypeSchema = z.enum([
	...OrderEnvelopeTypes,
	...DriverEnvelopeTypes,
	...WalletEnvelopeTypes,
	...PaymentEnvelopeTypes,
]);

export const createWSEnvelopeSchema = <T extends z.ZodType>(schema: T) =>
	z.object({
		type: WSEnvelopeTypeSchema,
		from: WSEnvelopeSenderSchema,
		to: WSEnvelopeSenderSchema,
		payload: schema,
	});

export const WSEnvelopeSchema = createWSEnvelopeSchema(z.any());
export const WSPlaceOrderEnvelopeSchema = createWSEnvelopeSchema(
	PlaceOrderResponseSchema,
);
export const WSPaymentEnvelopeSchema = createWSEnvelopeSchema(
	z.object({
		wallet: WalletSchema,
		transaction: TransactionSchema,
		payment: PaymentSchema,
	}),
);
export const WSOrderEnvelopeSchema = createWSEnvelopeSchema(
	z.object({
		driverUpdateLocation: CoordinateSchema.optional(),
	}),
);

export type WSEnvelope = z.infer<typeof WSEnvelopeSchema>;
export type WSOrderEnvelope = z.infer<typeof WSOrderEnvelopeSchema>;
export type WSPaymentEnvelope = z.infer<typeof WSPaymentEnvelopeSchema>;
export type WSPlaceOrderEnvelope = z.infer<typeof WSPlaceOrderEnvelopeSchema>;

export const WebsocketSchemaRegistries = {
	WSEnvelopeSender: { schema: WSEnvelopeSenderSchema, strategy: "output" },
	WSEnvelopeType: { schema: WSEnvelopeTypeSchema, strategy: "output" },
	WSEnvelope: { schema: WSEnvelopeSchema, strategy: "output" },
	WSOrderEnvelope: { schema: WSOrderEnvelopeSchema, strategy: "output" },
	WSPaymentEnvelope: { schema: WSPaymentEnvelopeSchema, strategy: "output" },
	WSPlaceOrderEnvelope: {
		schema: WSPlaceOrderEnvelopeSchema,
		strategy: "output",
	},
} satisfies SchemaRegistries;

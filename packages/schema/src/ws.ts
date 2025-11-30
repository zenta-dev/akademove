import * as z from "zod";
import type { SchemaRegistries } from "./common.ts";
import { CONSTANTS } from "./constants.ts";
import { DriverSchema } from "./driver.ts";
import { OrderSchema } from "./order.ts";
import { PaymentSchema } from "./payment.ts";
import { CoordinateSchema } from "./position.ts";
import { TransactionSchema } from "./transaction.ts";
import { WalletSchema } from "./wallet.ts";

export const EnvelopeSenderSchema = z
	.enum(["s", "c"])
	.describe("Envelope sender: 's' for server, 'c' for client");

export const EnvelopeTargetSchema = z
	.enum([...CONSTANTS.USER_ROLES, "SYSTEM", "ALL"])
	.describe("Envelope target");

export const createWsMinEnvelopeSchema = <
	TEvent extends z.ZodEnum,
	TAction extends z.ZodEnum,
	TPayload extends z.ZodType,
>({
	event,
	action,
	payload,
}: {
	event: TEvent;
	action: TAction;
	payload: TPayload;
}) =>
	z.object({
		e: event.optional(),
		a: action.optional(),
		tg: EnvelopeTargetSchema.optional(),
		f: EnvelopeSenderSchema,
		t: EnvelopeSenderSchema,
		p: payload,
	});

export const OrderEnvelopeEventSchema = z.enum([
	"CANCELED",
	"OFFER",
	"UNAVAILABLE",
	"DRIVER_ACCEPTED",
	"DRIVER_LOCATION_UPDATE",
	"COMPLETED",
	"MATCHING",
	"CHAT_MESSAGE",
]);
export const OrderEnvelopeActionSchema = z.enum([
	"MATCHING",
	"ACCEPTED",
	"UPDATE_LOCATION",
	"DONE",
	"SEND_MESSAGE",
]);
export const OrderEnvelopePayloadSchema = z.object({
	detail: z
		.object({
			order: OrderSchema,
			payment: PaymentSchema,
			transaction: TransactionSchema,
		})
		.optional(),
	driverAssigned: DriverSchema.optional(),
	driverUpdateLocation: z
		.object({
			driverId: z.string(),
			...CoordinateSchema.shape,
		})
		.optional(),
	done: z
		.object({
			by: z.enum(["USER", "DRIVER"]),
			orderId: z.string(),
			driverId: z.string(),
			driverCurrentLocation: CoordinateSchema,
		})
		.optional(),
	message: z
		.object({
			id: z.string().uuid(),
			orderId: z.string().uuid(),
			senderId: z.string(),
			senderName: z.string(),
			message: z.string(),
			sentAt: z.date(),
		})
		.optional(),
	cancelReason: z.string().optional(),
});
export const OrderEnvelopeSchema = createWsMinEnvelopeSchema({
	event: OrderEnvelopeEventSchema,
	action: OrderEnvelopeActionSchema,
	payload: OrderEnvelopePayloadSchema,
});
export type OrderEnvelope = z.infer<typeof OrderEnvelopeSchema>;

export const PaymentEnvelopeEventSchema = z.enum([
	"TOP_UP_SUCCESS",
	"PAYMENT_SUCCESS",
	"TOP_UP_FAILED",
	"PAYMENT_FAILED",
]);
export const PaymentEnvelopeActionSchema = z.enum([]);
export const PaymentEnvelopePayloadSchema = z.object({
	failReason: z.string().optional(),
	payment: PaymentSchema,
	transaction: TransactionSchema,
	wallet: WalletSchema.optional(),
});
export const PaymentEnvelopeSchema = createWsMinEnvelopeSchema({
	event: PaymentEnvelopeEventSchema,
	action: PaymentEnvelopeActionSchema,
	payload: PaymentEnvelopePayloadSchema,
});
export type PaymentEnvelope = z.infer<typeof PaymentEnvelopeSchema>;

export const WSSchemaRegistries = {
	EnvelopeSender: { schema: EnvelopeSenderSchema, strategy: "output" },
	EnvelopeTarget: { schema: EnvelopeTargetSchema, strategy: "output" },
	OrderEnvelopeEvent: { schema: OrderEnvelopeEventSchema, strategy: "output" },
	OrderEnvelopeAction: {
		schema: OrderEnvelopeActionSchema,
		strategy: "output",
	},
	OrderEnvelopePayload: {
		schema: OrderEnvelopePayloadSchema,
		strategy: "output",
	},
	OrderEnvelope: { schema: OrderEnvelopeSchema, strategy: "output" },
	PaymentEnvelopeEvent: {
		schema: PaymentEnvelopeEventSchema,
		strategy: "output",
	},
	PaymentEnvelopeAction: {
		schema: PaymentEnvelopeActionSchema,
		strategy: "output",
	},
	PaymentEnvelopePayload: {
		schema: PaymentEnvelopePayloadSchema,
		strategy: "output",
	},
	PaymentEnvelope: { schema: PaymentEnvelopeSchema, strategy: "output" },
} satisfies SchemaRegistries;

import * as z from "zod";
import type { SchemaRegistries } from "./common.js";
import { CONSTANTS } from "./constants.js";
import { DriverSchema } from "./driver.js";
import { OrderSchema } from "./order.js";
import { PaymentSchema } from "./payment.js";
import { CoordinateSchema } from "./position.js";
import { TransactionSchema } from "./transaction.js";
import { WalletSchema } from "./wallet.js";

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
	"CHAT_UNREAD_COUNT",
	"MERCHANT_ACCEPTED",
	"MERCHANT_REJECTED",
	"MERCHANT_PREPARING",
	"MERCHANT_READY",
	"NO_SHOW",
	"DRIVER_CANCELLED_REMATCHING",
	"ORDER_STATUS_CHANGED",
]);
export const OrderEnvelopeActionSchema = z.enum([
	"MATCHING",
	"ACCEPTED",
	"UPDATE_LOCATION",
	"DONE",
	"SEND_MESSAGE",
	"MERCHANT_ACCEPT",
	"MERCHANT_REJECT",
	"MERCHANT_MARK_PREPARING",
	"MERCHANT_MARK_READY",
	"REPORT_NO_SHOW",
]);
export const OrderEnvelopePayloadSchema = z.object({
	detail: z
		.object({
			order: OrderSchema,
			payment: PaymentSchema.nullable(),
			transaction: TransactionSchema.nullable(),
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
			id: z.uuid(),
			orderId: z.uuid(),
			senderId: z.string(),
			senderName: z.string(),
			senderRole: z.enum(["USER", "DRIVER", "MERCHANT"]),
			message: z.string(),
			sentAt: z.date(),
		})
		.optional(),
	chatUnreadCount: z
		.object({
			orderId: z.uuid(),
			userId: z.string(),
			unreadCount: z.number().int().min(0),
		})
		.optional(),
	merchantAction: z
		.object({
			orderId: z.uuid(),
			merchantId: z.uuid(),
			reason: z.string().optional(),
		})
		.optional(),
	cancelReason: z.string().optional(),
	noShow: z
		.object({
			orderId: z.uuid(),
			driverId: z.uuid(),
			reason: z.string().optional(),
		})
		.optional(),
	retryInfo: z
		.object({
			orderId: z.uuid(),
			cancelledDriverId: z.uuid(),
			excludedDriverCount: z.number(),
			reason: z.string().optional(),
		})
		.optional(),
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
export const PaymentEnvelopeActionSchema = z.enum(["NONE"]);
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

// Merchant WebSocket Envelope - for merchant dashboard real-time notifications
export const MerchantEnvelopeEventSchema = z.enum([
	"NEW_ORDER",
	"ORDER_CANCELLED",
	"DRIVER_ASSIGNED",
	"ORDER_COMPLETED",
	"ORDER_STATUS_CHANGED",
]);
export const MerchantEnvelopeActionSchema = z.enum(["NONE"]);
export const MerchantEnvelopePayloadSchema = z.object({
	order: OrderSchema.optional(),
	orderId: z.uuid().optional(),
	merchantId: z.uuid().optional(),
	itemCount: z.number().optional(),
	totalAmount: z.number().optional(),
	cancelReason: z.string().optional(),
	driverName: z.string().optional(),
	newStatus: z.string().optional(),
});
export const MerchantEnvelopeSchema = createWsMinEnvelopeSchema({
	event: MerchantEnvelopeEventSchema,
	action: MerchantEnvelopeActionSchema,
	payload: MerchantEnvelopePayloadSchema,
});
export type MerchantEnvelope = z.infer<typeof MerchantEnvelopeSchema>;

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
	MerchantEnvelopeEvent: {
		schema: MerchantEnvelopeEventSchema,
		strategy: "output",
	},
	MerchantEnvelopeAction: {
		schema: MerchantEnvelopeActionSchema,
		strategy: "output",
	},
	MerchantEnvelopePayload: {
		schema: MerchantEnvelopePayloadSchema,
		strategy: "output",
	},
	MerchantEnvelope: { schema: MerchantEnvelopeSchema, strategy: "output" },
} satisfies SchemaRegistries;

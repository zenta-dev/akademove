import * as z from "zod";
import type { SchemaRegistries } from "./common.ts";
import { PlaceOrderResponseSchema } from "./order.ts";
import { TransactionSchema, TransactionStatusSchema } from "./transaction.ts";
import { WalletSchema } from "./wallet.ts";

export const WSEnvelopeSenderSchema = z.enum(["server", "client"]);

const OrderEnvelopeTypes = [
	"order:request",
	"order:matching",
	"order:cancelled",
	"order:accepted",
] as const;
const DriverEnvelopeTypes = [
	"driver:location_update",
	"driver:assigned",
] as const;
const WalletEnvelopeTypes = ["wallet:top_up_success"] as const;

export const WSEnvelopeTypeSchema = z.enum([
	...OrderEnvelopeTypes,
	...DriverEnvelopeTypes,
	...WalletEnvelopeTypes,
]);

export const createWSEnvelopeSchema = <T extends z.ZodType>(schema: T) =>
	z.object({
		type: WSEnvelopeTypeSchema,
		from: WSEnvelopeSenderSchema,
		to: WSEnvelopeSenderSchema,
		payload: schema,
	});

export const WSEnvelopeSchema = createWSEnvelopeSchema(z.any());
export const WSTopUpEnvelopeSchema = createWSEnvelopeSchema(
	z.object({
		status: TransactionStatusSchema,
		wallet: WalletSchema,
		transaction: TransactionSchema,
	}),
);
export const WSPlaceOrderEnvelopeSchema = createWSEnvelopeSchema(
	PlaceOrderResponseSchema,
);
// export const WSTokenSchema = z.object({
// 	chn: z.string().describe("Channel name"),
// 	tags: z.array(z.string()).optional().readonly().describe("Tags"),
// 	att: z.unknown().optional().describe("Attachment"),
// 	rpc: z
// 		.array(z.string())
// 		.optional()
// 		.readonly()
// 		.describe("Allowed remote methods"),
// 	iat: z.number().describe("Issued at time in seconds"),
// 	exp: z.number().describe("Expiration time in seconds"),
// });

export type WSEnvelope = z.infer<typeof WSEnvelopeSchema>;
export type WSTopUpEnvelope = z.infer<typeof WSTopUpEnvelopeSchema>;
export type WSPlaceOrderEnvelope = z.infer<typeof WSPlaceOrderEnvelopeSchema>;

export const WebsocketSchemaRegistries = {
	WSEnvelopeSender: { schema: WSEnvelopeSenderSchema, strategy: "output" },
	WSEnvelopeType: { schema: WSEnvelopeTypeSchema, strategy: "output" },
	WSEnvelope: { schema: WSEnvelopeSchema, strategy: "output" },
	WSTopUpEnvelope: { schema: WSTopUpEnvelopeSchema, strategy: "output" },
	WSPlaceOrderEnvelope: {
		schema: WSPlaceOrderEnvelopeSchema,
		strategy: "output",
	},
	// WSTokenSchema: {
	// 	schema: WSTokenSchema,
	// 	strategy: "output",
	// },
} satisfies SchemaRegistries;

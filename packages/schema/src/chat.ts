import * as z from "zod";
import type { SchemaRegistries } from "./common.ts";
import { DateSchema } from "./common.ts";
import { UserSchema } from "./user.ts";

export const OrderChatMessageSchema = z.object({
	id: z.string().uuid(),
	orderId: z.string().uuid(),
	senderId: z.string(),
	message: z.string(),
	sentAt: DateSchema,
	createdAt: DateSchema,
	updatedAt: DateSchema,

	// relations
	sender: UserSchema.pick({ name: true, image: true }).optional(),
});
export type OrderChatMessage = z.infer<typeof OrderChatMessageSchema>;

export const InsertOrderChatMessageSchema = OrderChatMessageSchema.pick({
	orderId: true,
	message: true,
});
export type InsertOrderChatMessage = z.infer<
	typeof InsertOrderChatMessageSchema
>;

export const OrderChatMessageListQuerySchema = z.object({
	orderId: z.string().uuid(),
	limit: z.coerce.number().positive().max(100).default(50),
	cursor: z.string().uuid().optional(),
});
export type OrderChatMessageListQuery = z.infer<
	typeof OrderChatMessageListQuerySchema
>;

export const ChatSchemaRegistries = {
	OrderChatMessage: { schema: OrderChatMessageSchema, strategy: "output" },
	InsertOrderChatMessage: {
		schema: InsertOrderChatMessageSchema,
		strategy: "input",
	},
	OrderChatMessageListQuery: {
		schema: OrderChatMessageListQuerySchema,
		strategy: "input",
	},
} satisfies SchemaRegistries;

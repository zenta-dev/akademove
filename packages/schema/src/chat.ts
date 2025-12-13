import * as z from "zod";
import type { SchemaRegistries } from "./common.js";
import { DateSchema } from "./common.js";
import { UserSchema } from "./user.js";

export const ChatSenderRoleSchema = z.enum(["USER", "DRIVER", "MERCHANT"]);
export type ChatSenderRole = z.infer<typeof ChatSenderRoleSchema>;

export const OrderChatMessageSchema = z.object({
	id: z.uuid(),
	orderId: z.uuid(),
	senderId: z.string(),
	message: z.string(),
	sentAt: DateSchema,
	createdAt: DateSchema,
	updatedAt: DateSchema,

	// relations
	sender: UserSchema.pick({ name: true, image: true })
		.extend({ role: ChatSenderRoleSchema })
		.optional(),
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
	orderId: z.uuid(),
	limit: z.coerce.number().int().max(1000),
	cursor: z.uuid().optional(),
});
export type OrderChatMessageListQuery = z.infer<
	typeof OrderChatMessageListQuerySchema
>;

export const ChatSchemaRegistries = {
	ChatSenderRole: { schema: ChatSenderRoleSchema, strategy: "output" },
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

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

// --- Read Status Schemas --- //

export const OrderChatReadStatusSchema = z.object({
	id: z.uuid(),
	orderId: z.uuid(),
	userId: z.string(),
	lastReadMessageId: z.uuid().nullable(),
	lastReadAt: DateSchema.nullable(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type OrderChatReadStatus = z.infer<typeof OrderChatReadStatusSchema>;

export const MarkChatAsReadSchema = z.object({
	orderId: z.uuid(),
	lastReadMessageId: z.uuid().optional(),
});
export type MarkChatAsRead = z.infer<typeof MarkChatAsReadSchema>;

export const ChatUnreadCountSchema = z.object({
	orderId: z.uuid(),
	unreadCount: z.number().int().min(0),
});
export type ChatUnreadCount = z.infer<typeof ChatUnreadCountSchema>;

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
	OrderChatReadStatus: {
		schema: OrderChatReadStatusSchema,
		strategy: "output",
	},
	MarkChatAsRead: { schema: MarkChatAsReadSchema, strategy: "input" },
	ChatUnreadCount: { schema: ChatUnreadCountSchema, strategy: "output" },
} satisfies SchemaRegistries;

import { oc } from "@orpc/contract";
import {
	ChatUnreadCountSchema,
	InsertOrderChatMessageSchema,
	MarkChatAsReadSchema,
	OrderChatMessageListQuerySchema,
	OrderChatMessageSchema,
	OrderChatReadStatusSchema,
} from "@repo/schema/chat";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const ChatSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: OrderChatMessageListQuerySchema }))
		.output(
			createSuccesSchema(
				z.object({
					rows: z.array(OrderChatMessageSchema),
					hasMore: z.boolean(),
					nextCursor: z.uuid().optional(),
				}),
				"Successfully retrieved chat messages",
			),
		),
	send: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: InsertOrderChatMessageSchema,
			}),
		)
		.output(
			createSuccesSchema(OrderChatMessageSchema, "Message sent successfully"),
		),
	getUnreadCount: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "GET",
			path: "/unread-count",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: z.object({ orderId: z.uuid() }) }))
		.output(
			createSuccesSchema(
				ChatUnreadCountSchema,
				"Successfully retrieved unread count",
			),
		),
	markAsRead: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/mark-read",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: MarkChatAsReadSchema }))
		.output(
			createSuccesSchema(
				OrderChatReadStatusSchema,
				"Messages marked as read successfully",
			),
		),
};

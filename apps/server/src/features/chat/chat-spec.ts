import { oc } from "@orpc/contract";
import {
	InsertOrderChatMessageSchema,
	OrderChatMessageListQuerySchema,
	OrderChatMessageSchema,
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
					nextCursor: z.string().uuid().optional(),
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
};

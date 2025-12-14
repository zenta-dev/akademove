import { oc } from "@orpc/contract";
import {
	InsertSupportChatMessageSchema,
	InsertSupportTicketSchema,
	SupportChatMessageListQuerySchema,
	SupportChatMessageSchema,
	SupportTicketListQuerySchema,
	SupportTicketSchema,
	UpdateSupportTicketSchema,
} from "@repo/schema/support-chat";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const SupportChatSpec = {
	// ==================== TICKET OPERATIONS ====================
	listTickets: oc
		.route({
			tags: [FEATURE_TAGS.SUPPORT_CHAT],
			method: "GET",
			path: "/tickets",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: SupportTicketListQuerySchema }))
		.output(
			createSuccesSchema(
				z.object({
					rows: z.array(SupportTicketSchema),
					hasMore: z.boolean(),
					nextCursor: z.uuid().optional(),
				}),
				"Successfully retrieved support tickets",
			),
		),

	getTicket: oc
		.route({
			tags: [FEATURE_TAGS.SUPPORT_CHAT],
			method: "GET",
			path: "/tickets/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.uuid() }) }))
		.output(
			createSuccesSchema(
				SupportTicketSchema,
				"Successfully retrieved support ticket",
			),
		),

	createTicket: oc
		.route({
			tags: [FEATURE_TAGS.SUPPORT_CHAT],
			method: "POST",
			path: "/tickets",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertSupportTicketSchema }))
		.output(
			createSuccesSchema(
				SupportTicketSchema,
				"Support ticket created successfully",
				{ status: 201 },
			),
		),

	updateTicket: oc
		.route({
			tags: [FEATURE_TAGS.SUPPORT_CHAT],
			method: "PATCH",
			path: "/tickets/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: UpdateSupportTicketSchema,
			}),
		)
		.output(
			createSuccesSchema(
				SupportTicketSchema,
				"Support ticket updated successfully",
			),
		),

	// ==================== MESSAGE OPERATIONS ====================
	listMessages: oc
		.route({
			tags: [FEATURE_TAGS.SUPPORT_CHAT],
			method: "GET",
			path: "/messages",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: SupportChatMessageListQuerySchema }))
		.output(
			createSuccesSchema(
				z.object({
					rows: z.array(SupportChatMessageSchema),
					hasMore: z.boolean(),
					nextCursor: z.uuid().optional(),
				}),
				"Successfully retrieved chat messages",
			),
		),

	sendMessage: oc
		.route({
			tags: [FEATURE_TAGS.SUPPORT_CHAT],
			method: "POST",
			path: "/messages",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertSupportChatMessageSchema }))
		.output(
			createSuccesSchema(
				SupportChatMessageSchema,
				"Message sent successfully",
				{ status: 201 },
			),
		),

	getUnreadCount: oc
		.route({
			tags: [FEATURE_TAGS.SUPPORT_CHAT],
			method: "GET",
			path: "/messages/unread-count",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: z.object({ ticketId: z.uuid() }) }))
		.output(
			createSuccesSchema(
				z.object({ unreadCount: z.number() }),
				"Successfully retrieved unread count",
			),
		),

	markAsRead: oc
		.route({
			tags: [FEATURE_TAGS.SUPPORT_CHAT],
			method: "POST",
			path: "/messages/mark-read",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: z.object({ ticketId: z.uuid() }) }))
		.output(
			createSuccesSchema(
				z.object({ count: z.number() }),
				"Messages marked as read successfully",
			),
		),
};

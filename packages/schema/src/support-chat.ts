import * as z from "zod";
import type { SchemaRegistries } from "./common.js";
import { DateSchema } from "./common.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";
import { UserSchema } from "./user.js";

// Support ticket status enum
export const SupportTicketStatusSchema = z.enum([
	"OPEN",
	"IN_PROGRESS",
	"WAITING_USER",
	"RESOLVED",
	"CLOSED",
] as const);
export type SupportTicketStatus = z.infer<typeof SupportTicketStatusSchema>;

// Support ticket priority enum
export const SupportTicketPrioritySchema = z.enum([
	"LOW",
	"MEDIUM",
	"HIGH",
	"URGENT",
] as const);
export type SupportTicketPriority = z.infer<typeof SupportTicketPrioritySchema>;

// Support ticket category enum
export const SupportTicketCategorySchema = z.enum([
	"GENERAL",
	"ORDER_ISSUE",
	"PAYMENT_ISSUE",
	"DRIVER_COMPLAINT",
	"MERCHANT_COMPLAINT",
	"ACCOUNT_ISSUE",
	"TECHNICAL_ISSUE",
	"FEATURE_REQUEST",
	"OTHER",
] as const);
export type SupportTicketCategory = z.infer<typeof SupportTicketCategorySchema>;

// Support ticket schema
export const SupportTicketSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	assignedToId: z.string().optional(),
	subject: z.string().min(1).max(255),
	category: SupportTicketCategorySchema,
	priority: SupportTicketPrioritySchema,
	status: SupportTicketStatusSchema,
	orderId: z.uuid().optional(),
	lastMessageAt: DateSchema.optional(),
	resolvedAt: DateSchema.optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,

	// relations
	user: UserSchema.pick({ name: true, image: true, email: true }).optional(),
	assignedTo: UserSchema.pick({ name: true, image: true }).optional(),
});
export type SupportTicket = z.infer<typeof SupportTicketSchema>;

export const SupportTicketKeySchema =
	extractSchemaKeysAsEnum(SupportTicketSchema);

// Insert support ticket schema
export const InsertSupportTicketSchema = SupportTicketSchema.omit({
	id: true,
	userId: true,
	assignedToId: true,
	status: true,
	lastMessageAt: true,
	resolvedAt: true,
	createdAt: true,
	updatedAt: true,
	user: true,
	assignedTo: true,
}).safeExtend({
	message: z.string().min(1).max(5000), // Initial message for the ticket
});
export type InsertSupportTicket = z.infer<typeof InsertSupportTicketSchema>;

// Update support ticket schema
export const UpdateSupportTicketSchema = z.object({
	assignedToId: z.string().optional(),
	priority: SupportTicketPrioritySchema.optional(),
	status: SupportTicketStatusSchema.optional(),
});
export type UpdateSupportTicket = z.infer<typeof UpdateSupportTicketSchema>;

// Support chat message schema
export const SupportChatMessageSchema = z.object({
	id: z.uuid(),
	ticketId: z.uuid(),
	senderId: z.string(),
	message: z.string(),
	isFromSupport: z.boolean(),
	readAt: DateSchema.optional(),
	sentAt: DateSchema,
	createdAt: DateSchema,
	updatedAt: DateSchema,

	// relations
	sender: UserSchema.pick({ name: true, image: true }).optional(),
});
export type SupportChatMessage = z.infer<typeof SupportChatMessageSchema>;

// Insert support chat message schema
export const InsertSupportChatMessageSchema = z.object({
	ticketId: z.uuid(),
	message: z.string().min(1).max(5000),
});
export type InsertSupportChatMessage = z.infer<
	typeof InsertSupportChatMessageSchema
>;

// List query schemas
export const SupportTicketListQuerySchema = z.object({
	status: SupportTicketStatusSchema.optional(),
	category: SupportTicketCategorySchema.optional(),
	priority: SupportTicketPrioritySchema.optional(),
	assignedToId: z.string().optional(),
	userId: z.string().optional(),
	search: z.string().optional(),
	limit: z.coerce.number().int().max(1000).default(20),
	cursor: z.uuid().optional(),
});
export type SupportTicketListQuery = z.infer<
	typeof SupportTicketListQuerySchema
>;

export const SupportChatMessageListQuerySchema = z.object({
	ticketId: z.uuid(),
	limit: z.coerce.number().int().max(1000).default(50),
	cursor: z.uuid().optional(),
});
export type SupportChatMessageListQuery = z.infer<
	typeof SupportChatMessageListQuerySchema
>;

// WebSocket envelope schemas for real-time support chat
export const SupportChatEnvelopeEventSchema = z.enum([
	"NEW_MESSAGE",
	"MESSAGE_READ",
	"TICKET_UPDATED",
	"TICKET_ASSIGNED",
	"TICKET_CLOSED",
	"TYPING",
]);

export const SupportChatEnvelopeActionSchema = z.enum([
	"SEND_MESSAGE",
	"MARK_READ",
	"START_TYPING",
	"STOP_TYPING",
]);

export const SupportChatEnvelopePayloadSchema = z.object({
	message: SupportChatMessageSchema.optional(),
	ticket: SupportTicketSchema.optional(),
	ticketId: z.uuid().optional(),
	messageId: z.uuid().optional(),
	isTyping: z.boolean().optional(),
	userId: z.string().optional(),
});

export const SupportChatEnvelopeSchema = z.object({
	e: SupportChatEnvelopeEventSchema.optional(),
	a: SupportChatEnvelopeActionSchema.optional(),
	f: z.enum(["s", "c"]), // from: server or client
	t: z.enum(["s", "c"]), // to: server or client
	p: SupportChatEnvelopePayloadSchema,
});
export type SupportChatEnvelope = z.infer<typeof SupportChatEnvelopeSchema>;

// Schema registries for OpenAPI
export const SupportChatSchemaRegistries = {
	SupportTicketStatus: {
		schema: SupportTicketStatusSchema,
		strategy: "output",
	},
	SupportTicketPriority: {
		schema: SupportTicketPrioritySchema,
		strategy: "output",
	},
	SupportTicketCategory: {
		schema: SupportTicketCategorySchema,
		strategy: "output",
	},
	SupportTicket: { schema: SupportTicketSchema, strategy: "output" },
	SupportTicketKey: { schema: SupportTicketKeySchema, strategy: "input" },
	InsertSupportTicket: { schema: InsertSupportTicketSchema, strategy: "input" },
	UpdateSupportTicket: { schema: UpdateSupportTicketSchema, strategy: "input" },
	SupportChatMessage: { schema: SupportChatMessageSchema, strategy: "output" },
	InsertSupportChatMessage: {
		schema: InsertSupportChatMessageSchema,
		strategy: "input",
	},
	SupportTicketListQuery: {
		schema: SupportTicketListQuerySchema,
		strategy: "input",
	},
	SupportChatMessageListQuery: {
		schema: SupportChatMessageListQuerySchema,
		strategy: "input",
	},
	SupportChatEnvelopeEvent: {
		schema: SupportChatEnvelopeEventSchema,
		strategy: "output",
	},
	SupportChatEnvelopeAction: {
		schema: SupportChatEnvelopeActionSchema,
		strategy: "output",
	},
	SupportChatEnvelopePayload: {
		schema: SupportChatEnvelopePayloadSchema,
		strategy: "output",
	},
	SupportChatEnvelope: {
		schema: SupportChatEnvelopeSchema,
		strategy: "output",
	},
} satisfies SchemaRegistries;

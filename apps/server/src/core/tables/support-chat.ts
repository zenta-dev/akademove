import { relations } from "drizzle-orm";
import { boolean, text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import {
	DateModifier,
	index,
	nowFn,
	pgEnum,
	pgTable,
	timestamp,
} from "./common";
import { order } from "./order";

// Enums
export const supportTicketStatus = pgEnum("support_ticket_status", [
	"OPEN",
	"IN_PROGRESS",
	"WAITING_USER",
	"RESOLVED",
	"CLOSED",
]);

export const supportTicketPriority = pgEnum("support_ticket_priority", [
	"LOW",
	"MEDIUM",
	"HIGH",
	"URGENT",
]);

export const supportTicketCategory = pgEnum("support_ticket_category", [
	"GENERAL",
	"ORDER_ISSUE",
	"PAYMENT_ISSUE",
	"DRIVER_COMPLAINT",
	"MERCHANT_COMPLAINT",
	"ACCOUNT_ISSUE",
	"TECHNICAL_ISSUE",
	"FEATURE_REQUEST",
	"OTHER",
]);

/**
 * Support ticket table for tracking user support requests
 */
export const supportTicket = pgTable(
	"support_ticket",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		assignedToId: text("assigned_to_id").references(() => user.id, {
			onDelete: "set null",
		}),
		subject: text().notNull(),
		category: supportTicketCategory().notNull().default("GENERAL"),
		priority: supportTicketPriority().notNull().default("MEDIUM"),
		status: supportTicketStatus().notNull().default("OPEN"),
		orderId: uuid("order_id").references(() => order.id, {
			onDelete: "set null",
		}),
		lastMessageAt: timestamp("last_message_at"),
		resolvedAt: timestamp("resolved_at"),
		...DateModifier,
	},
	(t) => [
		// Index for filtering by status
		index("support_ticket_status_idx").on(t.status),
		// Index for filtering by user
		index("support_ticket_user_idx").on(t.userId),
		// Index for filtering by assigned support agent
		index("support_ticket_assigned_idx").on(t.assignedToId),
		// Index for filtering by category
		index("support_ticket_category_idx").on(t.category),
		// Index for filtering by priority
		index("support_ticket_priority_idx").on(t.priority),
		// Composite index for common queries
		index("support_ticket_status_created_idx").on(t.status, t.createdAt),
		// Index for related order
		index("support_ticket_order_idx").on(t.orderId),
	],
);

export type SupportTicketDatabase = typeof supportTicket.$inferSelect;

/**
 * Support chat message table for messages within a support ticket
 */
export const supportChatMessage = pgTable(
	"support_chat_message",
	{
		id: uuid().primaryKey(),
		ticketId: uuid("ticket_id")
			.notNull()
			.references(() => supportTicket.id, { onDelete: "cascade" }),
		senderId: text("sender_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		message: text().notNull(),
		isFromSupport: boolean("is_from_support").notNull().default(false),
		readAt: timestamp("read_at"),
		sentAt: timestamp("sent_at").notNull().$defaultFn(nowFn),
		...DateModifier,
	},
	(t) => [
		// Index for filtering by ticket
		index("support_chat_ticket_idx").on(t.ticketId),
		// Index for filtering by sender
		index("support_chat_sender_idx").on(t.senderId),
		// Composite index for efficient ticket chat retrieval
		index("support_chat_ticket_sent_idx").on(t.ticketId, t.sentAt),
		// Index for sorting by time
		index("support_chat_sent_at_idx").on(t.sentAt),
		// Index for unread messages
		index("support_chat_unread_idx").on(t.ticketId, t.readAt),
	],
);

export type SupportChatMessageDatabase = typeof supportChatMessage.$inferSelect;

///
/// --- Relations --- ///
///

export const supportTicketRelations = relations(
	supportTicket,
	({ one, many }) => ({
		user: one(user, {
			fields: [supportTicket.userId],
			references: [user.id],
			relationName: "ticketUser",
		}),
		assignedTo: one(user, {
			fields: [supportTicket.assignedToId],
			references: [user.id],
			relationName: "ticketAssignee",
		}),
		order: one(order, {
			fields: [supportTicket.orderId],
			references: [order.id],
		}),
		messages: many(supportChatMessage),
	}),
);

export const supportChatMessageRelations = relations(
	supportChatMessage,
	({ one }) => ({
		ticket: one(supportTicket, {
			fields: [supportChatMessage.ticketId],
			references: [supportTicket.id],
		}),
		sender: one(user, {
			fields: [supportChatMessage.senderId],
			references: [user.id],
		}),
	}),
);

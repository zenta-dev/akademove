import { relations } from "drizzle-orm";
import { text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import { DateModifier, index, nowFn, pgTable, timestamp } from "./common";
import { order } from "./order";

/**
 * Tracks the last read message for each participant in an order chat.
 * Used to calculate unread message counts.
 */
export const orderChatReadStatus = pgTable(
	"order_chat_read_status",
	{
		id: uuid().primaryKey(),
		orderId: uuid("order_id")
			.notNull()
			.references(() => order.id, { onDelete: "cascade" }),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		lastReadMessageId: uuid("last_read_message_id").references(
			() => orderChatMessage.id,
			{ onDelete: "set null" },
		),
		lastReadAt: timestamp("last_read_at"),
		...DateModifier,
	},
	(t) => [
		// Unique constraint: one read status per user per order
		index("chat_read_status_order_user_idx").on(t.orderId, t.userId),
		index("chat_read_status_user_idx").on(t.userId),
	],
);

export type OrderChatReadStatusDatabase =
	typeof orderChatReadStatus.$inferSelect;

export const orderChatMessage = pgTable(
	"order_chat_messages",
	{
		id: uuid().primaryKey(),
		orderId: uuid("order_id")
			.notNull()
			.references(() => order.id, { onDelete: "cascade" }),
		senderId: text("sender_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		message: text().notNull(),
		sentAt: timestamp("sent_at").notNull().$defaultFn(nowFn),
		...DateModifier,
	},
	(t) => [
		// Foreign key indexes for filtering by order/sender
		index("chat_order_id_idx").on(t.orderId),
		index("chat_sender_id_idx").on(t.senderId),

		// Composite index for efficient order chat retrieval
		index("chat_order_sent_idx").on(t.orderId, t.sentAt),

		// Index for sorting by time
		index("chat_sent_at_idx").on(t.sentAt),
	],
);

///
/// --- Relations --- ///
///
export const orderChatMessageRelations = relations(
	orderChatMessage,
	({ one }) => ({
		order: one(order, {
			fields: [orderChatMessage.orderId],
			references: [order.id],
		}),
		sender: one(user, {
			fields: [orderChatMessage.senderId],
			references: [user.id],
		}),
	}),
);

export const orderChatReadStatusRelations = relations(
	orderChatReadStatus,
	({ one }) => ({
		order: one(order, {
			fields: [orderChatReadStatus.orderId],
			references: [order.id],
		}),
		user: one(user, {
			fields: [orderChatReadStatus.userId],
			references: [user.id],
		}),
		lastReadMessage: one(orderChatMessage, {
			fields: [orderChatReadStatus.lastReadMessageId],
			references: [orderChatMessage.id],
		}),
	}),
);

export type OrderChatMessageDatabase = typeof orderChatMessage.$inferSelect;

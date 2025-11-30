import { relations } from "drizzle-orm";
import { text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import { DateModifier, index, nowFn, pgTable, timestamp } from "./common";
import { order } from "./order";

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

export type OrderChatMessageDatabase = typeof orderChatMessage.$inferSelect;

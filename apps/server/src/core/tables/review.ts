import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import {
	integer,
	pgEnum,
	pgTable,
	text,
	timestamp,
	uuid,
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import { order } from "./order";

export const reviewCategory = pgEnum(
	"review_category",
	CONSTANTS.REVIEW_CATEGORIES,
);

export const review = pgTable("reviews", {
	id: uuid().primaryKey().defaultRandom(),
	orderId: uuid("order_id")
		.notNull()
		.references(() => order.id, { onDelete: "no action" }),
	fromUserId: text("from_user_id")
		.notNull()
		.references(() => user.id, { onDelete: "no action" }),
	toUserId: text("to_user_id")
		.notNull()
		.references(() => user.id, { onDelete: "no action" }),
	category: reviewCategory().notNull().default("other"),
	score: integer().notNull().default(0),
	comment: text().notNull().default(""),
	createdAt: timestamp("created_at").notNull().defaultNow(),
});

///
/// --- Relations --- ///
///
export const reviewRelations = relations(review, ({ one }) => ({
	order: one(order, {
		fields: [review.orderId],
		references: [order.id],
	}),
	fromUser: one(user, {
		fields: [review.fromUserId],
		references: [user.id],
	}),
	toUser: one(user, {
		fields: [review.toUserId],
		references: [user.id],
	}),
}));

export type ReviewDatabase = typeof review.$inferSelect;

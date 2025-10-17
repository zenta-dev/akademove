import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import {
	index,
	integer,
	pgEnum,
	pgTable,
	text,
	uniqueIndex,
	uuid,
} from "drizzle-orm/pg-core";
import { user } from "./auth";
import { DateModifier } from "./common";
import { order } from "./order";

export const reviewCategory = pgEnum(
	"review_category",
	CONSTANTS.REVIEW_CATEGORIES,
);

export const review = pgTable(
	"reviews",
	{
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
		...DateModifier,
	},
	(t) => [
		uniqueIndex("review_order_from_user_idx").on(t.orderId, t.fromUserId),
		index("review_order_id_idx").on(t.orderId),
		index("review_from_user_id_idx").on(t.fromUserId),
		index("review_to_user_id_idx").on(t.toUserId),
		index("review_category_idx").on(t.category),
		index("review_score_idx").on(t.score),
		index("review_to_user_score_idx").on(t.toUserId, t.score),
		index("review_to_user_category_idx").on(t.toUserId, t.category),
		index("review_created_at_idx").on(t.createdAt),
		index("review_to_user_created_at_idx").on(t.toUserId, t.createdAt),
	],
);

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

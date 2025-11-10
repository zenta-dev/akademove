import { boolean, index, jsonb, text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import { DateModifier, nowFn, pgEnum, pgTable, timestamp } from "./common";

export const fcmToken = pgTable(
	"fcm_tokens",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		token: text().notNull().unique(),
		...DateModifier,
	},
	(t) => [
		index("fcm_token_user_id_idx").on(t.userId),
		index("fcm_token_token_id_idx").on(t.token),
	],
);
export type FCMTokenTable = typeof fcmToken;
export type FCMTokenDatabase = typeof fcmToken.$inferSelect;

export const fcmTopicSubscription = pgTable(
	"fcm_topic_subscriptions",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		token: text().notNull(),
		topic: text().notNull(),
		createdAt: timestamp("created_at").notNull().$defaultFn(nowFn),
	},
	(t) => [
		index("fcm_topic_subscriptions_user_id_topic_idx").on(t.userId, t.topic),
		index("fcm_topic_subscriptions_token_topic_idx").on(t.token, t.topic),
	],
);
export type FCMTopicSubscriptionTable = typeof fcmTopicSubscription;
export type FCMTopicSubscriptionDatabase =
	typeof fcmTopicSubscription.$inferSelect;

export const fcmNotificationLogStatus = pgEnum("status", ["success", "failed"]);

export const fcmNotificationLog = pgTable(
	"fcm_notification_logs",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		token: text(),
		topic: text(),
		title: text().notNull(),
		body: text().notNull(),
		data: jsonb(),
		messageId: text("message_id"),
		status: fcmNotificationLogStatus().notNull(),
		error: text(),
		sentAt: timestamp("sent_at").notNull().$defaultFn(nowFn),
	},
	(t) => [
		index("fcm_notification_logs_user_id_idx").on(t.userId),
		index("fcm_notification_logs_sent_at_idx").on(t.sentAt),
	],
);
export type FCMNotificationLogTable = typeof fcmNotificationLog;
export type FCMNotificationLogDatabase = typeof fcmNotificationLog.$inferSelect;

export const userNotification = pgTable(
	"user_notifications",
	{
		id: uuid().primaryKey(),
		userId: text("user_id")
			.notNull()
			.references(() => user.id, { onDelete: "cascade" }),
		title: text().notNull(),
		body: text().notNull(),
		data: jsonb(),
		messageId: text("message_id"),
		isRead: boolean("is_read").notNull().default(false),
		createdAt: timestamp("created_at").notNull().$defaultFn(nowFn),
		readAt: timestamp("read_at"),
	},
	(t) => [
		index("user_notifications_user_id_idx").on(t.userId),
		index("user_notifications_is_read_idx").on(t.isRead),
		index("user_notifications_created_at_idx").on(t.createdAt),
	],
);
export type UserNotificationTable = typeof userNotification;
export type UserNotificationDatabase = typeof userNotification.$inferSelect;

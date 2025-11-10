import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.ts";
import { extractSchemaKeysAsEnum } from "./enum.helper.ts";

export const FCMTokenSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	token: z.string(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type FCMToken = z.infer<typeof FCMTokenSchema>;

export const FCMTopicSubscriptionSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	token: z.string(),
	topic: z.string(),
	createdAt: DateSchema,
});
export type FCMTopicSubscription = z.infer<typeof FCMTopicSubscriptionSchema>;

export const InsertFCMTopicSubscriptionSchema = FCMTopicSubscriptionSchema.omit(
	{
		id: true,
		createdAt: true,
	},
);
export type InsertFCMTopicSubscription = z.infer<
	typeof InsertFCMTopicSubscriptionSchema
>;

export const FCMNotificationLogSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	token: z.string().optional(),
	topic: z.string().optional(),
	title: z.string(),
	body: z.string(),
	data: z.any().optional(),
	messageId: z.string().optional(),
	status: z.enum(["success", "failed"]),
	error: z.string().optional(),
	sentAt: DateSchema,
});
export type FCMNotificationLog = z.infer<typeof FCMNotificationLogSchema>;

export const FCMNotificationLogKeySchema = extractSchemaKeysAsEnum(
	FCMNotificationLogSchema,
);

export const InsertFCMNotificationLogSchema = FCMNotificationLogSchema.omit({
	id: true,
});
export type InsertFCMNotificationLog = z.infer<
	typeof InsertFCMNotificationLogSchema
>;

export const UserNotificationSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	title: z.string(),
	body: z.string(),
	data: z.any().optional(),
	messageId: z.string().optional(),
	isRead: z.boolean(),
	createdAt: DateSchema,
	readAt: DateSchema.optional(),
});
export type UserNotification = z.infer<typeof UserNotificationSchema>;

export const UserNotificationKeySchema = extractSchemaKeysAsEnum(
	UserNotificationSchema,
);

export const InsertUserNotificationSchema = UserNotificationSchema.omit({
	id: true,
	createdAt: true,
});
export type InsertUserNotification = z.infer<
	typeof InsertUserNotificationSchema
>;

export const UpdateUserNotificationSchema =
	InsertUserNotificationSchema.partial();
export type UpdateUserNotification = z.infer<
	typeof UpdateUserNotificationSchema
>;

export const NotificationSchemaRegistries = {
	FCMNotificationLog: { schema: FCMNotificationLogSchema, strategy: "output" },
	UserNotification: { schema: UserNotificationSchema, strategy: "output" },
} satisfies SchemaRegistries;

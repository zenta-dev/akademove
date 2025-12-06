import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

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
	status: z.enum(["SUCCESS", "FAILED"]),
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

export const BroadcastStatusSchema = z.enum([
	"PENDING",
	"SENDING",
	"SENT",
	"FAILED",
] as const);
export type BroadcastStatus = z.infer<typeof BroadcastStatusSchema>;

export const BroadcastTypeSchema = z.enum(["EMAIL", "IN_APP", "ALL"] as const);
export type BroadcastType = z.infer<typeof BroadcastTypeSchema>;

export const BroadcastSchema = z.object({
	id: z.uuid(),
	title: z.string().min(1).max(255),
	message: z.string().min(1).max(5000),
	type: BroadcastTypeSchema,
	status: BroadcastStatusSchema,
	targetAudience: z.enum([
		"ALL",
		"USERS",
		"DRIVERS",
		"MERCHANTS",
		"ADMINS",
		"OPERATORS",
	]),
	targetIds: z.array(z.string()).optional(),
	scheduledAt: z.date().optional(),
	sentAt: z.date().optional(),
	completedAt: z.date().optional(),
	failedCount: z.number().default(0),
	successCount: z.number().default(0),
	totalCount: z.number().default(0),
	createdBy: z.string().optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Broadcast = z.infer<typeof BroadcastSchema>;

export const InsertBroadcastSchema = BroadcastSchema.omit({
	id: true,
	status: true,
	sentAt: true,
	completedAt: true,
	failedCount: true,
	successCount: true,
	totalCount: true,
	createdAt: true,
	updatedAt: true,
});
export type InsertBroadcast = z.infer<typeof InsertBroadcastSchema>;

export const UpdateBroadcastSchema = InsertBroadcastSchema.partial();
export type UpdateBroadcast = z.infer<typeof UpdateBroadcastSchema>;

export const BroadcastSchemaRegistries = {
	FCMNotificationLog: { schema: FCMNotificationLogSchema, strategy: "output" },
	UserNotification: { schema: UserNotificationSchema, strategy: "output" },
	Broadcast: { schema: BroadcastSchema, strategy: "output" },
	InsertBroadcast: { schema: InsertBroadcastSchema, strategy: "input" },
	UpdateBroadcast: { schema: UpdateBroadcastSchema, strategy: "input" },
} satisfies SchemaRegistries;

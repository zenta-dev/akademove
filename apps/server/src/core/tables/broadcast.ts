import {
	index,
	integer,
	pgTable,
	text,
	timestamp,
	uuid,
	varchar,
} from "drizzle-orm/pg-core";
import { z } from "zod";
// Broadcast Status Enum
export const BROADCAST_STATUS = {
	PENDING: "PENDING",
	SENDING: "SENDING",
	SENT: "SENT",
	FAILED: "FAILED",
} as const;
export const BroadcastStatusSchema = z.enum(
	Object.values(BROADCAST_STATUS) as [string, ...string[]],
);
// Broadcast Type Enum
export const BROADCAST_TYPE = {
	EMAIL: "EMAIL",
	IN_APP: "IN_APP",
	ALL: "ALL",
} as const;
export const BroadcastTypeSchema = z.enum(
	Object.values(BROADCAST_TYPE) as [string, ...string[]],
);
// Target Audience Enum
export const TARGET_AUDIENCE = {
	ALL: "ALL",
	USERS: "USERS",
	DRIVERS: "DRIVERS",
	MERCHANTS: "MERCHANTS",
	ADMINS: "ADMINS",
	OPERATORS: "OPERATORS",
} as const;
export const TargetAudienceSchema = z.enum(
	Object.values(TARGET_AUDIENCE) as [string, ...string[]],
);
// Broadcast Table
export const broadcast = pgTable(
	"broadcast",
	{
		id: uuid("id").primaryKey().defaultRandom(),
		title: varchar("title", { length: 255 }).notNull(),
		message: text("message").notNull(),
		type: varchar("type", { length: 20 }).notNull().$type<BroadcastType>(),
		status: varchar("status", { length: 20 })
			.notNull()
			.default("PENDING")
			.$type<BroadcastStatus>(),
		targetAudience: varchar("target_audience", { length: 20 })
			.notNull()
			.default("ALL")
			.$type<TargetAudience>(),
		targetIds: uuid("target_ids").array(),
		scheduledAt: timestamp("scheduled_at", { withTimezone: true }),
		sentAt: timestamp("sent_at", { withTimezone: true }),
		totalRecipients: integer("total_recipients").default(0),
		sentCount: integer("sent_count").default(0),
		failedCount: integer("failed_count").default(0),
		createdBy: uuid("created_by").notNull(),
		createdAt: timestamp("created_at", { withTimezone: true }).defaultNow(),
		updatedAt: timestamp("updated_at", { withTimezone: true }).defaultNow(),
	},
	(table) => [
		// Indexes for performance
		index().on(table.status),
		index().on(table.type),
		index().on(table.targetAudience),
		index().on(table.scheduledAt),
		index().on(table.createdBy),
		index().on(table.createdAt),
		// Composite indexes for common queries
		index().on(table.status, table.type),
		index().on(table.status, table.scheduledAt),
	],
);
// Zod Schemas
export const BroadcastSchema = z.object({
	id: z.uuid(),
	title: z.string().min(1, "Title is required").max(255, "Title too long"),
	message: z.string().min(1, "Message is required"),
	type: BroadcastTypeSchema,
	status: BroadcastStatusSchema,
	targetAudience: TargetAudienceSchema,
	targetIds: z.array(z.uuid()).optional(),
	scheduledAt: z.coerce.date().optional(),
	sentAt: z.coerce.date().optional(),
	totalRecipients: z.coerce
		.number()
		.int()
		.int()
		.nonnegative()
		.int()
		.nonnegative()
		.min(0)
		.default(0),
	sentCount: z.coerce
		.number()
		.int()
		.int()
		.nonnegative()
		.int()
		.nonnegative()
		.min(0)
		.default(0),
	failedCount: z.coerce
		.number()
		.int()
		.int()
		.nonnegative()
		.int()
		.nonnegative()
		.min(0)
		.default(0),
	createdBy: z.uuid(),
	createdAt: z.coerce.date(),
	updatedAt: z.coerce.date(),
});
export const InsertBroadcastSchema = BroadcastSchema.omit({
	id: true,
	status: true,
	sentAt: true,
	totalRecipients: true,
	sentCount: true,
	failedCount: true,
	createdAt: true,
	updatedAt: true,
});
export const UpdateBroadcastSchema = InsertBroadcastSchema.partial();
// Types
export type Broadcast = z.infer<typeof BroadcastSchema>;
export type InsertBroadcast = z.infer<typeof InsertBroadcastSchema>;
export type UpdateBroadcast = z.infer<typeof UpdateBroadcastSchema>;
export type BroadcastStatus = z.infer<typeof BroadcastStatusSchema>;
export type BroadcastType = z.infer<typeof BroadcastTypeSchema>;
export type TargetAudience = z.infer<typeof TargetAudienceSchema>;

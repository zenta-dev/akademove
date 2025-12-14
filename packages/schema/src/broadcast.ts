import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

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
	scheduledAt: z.coerce.date().optional(),
	sentAt: z.coerce.date().optional(),
	completedAt: z.coerce.date().optional(),
	failedCount: z.coerce.number().default(0),
	successCount: z.coerce.number().default(0),
	totalCount: z.coerce.number().default(0),
	createdBy: z.string().optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Broadcast = z.infer<typeof BroadcastSchema>;

export const BroadcastKeySchema = extractSchemaKeysAsEnum(BroadcastSchema);

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
	BroadcastStatus: { schema: BroadcastStatusSchema, strategy: "output" },
	BroadcastType: { schema: BroadcastTypeSchema, strategy: "output" },
	Broadcast: { schema: BroadcastSchema, strategy: "output" },
	InsertBroadcast: { schema: InsertBroadcastSchema, strategy: "input" },
	UpdateBroadcast: { schema: UpdateBroadcastSchema, strategy: "input" },
	BroadcastKey: { schema: BroadcastKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

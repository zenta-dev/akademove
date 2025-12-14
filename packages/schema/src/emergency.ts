import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { CONSTANTS } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const EmergencyTypeSchema = z.enum(CONSTANTS.EMERGENCY_TYPES);
export type EmergencyType = z.infer<typeof EmergencyTypeSchema>;

export const EmergencyStatusSchema = z.enum(CONSTANTS.EMERGENCY_STATUS);
export type EmergencyStatus = z.infer<typeof EmergencyStatusSchema>;

export const EmergencySchema = z.object({
	id: z.uuid(),
	orderId: z.uuid(), // Required - emergency must be tied to an order
	userId: z.uuid(),
	driverId: z.uuid().optional(),
	type: EmergencyTypeSchema,
	status: EmergencyStatusSchema,
	description: z.string(),
	location: z
		.object({
			latitude: z.coerce.number(),
			longitude: z.coerce.number(),
		})
		.optional(),
	contactedAuthorities: z.array(z.string()).optional(),
	respondedById: z.string().optional(),
	resolution: z.string().optional(),
	reportedAt: DateSchema,
	acknowledgedAt: DateSchema.optional(),
	respondingAt: DateSchema.optional(),
	resolvedAt: DateSchema.optional(),
});
export type Emergency = z.infer<typeof EmergencySchema>;

export const EmergencyKeySchema = extractSchemaKeysAsEnum(EmergencySchema);

export const InsertEmergencySchema = EmergencySchema.omit({
	id: true,
	reportedAt: true,
	acknowledgedAt: true,
	respondingAt: true,
	resolvedAt: true,
});
export type InsertEmergency = z.infer<typeof InsertEmergencySchema>;

export const UpdateEmergencySchema = EmergencySchema.omit({
	id: true,
	reportedAt: true,
	acknowledgedAt: true,
	respondingAt: true,
	resolvedAt: true,
}).partial();
export type UpdateEmergency = z.infer<typeof UpdateEmergencySchema>;

// Simplified schema for logging emergency events (WhatsApp redirect)
export const LogEmergencySchema = z.object({
	orderId: z.uuid(),
	location: z
		.object({
			latitude: z.coerce.number(),
			longitude: z.coerce.number(),
		})
		.optional(),
});
export type LogEmergency = z.infer<typeof LogEmergencySchema>;

export const EmergencySchemaRegistries = {
	EmergencyType: { schema: EmergencyTypeSchema, strategy: "output" },
	EmergencyStatus: { schema: EmergencyStatusSchema, strategy: "output" },
	Emergency: { schema: EmergencySchema, strategy: "output" },
	InsertEmergency: { schema: InsertEmergencySchema, strategy: "input" },
	UpdateEmergency: { schema: UpdateEmergencySchema, strategy: "input" },
	EmergencyKey: { schema: EmergencyKeySchema, strategy: "input" },
	LogEmergency: { schema: LogEmergencySchema, strategy: "input" },
} satisfies SchemaRegistries;

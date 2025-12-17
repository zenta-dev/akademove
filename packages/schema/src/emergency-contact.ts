import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const EmergencyContactSchema = z.object({
	id: z.uuid(),
	name: z.string().min(1).max(255),
	phone: z.string().min(10).max(20),
	description: z.string().max(500).optional(),
	isActive: z.boolean(),
	priority: z.coerce.number().int().min(0).default(0),
	createdAt: DateSchema,
	updatedAt: DateSchema,
	createdById: z.string().optional(),
	updatedById: z.string().optional(),
});
export type EmergencyContact = z.infer<typeof EmergencyContactSchema>;

export const EmergencyContactKeySchema = extractSchemaKeysAsEnum(
	EmergencyContactSchema,
);

export const InsertEmergencyContactSchema = EmergencyContactSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
	createdById: true,
	updatedById: true,
});
export type InsertEmergencyContact = z.infer<
	typeof InsertEmergencyContactSchema
>;

export const UpdateEmergencyContactSchema =
	InsertEmergencyContactSchema.partial();
export type UpdateEmergencyContact = z.infer<
	typeof UpdateEmergencyContactSchema
>;

// Schema for emergency trigger response with contact info
export const EmergencyWithContactSchema = z.object({
	emergency: z.object({
		id: z.uuid(),
		orderId: z.uuid(),
		userId: z.string(),
		driverId: z.uuid().optional(),
		type: z.string(),
		status: z.string(),
		description: z.string(),
		location: z
			.object({
				latitude: z.coerce.number(),
				longitude: z.coerce.number(),
			})
			.optional(),
		reportedAt: DateSchema,
	}),
	contacts: z.array(EmergencyContactSchema),
	orderInfo: z.object({
		id: z.uuid(),
		type: z.string(),
		status: z.string(),
		pickupAddress: z.string().optional(),
		dropoffAddress: z.string().optional(),
	}),
	userInfo: z.object({
		id: z.string(),
		name: z.string(),
		phone: z.string().optional(),
		gender: z.string().optional(),
	}),
	driverInfo: z
		.object({
			id: z.uuid(),
			userId: z.string(),
			name: z.string(),
			phone: z.string().optional(),
			gender: z.string().optional(),
			vehiclePlate: z.string().optional(),
		})
		.optional(),
});
export type EmergencyWithContact = z.infer<typeof EmergencyWithContactSchema>;

export const EmergencyContactSchemaRegistries = {
	EmergencyContact: { schema: EmergencyContactSchema, strategy: "output" },
	InsertEmergencyContact: {
		schema: InsertEmergencyContactSchema,
		strategy: "input",
	},
	UpdateEmergencyContact: {
		schema: UpdateEmergencyContactSchema,
		strategy: "input",
	},
	EmergencyContactKey: { schema: EmergencyContactKeySchema, strategy: "input" },
	EmergencyWithContact: {
		schema: EmergencyWithContactSchema,
		strategy: "output",
	},
} satisfies SchemaRegistries;

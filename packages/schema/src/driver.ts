import * as z from "zod";
import { DateSchema, LocationSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";
import { UserSchema } from "./user.ts";

export const DriverStatusSchema = z.enum(CONSTANTS.DRIVER_STATUSES);

export const DriverSchema = z
	.object({
		id: z.uuid(),
		userId: z.string(),
		studentId: z.string().min(10),
		licenseNumber: z.string().min(6),
		status: DriverStatusSchema.default("pending"),
		rating: z.number(),
		isOnline: z.boolean(),
		currentLocation: LocationSchema.optional(),
		lastLocationUpdate: DateSchema.optional(),
		createdAt: DateSchema,

		// relations
		user: UserSchema.partial().optional(),
	})
	.meta({
		title: "Driver",
		ref: "Driver",
	});

export const InsertDriverSchema = DriverSchema.pick({
	studentId: true,
	licenseNumber: true,
});

export const UpdateDriverSchema = DriverSchema.omit({
	id: true,
	userId: true,
	rating: true,
	lastLocationUpdate: true,
	createdAt: true,
}).partial();

export type DriverStatus = z.infer<typeof DriverStatusSchema>;
export type Driver = z.infer<typeof DriverSchema>;
export type InsertDriver = z.infer<typeof InsertDriverSchema>;
export type UpdateDriver = z.infer<typeof UpdateDriverSchema>;

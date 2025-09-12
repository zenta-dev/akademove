import * as z from "zod";
import { LocationSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

export const DriverStatusSchema = z.enum(CONSTANTS.DRIVER_STATUSES);

export const DriverSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	studentId: z.string(),
	licenseNumber: z.string(),
	status: DriverStatusSchema,
	rating: z.number(),
	isOnline: z.boolean().default(false),
	currentLocation: LocationSchema.nullable(),
	lastLocationUpdate: z.date().nullable(),
	createdAt: z.date(),
});

export type DriverStatus = z.infer<typeof DriverStatusSchema>;
export type Driver = z.infer<typeof DriverSchema>;

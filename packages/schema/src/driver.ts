import * as z from "zod";
import { LocationSchema } from "./common.ts";

export const DriverStatusSchema = z.enum([
	"pending",
	"approved",
	"rejected",
	"active",
	"inactive",
	"suspended",
]);

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

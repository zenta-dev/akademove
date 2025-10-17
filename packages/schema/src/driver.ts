import * as z from "zod";
import { BankSchema, DateSchema, LocationSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";
import { UserSchema } from "./user.ts";

export const DriverStatusSchema = z.enum(CONSTANTS.DRIVER_STATUSES);

export const DriverSchema = z
	.object({
		id: z.uuid(),
		userId: z.string(),
		studentId: z.coerce.number().min(10).max(20),
		licensePlate: z.string().min(6).max(32),
		status: DriverStatusSchema,
		rating: z.number(),
		isOnline: z.boolean(),
		currentLocation: LocationSchema.optional(),
		lastLocationUpdate: DateSchema.optional(),
		createdAt: DateSchema,

		studentCard: z.url(),
		driverLicense: z.url(),
		vehicleCertificate: z.url(),
		bank: BankSchema,
		// relations
		user: UserSchema.partial().optional(),
	})
	.meta({
		title: "Driver",
		ref: "Driver",
	});

export const DriverDocumentSchema = z.object({
	studentCard: z
		.file()
		.mime(["image/png", "image/jpg", "image/jpeg", "application/pdf"]),
	driverLicense: z
		.file()
		.mime(["image/png", "image/jpg", "image/jpeg", "application/pdf"]),
	vehicleCertificate: z
		.file()
		.mime(["image/png", "image/jpg", "image/jpeg", "application/pdf"]),
});

export const InsertDriverSchema = DriverSchema.pick({
	studentId: true,
	licensePlate: true,
	studentCard: true,
	driverLicense: true,
	vehicleCertificate: true,
	bank: true,
}).extend({
	...DriverDocumentSchema.shape,
});

export const UpdateDriverSchema = InsertDriverSchema.partial();

export type DriverStatus = z.infer<typeof DriverStatusSchema>;
export type Driver = z.infer<typeof DriverSchema>;
export type InsertDriver = z.infer<typeof InsertDriverSchema>;
export type UpdateDriver = z.infer<typeof UpdateDriverSchema>;

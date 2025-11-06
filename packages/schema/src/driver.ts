import * as z from "zod";
import {
	BankSchema,
	DateSchema,
	DayOfWeekSchema,
	type SchemaRegistries,
	TimeSchema,
} from "./common.ts";
import { CONSTANTS } from "./constants.ts";
import { CoordinateSchema } from "./position.ts";
import { UserSchema } from "./user.ts";

export const DriverStatusSchema = z
	.enum(CONSTANTS.DRIVER_STATUSES)
	.meta({ title: "DriverStatus" });

export const DriverSchema = z
	.object({
		id: z.uuid(),
		userId: z.string(),
		studentId: z.coerce.number<number>(),
		licensePlate: z.string().min(6).max(32),
		status: DriverStatusSchema,
		rating: z.number(),
		isOnline: z.boolean(),
		currentLocation: CoordinateSchema.optional(),
		lastLocationUpdate: DateSchema.optional(),
		createdAt: DateSchema,

		studentCard: z.url(),
		driverLicense: z.url(),
		vehicleCertificate: z.url(),
		bank: BankSchema,
		// relations
		user: UserSchema.partial().optional(),

		// scoped
		distance: z
			.number()
			.optional()
			.describe("Each user has different result since it calculated value"),
	})
	.meta({ title: "Driver" });

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
})
	.extend({
		...DriverDocumentSchema.shape,
	})
	.meta({ title: "InsertDriverRequest" });

export const UpdateDriverSchema = InsertDriverSchema.extend({
	currentLocation: CoordinateSchema.optional(),
})
	.partial()
	.meta({
		title: "UpdateDriverRequest",
	});

export type DriverStatus = z.infer<typeof DriverStatusSchema>;
export type Driver = z.infer<typeof DriverSchema>;
export type InsertDriver = z.infer<typeof InsertDriverSchema>;
export type UpdateDriver = z.infer<typeof UpdateDriverSchema>;

export const DriverScheduleSchema = z
	.object({
		id: z.uuid(),
		driverId: z.uuid(),
		dayOfWeek: DayOfWeekSchema,
		startTime: TimeSchema,
		endTime: TimeSchema,
		isRecurring: z.boolean().default(true),
		specificDate: DateSchema.optional(),
		isActive: z.boolean().default(true),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({ title: "DriverSchedule" });

export const InsertDriverScheduleSchema = DriverScheduleSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
}).meta({ title: "InsertDriverScheduleRequest" });

export const UpdateDriverScheduleSchema = DriverScheduleSchema.omit({
	id: true,
	driverId: true,
	createdAt: true,
	updatedAt: true,
})
	.partial()
	.meta({ title: "UpdateDriverScheduleRequest" });

export type DayOfWeek = z.infer<typeof DayOfWeekSchema>;
export type DriverSchedule = z.infer<typeof DriverScheduleSchema>;
export type InsertDriverSchedule = z.infer<typeof InsertDriverScheduleSchema>;
export type UpdateDriverSchedule = z.infer<typeof UpdateDriverScheduleSchema>;

export const DriverSchemaRegistries = {
	DriverStatus: { schema: DriverStatusSchema, strategy: "output" },
	Driver: { schema: DriverSchema, strategy: "output" },
	DriverSchedule: { schema: DriverScheduleSchema, strategy: "output" },
} satisfies SchemaRegistries;

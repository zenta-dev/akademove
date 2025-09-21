import * as z from "zod";
import { DateSchema, DayOfWeekSchema, TimeSchema } from "./common.ts";

export const ScheduleSchema = z
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
	.meta({
		title: "Schedule",
		ref: "Schedule",
	});

export const InsertScheduleSchema = ScheduleSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
});

export const UpdateScheduleSchema = ScheduleSchema.omit({
	id: true,
	driverId: true,
	createdAt: true,
	updatedAt: true,
}).partial();

export type DayOfWeek = z.infer<typeof DayOfWeekSchema>;
export type Schedule = z.infer<typeof ScheduleSchema>;
export type InsertSchedule = z.infer<typeof InsertScheduleSchema>;
export type UpdateSchedule = z.infer<typeof UpdateScheduleSchema>;

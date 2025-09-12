import * as z from "zod";
import { TimeSchema } from "./common.ts";

export const DayOfWeekSchema = z.enum([
	"sunday",
	"monday",
	"tuesday",
	"wednesday",
	"thursday",
	"friday",
	"saturday",
]);

export const ScheduleSchema = z.object({
	id: z.uuid(),
	driverId: z.uuid(),
	dayOfWeek: DayOfWeekSchema,
	startTime: TimeSchema,
	endTime: TimeSchema,
	isRecurring: z.boolean().default(true),
	specificDate: z.date().optional(),
	isActive: z.boolean().default(true),
	createdAt: z.date(),
	updatedAt: z.date(),
});

export type DayOfWeek = z.infer<typeof DayOfWeekSchema>;
export type Schedule = z.infer<typeof ScheduleSchema>;

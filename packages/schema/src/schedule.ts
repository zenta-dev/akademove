import * as z from "zod";
import { DateSchema, TimeSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

export const DayOfWeekSchema = z.enum(CONSTANTS.DAY_OF_WEEK);

export const ScheduleSchema = z.object({
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
});

export type DayOfWeek = z.infer<typeof DayOfWeekSchema>;
export type Schedule = z.infer<typeof ScheduleSchema>;

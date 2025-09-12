import * as z from "zod";

export const LocationSchema = z.object({
	lat: z.number(),
	lng: z.number(),
});

export const TimeSchema = z.object({
	h: z.number(),
	m: z.number(),
});

export type Location = z.infer<typeof LocationSchema>;
export type Time = z.infer<typeof TimeSchema>;

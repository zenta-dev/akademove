import * as z from "zod";
import { LocationSchema } from "./common.ts";

export const OrderStatusSchema = z.enum([
	"requested",
	"matching",
	"accepted",
	"arriving",
	"in_trip",
	"completed",
	"cancelled_by_user",
	"cancelled_by_driver",
	"cancelled_by_system",
]);
export const OrderTypeSchema = z.enum(["ride", "delivery", "food"]);

export const OrderNoteSchema = z.object({
	pickup: z.string().optional(),
	dropoff: z.string().optional(),
});

export const OrderSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	driverId: z.string().nullable(),
	merchantId: z.string().nullable(),
	type: OrderTypeSchema,
	status: OrderStatusSchema,
	pickupLocation: LocationSchema,
	dropoffLocation: LocationSchema,
	distanceKm: z.number(),
	basePrice: z.number(),
	tip: z.number().default(0.0),
	totalPrice: z.number(),
	note: OrderNoteSchema.optional(),
	requestedAt: z.date(),
	acceptedAt: z.date().nullable(),
	arrivedAt: z.date().nullable(),
	createdAt: z.date(),
	updatedAt: z.date(),
});

export type OrderStatus = z.infer<typeof OrderStatusSchema>;
export type OrderType = z.infer<typeof OrderTypeSchema>;
export type OrderNote = z.infer<typeof OrderNoteSchema>;
export type Order = z.infer<typeof OrderSchema>;

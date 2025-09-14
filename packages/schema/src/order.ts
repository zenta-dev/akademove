import * as z from "zod";
import { DateSchema, LocationSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

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
export const OrderTypeSchema = z.enum(CONSTANTS.ORDER_TYPES);

export const OrderNoteSchema = z.object({
	pickup: z.string().optional(),
	dropoff: z.string().optional(),
});

export const OrderSchema = z
	.object({
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
		note: OrderNoteSchema.nullable(),
		requestedAt: DateSchema,
		acceptedAt: DateSchema.nullable(),
		arrivedAt: DateSchema.nullable(),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({
		ref: "Order",
	});

export const InsertOrderSchema = OrderSchema.omit({
	id: true,
	requestedAt: true,
	acceptedAt: true,
	arrivedAt: true,
	createdAt: true,
	updatedAt: true,
});

export const UpdateOrderSchema = OrderSchema.omit({
	id: true,
	userId: true,
	pickupLocation: true,
	dropoffLocation: true,
	basePrice: true,
	requestedAt: true,
	acceptedAt: true,
	arrivedAt: true,
	createdAt: true,
	updatedAt: true,
});

export type OrderStatus = z.infer<typeof OrderStatusSchema>;
export type OrderType = z.infer<typeof OrderTypeSchema>;
export type OrderNote = z.infer<typeof OrderNoteSchema>;
export type Order = z.infer<typeof OrderSchema>;
export type InsertOrder = z.infer<typeof InsertOrderSchema>;
export type UpdateOrder = z.infer<typeof UpdateOrderSchema>;

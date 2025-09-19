import * as z from "zod";
import { DateSchema, LocationSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

export const OrderStatusSchema = z.enum(CONSTANTS.ORDER_STATUSES);
export const OrderTypeSchema = z.enum(CONSTANTS.ORDER_TYPES);

export const OrderNoteSchema = z.object({
	pickup: z.string().optional(),
	dropoff: z.string().optional(),
});

export const OrderSchema = z
	.object({
		id: z.uuid(),
		userId: z.string(),
		driverId: z.string().optional(),
		merchantId: z.string().optional(),
		type: OrderTypeSchema,
		status: OrderStatusSchema,
		pickupLocation: LocationSchema,
		dropoffLocation: LocationSchema,
		distanceKm: z.number(),
		basePrice: z.number(),
		tip: z.number().optional(),
		totalPrice: z.number(),
		note: OrderNoteSchema.optional(),
		requestedAt: DateSchema,
		acceptedAt: DateSchema.optional(),
		arrivedAt: DateSchema.optional(),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({
		title: "Order",
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
}).partial();

export type OrderStatus = z.infer<typeof OrderStatusSchema>;
export type OrderType = z.infer<typeof OrderTypeSchema>;
export type OrderNote = z.infer<typeof OrderNoteSchema>;
export type Order = z.infer<typeof OrderSchema>;
export type InsertOrder = z.infer<typeof InsertOrderSchema>;
export type UpdateOrder = z.infer<typeof UpdateOrderSchema>;

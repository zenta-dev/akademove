import * as z from "zod";
import {
	BankProviderSchema,
	DateSchema,
	type SchemaRegistries,
} from "./common.ts";
import { CONSTANTS } from "./constants.ts";
import { DriverSchema } from "./driver.ts";
import { extractSchemaKeysAsEnum } from "./enum.helper.ts";
import { flattenZodObject } from "./flatten.helper.ts";
import { MerchantMenuSchema, MerchantSchema } from "./merchant.ts";
import {
	PaymentMethodSchema,
	PaymentProviderSchema,
	PaymentSchema,
} from "./payment.ts";
import { CoordinateSchema } from "./position.ts";
import { TransactionSchema } from "./transaction.ts";
import { UserGenderSchema, UserSchema } from "./user.ts";

export const OrderStatusSchema = z.enum(CONSTANTS.ORDER_STATUSES);
export type OrderStatus = z.infer<typeof OrderStatusSchema>;

export const OrderTypeSchema = z.enum(CONSTANTS.ORDER_TYPES);
export type OrderType = z.infer<typeof OrderTypeSchema>;

export const OrderNoteSchema = z.object({
	pickup: z.string().optional(),
	dropoff: z.string().optional(),
	instructions: z.string().optional(),
});
export type OrderNote = z.infer<typeof OrderNoteSchema>;

export const OrderItemSchema = z.object({
	quantity: z.number(),
	item: MerchantMenuSchema.partial(),
});

export const OrderSummarySchema = z.object({
	distanceKm: z.coerce.number(),
	baseFare: z.coerce.number(),
	distanceFare: z.coerce.number(),
	additionalFees: z.coerce.number(),
	subtotal: z.coerce.number(),
	platformFee: z.coerce.number(),
	tax: z.coerce.number(),
	totalCost: z.coerce.number(),
	breakdown: z
		.object({
			distance: z.coerce.number(),
			duration: z.coerce.number(),
			perMinuteRate: z.coerce.number(),
			weight: z.coerce.number(),
			perKgRate: z.coerce.number(),
		})
		.partial(),
});
export type OrderSummary = z.infer<typeof OrderSummarySchema>;

export const OrderSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	driverId: z.string().optional(),
	merchantId: z.string().optional(),
	type: OrderTypeSchema,
	status: OrderStatusSchema,
	pickupLocation: CoordinateSchema,
	dropoffLocation: CoordinateSchema,
	distanceKm: z.number(),
	basePrice: z.number(),
	tip: z.number().optional(),
	totalPrice: z.number(),
	platformCommission: z.number().optional(),
	driverEarning: z.number().optional(),
	merchantCommission: z.number().optional(),
	note: OrderNoteSchema.optional(),
	requestedAt: DateSchema,
	acceptedAt: DateSchema.optional(),
	preparedAt: DateSchema.optional(),
	readyAt: DateSchema.optional(),
	arrivedAt: DateSchema.optional(),
	cancelReason: z.string().optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,

	gender: UserGenderSchema.optional(),

	// delivery, food
	itemCount: z.number().optional(),
	items: z.array(OrderItemSchema).optional(),

	// relations
	user: UserSchema.partial().optional(),
	driver: DriverSchema.partial().optional(),
	merchant: MerchantSchema.partial().optional(),
});
export type Order = z.infer<typeof OrderSchema>;

export const OrderKeySchema = extractSchemaKeysAsEnum(OrderSchema).exclude([
	"items",
	"itemCount",
	"user",
	"driver",
	"merchant",
]);

export const PlaceOrderSchema = OrderSchema.pick({
	dropoffLocation: true,
	pickupLocation: true,
	note: true,
	type: true,
	items: true,
	gender: true,
}).extend({
	payment: z.object({
		method: PaymentMethodSchema,
		provider: PaymentProviderSchema,
		bankProvider: BankProviderSchema.optional(),
	}),
});
export type PlaceOrder = z.infer<typeof PlaceOrderSchema>;

export const PlaceOrderResponseSchema = z.object({
	order: OrderSchema,
	payment: PaymentSchema,
	transaction: TransactionSchema,
});
export type PlaceOrderResponse = z.infer<typeof PlaceOrderResponseSchema>;

export const UpdateOrderSchema = OrderSchema.omit({
	id: true,
	userId: true,
	pickupLocation: true,
	dropoffLocation: true,
	basePrice: true,
	requestedAt: true,
	acceptedAt: true,
	preparedAt: true,
	readyAt: true,
	arrivedAt: true,
	createdAt: true,
	updatedAt: true,
}).partial();
export type UpdateOrder = z.infer<typeof UpdateOrderSchema>;

export const EstimateOrderSchema = PlaceOrderSchema.omit({
	payment: true,
}).extend({
	discountIds: z.array(z.coerce.number()).optional(),
	weight: z.number().positive().max(20).optional(),
});
export type EstimateOrder = z.infer<typeof EstimateOrderSchema>;

export const FlatEstimateOrderSchema = flattenZodObject(EstimateOrderSchema);

export const OrderSchemaRegistries = {
	OrderStatus: { schema: OrderStatusSchema, strategy: "output" },
	OrderType: { schema: OrderTypeSchema, strategy: "output" },
	OrderNote: { schema: OrderNoteSchema, strategy: "output" },
	OrderItem: { schema: OrderItemSchema, strategy: "output" },
	Order: { schema: OrderSchema, strategy: "output" },
	OrderSummary: { schema: OrderSummarySchema, strategy: "output" },
	PlaceOrder: { schema: PlaceOrderSchema, strategy: "input" },
	PlaceOrderResponse: { schema: PlaceOrderResponseSchema, strategy: "input" },
	UpdateOrder: { schema: UpdateOrderSchema, strategy: "input" },
	EstimateOrder: { schema: EstimateOrderSchema, strategy: "input" },
	OrderKey: { schema: OrderKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

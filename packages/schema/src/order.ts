import * as z from "zod";
import {
	BankProviderSchema,
	DateSchema,
	type SchemaRegistries,
} from "./common.js";
import { CONSTANTS } from "./constants.js";
import { DriverSchema } from "./driver.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";
import { flattenZodObject } from "./flatten.helper.js";
import { MerchantMenuSchema, MerchantSchema } from "./merchant.js";
import {
	PaymentMethodSchema,
	PaymentProviderSchema,
	PaymentSchema,
} from "./payment.js";
import { CoordinateSchema } from "./position.js";
import { TransactionSchema } from "./transaction.js";
import { UserGenderSchema, UserSchema } from "./user.js";

export const OrderStatusSchema = z.enum(CONSTANTS.ORDER_STATUSES);
export type OrderStatus = z.infer<typeof OrderStatusSchema>;

export const OrderStatusHistoryRoleSchema = z.enum([
	"USER",
	"DRIVER",
	"MERCHANT",
	"OPERATOR",
	"ADMIN",
	"SYSTEM",
]);
export type OrderStatusHistoryRole = z.infer<
	typeof OrderStatusHistoryRoleSchema
>;

export const OrderTypeSchema = z.enum(CONSTANTS.ORDER_TYPES);
export type OrderType = z.infer<typeof OrderTypeSchema>;

export const GenderPreferenceSchema = z.enum(["SAME", "ANY"]);
export type GenderPreference = z.infer<typeof GenderPreferenceSchema>;

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
	couponId: z.uuid().optional(),
	couponCode: z.string().optional(),
	discountAmount: z.number().optional(),
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
	genderPreference: GenderPreferenceSchema.optional(),

	// Scheduled order fields
	scheduledAt: DateSchema.optional(),
	scheduledMatchingAt: DateSchema.optional(),

	// Proof of delivery
	proofOfDeliveryUrl: z.string().url().optional(),
	deliveryOtp: z.string().length(6).optional(),
	otpVerifiedAt: DateSchema.optional(),

	// delivery, food
	itemCount: z.number().optional(),
	items: z.array(OrderItemSchema).optional(),

	// relations
	user: UserSchema.partial().optional(),
	driver: DriverSchema.partial().optional(),
	merchant: MerchantSchema.partial().optional(),
});
export type Order = z.infer<typeof OrderSchema>;

/**
 * Order Status History Schema - For audit trail API responses
 */
export const OrderStatusHistorySchema = z.object({
	id: z.number(),
	orderId: z.string().uuid(),
	previousStatus: OrderStatusSchema.nullable(),
	newStatus: OrderStatusSchema,
	changedBy: z.string().nullable(),
	changedByRole: OrderStatusHistoryRoleSchema.nullable(),
	reason: z.string().nullable(),
	metadata: z.record(z.string(), z.unknown()).nullable(),
	changedAt: DateSchema,
	// Optional relation
	changedByUser: UserSchema.partial().optional(),
});
export type OrderStatusHistory = z.infer<typeof OrderStatusHistorySchema>;

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
	genderPreference: true,
}).safeExtend({
	couponCode: z.string().optional(),
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
	autoAppliedCoupon: z
		.object({
			code: z.string(),
			discountAmount: z.number(),
		})
		.optional(),
});
export type PlaceOrderResponse = z.infer<typeof PlaceOrderResponseSchema>;

// Scheduled order schemas
export const PlaceScheduledOrderSchema = PlaceOrderSchema.safeExtend({
	scheduledAt: z.coerce.date(),
});
export type PlaceScheduledOrder = z.infer<typeof PlaceScheduledOrderSchema>;

export const PlaceScheduledOrderResponseSchema = z.object({
	order: OrderSchema,
	payment: PaymentSchema,
	transaction: TransactionSchema,
	autoAppliedCoupon: z
		.object({
			code: z.string(),
			discountAmount: z.number(),
		})
		.optional(),
});
export type PlaceScheduledOrderResponse = z.infer<
	typeof PlaceScheduledOrderResponseSchema
>;

export const UpdateScheduledOrderSchema = z.object({
	scheduledAt: z.coerce.date().optional(),
	cancelReason: z.string().optional(),
});
export type UpdateScheduledOrder = z.infer<typeof UpdateScheduledOrderSchema>;

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
}).safeExtend({
	discountIds: z.array(z.coerce.number()).optional(),
	weight: z.number().positive().max(20).optional(),
});
export type EstimateOrder = z.infer<typeof EstimateOrderSchema>;

export const FlatEstimateOrderSchema = flattenZodObject(EstimateOrderSchema);

export const OrderSchemaRegistries = {
	OrderStatus: { schema: OrderStatusSchema, strategy: "output" },
	OrderStatusHistoryRole: {
		schema: OrderStatusHistoryRoleSchema,
		strategy: "output",
	},
	OrderType: { schema: OrderTypeSchema, strategy: "output" },
	OrderNote: { schema: OrderNoteSchema, strategy: "output" },
	OrderItem: { schema: OrderItemSchema, strategy: "output" },
	Order: { schema: OrderSchema, strategy: "output" },
	OrderStatusHistory: { schema: OrderStatusHistorySchema, strategy: "output" },
	OrderSummary: { schema: OrderSummarySchema, strategy: "output" },
	PlaceOrder: { schema: PlaceOrderSchema, strategy: "input" },
	PlaceOrderResponse: { schema: PlaceOrderResponseSchema, strategy: "input" },
	PlaceScheduledOrder: { schema: PlaceScheduledOrderSchema, strategy: "input" },
	PlaceScheduledOrderResponse: {
		schema: PlaceScheduledOrderResponseSchema,
		strategy: "input",
	},
	UpdateScheduledOrder: {
		schema: UpdateScheduledOrderSchema,
		strategy: "input",
	},
	UpdateOrder: { schema: UpdateOrderSchema, strategy: "input" },
	EstimateOrder: { schema: EstimateOrderSchema, strategy: "input" },
	OrderKey: { schema: OrderKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

import * as z from "zod";
import type { SchemaRegistries } from "./common.js";
import { MerchantMenuSchema } from "./merchant.js";

// Individual cart item
export const CartItemSchema = z.object({
	menuId: z.uuid(),
	merchantId: z.uuid(),
	merchantName: z.string(),
	menuName: z.string(),
	menuImage: z.string().nullable(),
	unitPrice: z.coerce.number(),
	quantity: z.coerce.number().int().min(1).max(99),
	notes: z.string().nullable().optional(),
});

export type CartItem = z.infer<typeof CartItemSchema>;

// Full cart
export const CartSchema = z.object({
	merchantId: z.uuid(),
	merchantName: z.string(),
	items: z.array(CartItemSchema).min(1),
	totalItems: z.coerce.number().int().min(1),
	subtotal: z.coerce.number(),
	lastUpdated: z.coerce.date(),
});

export type Cart = z.infer<typeof CartSchema>;

// Helper schemas for operations
export const AddToCartSchema = z.object({
	menu: MerchantMenuSchema,
	quantity: z.coerce.number().int().min(1).max(99).default(1),
	notes: z.string().nullable().optional(),
});

export type AddToCart = z.infer<typeof AddToCartSchema>;

// Registry for schema extraction
export const CartSchemaRegistries = {
	CartItem: { schema: CartItemSchema, strategy: "output" },
	Cart: { schema: CartSchema, strategy: "output" },
	AddToCart: { schema: AddToCartSchema, strategy: "input" },
} satisfies SchemaRegistries;

import * as z from "zod";
import type { SchemaRegistries } from "./common.js";
import { MerchantCategorySchema, MerchantMenuSchema } from "./merchant.js";
import { CoordinateSchema } from "./position.js";

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
	// Stock info for validation
	stock: z.coerce.number().int().nonnegative().optional(),
});

export type CartItem = z.infer<typeof CartItemSchema>;

// Full cart with merchant metadata
export const CartSchema = z.object({
	merchantId: z.uuid(),
	merchantName: z.string(),
	merchantLocation: CoordinateSchema.optional(),
	merchantCategory: MerchantCategorySchema.optional(),
	items: z.array(CartItemSchema),
	totalItems: z.coerce.number().int().nonnegative(),
	subtotal: z.coerce.number(),
	attachmentUrl: z.string().nullable().optional(),
	lastUpdated: z.coerce.date(),
});

export type Cart = z.infer<typeof CartSchema>;

// Add item to cart request
export const AddToCartRequestSchema = z.object({
	menuId: z.uuid(),
	quantity: z.coerce.number().int().min(1).max(99).default(1),
	notes: z.string().nullable().optional(),
	// Replace cart if merchant differs (optional - defaults to error)
	replaceIfConflict: z.boolean().optional().default(false),
});

export type AddToCartRequest = z.infer<typeof AddToCartRequestSchema>;

// Update cart item quantity request
export const UpdateCartItemRequestSchema = z.object({
	menuId: z.uuid(),
	delta: z.coerce.number().int().min(-99).max(99),
});

export type UpdateCartItemRequest = z.infer<typeof UpdateCartItemRequestSchema>;

// Remove cart item request
export const RemoveCartItemRequestSchema = z.object({
	menuId: z.uuid(),
});

export type RemoveCartItemRequest = z.infer<typeof RemoveCartItemRequestSchema>;

// Update cart attachment request
export const UpdateCartAttachmentRequestSchema = z.object({
	attachmentUrl: z.string().nullable(),
});

export type UpdateCartAttachmentRequest = z.infer<
	typeof UpdateCartAttachmentRequestSchema
>;

// Cart response with validation info
export const CartResponseSchema = z.object({
	cart: CartSchema.nullable(),
	// Stock validation warnings (items where quantity exceeds stock)
	stockWarnings: z
		.array(
			z.object({
				menuId: z.uuid(),
				menuName: z.string(),
				requestedQuantity: z.number(),
				availableStock: z.number(),
			}),
		)
		.optional(),
});

export type CartResponse = z.infer<typeof CartResponseSchema>;

// Helper schemas for operations (legacy - kept for backward compatibility)
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
	CartResponse: { schema: CartResponseSchema, strategy: "output" },
	AddToCart: { schema: AddToCartSchema, strategy: "input" },
	AddToCartRequest: { schema: AddToCartRequestSchema, strategy: "input" },
	UpdateCartItemRequest: {
		schema: UpdateCartItemRequestSchema,
		strategy: "input",
	},
	RemoveCartItemRequest: {
		schema: RemoveCartItemRequestSchema,
		strategy: "input",
	},
	UpdateCartAttachmentRequest: {
		schema: UpdateCartAttachmentRequestSchema,
		strategy: "input",
	},
} satisfies SchemaRegistries;

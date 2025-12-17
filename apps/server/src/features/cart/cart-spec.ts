import { oc } from "@orpc/contract";
import {
	AddToCartRequestSchema,
	CartResponseSchema,
	RemoveCartItemRequestSchema,
	UpdateCartItemRequestSchema,
} from "@repo/schema/cart";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const CartSpec = {
	/** Get current user's cart */
	get: oc
		.route({
			tags: [FEATURE_TAGS.CART],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({}))
		.output(createSuccesSchema(CartResponseSchema, "Cart retrieved")),

	/** Add item to cart */
	addItem: oc
		.route({
			tags: [FEATURE_TAGS.CART],
			method: "POST",
			path: "/items",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: AddToCartRequestSchema }))
		.output(createSuccesSchema(CartResponseSchema, "Item added to cart")),

	/** Update item quantity */
	updateItem: oc
		.route({
			tags: [FEATURE_TAGS.CART],
			method: "PATCH",
			path: "/items",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: UpdateCartItemRequestSchema }))
		.output(createSuccesSchema(CartResponseSchema, "Cart item updated")),

	/** Remove item from cart */
	removeItem: oc
		.route({
			tags: [FEATURE_TAGS.CART],
			method: "DELETE",
			path: "/items/{menuId}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: RemoveCartItemRequestSchema }))
		.output(createSuccesSchema(CartResponseSchema, "Item removed from cart")),

	/** Clear entire cart */
	clear: oc
		.route({
			tags: [FEATURE_TAGS.CART],
			method: "DELETE",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({}))
		.output(createSuccesSchema(z.null(), "Cart cleared")),
};

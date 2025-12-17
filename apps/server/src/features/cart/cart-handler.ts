import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import { CartSpec } from "./cart-spec";

const { priv } = createORPCRouter(CartSpec);

export const CartHandler = priv.router({
	get: priv.get.handler(async ({ context }) => {
		if (!context.user) {
			throw new AuthError("Authentication required", { code: "UNAUTHORIZED" });
		}

		const result = await context.repo.cart.get(context.user.id);

		return {
			status: 200,
			body: {
				message: "Cart retrieved",
				data: result,
			},
		};
	}),

	addItem: priv.addItem.handler(async ({ context, input: { body } }) => {
		if (!context.user) {
			throw new AuthError("Authentication required", { code: "UNAUTHORIZED" });
		}

		const data = trimObjectValues(body);
		const result = await context.repo.cart.addItem(context.user.id, data);

		return {
			status: 200,
			body: {
				message: "Item added to cart",
				data: result,
			},
		};
	}),

	updateItem: priv.updateItem.handler(async ({ context, input: { body } }) => {
		if (!context.user) {
			throw new AuthError("Authentication required", { code: "UNAUTHORIZED" });
		}

		const result = await context.repo.cart.updateItem(context.user.id, body);

		return {
			status: 200,
			body: {
				message: "Cart item updated",
				data: result,
			},
		};
	}),

	removeItem: priv.removeItem.handler(
		async ({ context, input: { params } }) => {
			if (!context.user) {
				throw new AuthError("Authentication required", {
					code: "UNAUTHORIZED",
				});
			}

			const result = await context.repo.cart.removeItem(
				context.user.id,
				params.menuId,
			);

			return {
				status: 200,
				body: {
					message: "Item removed from cart",
					data: result,
				},
			};
		},
	),

	clear: priv.clear.handler(async ({ context }) => {
		if (!context.user) {
			throw new AuthError("Authentication required", { code: "UNAUTHORIZED" });
		}

		await context.repo.cart.clear(context.user.id);

		return {
			status: 200,
			body: {
				message: "Cart cleared",
				data: null,
			},
		};
	}),
});

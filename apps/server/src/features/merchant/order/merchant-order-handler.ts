import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import { MerchantOrderSpec } from "./merchant-order-spec";

const { priv } = createORPCRouter(MerchantOrderSpec);

export const MerchantOrderHandler = priv.router({
	accept: priv.accept.handler(async ({ context, input: { params } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can accept orders
		if (
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError("Access denied: Only merchants can accept orders", {
				code: "FORBIDDEN",
			});
		}

		return await context.svc.db.transaction(async (tx) => {
			// Get merchant ID from logged-in user
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);

			const result = await context.repo.merchant.order.acceptOrder(
				params.id,
				merchant.id,
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_order_accepted(), data: result },
			};
		});
	}),

	reject: priv.reject.handler(async ({ context, input: { params, body } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can reject orders
		if (
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError("Access denied: Only merchants can reject orders", {
				code: "FORBIDDEN",
			});
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);

			// Get merchant ID from logged-in user
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);

			const result = await context.repo.merchant.order.rejectOrder(
				params.id,
				merchant.id,
				data.reason,
				data.note,
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_order_rejected(), data: result },
			};
		});
	}),

	markPreparing: priv.markPreparing.handler(
		async ({ context, input: { params } }) => {
			// Only MERCHANT, ADMIN, and OPERATOR can mark orders as preparing
			if (
				context.user.role !== "MERCHANT" &&
				context.user.role !== "ADMIN" &&
				context.user.role !== "OPERATOR"
			) {
				throw new AuthError(
					"Access denied: Only merchants can update order status",
					{
						code: "FORBIDDEN",
					},
				);
			}

			return await context.svc.db.transaction(async (tx) => {
				// Get merchant ID from logged-in user
				const merchant = await context.repo.merchant.main.getByUserId(
					context.user.id,
				);

				const result = await context.repo.merchant.order.markPreparing(
					params.id,
					merchant.id,
					{ tx },
				);

				return {
					status: 200,
					body: {
						message: m.server_order_preparing(),
						data: result,
					},
				};
			});
		},
	),

	markReady: priv.markReady.handler(async ({ context, input: { params } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can mark orders as ready
		if (
			context.user.role !== "MERCHANT" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError(
				"Access denied: Only merchants can update order status",
				{
					code: "FORBIDDEN",
				},
			);
		}

		return await context.svc.db.transaction(async (tx) => {
			// Get merchant ID from logged-in user
			const merchant = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);

			const result = await context.repo.merchant.order.markReady(
				params.id,
				merchant.id,
				{ tx },
			);

			return {
				status: 200,
				body: {
					message: m.server_order_ready(),
					data: result,
				},
			};
		});
	}),
});

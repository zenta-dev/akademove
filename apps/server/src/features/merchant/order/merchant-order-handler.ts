import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { BUSINESS_CONSTANTS, DRIVER_POOL_KEY } from "@/core/constants";
import { AuthError } from "@/core/error";
import { shouldBypassAuthorization } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import {
	OrderQueueService,
	ProcessingQueueService,
} from "@/core/services/queue";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { OrderRefundService } from "@/features/order/services/order-refund-service";
import { logger } from "@/utils/logger";
import { MerchantOrderSpec } from "./merchant-order-spec";

const { priv } = createORPCRouter(MerchantOrderSpec);

export const MerchantOrderHandler = priv.router({
	accept: priv.accept.handler(async ({ context, input: { params } }) => {
		// Only MERCHANT, ADMIN, and OPERATOR can accept orders
		if (
			!shouldBypassAuthorization() &&
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
			!shouldBypassAuthorization() &&
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
				!shouldBypassAuthorization() &&
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
			!shouldBypassAuthorization() &&
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

			// Mark order as ready first (updates status to READY_FOR_PICKUP)
			const readyOrder = await context.repo.merchant.order.markReady(
				params.id,
				merchant.id,
				{ tx },
			);

			logger.info(
				{ orderId: readyOrder.id, merchantId: merchant.id },
				"[MerchantOrderHandler] Merchant marked order as ready, triggering driver matching",
			);

			// For merchant orders (FOOD), now trigger driver matching
			// Update order status to MATCHING and broadcast to driver pool
			const updatedOrder = await context.repo.order.update(
				readyOrder.id,
				{ status: "MATCHING" },
				{ tx },
			);

			logger.info(
				{ orderId: updatedOrder.id },
				"[MerchantOrderHandler] Order moved to MATCHING after merchant ready",
			);

			// Get payment info for the order to setup refund if matching fails
			const paymentTransaction =
				await OrderRefundService.findPaymentTransaction(tx, updatedOrder.id);
			const payment = paymentTransaction
				? await OrderRefundService.findPayment(tx, paymentTransaction.id)
				: null;

			// Enqueue timeout job for driver matching (uses configured timeout)
			try {
				const businessConfig = await BusinessConfigurationService.getConfig(
					context.svc.db,
					context.svc.kv,
				);

				const timeoutMinutes = businessConfig.driverMatchingTimeoutMinutes;
				const timeoutSeconds = timeoutMinutes * 60;

				await OrderQueueService.enqueueOrderTimeout(
					{
						orderId: updatedOrder.id,
						userId: updatedOrder.userId,
						paymentId: payment?.id,
						totalPrice: updatedOrder.totalPrice,
						timeoutReason: `No driver found within ${timeoutMinutes} minutes`,
						processRefund: true,
					},
					timeoutSeconds,
				);

				logger.info(
					{
						orderId: updatedOrder.id,
						timeoutMinutes,
					},
					"[MerchantOrderHandler] Order timeout job enqueued after merchant ready",
				);
			} catch (queueError) {
				// Log but don't fail - cron fallback will handle stuck orders
				logger.error(
					{ error: queueError, orderId: updatedOrder.id },
					"[MerchantOrderHandler] Failed to enqueue timeout job - cron will handle",
				);
			}

			// Broadcast to driver pool to start driver matching with delay
			// Uses queue-based delayed broadcast to allow WebSocket clients time to connect
			try {
				await ProcessingQueueService.enqueueWebSocketBroadcast(
					{
						roomName: DRIVER_POOL_KEY,
						action: "MATCHING",
						target: "SYSTEM",
						data: {
							detail: {
								order: updatedOrder,
								payment: payment ?? null,
								transaction: paymentTransaction ?? null,
							},
						},
					},
					{ delaySeconds: BUSINESS_CONSTANTS.BROADCAST_DELAY_SECONDS },
				);

				logger.info(
					{ orderId: updatedOrder.id },
					"[MerchantOrderHandler] Delayed broadcast enqueued to driver pool for driver matching",
				);
			} catch (broadcastError) {
				// Log but don't fail - WebSocket broadcast is best-effort
				logger.error(
					{ error: broadcastError, orderId: updatedOrder.id },
					"[MerchantOrderHandler] Failed to enqueue driver pool broadcast",
				);
			}

			return {
				status: 200,
				body: {
					message: m.server_order_ready(),
					data: updatedOrder,
				},
			};
		});
	}),
});

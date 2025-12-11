import { env } from "cloudflare:workers";
import { m } from "@repo/i18n";
import type { OrderStatus, OrderType } from "@repo/schema/order";
import type { Payment } from "@repo/schema/payment";
import type { Transaction } from "@repo/schema/transaction";
import { nullsToUndefined } from "@repo/shared";
import Decimal from "decimal.js";
import { eq } from "drizzle-orm";
import { DRIVER_POOL_KEY } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import { tables } from "@/core/services/db";
import type { PaymentDatabase } from "@/core/tables/payment";
import { OrderStateService } from "@/features/order/services/order-state-service";
import { delay, toNumberSafe, toStringNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
import { generateOrderCode } from "@/utils/uuid";
import { PaymentChargeService } from "./payment-charge-service";

/**
 * Webhook processing request
 */
export interface WebhookProcessRequest {
	order_id: string;
	transaction_status: string;
	metadata: {
		type: OrderType | "TOPUP";
		orderId?: string;
		customerId?: string;
		[key: string]: unknown;
	};
	[key: string]: unknown;
}

/**
 * Dependencies for webhook processing
 */
export interface WebhookProcessDeps {
	tx: WithTx["tx"];
	updatePayment: (
		id: string,
		data: { status: Payment["status"]; updatedAt: Date },
	) => Promise<Payment>;
	updateTransaction: (
		id: string,
		data: {
			status: Transaction["status"];
			balanceBefore?: number;
			balanceAfter?: number;
		},
		opts?: Partial<WithTx>,
	) => Promise<Transaction>;
	sendNotification: (
		data: {
			fromUserId: string;
			toUserId: string;
			title: string;
			body: string;
			data?: Record<string, unknown>;
			android?: {
				priority?: "normal" | "high";
				notification?: { clickAction?: string };
			};
			apns?: { payload?: { aps?: { category?: string; sound?: string } } };
			webpush?: { fcmOptions?: { link?: string } };
		},
		opts?: Partial<WithTx>,
	) => Promise<unknown>;
}

/**
 * Service responsible for processing payment webhooks from Midtrans
 *
 * Handles:
 * - Idempotency checks (prevent duplicate processing)
 * - Payment expiration logic
 * - Top-up success (wallet balance increase)
 * - Order payment success (trigger order matching)
 * - WebSocket notifications
 * - Push notifications
 *
 * @example
 * ```typescript
 * const webhookService = new PaymentWebhookService(db);
 *
 * await webhookService.processWebhook(webhookBody, {
 *   tx,
 *   updatePayment,
 *   updateTransaction,
 *   sendNotification
 * });
 * ```
 */
export class PaymentWebhookService {
	/**
	 * Processes Midtrans webhook notification
	 *
	 * Process flow:
	 * 1. Validates payment exists
	 * 2. Checks idempotency (skip if already processed)
	 * 3. Routes to appropriate handler based on status:
	 *    - expire → handleExpiredPayment
	 *    - settlement/success → handleTopUpSuccess or handleOrderPaymentSuccess
	 *
	 * @param body - Webhook request body from Midtrans
	 * @param deps - Dependencies (tx, updatePayment, updateTransaction, sendNotification)
	 * @throws RepositoryError if payment not found or processing fails
	 */
	async processWebhook(
		body: WebhookProcessRequest,
		deps: WebhookProcessDeps,
	): Promise<void> {
		try {
			const { tx, updatePayment, updateTransaction, sendNotification } = deps;

			logger.debug({ body }, "[PaymentWebhookService] processWebhook");

			const paymentId = body.order_id;
			const status = body.transaction_status;

			// Skip pending status (no action needed)
			if (status === "pending") return;

			const payment = await tx.query.payment.findFirst({
				where: (f, op) => op.eq(f.externalId, paymentId),
			});
			const transactionId = payment?.transactionId;

			if (!payment || !transactionId) {
				throw new RepositoryError(`Payment with id ${paymentId} not found`, {
					code: "NOT_FOUND",
				});
			}

			// CRITICAL: Idempotency check - prevent duplicate processing
			if (
				payment.status === "SUCCESS" ||
				payment.status === "REFUNDED" ||
				payment.status === "EXPIRED"
			) {
				logger.warn(
					{ paymentId, currentStatus: payment.status, webhookStatus: status },
					"[PaymentWebhookService] Webhook already processed - idempotent response",
				);
				return; // Idempotent - already processed
			}

			// Route to appropriate handler based on webhook status
			if (status === "expire") {
				await this.handleExpiredPayment({
					tx,
					payment,
					transactionId,
					updatePayment,
					updateTransaction,
					sendNotification,
				});
			}

			if (status === "settlement" || status === "success") {
				const type = body.metadata.type;
				if (type === "TOPUP") {
					await this.handleTopUpSuccess({
						tx,
						payment,
						transactionId,
						updatePayment,
						updateTransaction,
						sendNotification,
					});
				}
				if (type === "RIDE" || type === "FOOD" || type === "DELIVERY") {
					const orderId = body.metadata.orderId as string;
					const customerId = body.metadata.customerId as string;
					await this.handleOrderPaymentSuccess({
						tx,
						orderId,
						customerId,
						payment,
						transactionId,
						type,
						updatePayment,
						updateTransaction,
						sendNotification,
					});
				}
			}
		} catch (error) {
			logger.error(
				{ error },
				"[PaymentWebhookService] Failed to process webhook",
			);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(m.error_failed_process_webhook(), {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Handles expired payment webhook
	 *
	 * Process:
	 * 1. Updates payment status to EXPIRED
	 * 2. Updates transaction status to EXPIRED
	 * 3. Sends WebSocket notification
	 * 4. Sends push notification
	 *
	 * @param params - Payment, transaction, and dependencies
	 */
	async handleExpiredPayment(params: {
		tx: WithTx["tx"];
		payment: PaymentDatabase;
		transactionId: string;
		updatePayment: WebhookProcessDeps["updatePayment"];
		updateTransaction: WebhookProcessDeps["updateTransaction"];
		sendNotification: WebhookProcessDeps["sendNotification"];
	}): Promise<void> {
		const {
			tx,
			payment,
			transactionId,
			updatePayment,
			updateTransaction,
			sendNotification,
		} = params;

		const [updatedPayment, transaction] = await Promise.all([
			updatePayment(payment.id, { status: "EXPIRED", updatedAt: new Date() }),
			tx.query.transaction.findFirst({
				with: { wallet: true },
				where: (f, op) => op.eq(f.id, transactionId),
			}),
		]);

		if (!transaction) {
			throw new RepositoryError(
				`Transaction with id ${transactionId} not found`,
				{ code: "NOT_FOUND" },
			);
		}

		const updatedTransaction = await updateTransaction(
			transaction.id,
			{ status: "EXPIRED" },
			{ tx },
		);

		const paymentStub = this.#getPaymentRoomStub(payment.id);
		const composedPayment = PaymentChargeService.composeEntity(
			updatedPayment as unknown as PaymentDatabase,
		);

		const tasks: Promise<unknown>[] = [];
		const userId = transaction.wallet.userId;

		if (transaction.type === "TOPUP") {
			tasks.push(
				paymentStub.broadcast({
					e: "TOP_UP_FAILED",
					f: "s",
					t: "c",
					tg: "USER",
					p: {
						failReason: "Payment expired",
						payment: composedPayment,
						transaction: updatedTransaction,
					},
				}),
			);
			tasks.push(
				sendNotification(
					{
						fromUserId: userId,
						toUserId: userId,
						title: "Top up failed",
						body: `Top up with id ${transaction.id} failed`,
					},
					{ tx },
				),
			);
		}

		if (transaction.type === "PAYMENT") {
			tasks.push(
				paymentStub.broadcast({
					e: "PAYMENT_FAILED",
					f: "s",
					t: "c",
					tg: "USER",
					p: {
						failReason: "Payment expired",
						payment: composedPayment,
						transaction: updatedTransaction,
					},
				}),
			);
			tasks.push(
				sendNotification(
					{
						fromUserId: userId,
						toUserId: userId,
						title: "Payment failed",
						body: `Payment with id ${transaction.id} failed`,
					},
					{ tx },
				),
			);
		}

		await Promise.allSettled(tasks);
	}

	/**
	 * Handles successful top-up payment webhook
	 *
	 * Process:
	 * 1. Updates payment status to SUCCESS
	 * 2. Atomically increases wallet balance
	 * 3. Updates transaction with SUCCESS + balance info
	 * 4. Sends WebSocket notification
	 * 5. Sends push notification
	 *
	 * @param params - Payment, transaction, and dependencies
	 */
	async handleTopUpSuccess(params: {
		tx: WithTx["tx"];
		payment: PaymentDatabase;
		transactionId: string;
		updatePayment: WebhookProcessDeps["updatePayment"];
		updateTransaction: WebhookProcessDeps["updateTransaction"];
		sendNotification: WebhookProcessDeps["sendNotification"];
	}): Promise<void> {
		const {
			tx,
			payment,
			transactionId,
			updatePayment,
			updateTransaction,
			sendNotification,
		} = params;

		const [updatedPayment, transaction] = await Promise.all([
			updatePayment(payment.id, { status: "SUCCESS", updatedAt: new Date() }),
			tx.query.transaction.findFirst({
				with: { wallet: true },
				where: (f, op) => op.eq(f.id, transactionId),
			}),
		]);

		if (!transaction) {
			throw new RepositoryError(
				`Transaction with id ${transactionId} not found`,
				{ code: "NOT_FOUND" },
			);
		}

		const wallet = transaction.wallet;
		const safeCurrentBalance = new Decimal(wallet.balance);
		const safeAmount = new Decimal(transaction.amount);
		const safeNewBalance = safeCurrentBalance.plus(safeAmount);
		const newBalance = toStringNumberSafe(safeNewBalance);

		// Atomically update wallet balance
		const [updatedWallet] = await tx
			.update(tables.wallet)
			.set({
				balance: newBalance,
				updatedAt: new Date(),
			})
			.where(eq(tables.wallet.id, wallet.id))
			.returning();

		// Update transaction with balance info
		const updatedTransaction = await updateTransaction(
			transaction.id,
			{
				status: "SUCCESS",
				balanceBefore: toNumberSafe(wallet.balance),
				balanceAfter: toNumberSafe(newBalance),
			},
			{ tx },
		);

		const paymentStub = this.#getPaymentRoomStub(payment.id);
		const composedPayment = PaymentChargeService.composeEntity(
			updatedPayment as unknown as PaymentDatabase,
		);
		const composedWallet = {
			...wallet,
			balance: toNumberSafe(updatedWallet.balance),
			updatedAt: updatedWallet.updatedAt,
		};

		const userId = wallet.userId;
		const tasks: Promise<unknown>[] = [
			paymentStub.broadcast({
				e: "TOP_UP_SUCCESS",
				f: "s",
				t: "c",
				tg: "USER",
				p: {
					payment: composedPayment,
					transaction: updatedTransaction,
					wallet: composedWallet,
				},
			}),
			sendNotification(
				{
					fromUserId: userId,
					toUserId: userId,
					title: "Top up success",
					body: `Top up Rp ${toNumberSafe(transaction.amount)} success`,
				},
				{ tx },
			),
		];

		await Promise.allSettled(tasks);
	}

	/**
	 * Handles successful order payment webhook
	 *
	 * Process:
	 * 1. Updates payment status to SUCCESS
	 * 2. Updates transaction status to SUCCESS
	 * 3. Updates order status to MATCHING
	 * 4. Sends WebSocket notification to payment room
	 * 5. Triggers order matching via OrderRoom WebSocket
	 * 6. Sends push notification to customer
	 * 7. If merchant order: sends push notification to merchant
	 *
	 * @param params - Order, payment, transaction, and dependencies
	 */
	async handleOrderPaymentSuccess(params: {
		tx: WithTx["tx"];
		orderId: string;
		customerId: string;
		payment: PaymentDatabase;
		transactionId: string;
		type: OrderType;
		updatePayment: WebhookProcessDeps["updatePayment"];
		updateTransaction: WebhookProcessDeps["updateTransaction"];
		sendNotification: WebhookProcessDeps["sendNotification"];
	}): Promise<void> {
		const {
			tx,
			orderId,
			customerId,
			payment,
			transactionId,
			updatePayment,
			updateTransaction,
			sendNotification,
		} = params;

		const [updatedPayment, transaction, order] = await Promise.all([
			updatePayment(payment.id, { status: "SUCCESS", updatedAt: new Date() }),
			tx.query.transaction.findFirst({
				with: { wallet: true },
				where: (f, op) => op.eq(f.id, transactionId),
			}),
			tx.query.order.findFirst({
				with: {
					user: { columns: { name: true } },
					driver: { columns: {}, with: { user: { columns: { name: true } } } },
					merchant: {
						columns: { name: true },
						with: { user: { columns: { id: true } } },
					},
					items: { columns: { quantity: true } },
				},
				where: (f, op) => op.eq(f.id, orderId),
			}),
		]);

		if (!transaction) {
			throw new RepositoryError(
				`Transaction with id ${transactionId} not found`,
				{ code: "NOT_FOUND" },
			);
		}
		if (!order) {
			throw new RepositoryError(`Order with id ${orderId} not found`, {
				code: "NOT_FOUND",
			});
		}

		// Validate state transition before updating
		const currentStatus = order.status as OrderStatus;
		const stateService = new OrderStateService();

		// Only proceed if order is in REQUESTED status (waiting for payment)
		if (currentStatus !== "REQUESTED") {
			logger.warn(
				{ orderId, currentStatus },
				"[PaymentWebhookService] Order not in REQUESTED status, skipping status update",
			);
			// Don't throw error - payment was still successful, but order may have been updated already
			return;
		}

		// Validate transition using state machine
		stateService.validateTransition(currentStatus, "MATCHING");

		// Update transaction and order status
		const [updatedTransaction] = await Promise.all([
			updateTransaction(transaction.id, { status: "SUCCESS" }, { tx }),
			tx
				.update(tables.order)
				.set({ status: "MATCHING", updatedAt: new Date() })
				.where(eq(tables.order.id, order.id)),
			// Record status change in audit trail
			tx
				.insert(tables.orderStatusHistory)
				.values({
					orderId: order.id,
					previousStatus: currentStatus,
					newStatus: "MATCHING",
					changedBy: undefined,
					changedByRole: "SYSTEM",
					reason: "Payment successful, order moved to matching",
					changedAt: new Date(),
				}),
		]);

		const paymentStub = this.#getPaymentRoomStub(payment.id);
		const orderStub = this.#getOrderRoomStub(DRIVER_POOL_KEY);

		const composedPayment = PaymentChargeService.composeEntity(
			updatedPayment as unknown as PaymentDatabase,
		);
		// Compose order with proper decimal conversions for WebSocket broadcasting
		// biome-ignore lint/suspicious/noExplicitAny: Complex order type with runtime decimal conversions
		const composedOrder: any = nullsToUndefined({
			...order,
			status: "MATCHING" as const,
			basePrice: toNumberSafe(order.basePrice),
			totalPrice: toNumberSafe(order.totalPrice),
			tip: order.tip ? toNumberSafe(order.tip) : undefined,
			platformCommission: order.platformCommission
				? toNumberSafe(order.platformCommission)
				: undefined,
			driverEarning: order.driverEarning
				? toNumberSafe(order.driverEarning)
				: undefined,
			merchantCommission: order.merchantCommission
				? toNumberSafe(order.merchantCommission)
				: undefined,
			discountAmount: order.discountAmount
				? toNumberSafe(order.discountAmount)
				: undefined,
		});
		const composedWallet = {
			...transaction.wallet,
			balance: toNumberSafe(transaction.wallet.balance),
		};

		const tasks: Promise<unknown>[] = [
			// Notify payment room
			paymentStub.broadcast({
				e: "PAYMENT_SUCCESS",
				f: "s",
				t: "c",
				tg: "USER",
				p: {
					payment: composedPayment,
					transaction: updatedTransaction,
					wallet: composedWallet,
				},
			}),
			// Trigger order matching (delayed by 500ms)
			delay(500, () =>
				orderStub.broadcast({
					a: "MATCHING",
					f: "s",
					t: "s",
					tg: "SYSTEM",
					p: {
						detail: {
							payment: composedPayment,
							order: composedOrder,
							transaction: updatedTransaction,
						},
					},
				}),
			),
			// Notify customer
			sendNotification(
				{
					fromUserId: customerId,
					toUserId: order.userId,
					title: "Akademove Payment Success",
					body: `Payment for ${generateOrderCode(order.id)} success.`,
				},
				{ tx },
			),
		];

		// If merchant order: notify merchant via WebSocket and push notification
		const merchantUserId = order.merchant?.user.id;
		const merchantId = order.merchantId;
		if (merchantId && merchantUserId) {
			const itemCount = order.items.reduce((sum, i) => sum + i.quantity, 0);
			const orderUrl = `${env.CORS_ORIGIN}/dash/merchant/orders/${order.id}`;

			// Broadcast new order to merchant's WebSocket room for real-time dashboard updates
			const merchantRoomStub = this.#getMerchantRoomStub(merchantId);
			tasks.push(
				merchantRoomStub.broadcast({
					e: "NEW_ORDER",
					f: "s",
					t: "c",
					tg: "MERCHANT",
					p: {
						order: composedOrder,
						orderId: order.id,
						merchantId,
						itemCount,
						totalAmount: toNumberSafe(order.totalPrice),
					},
				}),
			);

			// Also send push notification for when merchant is not connected
			tasks.push(
				sendNotification(
					{
						fromUserId: customerId,
						toUserId: merchantUserId,
						title: "New Order Received",
						body: `You have a new order (#${order.id}) with ${itemCount} item${itemCount > 1 ? "s" : ""}. Tap to view details.`,
						data: {
							type: "NEW_ORDER",
							orderId: order.id,
							merchantId,
							deeplink: "akademove://merchant/order",
						},
						android: {
							priority: "high",
							notification: { clickAction: "MERCHANT_OPEN_ORDER_DETAIL" },
						},
						apns: {
							payload: { aps: { category: "ORDER_DETAIL", sound: "default" } },
						},
						webpush: { fcmOptions: { link: orderUrl } },
					},
					{ tx },
				),
			);
		}

		await Promise.allSettled(tasks);
	}

	/**
	 * Gets payment room Durable Object stub for WebSocket broadcasting
	 *
	 * @param paymentId - Payment ID (used as room name)
	 * @returns Durable Object stub
	 */
	#getPaymentRoomStub(paymentId: string) {
		const stubId = env.PAYMENT_ROOM.idFromName(paymentId);
		return env.PAYMENT_ROOM.get(stubId);
	}

	/**
	 * Gets order room Durable Object stub for WebSocket broadcasting
	 *
	 * @param roomName - Room name (typically DRIVER_POOL_KEY)
	 * @returns Durable Object stub
	 */
	#getOrderRoomStub(roomName: string) {
		const stubId = env.ORDER_ROOM.idFromName(roomName);
		return env.ORDER_ROOM.get(stubId);
	}

	/**
	 * Gets merchant room Durable Object stub for WebSocket broadcasting
	 *
	 * @param merchantId - Merchant ID (used as room name)
	 * @returns Durable Object stub
	 */
	#getMerchantRoomStub(merchantId: string) {
		const stubId = env.MERCHANT_ROOM.idFromName(merchantId);
		return env.MERCHANT_ROOM.get(stubId);
	}
}

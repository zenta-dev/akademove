import { env } from "cloudflare:workers";
import { m } from "@repo/i18n";
import type { OrderStatus, OrderType } from "@repo/schema/order";
import type { Payment } from "@repo/schema/payment";
import type { Transaction } from "@repo/schema/transaction";
import { nullsToUndefined } from "@repo/shared";
import Decimal from "decimal.js";
import { eq } from "drizzle-orm";
import { BUSINESS_CONSTANTS, DRIVER_POOL_KEY } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import { tables } from "@/core/services/db";
import {
	OrderQueueService,
	ProcessingQueueService,
} from "@/core/services/queue";
import type { PaymentDatabase } from "@/core/tables/payment";
import { BusinessConfigurationService } from "@/features/configuration/services/business-configuration-service";
import { OrderStateService } from "@/features/order/services/order-state-service";
import { toNumberSafe, toStringNumberSafe } from "@/utils";
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
						data: {
							type: "TOPUP_FAILED",
							transactionId: transaction.id,
							deeplink: "akademove://wallet",
						},
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
						data: {
							type: "PAYMENT_FAILED",
							transactionId: transaction.id,
							deeplink: "akademove://wallet",
						},
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
					data: {
						type: "TOPUP_SUCCESS",
						transactionId: transaction.id,
						amount: String(toNumberSafe(transaction.amount)),
						deeplink: "akademove://wallet",
					},
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
	 * 3. Updates order status:
	 *    - FOOD orders: Stay in REQUESTED (wait for merchant acceptance)
	 *    - RIDE/DELIVERY orders: Move to MATCHING (start driver search)
	 * 4. Sends WebSocket notification to payment room
	 * 5. For RIDE/DELIVERY: Triggers order matching via driver pool broadcast
	 * 6. For FOOD: Notifies merchant via WebSocket and push notification
	 * 7. Sends push notification to customer
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
					user: { columns: { name: true, image: true } },
					driver: {
						columns: {},
						with: { user: { columns: { name: true, image: true } } },
					},
					merchant: {
						columns: { name: true },
						with: { user: { columns: { id: true } } },
					},
					items: {
						with: {
							menu: true,
						},
					},
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

		// Determine new status based on order type:
		// - FOOD orders: Stay in REQUESTED, merchant must accept first
		// - RIDE/DELIVERY orders: Move to MATCHING for driver search
		const isFoodOrder = params.type === "FOOD";
		const newStatus = isFoodOrder ? "REQUESTED" : "MATCHING";

		// Validate transition using state machine (only for non-FOOD orders that change status)
		if (!isFoodOrder) {
			stateService.validateTransition(currentStatus, "MATCHING");
		}

		// Update transaction and order status
		// For FOOD orders, status stays REQUESTED so we only update transaction
		const updatedTransaction = await updateTransaction(
			transaction.id,
			{ status: "SUCCESS" },
			{ tx },
		);

		// Only update order status and add history for non-FOOD orders
		if (!isFoodOrder) {
			await Promise.all([
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
		}

		const paymentStub = this.#getPaymentRoomStub(payment.id);

		const composedPayment = PaymentChargeService.composeEntity(
			updatedPayment as unknown as PaymentDatabase,
		);

		// Transform order items to expected format: { quantity, item: MerchantMenu }
		const composedItems = order.items
			?.filter(
				(item): item is typeof item & { menu: NonNullable<typeof item.menu> } =>
					item.menu !== null,
			)
			.map((item) => ({
				quantity: item.quantity,
				item: {
					id: item.menu.id,
					merchantId: item.menu.merchantId,
					name: item.menu.name,
					category: item.menu.category ?? undefined,
					price: toNumberSafe(item.menu.price),
					stock: item.menu.stock,
					image: item.menu.image ?? undefined,
					createdAt: item.menu.createdAt,
					updatedAt: item.menu.updatedAt,
				},
			}));

		// Destructure to exclude raw items, then add transformed items
		const { items: _rawItems, ...orderWithoutItems } = order;

		// Compose order with proper decimal conversions for WebSocket broadcasting
		// biome-ignore lint/suspicious/noExplicitAny: Complex order type with runtime decimal conversions
		const composedOrder: any = nullsToUndefined({
			...orderWithoutItems,
			status: newStatus,
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
			items: composedItems,
			itemCount: composedItems?.length,
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
			// Notify customer
			sendNotification(
				{
					fromUserId: customerId,
					toUserId: order.userId,
					title: "Akademove Payment Success",
					body: `Payment for ${generateOrderCode(order.id)} success.`,
					data: {
						type: "PAYMENT_SUCCESS",
						orderId: order.id,
						deeplink: `akademove://order/${order.id}`,
					},
				},
				{ tx },
			),
		];

		// For RIDE/DELIVERY orders: Trigger driver matching via driver pool broadcast
		// For FOOD orders: Skip driver pool - matching only starts after merchant marks READY_FOR_PICKUP
		if (!isFoodOrder) {
			try {
				// Fetch driver matching config from database
				// Note: We need to use tx as db here since we're inside a transaction
				const matchingConfig =
					await BusinessConfigurationService.getDriverMatchingConfig(
						tx as unknown as Parameters<
							typeof BusinessConfigurationService.getDriverMatchingConfig
						>[0],
						env.MAIN_KV as unknown as Parameters<
							typeof BusinessConfigurationService.getDriverMatchingConfig
						>[1],
					);

				// Enqueue driver matching job (which handles push notifications to drivers)
				// This is critical for notifying drivers - WebSocket alone is not enough
				await OrderQueueService.enqueueDriverMatching({
					orderId: order.id,
					pickupLocation: order.pickupLocation,
					orderType: order.type,
					genderPreference: order.genderPreference ?? undefined,
					userGender: order.gender ?? undefined,
					initialRadiusKm: matchingConfig.initialRadiusKm,
					maxRadiusKm: matchingConfig.maxRadiusKm,
					maxMatchingDurationMinutes: matchingConfig.timeoutMinutes,
					currentAttempt: 1,
					maxExpansionAttempts: Math.ceil(
						Math.log(
							matchingConfig.maxRadiusKm / matchingConfig.initialRadiusKm,
						) / Math.log(1 + matchingConfig.expansionRate),
					),
					expansionRate: matchingConfig.expansionRate,
					matchingIntervalSeconds: matchingConfig.intervalSeconds,
					broadcastLimit: matchingConfig.broadcastLimit,
					maxCancellationsPerDay: matchingConfig.maxCancellationsPerDay,
					paymentId: payment.id,
					excludedDriverIds: [],
					isRetry: false,
				});

				logger.info(
					{ orderId: order.id },
					"[PaymentWebhookService] Driver matching job enqueued after QRIS/Bank Transfer payment success",
				);
			} catch (matchingError) {
				// Log but don't fail the webhook - the cron rebroadcast will handle stuck orders
				logger.error(
					{ error: matchingError, orderId: order.id },
					"[PaymentWebhookService] Failed to enqueue driver matching job - cron will handle",
				);
			}

			// Trigger order matching with delayed broadcast via queue
			// Note: setTimeout doesn't work reliably in Cloudflare Workers due to security restrictions
			// @see https://developers.cloudflare.com/workers/runtime-apis/nodejs/timers/
			tasks.push(
				ProcessingQueueService.enqueueWebSocketBroadcast(
					{
						roomName: DRIVER_POOL_KEY,
						event: "MATCHING",
						target: "DRIVER",
						data: {
							detail: {
								payment: composedPayment,
								order: composedOrder,
								transaction: updatedTransaction,
							},
						},
					},
					{ delaySeconds: BUSINESS_CONSTANTS.BROADCAST_DELAY_SECONDS },
				),
			);

			logger.info(
				{ orderId: order.id, type: params.type },
				"[PaymentWebhookService] RIDE/DELIVERY order - enqueued driver pool broadcast for matching",
			);
		}

		// For FOOD orders: notify merchant via WebSocket and push notification
		// Merchant must accept before driver matching starts
		const merchantUserId = order.merchant?.user.id;
		const merchantId = order.merchantId;
		if (isFoodOrder && merchantId && merchantUserId) {
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

			logger.info(
				{ orderId: order.id, merchantId, merchantUserId },
				"[PaymentWebhookService] FOOD order - notified merchant, waiting for acceptance",
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

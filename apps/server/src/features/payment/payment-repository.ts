import { env } from "cloudflare:workers";
import type { ChargeResponse } from "@erhahahaa/midtrans-client-typescript";
import type { BankProvider } from "@repo/schema/common";
import type { OrderType } from "@repo/schema/order";
import {
	type InsertPayment,
	type Payment,
	type PaymentMethod,
	type PaymentProvider,
	type UpdatePayment,
	type VANumber,
	VANumberSchema,
	type WebhookRequest,
} from "@repo/schema/payment";
import type { Transaction, TransactionType } from "@repo/schema/transaction";
import type { Wallet } from "@repo/schema/wallet";
import { nullsToUndefined } from "@repo/shared";
import Decimal from "decimal.js";
import { eq, sql } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import {
	CACHE_TTLS,
	DRIVER_POOL_KEY,
	PAYMENT_EXPIRY_MINUTE,
} from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { PaymentService } from "@/core/services/payment";
import type { PaymentDatabase } from "@/core/tables/payment";
import { delay, log, toNumberSafe, toStringNumberSafe } from "@/utils";
import { generateOrderCode } from "@/utils/uuid";
import type { NotificationRepository } from "../notification/notification-repository";
import { OrderRepository } from "../order/order-repository";
import type { TransactionRepository } from "../transaction/transaction-repository";
import { WalletRepository } from "../wallet/wallet-repository";

export interface ChargePayload extends WithUserId {
	transactionType: Extract<TransactionType, "TOPUP" | "PAYMENT">;
	orderType: OrderType | "TOPUP";
	provider: PaymentProvider;
	amount: number;
	method: PaymentMethod;
	metadata?: Record<string, unknown>;
	bank?: BankProvider;
	va_number?: string;
}

interface HandleWebhookPayload extends WithTx {
	body: WebhookRequest;
}
export class PaymentRepository extends BaseRepository {
	readonly #paymentSvc: PaymentService;
	readonly #transaction: TransactionRepository;
	readonly #wallet: WalletRepository;
	readonly #notification: NotificationRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		paymentSvc: PaymentService,
		transaction: TransactionRepository,
		wallet: WalletRepository,
		notification: NotificationRepository,
	) {
		super("payment", kv, db);
		this.#paymentSvc = paymentSvc;
		this.#transaction = transaction;
		this.#wallet = wallet;
		this.#notification = notification;
	}

	static composeEntity(item: PaymentDatabase): Payment {
		return nullsToUndefined({
			...item,
			amount: toNumberSafe(item.amount),
		});
	}

	async #getFromDB(
		id: string,
		opts?: Partial<WithTx>,
	): Promise<Payment | undefined> {
		const result = await (opts?.tx ?? this.db).query.payment.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? PaymentRepository.composeEntity(result) : undefined;
	}

	async get(id: string, opts?: Partial<WithTx>) {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);
				if (!res) throw new RepositoryError("Failed to get driver from DB");
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async #insert(
		param: InsertPayment,
		opts?: Partial<WithTx>,
	): Promise<Payment> {
		try {
			const now = new Date();
			const [res] = await (opts?.tx ?? this.db)
				.insert(tables.payment)
				.values({
					...param,
					id: v7(),
					amount: toStringNumberSafe(param.amount),
					createdAt: now,
					updatedAt: now,
				})
				.returning();

			const payment = PaymentRepository.composeEntity(res);
			await this.setCache(payment.id, payment, {
				expirationTtl: CACHE_TTLS["1h"],
			});
			return payment;
		} catch (error) {
			throw this.handleError(error, "insert");
		}
	}

	async update(
		id: string,
		params: UpdatePayment,
		opts?: Partial<WithTx>,
	): Promise<Payment> {
		try {
			const [payment] = await (opts?.tx ?? this.db)
				.update(tables.payment)
				.set({
					...params,
					amount: params.amount ? toStringNumberSafe(params.amount) : undefined,
				})
				.where(eq(tables.payment.id, id))
				.returning();

			return PaymentRepository.composeEntity(payment);
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async charge(
		params: ChargePayload,
		opts: WithTx,
	): Promise<{ payment: Payment; transaction: Transaction; wallet: Wallet }> {
		try {
			const { provider, method, amount, userId, orderType, transactionType } =
				params;
			const { tx } = opts;
			const [wallet, user] = await Promise.all([
				this.#wallet.getByUserId(userId, opts),
				tx.query.user.findFirst({
					columns: { name: true, email: true, phone: true },
					where: (f, op) => op.eq(f.id, userId),
				}),
			]);
			if (!user) {
				throw new RepositoryError(`User with id ${userId} not found`, {
					code: "NOT_FOUND",
				});
			}

			// Handle wallet payment directly without external payment provider
			if (method === "WALLET") {
				return await this.#handleWalletPayment({
					wallet,
					amount,
					userId,
					orderType,
					transactionType,
					metadata: params.metadata,
					tx,
				});
			}

			let desc: string | undefined;

			switch (orderType) {
				case "TOPUP":
					desc = `Top-up ${method}`;
					break;
				case "RIDE":
				case "FOOD":
				case "DELIVERY":
					desc = "Payment";
					break;
			}

			const metadata = { ...params.metadata, type: orderType, desc };

			const transaction = await this.#transaction.insert({
				walletId: wallet.id,
				type: transactionType,
				amount,
				status: "PENDING",
				description: desc,
				metadata,
			});

			const expiresAt = new Date(
				Date.now() + PAYMENT_EXPIRY_MINUTE * 60 * 1000,
			);

			let paymentResponse: ChargeResponse;
			try {
				paymentResponse = (await this.#paymentSvc.charge({
					externalId: transaction.id,
					amount,
					customer: {
						...user,
						phone: `${user?.phone.countryCode}-${user?.phone.number}`,
					},
					expiry: { duration: PAYMENT_EXPIRY_MINUTE, unit: "minute" },
					method,
					metadata,
					bank: params.bank,
					va_number: params.va_number,
				})) as ChargeResponse;
			} catch (paymentError) {
				log.error(
					{ error: paymentError, transactionId: transaction.id },
					"[PaymentRepository] Payment gateway failed - transaction will be rolled back",
				);

				// Mark transaction as FAILED before re-throwing
				await this.#transaction.update(
					transaction.id,
					{ status: "FAILED" },
					{ tx },
				);

				throw new RepositoryError(
					"Payment gateway failed. Please try again later.",
					{
						code: "INTERNAL_SERVER_ERROR",
					},
				);
			}

			const actions = paymentResponse.actions;
			const action = actions?.find((val) => val.name === "generate-qr-code");

			const va_numbers = paymentResponse.va_numbers;
			let va_number: VANumber | undefined;
			if (va_numbers && Array.isArray(va_numbers) && va_numbers.length > 0) {
				const first = va_numbers[0];
				const parse = VANumberSchema.safeParse(first);
				if (parse.success) va_number = parse.data;
			} else if (params.bank?.toLowerCase() === "permata") {
				va_number = {
					bank: "permata",
					va_number: paymentResponse.permata_va_number || "",
				};
			}

			log.debug(
				{ paymentResponse, actions, va_numbers },
				`[${this.constructor.name}] - charge result`,
			);

			const payment = await this.#insert({
				transactionId: transaction.id,
				provider,
				method,
				bankProvider: params.bank,
				amount,
				status: "PENDING",
				externalId: transaction.id,
				expiresAt,
				response: paymentResponse,
				paymentUrl: action?.url,
				va_number: va_number,
				payload: { method, amount, userId, provider, metadata },
			});

			return { payment, transaction, wallet };
		} catch (error) {
			throw this.handleError(error, "top-up");
		}
	}

	async handleWebhookMidtrans(payload: HandleWebhookPayload): Promise<void> {
		try {
			const { body, tx } = payload;

			log.debug({ body }, "[PaymentRepository] handleWebhook");
			const paymentId = body.order_id;
			const status = body.transaction_status;
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
				log.warn(
					{ paymentId, currentStatus: payment.status, webhookStatus: status },
					"[PaymentRepository] Webhook already processed - idempotent response",
				);
				return; // Idempotent - already processed
			}

			if (status === "expire") {
				await this.#handleExpiredPayment({ tx, payment, transactionId });
			}

			if (status === "settlement" || status === "success") {
				const type = body.metadata.type as ChargePayload["orderType"];
				if (type === "TOPUP") {
					await this.#handleTopUpPaymentSuccess({ tx, payment, transactionId });
				}
				if (type === "RIDE" || type === "FOOD" || type === "DELIVERY") {
					const orderId = body.metadata.orderId as string;
					const customerId = body.metadata.customerId as string;
					await this.#handleOrderPaymentSuccess({
						tx,
						orderId,
						customerId,
						payment,
						transactionId,
						type,
					});
				}
			}
		} catch (error) {
			log.error({ error }, "Failed to process webhook");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to process webhook", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	static getRoomStubByName(name: string) {
		const stubId = env.PAYMENT_ROOM.idFromName(name);
		const stub = env.PAYMENT_ROOM.get(stubId);
		return stub;
	}

	async #handleExpiredPayment(
		params: {
			payment: PaymentDatabase;
			transactionId: string;
		} & WithTx,
	) {
		const opts = { tx: params.tx };

		const [updatedPayment, transaction] = await Promise.all([
			params.tx
				.update(tables.payment)
				.set({ status: "EXPIRED", updatedAt: new Date() })
				.where(eq(tables.payment.id, params.payment.id))
				.returning()
				.then(([r]) => r),
			params.tx.query.transaction.findFirst({
				with: { wallet: true },
				where: (f, op) => op.eq(f.id, params.transactionId),
			}),
		]);

		if (!transaction) {
			throw new RepositoryError(
				`Transaction with id ${params.transactionId} not found`,
				{ code: "NOT_FOUND" },
			);
		}

		const updatedTransaction = await this.#transaction.update(
			transaction.id,
			{ status: "EXPIRED" },
			opts,
		);

		const stub = PaymentRepository.getRoomStubByName(params.payment.id);

		const composedPayment = PaymentRepository.composeEntity(updatedPayment);

		const tasks: Promise<unknown>[] = [];

		const userId = transaction.wallet.userId;
		if (transaction.type === "TOPUP") {
			tasks.push(
				stub.broadcast({
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
				this.#notification.sendNotificationToUserId(
					{
						fromUserId: userId,
						toUserId: userId,
						title: "Top up failed",
						body: `Top up with id ${transaction.id} failed`,
					},
					opts,
				),
			);
		}
		if (transaction.type === "PAYMENT") {
			tasks.push(
				stub.broadcast({
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
				this.#notification.sendNotificationToUserId(
					{
						fromUserId: userId,
						toUserId: userId,
						title: "Payment failed",
						body: `Payment with id ${transaction.id} failed`,
					},
					opts,
				),
			);
		}

		await Promise.allSettled(tasks);
	}

	async #handleOrderPaymentSuccess(
		params: {
			orderId: string;
			customerId: string;
			payment: PaymentDatabase;
			transactionId: string;
			type: OrderType;
		} & WithTx,
	) {
		const { tx } = params;
		const [updatedPayment, transaction, order] = await Promise.all([
			tx
				.update(tables.payment)
				.set({ status: "SUCCESS", updatedAt: new Date() })
				.where(eq(tables.payment.id, params.payment.id))
				.returning()
				.then(([p]) => p),
			tx.query.transaction.findFirst({
				with: { wallet: true },
				where: (f, op) => op.eq(f.id, params.transactionId),
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
				where: (f, op) => op.eq(f.id, params.orderId),
			}),
		]);

		if (!transaction) {
			throw new RepositoryError(
				`Transaction with id ${params.transactionId} not found`,
				{ code: "NOT_FOUND" },
			);
		}
		if (!order) {
			throw new RepositoryError(`Order with id ${params.orderId} not found`, {
				code: "NOT_FOUND",
			});
		}

		const opts = { tx };

		const [updatedTransaction] = await Promise.all([
			this.#transaction.update(transaction.id, { status: "SUCCESS" }, opts),
			opts.tx
				.update(tables.order)
				.set({ status: "MATCHING" })
				.where(eq(tables.order.id, order.id)),
		]);

		const paymentStub = PaymentRepository.getRoomStubByName(params.payment.id);
		const orderStub = OrderRepository.getRoomStubByName(DRIVER_POOL_KEY);

		const composedPayment = PaymentRepository.composeEntity(updatedPayment);
		const composedOrder = OrderRepository.composeEntity({
			...order,
			status: "MATCHING",
		});
		const composedWallet = WalletRepository.composeEntity(transaction.wallet);

		const tasks: Promise<unknown>[] = [
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
			this.#notification.sendNotificationToUserId(
				{
					fromUserId: params.customerId,
					toUserId: order.userId,
					title: "Akademove Payment Success",
					body: `Payment for ${generateOrderCode(order.id)} success.`,
				},
				opts,
			),
		];

		const merchantUserId = order.merchant?.user.id;
		const merchantId = order.merchantId;
		if (merchantId && merchantUserId) {
			const itemCount = order.items.reduce((sum, i) => sum + i.quantity, 0);

			const orderUrl = `${env.CORS_ORIGIN}/dash/merchant/orders/${order.id}`;

			tasks.push(
				this.#notification.sendNotificationToUserId(
					{
						fromUserId: params.customerId,
						toUserId: merchantUserId,
						title: "📦 New Order Received",
						body: `You have a new order (#${order.id}) with ${itemCount} item${itemCount > 1 ? "s" : ""}. Tap to view details.`,
						data: {
							type: "NEW_ORDER",
							orderId: order.id,
							merchantId,
							deeplink: "akademove://merchant/order", // TODO: replace with actual android url
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
					opts,
				),
			);
		}

		await Promise.allSettled(tasks);
	}

	async #handleTopUpPaymentSuccess(
		params: {
			payment: PaymentDatabase;
			transactionId: string;
		} & WithTx,
	) {
		const opts = { tx: params.tx };
		const [[updatedPayment], transaction] = await Promise.all([
			params.tx
				.update(tables.payment)
				.set({ status: "SUCCESS", updatedAt: new Date() })
				.where(eq(tables.payment.id, params.payment.id))
				.returning(),
			params.tx.query.transaction.findFirst({
				with: { wallet: true },
				where: (f, op) => op.eq(f.id, params.transactionId),
			}),
		]);

		if (!transaction) {
			throw new RepositoryError(
				`Transaction with id ${params.transactionId} not found`,
				{ code: "NOT_FOUND" },
			);
		}

		const wallet = transaction.wallet;

		const safeCurrentBalance = new Decimal(wallet.balance);
		const safeAmount = new Decimal(transaction.amount);
		const safeNewBalance = safeCurrentBalance.plus(safeAmount);
		const newBalance = toStringNumberSafe(safeNewBalance);

		const [[updatedWallet], updatedTransaction] = await Promise.all([
			params.tx
				.update(tables.wallet)
				.set({
					balance: newBalance,
					updatedAt: new Date(),
				})
				.where(eq(tables.wallet.id, wallet.id))
				.returning(),
			this.#transaction.update(
				transaction.id,
				{
					status: "SUCCESS",
					balanceBefore: toNumberSafe(wallet.balance),
					balanceAfter: toNumberSafe(newBalance),
				},
				opts,
			),
		]);

		const paymentStub = PaymentRepository.getRoomStubByName(params.payment.id);

		const userId = wallet.userId;
		const tasks: Promise<unknown>[] = [
			paymentStub.broadcast({
				e: "TOP_UP_SUCCESS",
				f: "s",
				t: "c",
				tg: "USER",
				p: {
					payment: PaymentRepository.composeEntity(updatedPayment),
					transaction: updatedTransaction,
					wallet: WalletRepository.composeEntity(updatedWallet),
				},
			}),
			this.#notification.sendNotificationToUserId(
				{
					fromUserId: userId,
					toUserId: userId,
					title: "Top up success",
					body: `Top up Rp ${toNumberSafe(transaction.amount)} success`,
				},
				opts,
			),
		];

		await Promise.allSettled(tasks);
	}

	async #handleWalletPayment(
		params: {
			wallet: Wallet;
			amount: number;
			userId: string;
			orderType: ChargePayload["orderType"];
			transactionType: TransactionType;
			metadata?: Record<string, unknown>;
		} & WithTx,
	): Promise<{ payment: Payment; transaction: Transaction; wallet: Wallet }> {
		const { wallet, amount, orderType, transactionType, metadata, tx } = params;

		try {
			const amountDecimal = new Decimal(amount);
			const currentBalance = new Decimal(wallet.balance);
			const amountSql = toStringNumberSafe(amountDecimal);

			let desc: string | undefined;
			switch (orderType) {
				case "TOPUP":
					desc = "Top-up WALLET";
					break;
				case "RIDE":
				case "FOOD":
				case "DELIVERY":
					desc = `Payment for ${orderType}`;
					break;
			}

			const fullMetadata = { ...metadata, type: orderType, desc };

			// CRITICAL FIX: Atomic wallet deduction with balance check
			// This prevents race conditions and ensures balance never goes negative
			const [updatedWallet] = await tx
				.update(tables.wallet)
				.set({
					balance: sql`balance - ${amountSql}`,
					updatedAt: new Date(),
				})
				.where(
					sql`${tables.wallet.id} = ${wallet.id} AND balance >= ${amountSql}`,
				)
				.returning();

			if (!updatedWallet) {
				throw new RepositoryError("Insufficient wallet balance", {
					code: "BAD_REQUEST",
				});
			}

			const newBalance = new Decimal(updatedWallet.balance);
			const balanceBefore = toNumberSafe(currentBalance);
			const balanceAfter = toNumberSafe(newBalance);

			// Create transaction with SUCCESS status and balance info
			const transaction = await this.#transaction.insert({
				walletId: wallet.id,
				type: transactionType,
				amount,
				status: "SUCCESS",
				description: desc,
				metadata: fullMetadata,
				balanceBefore,
				balanceAfter,
			});

			// Create payment record
			const payment = await this.#insert(
				{
					transactionId: transaction.id,
					provider: "MIDTRANS",
					method: "WALLET",
					amount,
					status: "SUCCESS",
					externalId: transaction.id,
					expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000), // 24 hours
					response: { wallet_payment: true },
					payload: {
						method: "WALLET",
						amount,
						userId: params.userId,
						provider: "MIDTRANS",
						metadata: fullMetadata,
					},
				},
				{ tx },
			);

			return {
				payment,
				transaction,
				wallet: WalletRepository.composeEntity(updatedWallet),
			};
		} catch (error) {
			log.error(
				{ error, userId: params.userId, amount, walletId: wallet.id },
				"[PaymentRepository] Failed to handle wallet payment - transaction will be rolled back",
			);
			// Re-throw the error to trigger transaction rollback
			throw error;
		}
	}
}

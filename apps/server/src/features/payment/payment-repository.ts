import { env } from "cloudflare:workers";
import { m } from "@repo/i18n";
import type { BankProvider } from "@repo/schema/common";
import type { OrderType } from "@repo/schema/order";
import type {
	InsertPayment,
	Payment,
	PaymentMethod,
	PaymentProvider,
	UpdatePayment,
	WebhookRequest,
} from "@repo/schema/payment";
import type { Transaction, TransactionType } from "@repo/schema/transaction";
import type { Wallet } from "@repo/schema/wallet";
import { nullsToUndefined } from "@repo/shared";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { PaymentDatabase } from "@/core/tables/payment";
import { log, toNumberSafe, toStringNumberSafe } from "@/utils";
import type { NotificationRepository } from "../notification/notification-repository";
import type { TransactionRepository } from "../transaction/transaction-repository";
import type { WalletRepository } from "../wallet/wallet-repository";
import type { PaymentChargeService, PaymentWebhookService } from "./services";

/**
 * Charge payment request payload
 */
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

/**
 * Webhook handler payload
 */
interface HandleWebhookPayload extends WithTx {
	body: WebhookRequest;
}

/**
 * Repository for payment data access operations
 *
 * Responsibilities (following Single Responsibility Principle):
 * - Payment CRUD operations (create, read, update)
 * - Payment caching
 * - Coordination between services (Dependency Inversion)
 *
 * Business logic delegated to services:
 * - PaymentChargeService: Payment gateway & wallet charging
 * - PaymentWebhookService: Webhook processing
 */
export class PaymentRepository extends BaseRepository {
	readonly #chargeService: PaymentChargeService;
	readonly #webhookService: PaymentWebhookService;
	readonly #transaction: TransactionRepository;
	readonly #wallet: WalletRepository;
	readonly #notification: NotificationRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		chargeService: PaymentChargeService,
		webhookService: PaymentWebhookService,
		transaction: TransactionRepository,
		wallet: WalletRepository,
		notification: NotificationRepository,
	) {
		super("payment", kv, db);
		this.#chargeService = chargeService;
		this.#webhookService = webhookService;
		this.#transaction = transaction;
		this.#wallet = wallet;
		this.#notification = notification;
	}

	/**
	 * Composes payment entity from database row
	 *
	 * @param item - Payment database row
	 * @returns Composed Payment entity
	 */
	static composeEntity(item: PaymentDatabase): Payment {
		return nullsToUndefined({
			...item,
			amount: toNumberSafe(item.amount),
		});
	}

	/**
	 * Gets payment room Durable Object stub for WebSocket broadcasting
	 *
	 * @param name - Room name (payment ID)
	 * @returns Durable Object stub
	 */
	static getRoomStubByName(name: string) {
		const stubId = env.PAYMENT_ROOM.idFromName(name);
		const stub = env.PAYMENT_ROOM.get(stubId);
		return stub;
	}

	/**
	 * Fetches payment from database by ID
	 *
	 * @param id - Payment ID
	 * @param opts - Transaction options
	 * @returns Payment or undefined if not found
	 */
	async #getFromDB(
		id: string,
		opts?: Partial<WithTx>,
	): Promise<Payment | undefined> {
		const result = await (opts?.tx ?? this.db).query.payment.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? PaymentRepository.composeEntity(result) : undefined;
	}

	/**
	 * Gets payment by ID with caching
	 *
	 * @param id - Payment ID
	 * @param opts - Transaction options
	 * @returns Payment entity
	 * @throws RepositoryError if payment not found
	 */
	async get(id: string, opts?: Partial<WithTx>): Promise<Payment> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);
				if (!res) throw new RepositoryError(m.error_failed_get_driver());
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	/**
	 * Inserts new payment record
	 *
	 * @param param - Payment data to insert
	 * @param opts - Transaction options
	 * @returns Created Payment entity
	 */
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

	/**
	 * Updates payment record
	 *
	 * @param id - Payment ID
	 * @param params - Fields to update
	 * @param opts - Transaction options
	 * @returns Updated Payment entity
	 */
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
					updatedAt: new Date(),
				})
				.where(eq(tables.payment.id, id))
				.returning();

			return PaymentRepository.composeEntity(payment);
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	/**
	 * Charges payment via payment gateway or wallet
	 *
	 * Delegates to PaymentChargeService for business logic:
	 * - Payment gateway charges (QRIS, bank transfer)
	 * - Wallet payment with atomic balance deduction
	 *
	 * @param params - Charge request parameters
	 * @param opts - Transaction options (required)
	 * @returns Payment, transaction, and wallet
	 * @throws RepositoryError if user not found or charge fails
	 */
	async charge(
		params: ChargePayload,
		opts: WithTx,
	): Promise<{ payment: Payment; transaction: Transaction; wallet: Wallet }> {
		try {
			const { method, userId } = params;
			const { tx } = opts;

			// Fetch wallet and user data
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

			// Convert phone to string format for payment gateway
			const userForPayment = {
				name: user.name,
				email: user.email ?? undefined,
				phone: {
					countryCode: user.phone.countryCode,
					number: String(user.phone.number),
				},
			};

			// Delegate to appropriate service based on payment method
			if (method === "wallet") {
				// Wallet payment: atomic balance deduction
				return await this.#chargeService.chargeWallet(
					{
						wallet,
						amount: params.amount,
						userId: params.userId,
						orderType: params.orderType,
						transactionType: params.transactionType,
						metadata: params.metadata,
					},
					{
						tx,
						insertPayment: this.#insert.bind(this),
						createTransaction: this.#transaction.insert.bind(this.#transaction),
					},
				);
			}

			// Payment gateway charge (QRIS, bank transfer)
			return await this.#chargeService.chargePayment(
				{
					userId: params.userId,
					transactionType: params.transactionType,
					orderType: params.orderType,
					provider: params.provider,
					amount: params.amount,
					method: params.method,
					metadata: params.metadata,
					bank: params.bank,
					va_number: params.va_number,
				},
				{
					tx,
					wallet,
					user: userForPayment,
					insertPayment: this.#insert.bind(this),
					createTransaction: this.#transaction.insert.bind(this.#transaction),
				},
			);
		} catch (error) {
			throw this.handleError(error, "charge");
		}
	}

	/**
	 * Handles Midtrans webhook notifications
	 *
	 * Delegates to PaymentWebhookService for business logic:
	 * - Idempotency checks
	 * - Payment expiration handling
	 * - Top-up success handling
	 * - Order payment success handling
	 * - WebSocket & push notifications
	 *
	 * @param payload - Webhook payload with body and transaction
	 * @throws RepositoryError if webhook processing fails
	 */
	async handleWebhookMidtrans(payload: HandleWebhookPayload): Promise<void> {
		try {
			const { body, tx } = payload;

			// Create adapter functions to match webhook service interface
			const updatePayment = async (
				id: string,
				data: { status: Payment["status"]; updatedAt: Date },
			) => {
				return await this.update(id, data, { tx });
			};

			const updateTransaction = async (
				id: string,
				data: {
					status: Transaction["status"];
					balanceBefore?: number;
					balanceAfter?: number;
				},
				opts?: Partial<WithTx>,
			) => {
				return await this.#transaction.update(
					id,
					data as never,
					opts ? { tx: opts.tx ?? tx } : { tx },
				);
			};

			const sendNotification = async (
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
			) => {
				// Convert data field to Record<string, string> as required by notification service
				const notificationData = data.data
					? Object.fromEntries(
							Object.entries(data.data).map(([k, v]) => [k, String(v)]),
						)
					: undefined;

				return await this.#notification.sendNotificationToUserId(
					{
						...data,
						data: notificationData,
					} as never,
					opts,
				);
			};

			// Delegate to PaymentWebhookService
			await this.#webhookService.processWebhook(body as never, {
				tx,
				updatePayment,
				updateTransaction,
				sendNotification,
			});
		} catch (error) {
			log.error({ error }, "[PaymentRepository] Failed to process webhook");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(m.error_failed_process_webhook(), {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}
}

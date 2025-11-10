import { env } from "cloudflare:workers";
import type { ChargeResponse } from "@erhahahaa/midtrans-client-typescript";
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
import Decimal from "decimal.js";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, PAYMENT_EXPIRY_MINUTE } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { PaymentService } from "@/core/services/payment";
import type { PaymentDatabase } from "@/core/tables/payment";
import { log, toNumberSafe, toStringNumberSafe } from "@/utils";
import type { TransactionRepository } from "../transaction/transaction-repository";
import { WalletRepository } from "../wallet/wallet-repository";

interface ChargePayload extends WithUserId {
	transactionType: Extract<TransactionType, "topup" | "payment">;
	orderType: OrderType | "top-up";
	provider: PaymentProvider;
	amount: number;
	method: PaymentMethod;
}

interface HandleWebhookPayload extends WithTx {
	body: WebhookRequest;
}
export class PaymentRepository extends BaseRepository {
	readonly #paymentSvc: PaymentService;
	readonly #transaction: TransactionRepository;
	readonly #wallet: WalletRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		paymentSvc: PaymentService,
		transaction: TransactionRepository,
		wallet: WalletRepository,
	) {
		super("payment", kv, db);
		this.#paymentSvc = paymentSvc;
		this.#transaction = transaction;
		this.#wallet = wallet;
	}

	static composeEntity(item: PaymentDatabase): Payment {
		return {
			...item,
			amount: toNumberSafe(item.amount),
			externalId: item.externalId ? item.externalId : undefined,
			paymentUrl: item.paymentUrl ? item.paymentUrl : undefined,
			expiresAt: item.expiresAt ? item.expiresAt : undefined,
		};
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

			let desc: string | undefined;

			switch (orderType) {
				case "top-up":
					desc = `Top-up ${method}`;
					break;
				case "ride":
				case "food":
				case "delivery":
					desc = "Payment";
					break;
			}

			const transaction = await this.#transaction.insert({
				walletId: wallet.id,
				type: transactionType,
				amount,
				status: "pending",
				description: desc,
			});

			const expiresAt = new Date(
				Date.now() + PAYMENT_EXPIRY_MINUTE * 60 * 1000,
			);
			const paymentResponse = (await this.#paymentSvc.charge({
				externalId: transaction.id,
				amount,
				customer: {
					...user,
					phone: `${user?.phone.countryCode}-${user?.phone.number}`,
				},
				expiry: { duration: PAYMENT_EXPIRY_MINUTE, unit: "minute" },
				method,
				metadata: { type: orderType },
			})) as ChargeResponse;

			const actions = paymentResponse.actions as
				| {
						name: string;
						method: string;
						url: string;
				  }[]
				| undefined;
			const action = actions?.find((val) => val.name === "generate-qr-code");

			log.debug(
				{ paymentResponse, actions },
				`[${this.constructor.name}] - charge result`,
			);

			const payment = await this.#insert({
				transactionId: transaction.id,
				provider,
				method,
				amount,
				status: "pending",
				externalId: transaction.id,
				expiresAt,
				response: paymentResponse,
				paymentUrl: action?.url,
				payload: { method, amount, userId, provider, type: orderType },
			});

			return { payment, transaction, wallet };
		} catch (error) {
			throw this.handleError(error, "top-up");
		}
	}

	async handleWebhookMidtrans(payload: HandleWebhookPayload): Promise<void> {
		try {
			const { body, tx } = payload;

			log.debug({ body }, "[WalletRepository] handleWebhook");
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

			if (status === "expire") {
				await this.#handleExpiredPayment({ tx, payment, transactionId });
			}

			if (status === "settlement" || status === "success") {
				const type = body.metadata.type as ChargePayload["orderType"];
				if (type === "top-up") {
					await this.#handleTopUpPaymentSuccess({ tx, payment, transactionId });
				}
				if (type === "ride" || type === "food" || type === "delivery") {
					await this.#handleOrderPaymentSuccess({ tx, payment, transactionId });
				}
			}
		} catch (error) {
			log.error({ error }, "Failed to get wallet");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Faile to process webhook", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	static getRoomStubById(id: string) {
		const stubId = env.PAYMENT_ROOM.idFromName(id);
		const stub = env.PAYMENT_ROOM.get(stubId);
		return stub;
	}

	async #handleExpiredPayment(
		params: {
			payment: PaymentDatabase;
			transactionId: string;
		} & WithTx,
	) {
		const [[updatedPayment], transaction] = await Promise.all([
			params.tx
				.update(tables.payment)
				.set({ status: "expired", updatedAt: new Date() })
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

		const updatedTransaction = await this.#transaction.update(
			transaction.id,
			{ status: "expired" },
			{ tx: params.tx },
		);

		const stub = PaymentRepository.getRoomStubById(params.payment.id);
		const payload = {
			wallet: WalletRepository.composeEntity(transaction.wallet),
			transaction: updatedTransaction,
			payment: PaymentRepository.composeEntity(updatedPayment),
		};

		if (transaction.type === "topup") {
			stub.broadcast({
				type: "wallet:top_up_failed",
				from: "server",
				to: "client",
				payload,
			});
		}
		if (transaction.type === "payment") {
			stub.broadcast({
				type: "payment:failed",
				from: "server",
				to: "client",
				payload,
			});
		}
	}

	async #handleOrderPaymentSuccess(
		params: {
			payment: PaymentDatabase;
			transactionId: string;
		} & WithTx,
	) {
		const [[updatedPayment], transaction] = await Promise.all([
			params.tx
				.update(tables.payment)
				.set({ status: "success", updatedAt: new Date() })
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

		const updatedTransaction = await this.#transaction.update(
			transaction.id,
			{ status: "success" },
			{ tx: params.tx },
		);

		const stub = PaymentRepository.getRoomStubById(params.payment.id);

		stub.broadcast({
			type: "payment:success",
			from: "server",
			to: "client",
			payload: {
				wallet: WalletRepository.composeEntity(wallet),
				transaction: updatedTransaction,
				payment: PaymentRepository.composeEntity(updatedPayment),
			},
		});
	}

	async #handleTopUpPaymentSuccess(
		params: {
			payment: PaymentDatabase;
			transactionId: string;
		} & WithTx,
	) {
		const [[updatedPayment], transaction] = await Promise.all([
			params.tx
				.update(tables.payment)
				.set({ status: "success", updatedAt: new Date() })
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
					status: "success",
					balanceBefore: toNumberSafe(wallet.balance),
					balanceAfter: toNumberSafe(newBalance),
				},
				{ tx: params.tx },
			),
		]);

		const stub = PaymentRepository.getRoomStubById(params.payment.id);

		stub.broadcast({
			type: "wallet:top_up_success",
			from: "server",
			to: "client",
			payload: {
				wallet: WalletRepository.composeEntity(updatedWallet),
				transaction: updatedTransaction,
				payment: PaymentRepository.composeEntity(updatedPayment),
			},
		});
	}
}

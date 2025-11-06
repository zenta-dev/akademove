import { env } from "cloudflare:workers";
import type { ChargeResponse } from "@erhahahaa/midtrans-client-typescript";
import type {
	Payment,
	PayRequest,
	TopUpRequest,
	WebhookRequest,
} from "@repo/schema/payment";
import type { Transaction } from "@repo/schema/transaction";
import type {
	Wallet,
	WalletMonthlySummaryRequest,
	WalletMonthlySummaryResponse,
} from "@repo/schema/wallet";
import Decimal from "decimal.js";
import { eq, sql } from "drizzle-orm";
import { v7 } from "uuid";
import { RepositoryError } from "@/core/error";
import { type DatabaseTransaction, tables } from "@/core/services/db";
import type { PaymentService } from "@/core/services/payment";
import type { WalletDatabase } from "@/core/tables/wallet";
import { log, safeAsync, toNumberSafe, toStringNumberSafe } from "@/utils";
import { PaymentRepository } from "../payment/payment-repository";
import { TransactionRepository } from "../transaction/transaction-repository";

interface WalletBasePayload {
	tx: DatabaseTransaction;
}

interface WalletGetPayload extends WalletBasePayload {
	userId: string;
}

interface WalletGetMonthlyPayload
	extends WalletMonthlySummaryRequest,
		WalletGetPayload {}

interface TopUpPayload extends TopUpRequest, WalletGetPayload {}

interface PayPayload extends PayRequest, WalletGetPayload {}
interface TransferPayload extends PayRequest, WalletGetPayload {}
interface HandleWebhookPayload extends WalletBasePayload {
	body: WebhookRequest;
}

export class WalletRepository {
	#payment: PaymentService;

	constructor(payment: PaymentService) {
		this.#payment = payment;
	}

	composeEntity(item: WalletDatabase): Wallet {
		return { ...item, balance: toNumberSafe(item.balance) };
	}

	async ensureWallet(payload: WalletGetPayload): Promise<Wallet> {
		try {
			let wallet = await payload.tx.query.wallet.findFirst({
				where: (f, op) => op.eq(f.userId, payload.userId),
			});
			if (!wallet) {
				[wallet] = await payload.tx
					.insert(tables.wallet)
					.values({ id: v7(), userId: payload.userId })
					.returning();
			}
			return this.composeEntity(wallet);
		} catch (error) {
			log.error({ error }, "Failed to ensure wallet");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to ensure wallet for user id ${payload.userId}`,
				{
					code: "NOT_FOUND",
				},
			);
		}
	}

	async get(payload: WalletGetPayload): Promise<Wallet> {
		try {
			return await this.ensureWallet(payload);
		} catch (error) {
			log.error({ error }, "Failed to get wallet");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Wallet for user id ${payload.userId} not found`,
				{
					code: "NOT_FOUND",
				},
			);
		}
	}

	async getTransactions(payload: WalletGetPayload): Promise<Transaction[]> {
		try {
			await this.ensureWallet(payload);
			const res = await safeAsync(
				payload.tx.query.wallet.findFirst({
					columns: {},
					with: { transactions: true },
					where: (f, op) => op.eq(f.userId, payload.userId),
				}),
			);
			if (!res.data) return [];
			return res.data.transactions.map(TransactionRepository.composeEntity);
		} catch (error) {
			log.error({ error }, "Failed to get transactions");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Wallet for user id ${payload.userId} not found`,
				{
					code: "NOT_FOUND",
				},
			);
		}
	}

	async getMonthlySummary(
		payload: WalletGetMonthlyPayload,
	): Promise<WalletMonthlySummaryResponse> {
		try {
			const { tx, year, month } = payload;
			const wallet = await this.ensureWallet(payload);

			const startDate = new Date(Date.UTC(year, month - 1, 1, 0, 0, 0));
			const endDate = new Date(Date.UTC(year, month, 1, 0, 0, 0));

			const res = await safeAsync(
				tx
					.select({
						type: tables.transaction.type,
						total: sql<string>`SUM(${tables.transaction.amount})`,
					})
					.from(tables.transaction)
					.where(sql`
      wallet_id = ${wallet.id}
      AND status = 'success'
      AND ${tables.transaction.createdAt} >= ${startDate.toISOString()}
      AND ${tables.transaction.createdAt} < ${endDate.toISOString()}
    `)
					.groupBy(tables.transaction.type),
			);

			const rows = res.data;

			if (!rows) {
				return {
					month: `${year}-${String(month).padStart(2, "0")}`,
					totalIncome: 0,
					totalExpense: 0,
					net: 0,
				};
			}

			let income = 0;
			let expense = 0;

			for (const row of rows) {
				const type = row.type;
				const total = Number(row.total);

				switch (type) {
					case "topup":
					case "refund":
						income += total;
						break;
					case "payment":
					case "withdraw":
						expense += total;
						break;
					case "adjustment":
						break;
				}
			}

			return {
				month: `${year}-${String(month).padStart(2, "0")}`,
				totalIncome: income,
				totalExpense: expense,
				net: income - expense,
			};
		} catch (error) {
			log.error({ error }, "Failed to compute monthly summary");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to compute monthly summary", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async topUp(payload: TopUpPayload): Promise<Payment> {
		try {
			const { method, amount, userId, tx } = payload;

			const [wallet, user] = await Promise.all([
				this.ensureWallet(payload),
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

			const safeAmount = toStringNumberSafe(amount);

			const [transaction] = await tx
				.insert(tables.transaction)
				.values({
					id: v7(),
					walletId: wallet.id,
					type: "topup",
					amount: safeAmount,
					status: "pending",
					description: `Top-up ${method}`,
				})
				.returning();

			const EXPIRY_MINUTES = 15;

			const expiresAt = new Date(Date.now() + EXPIRY_MINUTES * 60 * 1000);

			const paymentResponse = (await this.#payment.charge({
				externalId: transaction.id,
				amount,
				customer: {
					...user,
					phone: `${user?.phone.countryCode}-${user?.phone.number}`,
				},
				expiry: { duration: EXPIRY_MINUTES, unit: "minute" },
				method,
				metadata: { type: "TOP-UP" },
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
				{ paymentResponse, actions: paymentResponse.actions },
				"Payment response",
			);

			const [payment] = await tx
				.insert(tables.payment)
				.values({
					id: v7(),
					transactionId: transaction.id,
					provider: payload.provider,
					method: payload.method,
					amount: safeAmount,
					status: "pending",
					externalId: transaction.id,
					expiresAt,
					response: paymentResponse,
					paymentUrl: action?.url,
					payload: {
						method: payload.method,
						amount: payload.amount,
						userId: payload.userId,
						provider: payload.provider,
					},
				})
				.returning();

			return PaymentRepository.composePayment(payment);
		} catch (error) {
			log.error({ error }, "Failed to get wallet");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Wallet for user id ${payload.userId} not found`,
				{
					code: "NOT_FOUND",
				},
			);
		}
	}

	async pay(payload: PayPayload): Promise<Payment> {
		try {
			const { amount, referenceId, userId, tx } = payload;

			const [wallet, user] = await Promise.all([
				this.ensureWallet(payload),
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

			const safeAmount = new Decimal(amount);
			const safeBalance = new Decimal(wallet.balance);
			if (safeBalance.lessThan(safeAmount)) {
				throw new RepositoryError(
					`Insufficient balanc, current balance ${safeBalance}`,
					{ code: "BAD_REQUEST" },
				);
			}

			const amountSql = toStringNumberSafe(safeAmount);
			const safeBalanceBefore = safeBalance;
			const safeBalanceAfter = safeBalanceBefore.minus(safeAmount);
			const balanceBefore = toStringNumberSafe(safeBalanceBefore);
			const balanceAfter = toStringNumberSafe(safeBalanceAfter);

			const [[transaction], _] = await Promise.all([
				tx
					.insert(tables.transaction)
					.values({
						id: v7(),
						walletId: wallet.id,
						type: "payment",
						amount: amountSql,
						balanceBefore,
						balanceAfter,
						status: "success",
						description: `Payment for ${referenceId}`,
						referenceId,
					})
					.returning(),
				tx
					.update(tables.wallet)
					.set({ balance: balanceAfter, updatedAt: new Date() })
					.where(eq(tables.wallet.id, wallet.id)),
			]);

			const [payment] = await tx
				.insert(tables.payment)
				.values({
					id: v7(),
					transactionId: transaction.id,
					provider: "MANUAL",
					method: "WALLET",
					amount: amountSql,
					status: "success",
					externalId: referenceId,
				})
				.returning();

			return PaymentRepository.composePayment(payment);
		} catch (error) {
			log.error({ error }, "Failed to get wallet");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to do payment", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async handleWebhookMidtrans(payload: HandleWebhookPayload): Promise<void> {
		try {
			const { body, tx } = payload;

			log.debug({ body }, "[WalletRepository] handleWebhook");
			const externalId = body.order_id;
			const status = body.transaction_status;
			if (status === "pending") return;

			const payment = await tx.query.payment.findFirst({
				where: (f, op) => op.eq(f.externalId, externalId),
			});
			const paymentTransactionId = payment?.transactionId;
			if (!payment || !paymentTransactionId) {
				throw new RepositoryError(`Payment with id ${externalId} not found`, {
					code: "NOT_FOUND",
				});
			}

			if (status === "expire") {
				const [_, transaction] = await Promise.all([
					tx
						.update(tables.payment)
						.set({ status: "expired", updatedAt: new Date() })
						.where(eq(tables.payment.id, payment.id)),
					tx.query.transaction.findFirst({
						where: (f, op) => op.eq(f.id, paymentTransactionId),
					}),
				]);

				if (!transaction) {
					throw new RepositoryError(
						`Transaction with id ${paymentTransactionId} not found`,
						{
							code: "NOT_FOUND",
						},
					);
				}

				await tx
					.update(tables.transaction)
					.set({ status: "expired" })
					.where(eq(tables.transaction.id, transaction.id));
			}

			if (status === "settlement" || status === "success") {
				const [_, transaction] = await Promise.all([
					tx
						.update(tables.payment)
						.set({ status: "success", updatedAt: new Date() })
						.where(eq(tables.payment.id, payment.id)),
					tx.query.transaction.findFirst({
						with: { wallet: true },
						where: (f, op) => op.eq(f.id, paymentTransactionId),
					}),
				]);

				if (!transaction) {
					throw new RepositoryError(
						`Transaction with id ${paymentTransactionId} not found`,
						{
							code: "NOT_FOUND",
						},
					);
				}

				const wallet = transaction.wallet;

				if (!wallet) {
					throw new RepositoryError(
						`Wallet with id ${transaction.walletId} not found`,
						{
							code: "NOT_FOUND",
						},
					);
				}

				const safeCurrentBalance = new Decimal(wallet.balance);
				const safeAmount = new Decimal(transaction.amount);
				const safeNewBalance = safeCurrentBalance.plus(safeAmount);
				const newBalance = toStringNumberSafe(safeNewBalance);

				const [[newWallet], [newTransaction]] = await Promise.all([
					tx
						.update(tables.wallet)
						.set({
							balance: newBalance,
							updatedAt: new Date(),
						})
						.where(eq(tables.wallet.id, wallet.id))
						.returning(),
					tx
						.update(tables.transaction)
						.set({
							status: "success",
							balanceBefore: wallet.balance,
							balanceAfter: newBalance,
							updatedAt: new Date(),
						})
						.where(eq(tables.transaction.id, transaction.id))
						.returning(),
				]);
				const id = env.WALLET_ROOM.idFromName(wallet.id);
				const stub = env.WALLET_ROOM.get(id);
				stub.broadcast({
					type: "wallet:top_up_success",
					from: "server",
					to: "client",
					payload: {
						status: "success",
						wallet: this.composeEntity(newWallet),
						transaction: TransactionRepository.composeEntity(newTransaction),
					},
				});
			}
		} catch (error) {
			log.error({ error }, "Failed to get wallet");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Faile to process webhook", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}
}

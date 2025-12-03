import type { Payment, PayRequest } from "@repo/schema/payment";
import type {
	UpdateWallet,
	Wallet,
	WalletMonthlySummaryRequest,
	WalletMonthlySummaryResponse,
} from "@repo/schema/wallet";
import Decimal from "decimal.js";
import { eq, sql } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { RepositoryError } from "@/core/error";
import type { WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { walletDatabase } from "@/core/tables/wallet";
import { safeAsync, toNumberSafe, toStringNumberSafe } from "@/utils";
import { PaymentRepository } from "../payment/payment-repository";

interface WalletGetMonthlyPayload
	extends WalletMonthlySummaryRequest,
		WithUserId {}

interface PayPayload extends PayRequest, WithUserId {}

export class WalletRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("wallet", kv, db);
	}

	static composeEntity(item: walletDatabase): Wallet {
		return { ...item, balance: toNumberSafe(item.balance) };
	}

	async #ensurewallet(userId: string, opts?: WithTx): Promise<Wallet> {
		try {
			let wallet = await (opts?.tx ?? this.db).query.wallet.findFirst({
				where: (f, op) => op.eq(f.userId, userId),
			});
			if (!wallet) {
				[wallet] = await (opts?.tx ?? this.db)
					.insert(tables.wallet)
					.values({ id: v7(), userId })
					.returning();
			}
			return WalletRepository.composeEntity(wallet);
		} catch (error) {
			throw this.handleError(error, "ensure");
		}
	}

	async getByUserId(userId: string, opts?: WithTx): Promise<Wallet> {
		try {
			return await this.#ensurewallet(userId, opts);
		} catch (error) {
			throw this.handleError(error, "get by user id");
		}
	}

	async getMonthlySummary(
		params: WalletGetMonthlyPayload,
		opts?: WithTx,
	): Promise<WalletMonthlySummaryResponse> {
		try {
			const { year, month } = params;
			const tx = opts?.tx ?? this.db;
			const wallet = await this.#ensurewallet(params.userId);

			const startDate = new Date(Date.UTC(year, month - 1, 1, 0, 0, 0));
			const endDate = new Date(Date.UTC(year, month, 1, 0, 0, 0));

			const res = await safeAsync(
				tx
					.select({
						type: tables.transaction.type,
						total: sql<string>`SUM(${tables.transaction.amount})`,
					})
					.from(tables.transaction)
					.where(
						sql`${tables.transaction.walletId} = ${wallet.id} AND ${tables.transaction.status} = 'SUCCESS' AND ${tables.transaction.createdAt} >= ${startDate} AND ${tables.transaction.createdAt} < ${endDate}`,
					)
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
					case "TOPUP":
					case "REFUND":
						income += total;
						break;
					case "PAYMENT":
					case "WITHDRAW":
						expense += total;
						break;
					case "ADJUSTMENT":
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
			throw this.handleError(error, "get monthly summary");
		}
	}

	async pay(payload: PayPayload, opts: WithTx): Promise<Payment> {
		try {
			const { amount, referenceId, userId } = payload;
			const { tx } = opts;

			const [wallet, user] = await Promise.all([
				this.#ensurewallet(userId, opts),
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
			const amountSql = toStringNumberSafe(safeAmount);

			// CRITICAL FIX: Atomic update with WHERE clause check to prevent race conditions
			// This uses database-level constraints to ensure balance never goes negative
			const [updatedwallet] = await tx
				.update(tables.wallet)
				.set({
					balance: sql`balance - ${amountSql}`,
					updatedAt: new Date(),
				})
				.where(
					sql`${tables.wallet.id} = ${wallet.id} AND balance >= ${amountSql}`,
				)
				.returning();

			if (!updatedwallet) {
				throw new RepositoryError(
					`Insufficient balance. Payment of ${amount} exceeds available balance.`,
					{ code: "BAD_REQUEST" },
				);
			}

			const safeBalanceBefore = new Decimal(wallet.balance);
			const safeBalanceAfter = new Decimal(updatedwallet.balance);
			const balanceBefore = toStringNumberSafe(safeBalanceBefore);
			const balanceAfter = toStringNumberSafe(safeBalanceAfter);

			const [transaction] = await tx
				.insert(tables.transaction)
				.values({
					id: v7(),
					walletId: wallet.id,
					type: "PAYMENT",
					amount: amountSql,
					balanceBefore,
					balanceAfter,
					status: "SUCCESS",
					description: `Payment for ${referenceId}`,
					referenceId,
				})
				.returning();

			const [payment] = await tx
				.insert(tables.payment)
				.values({
					id: v7(),
					transactionId: transaction.id,
					provider: "MANUAL",
					method: "wallet",
					amount: amountSql,
					status: "SUCCESS",
					externalId: referenceId,
				})
				.returning();

			return PaymentRepository.composeEntity(payment);
		} catch (error) {
			throw this.handleError(error, "pay");
		}
	}

	async update(
		id: string,
		params: UpdateWallet,
		opts?: Partial<WithTx>,
	): Promise<Wallet> {
		try {
			const [wallet] = await (opts?.tx ?? this.db)
				.update(tables.wallet)
				.set({
					...params,
					balance: params.balance
						? toStringNumberSafe(params.balance)
						: undefined,
				})
				.where(eq(tables.wallet.id, id))
				.returning();

			return WalletRepository.composeEntity(wallet);
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}
}

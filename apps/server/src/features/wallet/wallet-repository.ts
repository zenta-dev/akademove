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
import { FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { WalletDatabase } from "@/core/tables/wallet";
import { safeAsync, toNumberSafe, toStringNumberSafe } from "@/utils";
import { PaymentRepository } from "../payment/payment-repository";

interface WalletGetMonthlyPayload
	extends WalletMonthlySummaryRequest,
		WithUserId {}

interface PayPayload extends PayRequest, WithUserId {}

export class WalletRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super(FEATURE_TAGS.WALLET, "wallet", kv, db);
	}

	static composeEntity(item: WalletDatabase): Wallet {
		return { ...item, balance: toNumberSafe(item.balance) };
	}

	async #ensureWallet(userId: string, opts?: WithTx): Promise<Wallet> {
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
			return await this.#ensureWallet(userId, opts);
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
			const wallet = await this.#ensureWallet(params.userId);

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
			throw this.handleError(error, "get monthly summary");
		}
	}

	async pay(payload: PayPayload, opts: WithTx): Promise<Payment> {
		try {
			const { amount, referenceId, userId } = payload;
			const { tx } = opts;

			const [wallet, user] = await Promise.all([
				this.#ensureWallet(userId),
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
					`Insufficient balance, current balance ${safeBalance}`,
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

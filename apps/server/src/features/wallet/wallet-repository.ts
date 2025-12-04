import type { Payment, PayRequest } from "@repo/schema/payment";
import type {
	UpdateWallet,
	Wallet,
	WalletMonthlySummaryRequest,
	WalletMonthlySummaryResponse,
} from "@repo/schema/wallet";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { RepositoryError } from "@/core/error";
import type { WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { walletDatabase } from "@/core/tables/wallet";
import { toNumberSafe, toStringNumberSafe } from "@/utils";
import {
	type WalletBalanceService,
	WalletMonthlySummaryService,
	type WalletTransactionService,
} from "./services";

interface WalletGetMonthlyPayload
	extends WalletMonthlySummaryRequest,
		WithUserId {}

interface PayPayload extends PayRequest, WithUserId {}

export class WalletRepository extends BaseRepository {
	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		private readonly balanceService: WalletBalanceService,
		private readonly transactionService: WalletTransactionService,
	) {
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
			const { year, month, userId } = params;
			const tx = opts?.tx ?? this.db;
			const wallet = await this.#ensurewallet(userId);

			// Delegate monthly summary calculation to WalletMonthlySummaryService
			return await WalletMonthlySummaryService.getMonthlySummary(tx, {
				walletId: wallet.id,
				year,
				month,
			});
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

			if (!referenceId) {
				throw new RepositoryError("Reference ID is required for payment", {
					code: "BAD_REQUEST",
				});
			}

			// Delegate balance deduction to WalletBalanceService
			const { balanceBefore, balanceAfter } = await this.balanceService.deduct(
				{ walletId: wallet.id, amount },
				{ tx },
			);

			// Delegate payment transaction recording to WalletTransactionService
			const payment = await this.transactionService.recordPayment(
				{
					walletId: wallet.id,
					amount,
					balanceBefore,
					balanceAfter,
					referenceId,
				},
				{ tx },
			);

			return payment;
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

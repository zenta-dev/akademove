import Decimal from "decimal.js";
import { sql } from "drizzle-orm";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import { toStringNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

/**
 * Service responsible for wallet balance operations
 *
 * Handles:
 * - Balance checks and validation
 * - Atomic balance updates (add/deduct)
 * - Insufficient balance detection
 * - Balance locking for concurrent transactions
 *
 * @example
 * ```typescript
 * const balanceService = new WalletBalanceService(db);
 *
 * // Deduct balance atomically
 * const newBalance = await balanceService.deduct({
 *   walletId: "wallet-123",
 *   amount: 50000,
 *   tx
 * });
 * ```
 */
export class WalletBalanceService {
	readonly #db: DatabaseService;

	constructor(db: DatabaseService) {
		this.#db = db;
	}

	/**
	 * Checks if wallet has sufficient balance
	 *
	 * @param walletId - Wallet ID
	 * @param amount - Amount to check
	 * @param opts - Optional transaction context
	 * @returns true if sufficient balance
	 */
	async hasSufficientBalance(
		walletId: string,
		amount: number,
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			const wallet = await (opts?.tx ?? this.#db).query.wallet.findFirst({
				columns: { balance: true },
				where: (f, op) => op.eq(f.id, walletId),
			});

			if (!wallet) {
				throw new RepositoryError(`Wallet with id ${walletId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const balance = new Decimal(wallet.balance);
			const required = new Decimal(amount);

			return balance.gte(required);
		} catch (error) {
			if (error instanceof RepositoryError) throw error;

			logger.error(
				{ error, walletId, amount },
				"[WalletBalanceService] Failed to check balance",
			);
			throw new RepositoryError("Failed to check wallet balance", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Deducts amount from wallet balance atomically
	 *
	 * Uses database-level atomic update with WHERE clause check
	 * to prevent race conditions and negative balances.
	 *
	 * @param params - Deduction parameters
	 * @param opts - Transaction context (REQUIRED)
	 * @returns New balance and old balance
	 * @throws RepositoryError if insufficient balance
	 */
	async deduct(
		params: { walletId: string; amount: number },
		opts: Required<PartialWithTx>,
	): Promise<{ balanceBefore: number; balanceAfter: number }> {
		try {
			const { walletId, amount } = params;
			const { tx } = opts;

			// Get current balance
			const wallet = await tx.query.wallet.findFirst({
				columns: { balance: true },
				where: (f, op) => op.eq(f.id, walletId),
			});

			if (!wallet) {
				throw new RepositoryError(`Wallet with id ${walletId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const safeAmount = new Decimal(amount);
			const amountSql = toStringNumberSafe(safeAmount);

			// CRITICAL: Atomic update with balance check to prevent race conditions
			const [updatedWallet] = await tx
				.update(tables.wallet)
				.set({
					balance: sql`balance - ${amountSql}`,
					updatedAt: new Date(),
				})
				.where(
					sql`${tables.wallet.id} = ${walletId} AND balance >= ${amountSql}`,
				)
				.returning();

			if (!updatedWallet) {
				throw new RepositoryError(
					`Insufficient balance. Deduction of ${amount} exceeds available balance.`,
					{ code: "BAD_REQUEST" },
				);
			}

			const balanceBefore = new Decimal(wallet.balance).toNumber();
			const balanceAfter = new Decimal(updatedWallet.balance).toNumber();

			logger.info(
				{ walletId, amount, balanceBefore, balanceAfter },
				"[WalletBalanceService] Deducted balance",
			);

			return { balanceBefore, balanceAfter };
		} catch (error) {
			if (error instanceof RepositoryError) throw error;

			logger.error(
				{ error, params },
				"[WalletBalanceService] Failed to deduct balance",
			);
			throw new RepositoryError("Failed to deduct wallet balance", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Adds amount to wallet balance atomically
	 *
	 * @param params - Addition parameters
	 * @param opts - Transaction context (REQUIRED)
	 * @returns New balance and old balance
	 */
	async add(
		params: { walletId: string; amount: number },
		opts: Required<PartialWithTx>,
	): Promise<{ balanceBefore: number; balanceAfter: number }> {
		try {
			const { walletId, amount } = params;
			const { tx } = opts;

			// Get current balance
			const wallet = await tx.query.wallet.findFirst({
				columns: { balance: true },
				where: (f, op) => op.eq(f.id, walletId),
			});

			if (!wallet) {
				throw new RepositoryError(`Wallet with id ${walletId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const safeAmount = new Decimal(amount);
			const amountSql = toStringNumberSafe(safeAmount);

			// Atomic update
			const [updatedWallet] = await tx
				.update(tables.wallet)
				.set({
					balance: sql`balance + ${amountSql}`,
					updatedAt: new Date(),
				})
				.where(sql`${tables.wallet.id} = ${walletId}`)
				.returning();

			if (!updatedWallet) {
				throw new RepositoryError(
					`Failed to update wallet with id ${walletId}`,
					{ code: "INTERNAL_SERVER_ERROR" },
				);
			}

			const balanceBefore = new Decimal(wallet.balance).toNumber();
			const balanceAfter = new Decimal(updatedWallet.balance).toNumber();

			logger.info(
				{ walletId, amount, balanceBefore, balanceAfter },
				"[WalletBalanceService] Added balance",
			);

			return { balanceBefore, balanceAfter };
		} catch (error) {
			if (error instanceof RepositoryError) throw error;

			logger.error(
				{ error, params },
				"[WalletBalanceService] Failed to add balance",
			);
			throw new RepositoryError("Failed to add wallet balance", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Gets current wallet balance
	 *
	 * @param walletId - Wallet ID
	 * @param opts - Optional transaction context
	 * @returns Current balance
	 */
	async getBalance(walletId: string, opts?: PartialWithTx): Promise<number> {
		try {
			const wallet = await (opts?.tx ?? this.#db).query.wallet.findFirst({
				columns: { balance: true },
				where: (f, op) => op.eq(f.id, walletId),
			});

			if (!wallet) {
				throw new RepositoryError(`Wallet with id ${walletId} not found`, {
					code: "NOT_FOUND",
				});
			}

			return new Decimal(wallet.balance).toNumber();
		} catch (error) {
			if (error instanceof RepositoryError) throw error;

			logger.error(
				{ error, walletId },
				"[WalletBalanceService] Failed to get balance",
			);
			throw new RepositoryError("Failed to get wallet balance", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}
}

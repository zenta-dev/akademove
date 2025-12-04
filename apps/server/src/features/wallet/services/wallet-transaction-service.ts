import type { Payment } from "@repo/schema/payment";
import type { TransactionType } from "@repo/schema/transaction";
import Decimal from "decimal.js";
import { v7 } from "uuid";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import { tables } from "@/core/services/db";
import { PaymentRepository } from "@/features/payment/payment-repository";
import { log, toStringNumberSafe } from "@/utils";

/**
 * Service responsible for wallet transaction recording
 *
 * Handles:
 * - Transaction creation (TOPUP, PAYMENT, REFUND, WITHDRAW, etc.)
 * - Payment record creation
 * - Balance tracking (before/after)
 *
 * @example
 * ```typescript
 * const transactionService = new WalletTransactionService();
 *
 * // Record a payment transaction
 * const payment = await transactionService.recordPayment({
 *   walletId: "wallet-123",
 *   amount: 50000,
 *   balanceBefore: 100000,
 *   balanceAfter: 50000,
 *   referenceId: "order-456",
 *   tx
 * });
 * ```
 */
export class WalletTransactionService {
	/**
	 * Records a transaction in the database
	 *
	 * @param params - Transaction parameters
	 * @param opts - Transaction context (REQUIRED)
	 * @returns Transaction ID
	 */
	async recordTransaction(
		params: {
			walletId: string;
			type: TransactionType;
			amount: number;
			balanceBefore: number;
			balanceAfter: number;
			status?: "PENDING" | "SUCCESS" | "FAILED";
			description?: string;
			referenceId?: string;
			metadata?: unknown;
		},
		opts: Required<PartialWithTx>,
	): Promise<string> {
		try {
			const {
				walletId,
				type,
				amount,
				balanceBefore,
				balanceAfter,
				status = "SUCCESS",
				description,
				referenceId,
				metadata,
			} = params;
			const { tx } = opts;

			const safeAmount = new Decimal(amount);
			const safeBalanceBefore = new Decimal(balanceBefore);
			const safeBalanceAfter = new Decimal(balanceAfter);

			const [transaction] = await tx
				.insert(tables.transaction)
				.values({
					id: v7(),
					walletId,
					type,
					amount: toStringNumberSafe(safeAmount),
					balanceBefore: toStringNumberSafe(safeBalanceBefore),
					balanceAfter: toStringNumberSafe(safeBalanceAfter),
					status,
					description,
					referenceId,
					metadata,
				})
				.returning();

			log.info(
				{ transactionId: transaction.id, walletId, type, amount },
				"[WalletTransactionService] Recorded transaction",
			);

			return transaction.id;
		} catch (error) {
			log.error(
				{ error, params },
				"[WalletTransactionService] Failed to record transaction",
			);
			throw new RepositoryError("Failed to record wallet transaction", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Records a payment transaction with payment record
	 *
	 * Creates both transaction and payment records atomically.
	 *
	 * @param params - Payment parameters
	 * @param opts - Transaction context (REQUIRED)
	 * @returns Payment entity
	 */
	async recordPayment(
		params: {
			walletId: string;
			amount: number;
			balanceBefore: number;
			balanceAfter: number;
			referenceId: string;
			description?: string;
		},
		opts: Required<PartialWithTx>,
	): Promise<Payment> {
		try {
			const {
				walletId,
				amount,
				balanceBefore,
				balanceAfter,
				referenceId,
				description,
			} = params;
			const { tx } = opts;

			// Create transaction record
			const transactionId = await this.recordTransaction(
				{
					walletId,
					type: "PAYMENT",
					amount,
					balanceBefore,
					balanceAfter,
					status: "SUCCESS",
					description: description ?? `Payment for ${referenceId}`,
					referenceId,
				},
				opts,
			);

			// Create payment record
			const safeAmount = new Decimal(amount);
			const [payment] = await tx
				.insert(tables.payment)
				.values({
					id: v7(),
					transactionId,
					provider: "MANUAL",
					method: "wallet",
					amount: toStringNumberSafe(safeAmount),
					status: "SUCCESS",
					externalId: referenceId,
				})
				.returning();

			log.info(
				{ paymentId: payment.id, transactionId, referenceId, amount },
				"[WalletTransactionService] Recorded payment",
			);

			return PaymentRepository.composeEntity(payment);
		} catch (error) {
			log.error(
				{ error, params },
				"[WalletTransactionService] Failed to record payment",
			);
			throw new RepositoryError("Failed to record wallet payment", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Records a top-up transaction
	 *
	 * @param params - Top-up parameters
	 * @param opts - Transaction context (REQUIRED)
	 * @returns Transaction ID
	 */
	async recordTopup(
		params: {
			walletId: string;
			amount: number;
			balanceBefore: number;
			balanceAfter: number;
			referenceId?: string;
			description?: string;
		},
		opts: Required<PartialWithTx>,
	): Promise<string> {
		return await this.recordTransaction(
			{
				...params,
				type: "TOPUP",
				status: "SUCCESS",
				description: params.description ?? "Wallet top-up",
			},
			opts,
		);
	}

	/**
	 * Records a refund transaction
	 *
	 * @param params - Refund parameters
	 * @param opts - Transaction context (REQUIRED)
	 * @returns Transaction ID
	 */
	async recordRefund(
		params: {
			walletId: string;
			amount: number;
			balanceBefore: number;
			balanceAfter: number;
			referenceId: string;
			description?: string;
		},
		opts: Required<PartialWithTx>,
	): Promise<string> {
		return await this.recordTransaction(
			{
				...params,
				type: "REFUND",
				status: "SUCCESS",
				description: params.description ?? `Refund for ${params.referenceId}`,
			},
			opts,
		);
	}

	/**
	 * Records a withdrawal transaction
	 *
	 * @param params - Withdrawal parameters
	 * @param opts - Transaction context (REQUIRED)
	 * @returns Transaction ID
	 */
	async recordWithdrawal(
		params: {
			walletId: string;
			amount: number;
			balanceBefore: number;
			balanceAfter: number;
			referenceId?: string;
			description?: string;
		},
		opts: Required<PartialWithTx>,
	): Promise<string> {
		return await this.recordTransaction(
			{
				...params,
				type: "WITHDRAW",
				status: "SUCCESS",
				description: params.description ?? "Wallet withdrawal",
			},
			opts,
		);
	}

	/**
	 * Records an earning transaction (driver earnings)
	 *
	 * @param params - Earning parameters
	 * @param opts - Transaction context (REQUIRED)
	 * @returns Transaction ID
	 */
	async recordEarning(
		params: {
			walletId: string;
			amount: number;
			balanceBefore: number;
			balanceAfter: number;
			referenceId: string;
			description?: string;
		},
		opts: Required<PartialWithTx>,
	): Promise<string> {
		return await this.recordTransaction(
			{
				...params,
				type: "EARNING",
				status: "SUCCESS",
				description: params.description ?? `Earning from ${params.referenceId}`,
			},
			opts,
		);
	}

	/**
	 * Records a commission transaction (platform commission)
	 *
	 * @param params - Commission parameters
	 * @param opts - Transaction context (REQUIRED)
	 * @returns Transaction ID
	 */
	async recordCommission(
		params: {
			walletId: string;
			amount: number;
			balanceBefore: number;
			balanceAfter: number;
			referenceId: string;
			description?: string;
		},
		opts: Required<PartialWithTx>,
	): Promise<string> {
		return await this.recordTransaction(
			{
				...params,
				type: "COMMISSION",
				status: "SUCCESS",
				description:
					params.description ?? `Commission for ${params.referenceId}`,
			},
			opts,
		);
	}
}

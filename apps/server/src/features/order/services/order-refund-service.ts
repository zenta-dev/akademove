import { m } from "@repo/i18n";
import Decimal from "decimal.js";
import { eq, sql } from "drizzle-orm";
import { v7 } from "uuid";
import type { WithTx } from "@/core/interface";
import { type DatabaseTransaction, tables } from "@/core/services/db";
import { toNumberSafe, toStringNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

/**
 * Service responsible for processing order refunds
 *
 * @responsibility Process refunds for cancelled orders including wallet balance updates
 */
export class OrderRefundService {
	/**
	 * Find the payment transaction for an order
	 */
	static async findPaymentTransaction(
		tx: DatabaseTransaction,
		orderId: string,
	) {
		return await tx.query.transaction.findFirst({
			where: (f, op) =>
				op.and(
					op.eq(f.referenceId, orderId),
					op.eq(f.type, "PAYMENT"),
					op.inArray(f.status, ["PENDING", "SUCCESS"]),
				),
		});
	}

	/**
	 * Find wallet by ID
	 */
	static async findWallet(tx: DatabaseTransaction, walletId: string) {
		return await tx.query.wallet.findFirst({
			where: (f, op) => op.eq(f.id, walletId),
		});
	}

	/**
	 * Find payment by transaction ID
	 */
	static async findPayment(tx: DatabaseTransaction, transactionId: string) {
		return await tx.query.payment.findFirst({
			where: (f, op) => op.eq(f.transactionId, transactionId),
		});
	}

	/**
	 * Calculate expected new wallet balance after refund
	 * NOTE: This is only used for transaction record, actual balance update uses atomic SQL
	 */
	static calculateNewBalance(
		currentBalance: string,
		refundAmount: Decimal,
	): Decimal {
		const current = new Decimal(currentBalance);
		return current.plus(refundAmount);
	}

	/**
	 * Update transaction status to REFUNDED
	 */
	static async updateTransactionStatus(
		tx: DatabaseTransaction,
		transactionId: string,
		balanceBefore: Decimal,
		balanceAfter: Decimal,
	): Promise<void> {
		await tx
			.update(tables.transaction)
			.set({
				status: "REFUNDED",
				balanceBefore: toStringNumberSafe(balanceBefore),
				balanceAfter: toStringNumberSafe(balanceAfter),
			})
			.where(eq(tables.transaction.id, transactionId));
	}

	/**
	 * Update payment status to REFUNDED
	 */
	static async updatePaymentStatus(
		tx: DatabaseTransaction,
		paymentId: string,
	): Promise<void> {
		await tx
			.update(tables.payment)
			.set({ status: "REFUNDED" })
			.where(eq(tables.payment.id, paymentId));
	}

	/**
	 * Update wallet balance atomically using SQL
	 * This prevents race conditions when multiple refunds happen concurrently
	 */
	static async updateWalletBalance(
		tx: DatabaseTransaction,
		walletId: string,
		refundAmount: Decimal,
	): Promise<void> {
		const amountSql = toStringNumberSafe(refundAmount);
		await tx
			.update(tables.wallet)
			.set({
				balance: sql`balance + ${amountSql}`,
				updatedAt: new Date(),
			})
			.where(eq(tables.wallet.id, walletId));
	}

	/**
	 * Create a REFUND transaction record for audit trail
	 */
	static async createRefundTransaction(
		tx: DatabaseTransaction,
		params: {
			walletId: string;
			orderId: string;
			refundAmount: Decimal;
			balanceBefore: Decimal;
			balanceAfter: Decimal;
			reason?: string;
		},
	): Promise<void> {
		await tx.insert(tables.transaction).values({
			id: v7(),
			walletId: params.walletId,
			type: "REFUND",
			amount: toStringNumberSafe(params.refundAmount),
			balanceBefore: toStringNumberSafe(params.balanceBefore),
			balanceAfter: toStringNumberSafe(params.balanceAfter),
			status: "SUCCESS",
			description:
				params.reason ?? `Refund for order #${params.orderId.slice(0, 8)}`,
			referenceId: params.orderId,
			metadata: {
				type: "ORDER_REFUND",
				orderId: params.orderId,
				reason: params.reason,
			},
		});
	}

	/**
	 * Process refund for a cancelled order
	 *
	 * @param orderId - Order ID to process refund for
	 * @param userId - User ID for logging
	 * @param refundAmount - Amount to refund (as Decimal)
	 * @param penaltyAmount - Penalty amount deducted (as Decimal)
	 * @param opts - Transaction context
	 * @param reason - Optional reason for the refund
	 */
	static async processRefund(
		orderId: string,
		userId: string,
		refundAmount: Decimal,
		penaltyAmount: Decimal,
		opts: WithTx,
		reason?: string,
	): Promise<void> {
		const { tx } = opts;

		// Find payment transaction by referenceId (orderId)
		const paymentTransaction = await OrderRefundService.findPaymentTransaction(
			tx,
			orderId,
		);

		if (!paymentTransaction) {
			// No payment transaction found - nothing to refund
			logger.debug(
				{ orderId, userId },
				"[OrderRefundService] No payment transaction found - skipping refund",
			);
			return;
		}

		// Get wallet
		const wallet = await OrderRefundService.findWallet(
			tx,
			paymentTransaction.walletId,
		);

		// Get payment
		const payment = await OrderRefundService.findPayment(
			tx,
			paymentTransaction.id,
		);

		if (!wallet || !payment) {
			logger.warn(
				{ orderId, userId, transactionId: paymentTransaction.id },
				"[OrderRefundService] Wallet or payment not found - cannot process refund",
			);
			return;
		}

		// Calculate balances for transaction record
		const currentBalance = new Decimal(wallet.balance);
		const balanceAfter = currentBalance.plus(refundAmount);

		// Update original payment transaction status
		await OrderRefundService.updateTransactionStatus(
			tx,
			paymentTransaction.id,
			currentBalance,
			balanceAfter,
		);

		// Update payment status
		await OrderRefundService.updatePaymentStatus(tx, payment.id);

		// Update wallet balance atomically
		await OrderRefundService.updateWalletBalance(tx, wallet.id, refundAmount);

		// Create a new REFUND transaction record for audit trail
		await OrderRefundService.createRefundTransaction(tx, {
			walletId: wallet.id,
			orderId,
			refundAmount,
			balanceBefore: currentBalance,
			balanceAfter,
			reason,
		});

		logger.info(
			{
				orderId,
				userId,
				refundAmount: toNumberSafe(refundAmount),
				penaltyAmount: toNumberSafe(penaltyAmount),
			},
			m.server_refund_processed(),
		);
	}
}

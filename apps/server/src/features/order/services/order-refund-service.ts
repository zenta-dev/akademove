import { m } from "@repo/i18n";
import Decimal from "decimal.js";
import { eq } from "drizzle-orm";
import type { WithTx } from "@/core/interface";
import { type DatabaseTransaction, tables } from "@/core/services/db";
import { log, toNumberSafe, toStringNumberSafe } from "@/utils";

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
	 * Calculate new wallet balance after refund
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
	 * Update wallet balance
	 */
	static async updateWalletBalance(
		tx: DatabaseTransaction,
		walletId: string,
		newBalance: Decimal,
	): Promise<void> {
		await tx
			.update(tables.wallet)
			.set({ balance: toStringNumberSafe(newBalance) })
			.where(eq(tables.wallet.id, walletId));
	}

	/**
	 * Process refund for a cancelled order
	 *
	 * @param orderId - Order ID to process refund for
	 * @param userId - User ID for logging
	 * @param refundAmount - Amount to refund (as Decimal)
	 * @param penaltyAmount - Penalty amount deducted (as Decimal)
	 * @param opts - Transaction context
	 */
	static async processRefund(
		orderId: string,
		userId: string,
		refundAmount: Decimal,
		penaltyAmount: Decimal,
		opts: WithTx,
	): Promise<void> {
		const { tx } = opts;

		// Find payment transaction by referenceId (orderId)
		const paymentTransaction = await OrderRefundService.findPaymentTransaction(
			tx,
			orderId,
		);

		if (!paymentTransaction) {
			// No payment transaction found - nothing to refund
			log.debug(
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
			log.warn(
				{ orderId, userId, transactionId: paymentTransaction.id },
				"[OrderRefundService] Wallet or payment not found - cannot process refund",
			);
			return;
		}

		// Calculate new balance
		const currentBalance = new Decimal(wallet.balance);
		const newBalance = OrderRefundService.calculateNewBalance(
			wallet.balance,
			refundAmount,
		);

		// Update transaction status
		await OrderRefundService.updateTransactionStatus(
			tx,
			paymentTransaction.id,
			currentBalance,
			newBalance,
		);

		// Update payment status
		await OrderRefundService.updatePaymentStatus(tx, payment.id);

		// Update wallet balance
		await OrderRefundService.updateWalletBalance(tx, wallet.id, newBalance);

		log.info(
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

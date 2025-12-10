import type { ChargeResponse } from "@erhahahaa/midtrans-client-typescript";
import { m } from "@repo/i18n";
import type { BankProvider } from "@repo/schema/common";
import type { OrderType } from "@repo/schema/order";
import type {
	InsertPayment,
	Payment,
	PaymentMethod,
	PaymentProvider,
} from "@repo/schema/payment";
import type { Transaction, TransactionType } from "@repo/schema/transaction";
import type { Wallet } from "@repo/schema/wallet";
import Decimal from "decimal.js";
import { sql } from "drizzle-orm";
import { PAYMENT_EXPIRY_MINUTE } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { PaymentService } from "@/core/services/payment";
import type { PaymentDatabase } from "@/core/tables/payment";
import { toNumberSafe, toStringNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";
import { parseVANumber } from "./va-number-parser";

/**
 * Payment charge request parameters
 */
export interface ChargePaymentRequest {
	userId: string;
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
 * Payment charge result
 */
export interface ChargePaymentResult {
	payment: Payment;
	transaction: Transaction;
	wallet: Wallet;
}

/**
 * Wallet payment request parameters
 */
export interface WalletPaymentRequest {
	wallet: Wallet;
	amount: number;
	userId: string;
	orderType: OrderType | "TOPUP";
	transactionType: TransactionType;
	metadata?: Record<string, unknown>;
}

/**
 * Service responsible for payment charging operations
 *
 * Handles:
 * - Payment gateway charges (QRIS, bank transfer)
 * - Wallet payment with atomic balance deduction
 * - VA number parsing and handling
 * - Payment record creation
 *
 * @example
 * ```typescript
 * const chargeService = new PaymentChargeService(db, paymentGateway);
 *
 * // Charge via payment gateway
 * const result = await chargeService.chargePayment({
 *   userId: "user-123",
 *   amount: 50000,
 *   method: "QRIS",
 *   provider: "MIDTRANS",
 *   orderType: "TOPUP",
 *   transactionType: "TOPUP"
 * }, { tx, wallet, user, insertPayment, createTransaction });
 *
 * // Charge via wallet
 * const walletResult = await chargeService.chargeWallet({
 *   wallet,
 *   amount: 50000,
 *   userId: "user-123",
 *   orderType: "RIDE",
 *   transactionType: "PAYMENT"
 * }, { tx, insertPayment, createTransaction });
 * ```
 */
export class PaymentChargeService {
	readonly #paymentGateway: PaymentService;

	constructor(_db: DatabaseService, paymentGateway: PaymentService) {
		this.#paymentGateway = paymentGateway;
	}

	/**
	 * Charges payment via payment gateway (QRIS, bank transfer)
	 *
	 * Process:
	 * 1. Validates user exists
	 * 2. Creates transaction record (PENDING)
	 * 3. Calls payment gateway API
	 * 4. Parses VA number from response
	 * 5. Creates payment record with gateway response
	 * 6. Returns payment, transaction, and wallet
	 *
	 * @param request - Payment charge parameters
	 * @param deps - Dependencies (tx, wallet, user, insertPayment, createTransaction)
	 * @returns Payment charge result
	 * @throws RepositoryError if user not found or payment gateway fails
	 */
	async chargePayment(
		request: ChargePaymentRequest,
		deps: {
			tx: WithTx["tx"];
			wallet: Wallet;
			user: {
				name: string;
				email?: string;
				phone: { countryCode: string; number: string };
			};
			insertPayment: (
				data: InsertPayment,
				opts?: Partial<WithTx>,
			) => Promise<Payment>;
			createTransaction: (data: {
				walletId: string;
				type: TransactionType;
				amount: number;
				status: "PENDING" | "SUCCESS" | "FAILED" | "EXPIRED";
				description?: string;
				metadata?: Record<string, unknown>;
			}) => Promise<Transaction>;
		},
	): Promise<ChargePaymentResult> {
		try {
			const { provider, method, amount, userId, orderType, transactionType } =
				request;
			const { tx, wallet, user, insertPayment, createTransaction } = deps;

			// Generate description based on order type
			let desc: string | undefined;
			switch (orderType) {
				case "TOPUP":
					desc = `Top-up ${method}`;
					break;
				case "RIDE":
				case "FOOD":
				case "DELIVERY":
					desc = "Payment";
					break;
			}

			const metadata = { ...request.metadata, type: orderType, desc };

			// Create transaction record (PENDING)
			const transaction = await createTransaction({
				walletId: wallet.id,
				type: transactionType,
				amount,
				status: "PENDING",
				description: desc,
				metadata,
			});

			const expiresAt = new Date(
				Date.now() + PAYMENT_EXPIRY_MINUTE * 60 * 1000,
			);

			// Call payment gateway
			let paymentResponse: ChargeResponse;
			try {
				paymentResponse = (await this.#paymentGateway.charge({
					externalId: transaction.id,
					amount,
					customer: {
						...user,
						phone: `${user.phone.countryCode}-${user.phone.number}`,
					},
					expiry: { duration: PAYMENT_EXPIRY_MINUTE, unit: "minute" },
					method,
					metadata,
					bank: request.bank,
					va_number: request.va_number,
				})) as ChargeResponse;
			} catch (paymentError) {
				logger.error(
					{ error: paymentError, transactionId: transaction.id },
					"[PaymentChargeService] Payment gateway failed - transaction will be rolled back",
				);

				// Mark transaction as FAILED before re-throwing
				await tx
					.update(tables.transaction)
					.set({ status: "FAILED", updatedAt: new Date() })
					.where(sql`${tables.transaction.id} = ${transaction.id}`);

				throw new RepositoryError(
					"Payment gateway failed. Please try again later.",
					{
						code: "INTERNAL_SERVER_ERROR",
					},
				);
			}

			// Parse payment URL from actions
			const actions = paymentResponse.actions;
			const action = actions?.find((val) => val.name === "generate-qr-code");

			// Parse VA number
			const va_number = parseVANumber(paymentResponse, request.bank);

			logger.debug(
				{ paymentResponse, actions, va_number },
				"[PaymentChargeService] Charge result",
			);

			// Create payment record
			const payment = await insertPayment(
				{
					transactionId: transaction.id,
					provider,
					method,
					bankProvider: request.bank,
					amount,
					status: "PENDING",
					externalId: transaction.id,
					expiresAt,
					response: paymentResponse,
					paymentUrl: action?.url,
					va_number: va_number,
					payload: { method, amount, userId, provider, metadata },
				},
				{ tx },
			);

			return { payment, transaction, wallet };
		} catch (error) {
			logger.error(
				{ error, request },
				"[PaymentChargeService] Failed to charge payment",
			);
			throw error;
		}
	}

	/**
	 * Charges payment via wallet with atomic balance deduction
	 *
	 * Process:
	 * 1. Atomically deducts balance from wallet (with balance check)
	 * 2. Creates transaction record (SUCCESS)
	 * 3. Creates payment record
	 * 4. Returns payment, transaction, and updated wallet
	 *
	 * Uses SQL-level atomic operation to prevent race conditions:
	 * `balance = balance - amount WHERE balance >= amount`
	 *
	 * @param request - Wallet payment parameters
	 * @param deps - Dependencies (tx, insertPayment, createTransaction)
	 * @returns Payment charge result
	 * @throws RepositoryError if insufficient balance
	 */
	async chargeWallet(
		request: WalletPaymentRequest,
		deps: {
			tx: WithTx["tx"];
			insertPayment: (
				data: InsertPayment,
				opts?: Partial<WithTx>,
			) => Promise<Payment>;
			createTransaction: (data: {
				walletId: string;
				type: TransactionType;
				amount: number;
				status: "PENDING" | "SUCCESS" | "FAILED" | "EXPIRED";
				description?: string;
				metadata?: Record<string, unknown>;
				balanceBefore?: number;
				balanceAfter?: number;
			}) => Promise<Transaction>;
		},
	): Promise<ChargePaymentResult> {
		const { wallet, amount, orderType, transactionType, metadata, userId } =
			request;
		const { tx, insertPayment, createTransaction } = deps;

		try {
			const amountDecimal = new Decimal(amount);
			const currentBalance = new Decimal(wallet.balance);
			const amountSql = toStringNumberSafe(amountDecimal);

			// Generate description
			let desc: string | undefined;
			switch (orderType) {
				case "TOPUP":
					desc = "Top-up wallet";
					break;
				case "RIDE":
				case "FOOD":
				case "DELIVERY":
					desc = `Payment for ${orderType}`;
					break;
			}

			const fullMetadata = { ...metadata, type: orderType, desc };

			// CRITICAL: Atomic wallet deduction with balance check
			// Prevents race conditions and ensures balance never goes negative
			const [updatedWallet] = await tx
				.update(tables.wallet)
				.set({
					balance: sql`balance - ${amountSql}`,
					updatedAt: new Date(),
				})
				.where(
					sql`${tables.wallet.id} = ${wallet.id} AND balance >= ${amountSql}`,
				)
				.returning();

			if (!updatedWallet) {
				throw new RepositoryError(m.error_insufficient_wallet_balance(), {
					code: "BAD_REQUEST",
				});
			}

			const newBalance = new Decimal(updatedWallet.balance);
			const balanceBefore = toNumberSafe(currentBalance);
			const balanceAfter = toNumberSafe(newBalance);

			// Create transaction with SUCCESS status and balance info
			const transaction = await createTransaction({
				walletId: wallet.id,
				type: transactionType,
				amount,
				status: "SUCCESS",
				description: desc,
				metadata: fullMetadata,
				balanceBefore,
				balanceAfter,
			});

			// Create payment record
			const payment = await insertPayment(
				{
					transactionId: transaction.id,
					provider: "MIDTRANS",
					method: "wallet",
					amount,
					status: "SUCCESS",
					externalId: transaction.id,
					expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000), // 24 hours
					response: { wallet_payment: true },
					payload: {
						method: "wallet",
						amount,
						userId,
						provider: "MIDTRANS",
						metadata: fullMetadata,
					},
				},
				{ tx },
			);

			return {
				payment,
				transaction,
				wallet: {
					...wallet,
					balance: toNumberSafe(updatedWallet.balance),
					updatedAt: updatedWallet.updatedAt,
				},
			};
		} catch (error) {
			logger.error(
				{ error, userId, amount, walletId: wallet.id },
				"[PaymentChargeService] Failed to charge wallet - transaction will be rolled back",
			);
			throw error;
		}
	}

	/**
	 * Composes payment entity from database row
	 *
	 * @param item - Payment database row
	 * @returns Composed Payment entity
	 */
	static composeEntity(item: PaymentDatabase): Payment {
		return {
			...item,
			amount: toNumberSafe(item.amount),
			bankProvider: item.bankProvider ?? undefined,
			externalId: item.externalId ?? undefined,
			expiresAt: item.expiresAt ?? undefined,
			response: item.response ?? undefined,
			paymentUrl: item.paymentUrl ?? undefined,
			va_number: item.va_number ?? undefined,
			payload: item.payload ?? undefined,
			metadata: item.metadata ?? undefined,
		};
	}
}

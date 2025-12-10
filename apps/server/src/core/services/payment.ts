import {
	type BankTransfer,
	type ChargeParameter,
	type ChargeResponse,
	CoreApi,
	Iris,
	MidtransError,
	type TransactionStatusResponse,
} from "@erhahahaa/midtrans-client-typescript";
import type { BankProvider } from "@repo/schema/common";
import type { PaymentMethod } from "@repo/schema/payment";
import { logger } from "@/utils/logger";
import { PaymentError } from "../error";

export interface PaymentChargePayload {
	externalId: string;
	amount: number;
	description?: string;
	method: PaymentMethod;
	customer?: {
		name: string;
		email?: string;
		phone?: string;
	};
	expiry?: {
		duration: number;
		unit: "second" | "minute" | "hour" | "day";
	};
	bank?: BankProvider;
	va_number?: string;
	metadata?: Record<string, unknown>;
	echannel?: Record<string, unknown>;
}

export interface PaymentVerificationPayload {
	externalId: string;
}

export interface PaymentWebhookPayload {
	rawBody: unknown;
	headers: Record<string, string>;
}

export interface PaymentWebhookResult {
	status: string;
	externalId: string;
	fraudStatus?: string;
	raw: unknown;
}

export interface BankValidationPayload {
	bankProvider: BankProvider;
	accountNumber: string;
}

export interface BankValidationResult {
	isValid: boolean;
	accountName: string | null;
	bankCode: string;
	accountNumber: string;
}

// ==================== Payout/Disbursement Types ====================

/**
 * Payout request payload for creating a withdrawal/disbursement
 */
export interface PayoutPayload {
	/** Unique reference number for this payout (e.g., transaction ID) */
	referenceNo: string;
	/** Beneficiary's bank account name */
	beneficiaryName: string;
	/** Beneficiary's bank account number */
	beneficiaryAccount: string;
	/** Bank code (e.g., "bca", "bni", "bri", "mandiri", "permata") */
	beneficiaryBank: BankProvider;
	/** Beneficiary's email for notification (optional) */
	beneficiaryEmail?: string;
	/** Amount to disburse (in IDR) */
	amount: number;
	/** Notes/description for the payout */
	notes?: string;
}

/**
 * Payout status from Midtrans Iris
 * @see https://iris-docs.midtrans.com/#payout-status
 */
export type PayoutStatus =
	| "queued" // Payout is queued, waiting to be processed
	| "processed" // Payout is being processed by bank
	| "completed" // Payout successfully completed
	| "failed"; // Payout failed

/**
 * Payout result after creating a disbursement
 */
export interface PayoutResult {
	/** Status of the payout */
	status: PayoutStatus;
	/** Reference number from Midtrans */
	referenceNo: string;
	/** Error message if failed */
	errorMessage?: string;
}

/**
 * Detailed payout information
 */
export interface PayoutDetails {
	status: PayoutStatus;
	referenceNo: string;
	beneficiaryName: string;
	beneficiaryAccount: string;
	beneficiaryBank: string;
	amount: string;
	notes?: string;
	createdAt?: string;
	updatedAt?: string;
}

// ==================== Service Interfaces ====================

export interface PaymentService {
	charge(payload: PaymentChargePayload): Promise<unknown>;
	verify(payload: PaymentVerificationPayload): Promise<unknown>;
	handleWebhook(payload: PaymentWebhookPayload): Promise<unknown>;
}

export interface BankValidationService {
	validateBankAccount(
		payload: BankValidationPayload,
	): Promise<BankValidationResult>;
}

/**
 * Payout/Disbursement service interface for withdrawals
 */
export interface PayoutService {
	/** Create a payout/disbursement to a bank account */
	createPayout(payload: PayoutPayload): Promise<PayoutResult>;
	/** Get payout details by reference number */
	getPayoutDetails(referenceNo: string): Promise<PayoutDetails>;
	/** Get current Iris balance */
	getBalance(): Promise<number>;
}

// ==================== Service Options ====================

interface MidtransPaymentOptions {
	isProduction: boolean;
	serverKey: string;
	clientKey: string;
}

interface MidtransIrisOptions {
	isProduction: boolean;
	serverKey: string;
}

// ==================== Service Implementations ====================

export class MidtransPaymentService implements PaymentService {
	readonly #client: CoreApi;

	constructor(opts: MidtransPaymentOptions) {
		this.#client = new CoreApi(opts);
	}

	async charge(payload: PaymentChargePayload): Promise<ChargeResponse> {
		try {
			logger.debug({ payload }, "[MidtransPayment] charge payload");
			const { method, bank } = payload;
			const chargePayload: ChargeParameter = {
				payment_type: "qris",
				transaction_details: {
					order_id: payload.externalId,
					gross_amount: Math.ceil(payload.amount),
				},
				customer_details: payload.customer,
				metadata: { ...payload.metadata, description: payload.description },
			};

			if (payload.expiry) {
				chargePayload.custom_expiry = {
					expiry_duration: payload.expiry.duration,
					unit: payload.expiry.unit,
				};
			}

			if (method === "BANK_TRANSFER" && bank) {
				chargePayload.payment_type = "bank_transfer";
				chargePayload.bank_transfer = {
					bank: bank.toLowerCase() as BankTransfer["bank"],
					// va_number: payload.va_number,
				};

				if (payload.va_number) {
					chargePayload.bank_transfer.va_number = payload.va_number;
				}

				if (bank.toLowerCase() === "mandiri") {
					chargePayload.echannel = {
						bill_info1: "Payment for:",
						bill_info2: "Akademove",
						...payload.echannel,
					};
				}

				if (bank.toLowerCase() === "permata") {
					chargePayload.bank_transfer.permata = {
						recipient_name: "Zenta Dev",
					};
				}
			}

			const res = await this.#client.charge(chargePayload);
			return res;
		} catch (error) {
			logger.error(
				{ payload, detail: error },
				"[MidtransPayment] charge failed",
			);
			if (error instanceof MidtransError) {
				logger.info({ detail: error.rawHttpClientData }, "RAW");
			}
			throw new PaymentError("Failed to charge", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async verify(
		payload: PaymentVerificationPayload,
	): Promise<TransactionStatusResponse> {
		try {
			logger.debug({ payload }, "[MidtransPayment] verify payload");
			const res = await this.#client.transaction.status(payload.externalId);
			return res;
		} catch (error) {
			logger.error(
				{ payload, detail: error },
				"[MidtransPayment] verify failed.",
			);
			throw new PaymentError("Failed to verify", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async handleWebhook(
		payload: PaymentWebhookPayload,
	): Promise<PaymentWebhookResult> {
		try {
			logger.debug({ payload }, "[MidtransPayment] handleWebhook payload");
			const body = payload.rawBody as {
				transaction_status: string;
				order_id: string;
				fraud_status: string;
			};
			const result: PaymentWebhookResult = {
				status: body.transaction_status,
				externalId: body.order_id,
				fraudStatus: body.fraud_status,
				raw: body,
			};
			return result;
		} catch (error) {
			logger.error(
				{ payload, detail: error },
				"[MidtransPayment] handleWebhook failed.",
			);
			throw new PaymentError("Failed to handle webhook", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}
}

/**
 * Iris API response for bank account validation
 * @see https://iris-docs.midtrans.com/#validate-bank-account
 */
interface IrisBankValidationResponse {
	account_name?: string;
	account_no?: string;
	bank_name?: string;
	status?: string;
}

/**
 * Iris API response for payout item
 */
interface IrisPayoutItemResponse {
	status: string;
	reference_no: string;
	beneficiary_name?: string;
	beneficiary_account?: string;
	beneficiary_bank?: string;
	amount?: string;
	notes?: string;
	created_at?: string;
	updated_at?: string;
	error_message?: string;
	error_code?: string;
}

/**
 * MidtransBankValidationService uses the Midtrans Iris API to validate bank accounts.
 * This is used during driver/merchant sign-up to verify bank account ownership.
 *
 * @see https://iris-docs.midtrans.com/#validate-bank-account
 */
export class MidtransBankValidationService implements BankValidationService {
	readonly #client: Iris;

	constructor(opts: MidtransIrisOptions) {
		this.#client = new Iris(opts);
	}

	/**
	 * Get the Iris client instance for advanced operations
	 */
	get client(): Iris {
		return this.#client;
	}

	/**
	 * Validate a bank account using Midtrans Iris API
	 * Returns account holder name if valid, null if invalid
	 */
	async validateBankAccount(
		payload: BankValidationPayload,
	): Promise<BankValidationResult> {
		try {
			const bankCode = payload.bankProvider.toLowerCase();
			logger.debug(
				{ bankCode, accountNumber: payload.accountNumber },
				"[MidtransBankValidation] Validating bank account",
			);

			const response = (await this.#client.validateBankAccount({
				bank: bankCode,
				account: payload.accountNumber,
			})) as IrisBankValidationResponse;

			logger.debug(
				{ response },
				"[MidtransBankValidation] Validation response",
			);

			// Check if we got a valid account name back
			const accountName = response.account_name ?? null;
			const isValid = accountName !== null && accountName.trim().length > 0;

			return {
				isValid,
				accountName,
				bankCode: payload.bankProvider,
				accountNumber: payload.accountNumber,
			};
		} catch (error) {
			logger.error(
				{ payload, detail: error },
				"[MidtransBankValidation] Validation failed",
			);

			if (error instanceof MidtransError) {
				logger.debug(
					{ rawData: error.rawHttpClientData },
					"[MidtransBankValidation] Raw error data",
				);

				// Return invalid result instead of throwing for expected validation failures
				// (e.g., account not found, invalid account number format)
				return {
					isValid: false,
					accountName: null,
					bankCode: payload.bankProvider,
					accountNumber: payload.accountNumber,
				};
			}

			throw new PaymentError("Failed to validate bank account", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}
}

/**
 * MidtransPayoutService handles disbursements/payouts via Midtrans Iris API.
 * This is used for driver/merchant withdrawals to their bank accounts.
 *
 * @see https://iris-docs.midtrans.com/#create-payouts
 */
export class MidtransPayoutService implements PayoutService {
	readonly #client: Iris;

	constructor(opts: MidtransIrisOptions) {
		this.#client = new Iris(opts);
	}

	/**
	 * Create a payout/disbursement to a bank account
	 * This initiates a transfer from the Midtrans Iris balance to the beneficiary's bank account
	 *
	 * @param payload - Payout details including beneficiary info and amount
	 * @returns Payout result with status and reference number
	 */
	async createPayout(payload: PayoutPayload): Promise<PayoutResult> {
		try {
			logger.info(
				{
					referenceNo: payload.referenceNo,
					beneficiaryBank: payload.beneficiaryBank,
					amount: payload.amount,
				},
				"[MidtransPayout] Creating payout",
			);

			const response = await this.#client.createPayouts({
				payouts: [
					{
						beneficiary_name: payload.beneficiaryName,
						beneficiary_account: payload.beneficiaryAccount,
						beneficiary_bank: payload.beneficiaryBank.toLowerCase(),
						beneficiary_email: payload.beneficiaryEmail,
						amount: payload.amount.toString(),
						notes: payload.notes ?? `Withdrawal ${payload.referenceNo}`,
						reference_no: payload.referenceNo,
					},
				],
			});

			const payoutItem = response.payouts[0];
			if (!payoutItem) {
				throw new PaymentError("No payout response received", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			logger.info(
				{
					referenceNo: payoutItem.reference_no,
					status: payoutItem.status,
				},
				"[MidtransPayout] Payout created",
			);

			return {
				status: this.mapPayoutStatus(payoutItem.status),
				referenceNo: payoutItem.reference_no,
			};
		} catch (error) {
			logger.error(
				{ payload, detail: error },
				"[MidtransPayout] Create payout failed",
			);

			if (error instanceof MidtransError) {
				logger.debug(
					{ rawData: error.rawHttpClientData },
					"[MidtransPayout] Raw error data",
				);

				// Extract error message from Midtrans response
				const apiResponse = error.ApiResponse;
				const errorMessage =
					apiResponse?.status_message ?? "Payout creation failed";

				return {
					status: "failed",
					referenceNo: payload.referenceNo,
					errorMessage,
				};
			}

			if (error instanceof PaymentError) {
				throw error;
			}

			throw new PaymentError("Failed to create payout", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Get payout details by reference number
	 *
	 * @param referenceNo - The reference number of the payout
	 * @returns Detailed payout information
	 */
	async getPayoutDetails(referenceNo: string): Promise<PayoutDetails> {
		try {
			logger.debug({ referenceNo }, "[MidtransPayout] Getting payout details");

			const response = (await this.#client.getPayoutDetails(
				referenceNo,
			)) as IrisPayoutItemResponse;

			logger.debug({ response }, "[MidtransPayout] Payout details response");

			return {
				status: this.mapPayoutStatus(response.status),
				referenceNo: response.reference_no,
				beneficiaryName: response.beneficiary_name ?? "",
				beneficiaryAccount: response.beneficiary_account ?? "",
				beneficiaryBank: response.beneficiary_bank ?? "",
				amount: response.amount ?? "0",
				notes: response.notes,
				createdAt: response.created_at,
				updatedAt: response.updated_at,
			};
		} catch (error) {
			logger.error(
				{ referenceNo, detail: error },
				"[MidtransPayout] Get payout details failed",
			);

			if (error instanceof MidtransError) {
				logger.debug(
					{ rawData: error.rawHttpClientData },
					"[MidtransPayout] Raw error data",
				);
			}

			throw new PaymentError("Failed to get payout details", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Get current Iris balance
	 * This shows how much is available for disbursements
	 *
	 * @returns Available balance in IDR
	 */
	async getBalance(): Promise<number> {
		try {
			logger.debug("[MidtransPayout] Getting Iris balance");

			const response = await this.#client.getBalance();

			const balance = Number.parseFloat(response.balance);
			logger.info({ balance }, "[MidtransPayout] Current Iris balance");

			return balance;
		} catch (error) {
			logger.error({ detail: error }, "[MidtransPayout] Get balance failed");

			if (error instanceof MidtransError) {
				logger.debug(
					{ rawData: error.rawHttpClientData },
					"[MidtransPayout] Raw error data",
				);
			}

			throw new PaymentError("Failed to get Iris balance", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Map Midtrans Iris payout status to our PayoutStatus type
	 */
	private mapPayoutStatus(status: string): PayoutStatus {
		const statusLower = status.toLowerCase();
		switch (statusLower) {
			case "queued":
				return "queued";
			case "processed":
			case "processing":
				return "processed";
			case "completed":
			case "done":
				return "completed";
			case "failed":
			case "rejected":
			case "error":
				return "failed";
			default:
				logger.warn(
					{ status },
					"[MidtransPayout] Unknown payout status, defaulting to queued",
				);
				return "queued";
		}
	}
}

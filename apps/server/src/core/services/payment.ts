import {
	type BankTransfer,
	type ChargeParameter,
	type ChargeResponse,
	CoreApi,
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
 * @see https://docs.midtrans.com/reference/validate-bank-account
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
 * Iris API response for create payouts
 */
interface IrisCreatePayoutsResponse {
	payouts: Array<{
		status: string;
		reference_no: string;
	}>;
}

/**
 * Iris API response for balance
 */
interface IrisBalanceResponse {
	balance: string;
}

/**
 * Iris API error response
 */
interface IrisErrorResponse {
	error_message?: string;
	errors?: string[];
}

// ==================== Custom Iris HTTP Client ====================

const IRIS_SANDBOX_URL = "https://app.sandbox.midtrans.com/iris/api/v1";
const IRIS_PRODUCTION_URL = "https://app.midtrans.com/iris/api/v1";

/**
 * Custom Iris HTTP client that uses direct fetch instead of the midtrans package.
 * This follows the Midtrans Iris API documentation directly.
 *
 * @see https://docs.midtrans.com/reference/payout-api-overview
 */
class IrisHttpClient {
	readonly #serverKey: string;
	readonly #baseUrl: string;

	constructor(opts: MidtransIrisOptions) {
		this.#serverKey = opts.serverKey;
		this.#baseUrl = opts.isProduction ? IRIS_PRODUCTION_URL : IRIS_SANDBOX_URL;
	}

	private getAuthHeader(): string {
		// Midtrans uses HTTP Basic Auth with serverKey as username and empty password
		const credentials = Buffer.from(`${this.#serverKey}:`).toString("base64");
		return `Basic ${credentials}`;
	}

	async request<T>(
		method: "GET" | "POST" | "PATCH",
		endpoint: string,
		params?: Record<string, string>,
		body?: unknown,
	): Promise<T> {
		let url = `${this.#baseUrl}${endpoint}`;

		// Add query params for GET requests
		if (params && Object.keys(params).length > 0) {
			const searchParams = new URLSearchParams(params);
			url = `${url}?${searchParams.toString()}`;
		}

		const headers: Record<string, string> = {
			Authorization: this.getAuthHeader(),
			Accept: "application/json",
		};

		const fetchOptions: RequestInit = {
			method,
			headers,
		};

		if (body && method !== "GET") {
			headers["Content-Type"] = "application/json";
			fetchOptions.body = JSON.stringify(body);
		}

		logger.debug(
			{ method, url, hasBody: !!body },
			"[IrisHttpClient] Making request",
		);

		const response = await fetch(url, fetchOptions);
		const responseText = await response.text();

		logger.debug(
			{ status: response.status, responseText: responseText.substring(0, 500) },
			"[IrisHttpClient] Response received",
		);

		// Try to parse as JSON
		let data: T;
		try {
			data = JSON.parse(responseText) as T;
		} catch {
			// If response is not JSON, it's likely an auth error
			throw new PaymentError(
				`Iris API returned non-JSON response: ${responseText.substring(0, 100)}`,
				{ code: "INTERNAL_SERVER_ERROR" },
			);
		}

		// Check for error responses
		if (!response.ok) {
			const errorData = data as unknown as IrisErrorResponse;
			const errorMessage =
				errorData.error_message ??
				errorData.errors?.join(", ") ??
				`Iris API error: ${response.status}`;
			throw new PaymentError(errorMessage, { code: "BAD_REQUEST" });
		}

		return data;
	}
}

/**
 * CustomIrisBankValidationService uses direct fetch to the Midtrans Iris API.
 * This bypasses the midtrans-client-typescript package which may have issues.
 *
 * @see https://docs.midtrans.com/reference/validate-bank-account
 */
export class CustomIrisBankValidationService implements BankValidationService {
	readonly #client: IrisHttpClient;

	constructor(opts: MidtransIrisOptions) {
		this.#client = new IrisHttpClient(opts);
	}

	async validateBankAccount(
		payload: BankValidationPayload,
	): Promise<BankValidationResult> {
		try {
			const bankCode = payload.bankProvider.toLowerCase();
			logger.debug(
				{ bankCode, accountNumber: payload.accountNumber },
				"[CustomIrisBankValidation] Validating bank account",
			);

			const response = await this.#client.request<IrisBankValidationResponse>(
				"GET",
				"/account_validation",
				{
					bank: bankCode,
					account: payload.accountNumber,
				},
			);

			logger.debug(
				{ response },
				"[CustomIrisBankValidation] Validation response",
			);

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
				{ payload, error },
				"[CustomIrisBankValidation] Validation failed",
			);

			// Return invalid result for expected validation failures
			if (error instanceof PaymentError) {
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
 * CustomIrisPayoutService uses direct fetch to the Midtrans Iris API.
 *
 * @see https://docs.midtrans.com/reference/create-payouts
 */
export class CustomIrisPayoutService implements PayoutService {
	readonly #client: IrisHttpClient;

	constructor(opts: MidtransIrisOptions) {
		this.#client = new IrisHttpClient(opts);
	}

	async createPayout(payload: PayoutPayload): Promise<PayoutResult> {
		try {
			logger.info(
				{
					referenceNo: payload.referenceNo,
					beneficiaryBank: payload.beneficiaryBank,
					amount: payload.amount,
				},
				"[CustomIrisPayout] Creating payout",
			);

			const response = await this.#client.request<IrisCreatePayoutsResponse>(
				"POST",
				"/payouts",
				undefined,
				{
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
				},
			);

			const payoutItem = response.payouts[0];
			if (!payoutItem) {
				throw new PaymentError("No payout response received", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			logger.info(
				{ referenceNo: payoutItem.reference_no, status: payoutItem.status },
				"[CustomIrisPayout] Payout created",
			);

			return {
				status: this.mapPayoutStatus(payoutItem.status),
				referenceNo: payoutItem.reference_no,
			};
		} catch (error) {
			logger.error(
				{ payload, error },
				"[CustomIrisPayout] Create payout failed",
			);

			if (error instanceof PaymentError) {
				return {
					status: "failed",
					referenceNo: payload.referenceNo,
					errorMessage: error.message,
				};
			}

			throw new PaymentError("Failed to create payout", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async getPayoutDetails(referenceNo: string): Promise<PayoutDetails> {
		try {
			logger.debug(
				{ referenceNo },
				"[CustomIrisPayout] Getting payout details",
			);

			const response = await this.#client.request<IrisPayoutItemResponse>(
				"GET",
				`/payouts/${referenceNo}`,
			);

			logger.debug({ response }, "[CustomIrisPayout] Payout details response");

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
				{ referenceNo, error },
				"[CustomIrisPayout] Get payout details failed",
			);

			throw new PaymentError("Failed to get payout details", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	async getBalance(): Promise<number> {
		try {
			logger.debug("[CustomIrisPayout] Getting Iris balance");

			const response = await this.#client.request<IrisBalanceResponse>(
				"GET",
				"/balance",
			);

			const balance = Number.parseFloat(response.balance);
			logger.info({ balance }, "[CustomIrisPayout] Current Iris balance");

			return balance;
		} catch (error) {
			logger.error({ error }, "[CustomIrisPayout] Get balance failed");

			throw new PaymentError("Failed to get Iris balance", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

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
					"[CustomIrisPayout] Unknown payout status, defaulting to queued",
				);
				return "queued";
		}
	}
}

// ==================== Mock Services (when Iris is disabled) ====================

/**
 * MockBankValidationService is used when MIDTRANS_EXPERIMENTAL_IRIS is disabled.
 * It skips actual bank validation and returns the account as valid.
 *
 * WARNING: This does not perform real validation. Enable Iris for production use.
 */
export class MockBankValidationService implements BankValidationService {
	async validateBankAccount(
		payload: BankValidationPayload,
	): Promise<BankValidationResult> {
		logger.warn(
			{ payload },
			"[MockBankValidation] Using mock validation - MIDTRANS_EXPERIMENTAL_IRIS is disabled",
		);

		return {
			isValid: true,
			accountName: null,
			bankCode: payload.bankProvider,
			accountNumber: payload.accountNumber,
		};
	}
}

/**
 * MockPayoutService is used when MIDTRANS_EXPERIMENTAL_IRIS is disabled.
 * All payout operations will fail with an error.
 */
export class MockPayoutService implements PayoutService {
	async createPayout(payload: PayoutPayload): Promise<PayoutResult> {
		logger.error(
			{ payload },
			"[MockPayout] Payout attempted but MIDTRANS_EXPERIMENTAL_IRIS is disabled",
		);

		return {
			status: "failed",
			referenceNo: payload.referenceNo,
			errorMessage:
				"Payout service is disabled. Enable MIDTRANS_EXPERIMENTAL_IRIS to use payouts.",
		};
	}

	async getPayoutDetails(referenceNo: string): Promise<PayoutDetails> {
		logger.error(
			{ referenceNo },
			"[MockPayout] Get payout details attempted but MIDTRANS_EXPERIMENTAL_IRIS is disabled",
		);

		throw new PaymentError(
			"Payout service is disabled. Enable MIDTRANS_EXPERIMENTAL_IRIS to use payouts.",
			{ code: "BAD_REQUEST" },
		);
	}

	async getBalance(): Promise<number> {
		logger.error(
			"[MockPayout] Get balance attempted but MIDTRANS_EXPERIMENTAL_IRIS is disabled",
		);

		throw new PaymentError(
			"Payout service is disabled. Enable MIDTRANS_EXPERIMENTAL_IRIS to use payouts.",
			{ code: "BAD_REQUEST" },
		);
	}
}

/**
 * @deprecated Use CustomIrisBankValidationService instead.
 * MidtransBankValidationService uses the Midtrans Iris API to validate bank accounts.
 * This is used during driver/merchant sign-up to verify bank account ownership.
 *
 * @see https://iris-docs.midtrans.com/#validate-bank-account
 */
export class MidtransBankValidationService implements BankValidationService {
	readonly #client: CustomIrisBankValidationService;

	constructor(opts: MidtransIrisOptions) {
		this.#client = new CustomIrisBankValidationService(opts);
	}

	async validateBankAccount(
		payload: BankValidationPayload,
	): Promise<BankValidationResult> {
		return this.#client.validateBankAccount(payload);
	}
}

/**
 * @deprecated Use CustomIrisPayoutService instead.
 * MidtransPayoutService handles disbursements/payouts via Midtrans Iris API.
 * This is used for driver/merchant withdrawals to their bank accounts.
 *
 * @see https://iris-docs.midtrans.com/#create-payouts
 */
export class MidtransPayoutService implements PayoutService {
	readonly #client: CustomIrisPayoutService;

	constructor(opts: MidtransIrisOptions) {
		this.#client = new CustomIrisPayoutService(opts);
	}

	async createPayout(payload: PayoutPayload): Promise<PayoutResult> {
		return this.#client.createPayout(payload);
	}

	async getPayoutDetails(referenceNo: string): Promise<PayoutDetails> {
		return this.#client.getPayoutDetails(referenceNo);
	}

	async getBalance(): Promise<number> {
		return this.#client.getBalance();
	}
}

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

export interface PaymentService {
	charge(payload: PaymentChargePayload): Promise<unknown>;
	verify(payload: PaymentVerificationPayload): Promise<unknown>;
	handleWebhook(payload: PaymentWebhookPayload): Promise<unknown>;
}
interface MidtransPaymentOptions {
	isProduction: boolean;
	serverKey: string;
	clientKey: string;
}

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

import { ORPCError } from "@orpc/server";

export const COMMON_ERROR_DEFS = {
	BAD_REQUEST: { status: 400, message: "Bad Request" },
	UNAUTHORIZED: { status: 401, message: "Unauthorized" },
	FORBIDDEN: { status: 403, message: "Forbidden" },
	NOT_FOUND: { status: 404, message: "Not Found" },
	METHOD_NOT_SUPPORTED: { status: 405, message: "Method Not Supported" },
	NOT_ACCEPTABLE: { status: 406, message: "Not Acceptable" },
	TIMEOUT: { status: 408, message: "Request Timeout" },
	CONFLICT: { status: 409, message: "Conflict" },
	PRECONDITION_FAILED: { status: 412, message: "Precondition Failed" },
	PAYLOAD_TOO_LARGE: { status: 413, message: "Payload Too Large" },
	UNSUPPORTED_MEDIA_TYPE: { status: 415, message: "Unsupported Media Type" },
	UNPROCESSABLE_CONTENT: { status: 422, message: "Unprocessable Content" },
	TOO_MANY_REQUESTS: { status: 429, message: "Too Many Requests" },
	CLIENT_CLOSED_REQUEST: { status: 499, message: "Client Closed Request" },
	INTERNAL_SERVER_ERROR: { status: 500, message: "Internal Server Error" },
	NOT_IMPLEMENTED: { status: 501, message: "Not Implemented" },
	BAD_GATEWAY: { status: 502, message: "Bad Gateway" },
	SERVICE_UNAVAILABLE: { status: 503, message: "Service Unavailable" },
	GATEWAY_TIMEOUT: { status: 504, message: "Gateway Timeout" },
} as const;

export type CommonErrorCode = keyof typeof COMMON_ERROR_DEFS;

export interface ErrorOptions {
	code?: CommonErrorCode;
	fields?: string[];
}

export abstract class BaseError extends Error {
	readonly code?: CommonErrorCode;
	readonly fields?: string[];

	constructor(message: string, { code, fields }: ErrorOptions = {}) {
		super(message);
		this.name = new.target.name;
		this.code = code;
		this.fields = fields;
		Error.captureStackTrace?.(this, new.target);
	}

	toJSON() {
		return {
			success: false,
			message: this.message,
			code: this.code,
		} as const;
	}

	toORPCError() {
		const code = this.code ?? "INTERNAL_SERVER_ERROR";
		const { status } = COMMON_ERROR_DEFS[code];
		return new ORPCError(code, {
			defined: true,
			status,
			message: this.message,
			data: { fields: this.fields ?? [] },
		});
	}

	toResponse(): Response {
		const code = this.code ?? "INTERNAL_SERVER_ERROR";
		const { status } = COMMON_ERROR_DEFS[code];
		return new Response(JSON.stringify(this.toJSON()), {
			status,
			headers: { "Content-Type": "application/json" },
		});
	}
}

function createErrorClass(name: string) {
	return class extends BaseError {
		constructor(message: string, options: ErrorOptions = {}) {
			super(message, options);
			this.name = name;
		}
	};
}

export const KeyValueError = createErrorClass("KeyValueError");
export const MailError = createErrorClass("MailError");
export const StorageError = createErrorClass("StorageError");
export const RepositoryError = createErrorClass("RepositoryError");
export const MiddlewareError = createErrorClass("MiddlewareError");
export const UnknownError = createErrorClass("UnknownError");
export const SessionError = createErrorClass("SessionError");
export const AuthError = createErrorClass("AuthError");
export const MapError = createErrorClass("MapError");
export const PaymentError = createErrorClass("PaymentError");
export const FirebaseError = createErrorClass("FirebaseError");

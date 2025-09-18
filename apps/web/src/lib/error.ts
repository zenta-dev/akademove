export abstract class BaseError extends Error {
	constructor(message?: string) {
		super(message);
		this.name = this.constructor.name;
		Error.captureStackTrace(this, this.constructor);
	}
}

export class APIError extends BaseError {
	constructor(message?: string) {
		super(message);
		this.name = "APIError";
	}
}

interface BACOptions {
	code?: string;
}
export class BetterAuthClientError extends BaseError {
	readonly code?: string;
	constructor(message?: string, { code }: BACOptions = {}) {
		super(message);
		this.code = code;
		this.name = "BACError";
	}
}

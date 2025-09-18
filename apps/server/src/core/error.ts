interface ErrorOptions {
	code?: string | number;
	prevError?: Error;
}

export abstract class BaseError extends Error {
	private readonly code?: string | number;
	private readonly prevError?: Error;

	constructor(message: string, { code, prevError }: ErrorOptions = {}) {
		super(message);
		this.name = this.constructor.name;
		this.code = code;
		this.prevError = prevError;
		Error.captureStackTrace(this, this.constructor);
	}

	toString(): string {
		let errorString = `${this.name}: ${this.message}`;
		if (this.prevError) {
			errorString += `\nCaused by: ${this.prevError.toString()}`;
		}
		return errorString;
	}

	toJSON() {
		return {
			success: false,
			message: this.message,
			code: this.code,
			errors: [
				{
					name: this.name,
					stack: this.stack,
				},
			],
		};
	}

	toResponse(): Response {
		return new Response(JSON.stringify(this.toJSON()), {
			status: 500,
			headers: {
				"Content-Type": "application/json",
			},
		});
	}
}

export class KeyValueError extends BaseError {
	constructor(message: string, { code, prevError }: ErrorOptions = {}) {
		super(message, { code, prevError });
		this.name = "KeyValueError";
	}
}

export class MailError extends BaseError {
	constructor(message: string, { code, prevError }: ErrorOptions = {}) {
		super(message, { code, prevError });
		this.name = "MailError";
	}
}

export class StorageError extends BaseError {
	constructor(message: string, { code, prevError }: ErrorOptions = {}) {
		super(message, { code, prevError });
		this.name = "StorageError";
	}
}

export class RepositoryError extends BaseError {
	constructor(message: string, { code, prevError }: ErrorOptions = {}) {
		super(message, { code, prevError });
		this.name = "RepositoryError";
	}
}

export class MiddlewareError extends BaseError {
	constructor(message: string, { code, prevError }: ErrorOptions = {}) {
		super(message, { code, prevError });
		this.name = "MiddlewareError";
	}
}

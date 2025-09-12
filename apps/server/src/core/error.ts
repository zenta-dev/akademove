interface ErrorOptions {
	prevError?: Error;
}

abstract class BaseError extends Error {
	private readonly prevError?: Error;

	constructor(message: string, { prevError }: ErrorOptions = {}) {
		super(message);
		this.name = this.constructor.name;
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
			error: {
				name: this.name,
				stack: this.stack,
			},
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
	constructor(message: string, { prevError }: ErrorOptions = {}) {
		super(message, { prevError });
		this.name = "KeyValueError";
	}
}

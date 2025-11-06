import { env } from "cloudflare:workers";
import { createLogger } from "@repo/shared/logger.server";
import Decimal from "decimal.js";

export const isDev = env.NODE_ENV !== "production";
export const isCloudflare = env.RUNTIME === "cloudflare";
export const log = createLogger({
	nodeEnv: env.NODE_ENV,
	remote: { sourceToken: env.LOG_SOURCE_TOKEN, endpoint: env.LOG_ENDPOINT },
});
class Result<T> {
	readonly success: boolean;
	readonly data?: T;
	readonly error?: unknown;

	private constructor(success: boolean, data?: T, error?: unknown) {
		this.success = success;
		this.data = data;
		this.error = error;
	}

	static ok<T>(data: T): Result<T> {
		return new Result<T>(true, data);
	}

	static err<T = never>(error: unknown): Result<T> {
		return new Result<T>(false, undefined, error);
	}

	isOk(): this is Result<T> & { data: T } {
		return this.success;
	}

	isErr(): this is Result<T> & { error: unknown } {
		return !this.success;
	}
}

export async function safeAsync<T>(fn: Promise<T>): Promise<Result<T>> {
	try {
		const data = await fn;
		return Result.ok(data);
	} catch (error) {
		return Result.err<T>(error);
	}
}

export function safeSync<T>(fn: () => T): Result<T> {
	try {
		const data = fn();
		return Result.ok(data);
	} catch (error) {
		return Result.err<T>(error);
	}
}

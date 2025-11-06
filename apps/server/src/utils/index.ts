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
export function toNumberSafe(value: string | number | Decimal): number {
	return new Decimal(value).toDecimalPlaces(2).toNumber();
}

export function toStringNumberSafe(value: number | Decimal): string {
	return new Decimal(value).toFixed(2);
}
export function withQueryParams(
	req: Request,
	params: Record<string, string>,
): Request {
	const url = new URL(req.url);
	for (const [key, value] of Object.entries(params)) {
		url.searchParams.set(key, value);
	}
	return new Request(url.toString(), req);
}

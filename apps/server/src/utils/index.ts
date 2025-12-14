import { env } from "cloudflare:workers";
import Decimal from "decimal.js";

export const isDev = env.NODE_ENV !== "production";
export const isCloudflare = env.RUNTIME === "cloudflare";

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
export type PromiseFn<T> = () => Promise<T>;
type PromiseLike<T> = Promise<T> | PromiseFn<T>;

export async function safeAsync<T>(fn: PromiseLike<T>): Promise<Result<T>> {
	try {
		const data = await (typeof fn === "function" ? fn() : fn);
		return Result.ok(data);
	} catch (error) {
		return Result.err(error);
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

/**
 * @deprecated DO NOT USE IN CLOUDFLARE WORKERS
 *
 * setTimeout does not actually delay execution in Cloudflare Workers due to
 * security restrictions. It only defers execution to the next event loop iteration,
 * NOT for the full time specified.
 *
 * "Due to security-based restrictions on timers in Workers, timers are limited to
 * returning the time of the last I/O. This means that while setTimeout, setInterval,
 * and setImmediate will defer your function execution until other events have run,
 * they will not delay them for the full time specified."
 *
 * @see https://developers.cloudflare.com/workers/runtime-apis/nodejs/timers/
 *
 * Instead, use Cloudflare Queues with delaySeconds for reliable delays:
 * @example
 * import { ProcessingQueueService } from "@/core/services/queue";
 * import { BUSINESS_CONSTANTS } from "@/core/constants";
 *
 * await ProcessingQueueService.enqueueWebSocketBroadcast(
 *   { roomName: "driver-pool", action: "MATCHING", ... },
 *   { delaySeconds: BUSINESS_CONSTANTS.BROADCAST_DELAY_SECONDS }
 * );
 */
export function delay<T>(
	ms: number,
	fn?: PromiseLike<T>,
): Promise<T | undefined> {
	return new Promise((resolve) => {
		setTimeout(async () => {
			if (fn) {
				const result = await (typeof fn === "function" ? fn() : fn);
				resolve(result);
			} else {
				resolve(undefined);
			}
		}, ms);
	});
}

import { decode, encode } from "@msgpack/msgpack";
import { BaseError, KeyValueError } from "@/core/error";
import type { PromiseFn } from "@/utils";
import { logger } from "@/utils/logger";

export interface PutCacheOptions {
	expirationTtl?: number;
}
export interface KeyValueService {
	get<T>(key: string, options?: { fallback?: PromiseFn<T> }): Promise<T>;
	put<T>(key: string, value: T, options?: PutCacheOptions): Promise<void>;
	delete(key: string): Promise<void>;
}

export class CloudflareKVService implements KeyValueService {
	constructor(private namespace: KVNamespace) {
		if (!namespace) {
			throw new KeyValueError("KVNamespace is required");
		}
	}

	async get<T>(
		key: string,
		options?: { fallback?: () => Promise<T> },
	): Promise<T> {
		try {
			const value = await this.namespace.get(key, "arrayBuffer");

			if (!value) {
				// Cache miss - use fallback if provided (this is normal behavior, not an error)
				if (options?.fallback) return await options.fallback();
				throw new KeyValueError(`Value for key ${key} not found`, {
					code: "NOT_FOUND",
				});
			}

			const obj = decode(new Uint8Array(value)) as T;
			return obj;
		} catch (error) {
			// Only log and use fallback for unexpected errors (not cache misses)
			if (error instanceof BaseError && error.code === "NOT_FOUND") {
				throw error;
			}

			logger.error({ error, key }, "[CloudflareKVService] Error getting value");
			if (options?.fallback) {
				try {
					return await options.fallback();
				} catch (fallbackError) {
					logger.error(
						{ error: fallbackError, key },
						"[CloudflareKVService] Fallback error",
					);
					// Re-throw the original error from fallback to preserve context
					throw fallbackError;
				}
			}
			throw new KeyValueError(`Failed to get value for key "${key}"`);
		}
	}

	async put<T>(
		key: string,
		value: T,
		options?: KVNamespacePutOptions,
	): Promise<void> {
		try {
			if (typeof value !== "object" || value === null) {
				throw new KeyValueError(
					"Only objects or arrays are supported for binary storage.",
				);
			}

			const encoded = encode(value);
			await this.namespace.put(key, encoded, options);
		} catch (error) {
			throw new KeyValueError(
				`Failed to put value for key "${key}" — ${error}`,
			);
		}
	}

	async delete(key: string): Promise<void> {
		try {
			await this.namespace.delete(key);
		} catch (_error) {
			throw new KeyValueError(`Failed to delete key "${key}"`);
		}
	}
}

import { KeyValueError } from "@/core/error";
import type { PromiseFn } from "@/utils";

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
			const value = await this.namespace.get(key);
			if (!value) {
				if (options?.fallback) {
					return await options.fallback();
				}
				throw new KeyValueError(`Value for key ${key} not found`, {
					code: "NOT_FOUND",
				});
			}
			return JSON.parse(value) as T;
		} catch (error) {
			console.error(`[CloudflareKVService] Error => ${error}`);
			if (options?.fallback) {
				try {
					return await options.fallback();
				} catch (_error) {
					throw new KeyValueError(
						`Failed to get value for key "${key} from callback"`,
						{
							code: "NOT_FOUND",
						},
					);
				}
			} else {
				throw new KeyValueError(`Failed to get value for key "${key}"`);
			}
		}
	}

	async put<T>(
		key: string,
		value: T,
		options?: PutCacheOptions,
	): Promise<void> {
		try {
			let str = "{}";
			if (typeof value === "object" || Array.isArray(value)) {
				str = JSON.stringify(value);
			} else {
				throw new KeyValueError(
					"Unsupported data type, make sure use JSON or array",
				);
			}
			await this.namespace.put(key, str, options);
		} catch (_error) {
			throw new KeyValueError(`Failed to put value for key "${key}"`);
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

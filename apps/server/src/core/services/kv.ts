import type { KVNamespace } from "@cloudflare/workers-types";
import { KeyValueError } from "@/core/error";

interface PutOptions {
	expirationTtl?: number;
}
export interface KeyValueService {
	get<T>(
		key: string,
		options?: { fallback?: () => Promise<T> },
	): Promise<T | undefined>;
	put<T>(key: string, value: T, options?: PutOptions): Promise<void>;
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
	): Promise<T | undefined> {
		try {
			const value = await this.namespace.get(key);
			if (!value) {
				return undefined;
			}
			return JSON.parse(value) as T;
		} catch (_error) {
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
			}
			throw new KeyValueError(`Failed to get value for key "${key}"`);
		}
	}

	async put<T>(key: string, value: T, options?: PutOptions): Promise<void> {
		try {
			await this.namespace.put(key, JSON.stringify(value), options);
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

import type { KVNamespace } from "@cloudflare/workers-types";
import { KeyValueError } from "@/core/error";

interface PutOptions {
	expirationTtl?: number;
}
export interface KeyValueService {
	get<T>(key: string): Promise<T | undefined>;
	put<T>(key: string, value: T, options?: PutOptions): Promise<void>;
	delete(key: string): Promise<void>;
}

export class CloudflareKVService implements KeyValueService {
	constructor(private namespace: KVNamespace) {
		if (!namespace) {
			throw new KeyValueError("KVNamespace is required");
		}
	}
	async get<T>(key: string): Promise<T | undefined> {
		try {
			const value = await this.namespace.get(key);
			if (!value) {
				return undefined;
			}
			return JSON.parse(value) as T;
		} catch (error) {
			throw new KeyValueError(`Failed to get value for key "${key}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
	async put<T>(key: string, value: T, options?: PutOptions): Promise<void> {
		try {
			await this.namespace.put(key, JSON.stringify(value), options);
		} catch (error) {
			throw new KeyValueError(`Failed to put value for key "${key}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
	async delete(key: string): Promise<void> {
		try {
			await this.namespace.delete(key);
		} catch (error) {
			throw new KeyValueError(`Failed to delete key "${key}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

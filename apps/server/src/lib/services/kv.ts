import { KeyValueError } from "@/core/error";

export interface KeyValueService {
	get<T>(key: string): Promise<T | null>;
	set<T>(key: string, value: T): Promise<void>;
	delete(key: string): Promise<void>;
}

export class CloudflareKVService implements KeyValueService {
	constructor(private namespace: KVNamespace) {
		if (!namespace) {
			throw new KeyValueError("KVNamespace is required");
		}
	}
	async get<T>(key: string): Promise<T | null> {
		try {
			const value = await this.namespace.get(key);
			if (value === null) {
				return null;
			}
			return JSON.parse(value) as T;
		} catch (error) {
			throw new KeyValueError(`Failed to get value for key "${key}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
	async set<T>(key: string, value: T): Promise<void> {
		try {
			await this.namespace.put(key, JSON.stringify(value));
		} catch (error) {
			throw new KeyValueError(`Failed to set value for key "${key}"`, {
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

import type { UnifiedPaginationQuery } from "@repo/schema/pagination";

export interface GetOptions {
	fromCache?: boolean;
}
export interface GetAllOptions extends GetOptions, UnifiedPaginationQuery {}

export abstract class BaseRepository<T> {
	// Database specifix
	abstract getAll(opts?: GetAllOptions): Promise<T[]>;
	abstract getById(id: string, opts?: GetOptions): Promise<T | undefined>;
	abstract create(item: T): Promise<T>;
	abstract update(id: string, item: Partial<T>): Promise<T>;
	abstract delete(id: string): Promise<void>;
}

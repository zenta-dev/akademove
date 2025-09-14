import type {
	InsertMerchant,
	Merchant,
	UpdateMerchant,
} from "@repo/schema/merchant";
import { eq } from "drizzle-orm";
import { v4 } from "uuid";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	BaseRepository,
	GetAllOptions,
	GetOptions,
} from "@/core/interface";
import { type DatabaseInstance, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";

export class MerchantRepository implements BaseRepository<Merchant> {
	constructor(
		private readonly db: DatabaseInstance,
		private readonly kv: KeyValueService,
	) {}

	private composeMerchant(
		val: Omit<Merchant, "createdAt" | "updatedAt"> & {
			createdAt: Date;
			updatedAt: Date;
		},
	): Merchant {
		return {
			...val,
			createdAt: val.createdAt.getTime(),
			updatedAt: val.updatedAt.getTime(),
		};
	}
	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.MERCHANT}${id}`;
	}

	private async getCache(id: string): Promise<Merchant | undefined> {
		try {
			return await this.kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async setCache(
		id: string,
		data: Merchant | undefined,
	): Promise<void> {
		if (data) {
			try {
				await this.kv.put(this.composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	private async getMerchantFromDb(id: string): Promise<Merchant | undefined> {
		const result = await this.db.query.merchant.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return this.composeMerchant(result);
		return result;
	}

	async getAll(opts?: GetAllOptions): Promise<Merchant[]> {
		try {
			let stmt = this.db.query.merchant.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = this.db.query.merchant.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.merchant.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map((v) => this.composeMerchant(v));
		} catch (error) {
			throw new RepositoryError("Failed to get all merchant", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async getById(id: string, opts?: GetOptions): Promise<Merchant | undefined> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getCache(id);
				if (cached) return cached;
			}

			const result = await this.getMerchantFromDb(id);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get merchant by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async create(item: InsertMerchant & { userId: string }): Promise<Merchant> {
		try {
			const id = v4();
			const value = { ...item, id };

			const [operation] = await this.db
				.insert(tables.merchant)
				.values(value)
				.returning();

			const result = this.composeMerchant(operation);
			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create merchant", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async update(id: string, item: UpdateMerchant): Promise<Merchant> {
		try {
			const existing = await this.getMerchantFromDb(id);
			if (!existing) {
				throw new RepositoryError(`Merchant with id "${id}" not found`);
			}
			const value = {
				...existing,
				...item,
				createdAt: new Date(existing.createdAt),
				updatedAt: new Date(),
				id,
			};

			const [operation] = await this.db
				.update(tables.merchant)
				.set(value)
				.where(eq(tables.merchant.id, id))
				.returning();

			const result = this.composeMerchant(operation);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update merchant with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async delete(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.merchant)
				.where(eq(tables.merchant.id, id))
				.returning();

			if (result.length > 0) {
				try {
					await this.kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete merchant with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

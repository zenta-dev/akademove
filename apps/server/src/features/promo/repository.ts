import type { InsertPromo, Promo, UpdatePromo } from "@repo/schema/promo";
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

export class PromoRepository implements BaseRepository<Promo> {
	constructor(
		private readonly db: DatabaseInstance,
		private readonly kv: KeyValueService,
	) {}

	private composePromo(
		val: Omit<Promo, "periodStart" | "periodEnd" | "createdAt"> & {
			periodStart: Date;
			periodEnd: Date;
			createdAt: Date;
		},
	): Promo {
		return {
			...val,
			periodStart: val.periodStart.getTime(),
			periodEnd: val.periodEnd.getTime(),
			createdAt: val.createdAt.getTime(),
		};
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.PROMO}${id}`;
	}

	private async getCache(id: string): Promise<Promo | undefined> {
		try {
			return await this.kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async setCache(id: string, data: Promo | undefined): Promise<void> {
		if (data) {
			try {
				await this.kv.put(this.composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["1h"],
				});
			} catch {}
		}
	}

	private async getPromoFromDb(id: string): Promise<Promo | undefined> {
		const result = await this.db.query.promo.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return this.composePromo(result);
		return result;
	}

	async getAll(opts?: GetAllOptions): Promise<Promo[]> {
		try {
			let stmt = this.db.query.promo.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = this.db.query.promo.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.promo.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map((v) => this.composePromo(v));
		} catch (error) {
			throw new RepositoryError("Failed to get all promo", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async getById(id: string, opts?: GetOptions): Promise<Promo | undefined> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getCache(id);
				if (cached) return cached;
			}

			const result = await this.getPromoFromDb(id);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get promo by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async create(item: InsertPromo): Promise<Promo> {
		try {
			const id = v4();
			const value = {
				...item,
				usedCount: 0,
				periodStart: new Date(item.periodStart),
				periodEnd: new Date(item.periodEnd),
				id,
			};

			const [operation] = await this.db
				.insert(tables.promo)
				.values(value)
				.returning();

			const result = this.composePromo(operation);
			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create promo", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async update(id: string, item: UpdatePromo): Promise<Promo> {
		try {
			const existing = await this.getPromoFromDb(id);
			if (!existing) {
				throw new RepositoryError(`Promo with id "${id}" not found`);
			}
			const value = {
				...existing,
				...item,
				periodStart: new Date(item.periodStart),
				periodEnd: new Date(item.periodEnd),
				createdAt: new Date(existing.createdAt),
				id,
			};

			const [operation] = await this.db
				.update(tables.promo)
				.set(value)
				.where(eq(tables.promo.id, id))
				.returning();

			const result = this.composePromo(operation);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update promo with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async delete(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.promo)
				.where(eq(tables.promo.id, id))
				.returning();

			if (result.length > 0) {
				try {
					await this.kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete promo with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

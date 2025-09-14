import type { InsertReview, Review, UpdateReview } from "@repo/schema/review";
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

export class ReviewRepository implements BaseRepository<Review> {
	constructor(
		private readonly db: DatabaseInstance,
		private readonly kv: KeyValueService,
	) {}

	private composeReview(
		val: Omit<Review, "createdAt"> & {
			createdAt: Date;
		},
	): Review {
		return {
			...val,
			createdAt: val.createdAt.getTime(),
		};
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.REVIEW}${id}`;
	}

	private async getCache(id: string): Promise<Review | undefined> {
		try {
			return await this.kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async setCache(id: string, data: Review | undefined): Promise<void> {
		if (data) {
			try {
				await this.kv.put(this.composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["1h"],
				});
			} catch {}
		}
	}

	private async getReviewFromDb(id: string): Promise<Review | undefined> {
		const result = await this.db.query.review.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return this.composeReview(result);
		return result;
	}

	async getAll(opts?: GetAllOptions): Promise<Review[]> {
		try {
			let stmt = this.db.query.review.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = this.db.query.review.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.review.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map((v) => this.composeReview(v));
		} catch (error) {
			throw new RepositoryError("Failed to get all review", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async getById(id: string, opts?: GetOptions): Promise<Review | undefined> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getCache(id);
				if (cached) return cached;
			}

			const result = await this.getReviewFromDb(id);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get review by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async create(item: InsertReview): Promise<Review> {
		try {
			const id = v4();
			const value = {
				...item,
				usedCount: 0,
				id,
			};

			const [operation] = await this.db
				.insert(tables.review)
				.values(value)
				.returning();

			const result = this.composeReview(operation);
			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create review", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async update(id: string, item: UpdateReview): Promise<Review> {
		try {
			const existing = await this.getReviewFromDb(id);
			if (!existing) {
				throw new RepositoryError(`Review with id "${id}" not found`);
			}
			const value = {
				...existing,
				...item,
				createdAt: new Date(existing.createdAt),
				id,
			};

			const [operation] = await this.db
				.update(tables.review)
				.set(value)
				.where(eq(tables.review.id, id))
				.returning();

			const result = this.composeReview(operation);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update review with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async delete(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.review)
				.where(eq(tables.review.id, id))
				.returning();

			if (result.length > 0) {
				try {
					await this.kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete review with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { InsertReview, Review, UpdateReview } from "@repo/schema/review";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReviewDatabase } from "@/core/tables/review";

export class ReviewRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super(FEATURE_TAGS.REVIEW, "review", kv, db);
	}

	static composeEntity(item: ReviewDatabase): Review {
		return item;
	}

	async #getFromDB(id: string): Promise<Review | undefined> {
		const result = await this.db.query.review.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? ReviewRepository.composeEntity(result) : undefined;
	}

	async list(query?: UnifiedPaginationQuery): Promise<Review[]> {
		try {
			let stmt = this.db.query.review.findMany();

			if (query) {
				const { cursor, page, limit } = query;

				if (cursor) {
					stmt = this.db.query.review.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}

				if (page) {
					const offset = (page - 1) * limit;
					stmt = this.db.query.review.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return result.map((r) => ReviewRepository.composeEntity(r));
		} catch (error) {
			throw this.handleError(error, "list");
		}
	}

	async get(id: string): Promise<Review> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError("Failed to get review from DB");
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(item: InsertReview & { userId: string }): Promise<Review> {
		try {
			const [operation] = await this.db
				.insert(tables.review)
				.values({ ...item, id: v7() })
				.returning();

			const result = ReviewRepository.composeEntity(operation);
			await this.setCache(result.id, result, {
				expirationTtl: CACHE_TTLS["24h"],
			});
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateReview): Promise<Review> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Review with id "${id}" not found`);

			const [operation] = await this.db
				.update(tables.review)
				.set({
					...item,
					createdAt: new Date(existing.createdAt),
				})
				.where(eq(tables.review.id, id))
				.returning();

			const result = ReviewRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.review)
				.where(eq(tables.review.id, id))
				.returning({ id: tables.review.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "remove");
		}
	}
}

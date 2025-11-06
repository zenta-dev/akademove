import type { InsertReview, Review, UpdateReview } from "@repo/schema/review";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReviewDatabase } from "@/core/tables/review";
import { log } from "@/utils";

export class ReviewRepository {
	#db: DatabaseService;
	#kv: KeyValueService;

	constructor(db: DatabaseService, kv: KeyValueService) {
		this.#db = db;
		this.#kv = kv;
	}

	#composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.REVIEW}${id}`;
	}

	static composeEntity(item: ReviewDatabase): Review {
		return item;
	}

	async #getFromKV(id: string): Promise<Review | undefined> {
		try {
			return await this.#kv.get(this.#composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async #getFromDB(id: string): Promise<Review | undefined> {
		const result = await this.#db.query.review.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? ReviewRepository.composeEntity(result) : undefined;
	}

	async #setCache(id: string, data: Review | undefined): Promise<void> {
		if (!data) return;
		try {
			await this.#kv.put(this.#composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {
			// ignore cache write failures
		}
	}

	async list(opts?: GetAllOptions): Promise<Review[]> {
		try {
			let stmt = this.#db.query.review.findMany();

			if (opts) {
				const { cursor, page, limit } = opts;

				if (cursor) {
					stmt = this.#db.query.review.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}

				if (page) {
					const offset = (page - 1) * limit;
					stmt = this.#db.query.review.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return result.map((r) => ReviewRepository.composeEntity(r));
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list reviews");
		}
	}

	async get(id: string, opts?: GetOptions): Promise<Review> {
		try {
			if (opts?.fromCache) {
				const cached = await this.#getFromKV(id);
				if (cached) return cached;
			}

			const result = await this.#getFromDB(id);
			if (!result) throw new RepositoryError("Failed to get review from db");

			await this.#setCache(id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get review by id "${id}"`);
		}
	}

	async create(item: InsertReview & { userId: string }): Promise<Review> {
		try {
			const [operation] = await this.#db
				.insert(tables.review)
				.values({ ...item, id: v7() })
				.returning();

			const result = ReviewRepository.composeEntity(operation);
			await this.#setCache(result.id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to create review");
		}
	}

	async update(id: string, item: UpdateReview): Promise<Review> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Review with id "${id}" not found`);

			const [operation] = await this.#db
				.update(tables.review)
				.set({
					...existing,
					...item,
					createdAt: new Date(existing.createdAt),
				})
				.where(eq(tables.review.id, id))
				.returning();

			const result = ReviewRepository.composeEntity(operation);
			await this.#setCache(id, result);
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update review with id "${id}"`);
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.#db
				.delete(tables.review)
				.where(eq(tables.review.id, id))
				.returning({ id: tables.review.id });

			if (result.length > 0) {
				try {
					await this.#kv.delete(this.#composeCacheKey(id));
				} catch {
					// ignore cache delete failures
				}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to delete review with id "${id}"`);
		}
	}
}

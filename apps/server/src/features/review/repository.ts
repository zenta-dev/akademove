import type { InsertReview, Review, UpdateReview } from "@repo/schema/review";
import { eq } from "drizzle-orm";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReviewDatabase } from "@/core/tables/review";

export const createReviewRepository = (
	db: DatabaseService,
	kv: KeyValueService,
) => {
	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.REVIEW}${id}`;
	}

	function _composeEntity(item: ReviewDatabase): Review {
		return {
			...item,
			createdAt: item.createdAt.getTime(),
		};
	}

	async function _getFromKV(id: string): Promise<Review | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(id: string): Promise<Review | undefined> {
		const result = await db.query.review.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function _setCache(id: string, data: Review | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<Review[]> {
		try {
			let stmt = db.query.review.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.review.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.review.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			throw new RepositoryError("Failed to listing reviews", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function get(id: string, opts?: GetOptions) {
		try {
			if (opts?.fromCache) {
				const cached = await _getFromKV(id);
				if (cached) return cached;
			}

			const result = await _getFromDB(id);

			if (!result) throw new RepositoryError("Failed get review from db");

			await _setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get review by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function create(
		item: InsertReview & { userId: string },
	): Promise<Review> {
		try {
			const [operation] = await db
				.insert(tables.review)
				.values(item)
				.returning();

			const result = _composeEntity(operation);
			await _setCache(result.id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create review", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function update(id: string, item: UpdateReview): Promise<Review> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Review with id "${id}" not found`);
			}

			const [operation] = await db
				.update(tables.review)
				.set({
					...existing,
					...item,
					createdAt: new Date(existing.createdAt),
				})
				.where(eq(tables.review.id, id))
				.returning();

			const result = _composeEntity(operation);

			await _setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update review with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const result = await db
				.delete(tables.review)
				.where(eq(tables.review.id, id))
				.returning({ id: tables.review.id });

			if (result.length > 0) {
				try {
					await kv.delete(_composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete review with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	return { list, get, create, update, remove };
};

export type ReviewRepository = ReturnType<typeof createReviewRepository>;

import { m } from "@repo/i18n";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import {
	type InsertReview,
	type Review,
	ReviewKeySchema,
	type UpdateReview,
} from "@repo/schema/review";
import { eq, gt, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	OrderByOperation,
	PartialWithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReviewDatabase } from "@/core/tables/review";
import { ReviewEligibilityService, ReviewSearchService } from "./services";

export class ReviewRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("review", kv, db);
	}

	static composeEntity(item: ReviewDatabase): Review {
		return {
			...item,
			// Ensure categories is an array (from JSONB)
			categories: (item.categories ?? []) as Review["categories"],
		};
	}

	async #getFromDB(id: string): Promise<Review | undefined> {
		const result = await this.db.query.review.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? ReviewRepository.composeEntity(result) : undefined;
	}

	async #getQueryCount(query: string): Promise<number> {
		// Delegate to ReviewSearchService
		return ReviewSearchService.getQueryCount(this.db, query);
	}

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Review>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
			} = query ?? {};

			const orderBy = (
				f: typeof tables.review._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = ReviewKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search) clauses.push(ilike(tables.review.comment, `%${query}%`));

			if (cursor) {
				clauses.push(gt(tables.review.createdAt, new Date(cursor)));

				const res = await this.db.query.review.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(ReviewRepository.composeEntity);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const res = await this.db.query.review.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = res.map(ReviewRepository.composeEntity);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.review.findMany({
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map(ReviewRepository.composeEntity);

			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<Review> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError(m.error_failed_get_review());
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(item: InsertReview, opts?: PartialWithTx): Promise<Review> {
		try {
			const [operation] = await (opts?.tx ?? this.db)
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

	async update(
		id: string,
		item: UpdateReview,
		opts?: PartialWithTx,
	): Promise<Review> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Review with id "${id}" not found`);

			const [operation] = await (opts?.tx ?? this.db)
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

	async remove(id: string, opts?: PartialWithTx): Promise<void> {
		try {
			const result = await (opts?.tx ?? this.db)
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

	async getByOrder(orderId: string): Promise<Review[]> {
		try {
			const results = await this.db.query.review.findMany({
				where: (f, op) => op.eq(f.orderId, orderId),
				with: {
					fromUser: true,
					toUser: true,
				},
			});

			return results.map(ReviewRepository.composeEntity);
		} catch (error) {
			throw this.handleError(error, "get by order");
		}
	}

	async checkUserReviewedOrder(
		orderId: string,
		userId: string,
	): Promise<boolean> {
		// Delegate to ReviewEligibilityService
		return ReviewEligibilityService.hasUserReviewedOrder(
			this.db,
			orderId,
			userId,
		);
	}

	async getOrderReviewStatus(
		orderId: string,
		userId: string,
	): Promise<{
		canReview: boolean;
		alreadyReviewed: boolean;
		orderCompleted: boolean;
	}> {
		// Delegate to ReviewEligibilityService
		return ReviewEligibilityService.getOrderReviewStatus(
			this.db,
			orderId,
			userId,
		);
	}
}

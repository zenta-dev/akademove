import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import {
	type InsertReview,
	type Review,
	ReviewKeySchema,
	type UpdateReview,
} from "@repo/schema/review";
import { count, eq, gt, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ReviewDatabase } from "@/core/tables/review";
import { log } from "@/utils";

export class ReviewRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("review", kv, db);
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

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.review.id) })
				.from(tables.review)
				.where(ilike(tables.review.comment, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
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

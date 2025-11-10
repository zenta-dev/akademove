import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import {
	type InsertTransaction,
	type Transaction,
	TransactionKeySchema,
	type UpdateTransaction,
} from "@repo/schema/transaction";
import { eq, gt, inArray, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	OrderByOperation,
	PartialWithTx,
	WithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { TransactionDatabase } from "@/core/tables/transaction";
import { toNumberSafe, toStringNumberSafe } from "@/utils";

export class TransactionRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("transaction", kv, db);
	}

	static composeEntity(item: TransactionDatabase): Transaction {
		return {
			...item,
			amount: toNumberSafe(item.amount),
			balanceBefore: item.balanceBefore
				? toNumberSafe(item.balanceBefore)
				: undefined,
			balanceAfter: item.balanceAfter
				? toNumberSafe(item.balanceAfter)
				: undefined,
			description: item.description ? item.description : undefined,
			referenceId: item.referenceId ? item.referenceId : undefined,
		};
	}

	async getByIdAndUserId(
		params: { id: string; userId: string },
		opts?: WithTx,
	): Promise<Transaction> {
		try {
			const fallback = async () => {
				const res = await (opts?.tx ?? this.db).query.wallet.findFirst({
					columns: {},
					with: {
						transactions: {
							where: (f, op) => op.eq(f.id, params.id),
							limit: 1,
						},
					},
					where: (f, op) => op.eq(f.userId, params.userId),
				});

				if (!res || res.transactions.length === 0)
					throw new RepositoryError(`Transaction with id ${params.id}`);
				const transaction = TransactionRepository.composeEntity(
					res.transactions[0],
				);

				await this.setCache(transaction.id, transaction, {
					expirationTtl: CACHE_TTLS["1h"],
				});

				return transaction;
			};

			const res = await this.getCache(params.id, { fallback });

			return res;
		} catch (error) {
			throw this.handleError(error, "get by id and user id");
		}
	}

	async get(id: string, opts?: PartialWithTx): Promise<Transaction> {
		try {
			const fallback = async () => {
				const res = await (opts?.tx ?? this.db).query.transaction.findFirst({
					where: (f, op) => op.eq(f.id, id),
				});
				if (!res) {
					throw new RepositoryError(`Transaction withh id ${id} not found`);
				}
				const transaction = TransactionRepository.composeEntity(res);

				await this.setCache(transaction.id, transaction, {
					expirationTtl: CACHE_TTLS["1h"],
				});

				return transaction;
			};

			return await this.getCache(id, { fallback });
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async list(
		query?: UnifiedPaginationQuery & { userId: string },
		opts?: WithTx,
	): Promise<ListResult<Transaction>> {
		const result = { rows: [] };
		try {
			const {
				cursor,
				page,
				limit = 10,
				sortBy,
				order = "asc",
				userId,
			} = query ?? {};
			if (!userId) return result;

			const tx = opts?.tx ?? this.db;

			const orderBy = (
				f: typeof tables.transaction._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = TransactionKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [
				inArray(
					tables.transaction.walletId,
					tx
						.select({ id: tables.wallet.id })
						.from(tables.wallet)
						.where(eq(tables.wallet.userId, userId)),
				),
			];

			if (cursor) {
				clauses.push(gt(tables.review.createdAt, new Date(cursor)));

				const res = await this.db.query.transaction.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(TransactionRepository.composeEntity);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const result = await tx.query.transaction.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = result.map(TransactionRepository.composeEntity);

				const totalCount = await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await tx.query.transaction.findMany({
				orderBy,
				limit,
			});

			const rows = res.map(TransactionRepository.composeEntity);
			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return result;
		}
	}

	async insert(params: InsertTransaction, opts?: WithTx): Promise<Transaction> {
		try {
			const [operation] = await (opts?.tx ?? this.db)
				.insert(tables.transaction)
				.values({
					...params,
					id: v7(),
					amount: toStringNumberSafe(params.amount),
					balanceBefore: params.balanceBefore
						? toStringNumberSafe(params.balanceBefore)
						: undefined,
					balanceAfter: params.balanceAfter
						? toStringNumberSafe(params.balanceAfter)
						: undefined,
					createdAt: new Date(),
					updatedAt: new Date(),
				})
				.returning();

			const transaction = TransactionRepository.composeEntity(operation);

			await this.setCache(transaction.id, transaction, {
				expirationTtl: CACHE_TTLS["1h"],
			});

			return transaction;
		} catch (error) {
			throw this.handleError(error, "insert");
		}
	}

	async update(
		id: string,
		params: UpdateTransaction,
		opts: WithTx,
	): Promise<Transaction> {
		try {
			const [operation] = await (opts?.tx ?? this.db)
				.update(tables.transaction)
				.set({
					...params,
					amount: params.amount ? toStringNumberSafe(params.amount) : undefined,
					balanceBefore: params.balanceBefore
						? toStringNumberSafe(params.balanceBefore)
						: undefined,
					balanceAfter: params.balanceAfter
						? toStringNumberSafe(params.balanceAfter)
						: undefined,
					updatedAt: new Date(),
				})
				.where(eq(tables.transaction.id, id))
				.returning();

			const transaction = TransactionRepository.composeEntity(operation);

			await this.setCache(transaction.id, transaction, {
				expirationTtl: CACHE_TTLS["1h"],
			});

			return transaction;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}
}

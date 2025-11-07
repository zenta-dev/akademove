import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type {
	InsertTransaction,
	Transaction,
	UpdateTransaction,
} from "@repo/schema/transaction";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { TransactionDatabase } from "@/core/tables/transaction";
import { safeAsync, toNumberSafe, toStringNumberSafe } from "@/utils";

export class TransactionRepository extends BaseRepository {
	#db: DatabaseService;

	constructor(db: DatabaseService, kv: KeyValueService) {
		super(FEATURE_TAGS.TRANSACTION, kv);
		this.#db = db;
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
				const res = await (opts?.tx ?? this.#db).query.wallet.findFirst({
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
				const res = await (opts?.tx ?? this.#db).query.transaction.findFirst({
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
	): Promise<Transaction[]> {
		if (!query?.userId) return [];
		const res = await safeAsync(
			(opts?.tx ?? this.#db).query.wallet.findFirst({
				columns: {},
				with: { transactions: true },
				where: (f, op) => op.eq(f.userId, query?.userId),
			}),
		);
		if (!res.data) return [];
		return res.data.transactions.map(TransactionRepository.composeEntity);
	}

	async insert(params: InsertTransaction, opts?: WithTx): Promise<Transaction> {
		try {
			const [operation] = await (opts?.tx ?? this.#db)
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
			const [operation] = await (opts?.tx ?? this.#db)
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

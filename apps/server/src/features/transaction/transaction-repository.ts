import type { Transaction } from "@repo/schema/transaction";
import type { WithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import type { TransactionDatabase } from "@/core/tables/transaction";
import { safeAsync, toNumberSafe } from "@/utils";

export class TransactionRepository {
	#db: DatabaseService;

	constructor(db: DatabaseService) {
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

	async list(param: { userId: string }, opts?: {} & Partial<WithTx>) {
		const res = await safeAsync(
			(opts?.tx ?? this.#db).query.wallet.findFirst({
				columns: {},
				with: { transactions: true },
				where: (f, op) => op.eq(f.userId, param.userId),
			}),
		);
		if (!res.data) return [];
	}

	async insert() {}
}

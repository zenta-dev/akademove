import type { InsertPayment, Payment } from "@repo/schema/payment";
import { v7 } from "uuid";
import type { WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { PaymentDatabase } from "@/core/tables/payment";
import { toNumberSafe, toStringNumberSafe } from "@/utils";

export class PaymentRepository {
	#db: DatabaseService;

	constructor(db: DatabaseService) {
		this.#db = db;
	}

	static composePayment(item: PaymentDatabase): Payment {
		return {
			...item,
			amount: toNumberSafe(item.amount),
			transactionId: item.transactionId ? item.transactionId : undefined,
			externalId: item.externalId ? item.externalId : undefined,
			paymentUrl: item.paymentUrl ? item.paymentUrl : undefined,
			expiresAt: item.expiresAt ? item.expiresAt : undefined,
		};
	}

	async insert(
		param: InsertPayment,
		opts?: {} & Partial<WithTx>,
	): Promise<Payment> {
		const now = new Date();
		const [res] = await (opts?.tx ?? this.#db)
			.insert(tables.payment)
			.values({
				...param,
				id: v7(),
				amount: toStringNumberSafe(param.amount),
				createdAt: now,
				updatedAt: now,
			})
			.returning();

		return PaymentRepository.composePayment(res);
	}
}

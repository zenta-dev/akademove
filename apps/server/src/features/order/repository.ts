import type { InsertOrder, Order, UpdateOrder } from "@repo/schema/order";
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

export class OrderRepository implements BaseRepository<Order> {
	constructor(
		private readonly db: DatabaseInstance,
		private readonly kv: KeyValueService,
	) {}

	private composeOrder(
		val: Omit<
			Order,
			"requestedAt" | "acceptedAt" | "arrivedAt" | "updatedAt" | "createdAt"
		> & {
			requestedAt: Date;
			acceptedAt: Date | null;
			arrivedAt: Date | null;
			createdAt: Date;
			updatedAt: Date;
		},
	): Order {
		return {
			...val,
			requestedAt: val.requestedAt.getTime(),
			acceptedAt: val.acceptedAt?.getTime() ?? null,
			arrivedAt: val.arrivedAt?.getTime() ?? null,
			createdAt: val.createdAt.getTime(),
			updatedAt: val.updatedAt.getTime(),
		};
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.ORDER}${id}`;
	}

	private async getCache(id: string): Promise<Order | undefined> {
		try {
			return await this.kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async setCache(id: string, data: Order | undefined): Promise<void> {
		if (data) {
			try {
				await this.kv.put(this.composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["1h"],
				});
			} catch {}
		}
	}

	private async getOrderFromDb(id: string): Promise<Order | undefined> {
		const result = await this.db.query.order.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return this.composeOrder(result);
		return result;
	}

	async getAll(opts?: GetAllOptions): Promise<Order[]> {
		try {
			let stmt = this.db.query.order.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = this.db.query.order.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.order.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map((v) => this.composeOrder(v));
		} catch (error) {
			throw new RepositoryError("Failed to get all order", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async getById(id: string, opts?: GetOptions): Promise<Order | undefined> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getCache(id);
				if (cached) return cached;
			}

			const result = await this.getOrderFromDb(id);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get order by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	// TODO: fix this the logic is flaw
	async create(item: InsertOrder & { userId: string }): Promise<Order> {
		try {
			const id = v4();
			const value = { ...item, id };

			const [operation] = await this.db
				.insert(tables.order)
				.values(value)
				.returning();

			const result = this.composeOrder(operation);
			await this.setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create order", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	// TODO: fix this the logic is flaw
	async update(id: string, item: UpdateOrder): Promise<Order> {
		try {
			const existing = await this.getOrderFromDb(id);
			if (!existing) {
				throw new RepositoryError(`Order with id "${id}" not found`);
			}
			const value = {
				...existing,
				...item,
				requestedAt: new Date(existing.requestedAt),
				acceptedAt: existing.acceptedAt ? new Date(existing.acceptedAt) : null,
				arrivedAt: existing.arrivedAt ? new Date(existing.arrivedAt) : null,
				createdAt: new Date(existing.createdAt),
				updatedAt: new Date(),
				id,
			};

			const [operation] = await this.db
				.update(tables.order)
				.set(value)
				.where(eq(tables.order.id, id))
				.returning();

			const result = this.composeOrder(operation);

			await this.setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update order with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async delete(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.order)
				.where(eq(tables.order.id, id))
				.returning();

			if (result.length > 0) {
				try {
					await this.kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete order with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}
}

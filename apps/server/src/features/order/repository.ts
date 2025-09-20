import type { Driver } from "@repo/schema/driver";
import type { Merchant } from "@repo/schema/merchant";
import type { InsertOrder, Order, UpdateOrder } from "@repo/schema/order";
import type { User } from "@repo/schema/user";
import { eq } from "drizzle-orm";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { OrderDatabase } from "@/core/tables/order";

export const createOrderRepository = (
	db: DatabaseService,
	kv: KeyValueService,
) => {
	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.ORDER}${id}`;
	}

	function _composeEntity(
		item: OrderDatabase & {
			user: Partial<User> | null;
			driver: Partial<Driver> | null;
			merchant: Partial<Merchant> | null;
		},
	): Order {
		return {
			...item,
			user: item.user ? { name: item.user.name } : undefined,
			driver: item.driver ? { user: item.driver.user } : undefined,
			merchant: item.merchant ? { name: item.merchant.name } : undefined,
			driverId: item.driverId ?? undefined,
			merchantId: item.merchantId ?? undefined,
			note: item.note ?? undefined,
			tip: item.tip ?? undefined,
			requestedAt: item.requestedAt.getTime(),
			acceptedAt: item.acceptedAt?.getTime(),
			arrivedAt: item.arrivedAt?.getTime(),
			createdAt: item.createdAt.getTime(),
			updatedAt: item.updatedAt.getTime(),
		};
	}

	async function _getFromKV(id: string): Promise<Order | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(id: string): Promise<Order | undefined> {
		const result = await db.query.order.findFirst({
			with: {
				user: { columns: { name: true } },
				driver: { columns: {}, with: { user: { columns: { name: true } } } },
				merchant: { columns: { name: true } },
			},
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function _setCache(id: string, data: Order | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<Order[]> {
		try {
			let stmt = db.query.order.findMany({
				with: {
					user: { columns: { name: true } },
					driver: { columns: {}, with: { user: { columns: { name: true } } } },
					merchant: { columns: { name: true } },
				},
			});
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.order.findMany({
						with: {
							user: { columns: { name: true } },
							driver: {
								columns: {},
								with: { user: { columns: { name: true } } },
							},
							merchant: { columns: { name: true } },
						},
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.order.findMany({
						with: {
							user: { columns: { name: true } },
							driver: {
								columns: {},
								with: { user: { columns: { name: true } } },
							},
							merchant: { columns: { name: true } },
						},
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			throw new RepositoryError("Failed to listing orders", {
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

			if (!result) throw new RepositoryError("Failed get order from db");

			await _setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get order by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function create(
		item: InsertOrder & { userId: string },
	): Promise<Order> {
		try {
			const [operation] = await db
				.insert(tables.order)
				.values(item)
				.returning({ id: tables.order.id });

			const result = await _getFromDB(operation.id);
			if (!result) {
				throw new RepositoryError("Failed to create order");
			}

			await _setCache(result.id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create order", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function update(id: string, item: UpdateOrder): Promise<Order> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Order with id "${id}" not found`);
			}

			const [operation] = await db
				.update(tables.order)
				.set({
					...existing,
					...item,
					requestedAt: new Date(existing.requestedAt),
					acceptedAt: existing.acceptedAt
						? new Date(existing.acceptedAt)
						: null,
					arrivedAt: existing.arrivedAt ? new Date(existing.arrivedAt) : null,
					createdAt: new Date(existing.createdAt),
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, id))
				.returning({ id: tables.order.id });

			const result = await _getFromDB(operation.id);
			if (!result) {
				throw new RepositoryError("Failed to create order");
			}

			await _setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update order with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const result = await db
				.delete(tables.order)
				.where(eq(tables.order.id, id))
				.returning({ id: tables.order.id });

			if (result.length > 0) {
				try {
					await kv.delete(_composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete order with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	return { list, get, create, update, remove };
};

export type OrderRepository = ReturnType<typeof createOrderRepository>;

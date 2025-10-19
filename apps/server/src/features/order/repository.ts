import type { Driver } from "@repo/schema/driver";
import type { Merchant } from "@repo/schema/merchant";
import type {
	InsertOrder,
	Order,
	OrderStatus,
	UpdateOrder,
} from "@repo/schema/order";
import type { User, UserRole } from "@repo/schema/user";
import { eq, type SQL } from "drizzle-orm";
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
			acceptedAt: item.acceptedAt ?? undefined,
			arrivedAt: item.arrivedAt ?? undefined,
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

	async function list(
		opts?: GetAllOptions & {
			statuses?: OrderStatus[];
			id: string;
			role: UserRole;
		},
	): Promise<Order[]> {
		try {
			let stmt = db.query.order.findMany({
				with: {
					user: { columns: { name: true } },
					driver: { columns: {}, with: { user: { columns: { name: true } } } },
					merchant: { columns: { name: true } },
				},
				where: (f, op) => {
					const filters: SQL[] = [];
					const statuses = opts?.statuses ?? [];
					if (statuses.length > 0) {
						filters.push(op.inArray(f.status, statuses));
					}
					if (opts?.id && opts.role) {
						switch (opts.role) {
							case "user":
								filters.push(op.eq(f.userId, opts.id));
								break;
							case "driver":
								filters.push(op.eq(f.driverId, opts.id));
								break;
							case "merchant":
								filters.push(op.eq(f.merchantId, opts.id));
								break;
						}
					}

					return filters.length > 0 ? op.and(...filters) : undefined;
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
						where: (f, op) => {
							const filters: SQL[] = [op.gt(f.updatedAt, new Date(cursor))];
							const statuses = opts?.statuses ?? [];
							if (statuses.length > 0) {
								filters.push(op.inArray(f.status, statuses));
							}
							if (opts?.id && opts.role) {
								switch (opts.role) {
									case "user":
										filters.push(op.eq(f.userId, opts.id));
										break;
									case "driver":
										filters.push(op.eq(f.driverId, opts.id));
										break;
									case "merchant":
										filters.push(op.eq(f.merchantId, opts.id));
										break;
								}
							}

							return filters.length > 0 ? op.and(...filters) : undefined;
						},
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
						where: (f, op) => {
							const filters: SQL[] = [];
							const statuses = opts?.statuses ?? [];
							if (statuses.length > 0) {
								filters.push(op.inArray(f.status, statuses));
							}
							if (opts?.id && opts.role) {
								switch (opts.role) {
									case "user":
										filters.push(op.eq(f.userId, opts.id));
										break;
									case "driver":
										filters.push(op.eq(f.driverId, opts.id));
										break;
									case "merchant":
										filters.push(op.eq(f.merchantId, opts.id));
										break;
								}
							}

							return filters.length > 0 ? op.and(...filters) : undefined;
						},
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			console.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError("Failed to listing orders");
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
			console.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to get order by id "${id}"`);
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
			console.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError("Failed to create order");
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
			throw new RepositoryError(`Failed to update order with id "${id}"`);
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
			console.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to delete order with id "${id}"`);
		}
	}

	return { list, get, create, update, remove };
};

export type OrderRepository = ReturnType<typeof createOrderRepository>;

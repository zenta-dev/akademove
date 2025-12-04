import { m } from "@repo/i18n";
import {
	type Driver,
	DriverKeySchema,
	type InsertDriver,
	type UpdateDriver,
} from "@repo/schema/driver";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { getFileExtension } from "@repo/shared";
import {
	and,
	count,
	eq,
	gt,
	ilike,
	isNotNull,
	type SQL,
	sql,
} from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { UserDatabase } from "@/core/tables/auth";
import type { DetailedUserBadgeDatabase } from "@/core/tables/badge";
import type { DriverDatabase } from "@/core/tables/driver";
import { UserAdminRepository } from "@/features/user/admin/user-admin-repository";
import { log } from "@/utils";
import type { NearbyQuery } from "./driver-main-spec";

const BUCKET = "driver";

export class DriverMainRepository extends BaseRepository {
	readonly #storage: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super("driver", kv, db);
		this.#storage = storage;
	}

	static async composeEntity(
		item: DriverDatabase & {
			user: UserDatabase & {
				userBadges: DetailedUserBadgeDatabase[];
			};
		},
		storage: StorageService,
	): Promise<
		Driver & {
			studentCardId: string;
			driverLicenseId: string;
			vehicleCertificateId: string;
		}
	> {
		const [studentCard, driverLicense, vehicleCertificate, user] =
			await Promise.all([
				storage.getPresignedUrl({
					bucket: BUCKET,
					key: item.studentCard,
				}),
				storage.getPresignedUrl({
					bucket: BUCKET,
					key: item.driverLicense,
				}),
				storage.getPresignedUrl({
					bucket: BUCKET,
					key: item.vehicleCertificate,
				}),
				UserAdminRepository.composeEntity(item.user, storage),
			]);

		return {
			...item,
			user,
			currentLocation: item.currentLocation ?? undefined,
			lastLocationUpdate: item.lastLocationUpdate ?? undefined,
			lastCancellationDate: item.lastCancellationDate ?? undefined,
			studentCardId: item.studentCard,
			driverLicenseId: item.driverLicense,
			vehicleCertificateId: item.vehicleCertificate,
			studentCard,
			driverLicense,
			vehicleCertificate,
		};
	}

	async #getFromDB(
		id: string,
		opts?: WithTx,
	): Promise<
		| (Driver & {
				studentCardId: string;
				driverLicenseId: string;
				vehicleCertificateId: string;
		  })
		| undefined
	> {
		const tx = opts?.tx ?? this.db;

		const result = await tx.query.driver.findFirst({
			with: {
				user: {
					with: { userBadges: { with: { badge: true } } },
				},
			},
			where: (f, op) => op.eq(f.id, id),
		});

		return result
			? await DriverMainRepository.composeEntity(result, this.#storage)
			: undefined;
	}

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.driver.id) })
				.from(tables.driver)
				.innerJoin(tables.user, eq(tables.driver.userId, tables.user.id))
				.where(ilike(tables.user.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Driver>> {
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
				f: typeof tables.driver._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = DriverKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search) clauses.push(ilike(tables.user.name, `%${search}%`));

			if (cursor) {
				clauses.push(gt(tables.driver.updatedAt, new Date(cursor)));

				const result = await this.db.query.driver.findMany({
					with: {
						user: {
							with: { userBadges: { with: { badge: true } } },
						},
					},
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = await Promise.all(
					result.map((r) =>
						DriverMainRepository.composeEntity(r, this.#storage),
					),
				);
				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const result = await this.db.query.driver.findMany({
					with: {
						user: {
							with: { userBadges: { with: { badge: true } } },
						},
					},
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = await Promise.all(
					result.map((r) =>
						DriverMainRepository.composeEntity(r, this.#storage),
					),
				);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await this.db.query.driver.findMany({
				with: { user: { with: { userBadges: { with: { badge: true } } } } },
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit,
			});
			const rows = await Promise.all(
				result.map((r) => DriverMainRepository.composeEntity(r, this.#storage)),
			);
			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async nearby(query: NearbyQuery): Promise<Driver[]> {
		try {
			const { x, y, limit = 20, radiusKm = 10, gender } = query;

			const point = sql`ST_SetSRID(ST_MakePoint(${x}, ${y}), 4326)::geography`;
			const distance = sql<number>`ST_Distance(${tables.driver.currentLocation}::geography, ${point})`;

			const conditions = [
				eq(tables.driver.isOnline, true),
				eq(tables.driver.isTakingOrder, false),
				isNotNull(tables.driver.currentLocation),
				sql`ST_DWithin(
		${tables.driver.currentLocation}::geography,
		${point},
		${radiusKm * 1000}
	)`,
			];

			if (gender) conditions.push(eq(tables.user.gender, gender));

			const result = await this.db
				.select({
					driver: tables.driver,
					user: tables.user,
					distance: distance.as("distance_meters"),
				})
				.from(tables.driver)
				.innerJoin(tables.user, eq(tables.driver.userId, tables.user.id))
				.where(and(...conditions))
				.orderBy(distance)
				.limit(limit);

			return await Promise.all(
				result.map((r) =>
					DriverMainRepository.composeEntity(
						{ ...r.driver, user: { ...r.user, userBadges: [] } },
						this.#storage,
					),
				),
			);
		} catch (error) {
			throw this.handleError(error, "nearby");
		}
	}

	async get(id: string): Promise<Driver> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError(m.error_failed_get_driver());
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async getByUserId(userId: string): Promise<Driver> {
		try {
			const result = await this.db.query.driver.findFirst({
				with: { user: { with: { userBadges: { with: { badge: true } } } } },
				where: (f, op) => op.eq(f.userId, userId),
			});

			if (!result) throw new RepositoryError(m.error_failed_get_merchant());

			return await DriverMainRepository.composeEntity(result, this.#storage);
		} catch (error) {
			throw this.handleError(error, "get by user id");
		}
	}

	async create(
		item: InsertDriver & { userId: string },
		opts?: WithTx,
	): Promise<Driver> {
		try {
			const [user, existingDriver] = await Promise.all([
				(opts?.tx ?? this.db).query.user.findFirst({
					with: { userBadges: { with: { badge: true } } },
					where: (f, op) => op.eq(f.id, item.userId),
				}),
				(opts?.tx ?? this.db).query.driver.findFirst({
					columns: { studentId: true, licensePlate: true },
					where: (f, op) =>
						op.or(
							op.eq(f.studentId, item.studentId),
							op.eq(f.licensePlate, item.licensePlate),
						),
				}),
			]);

			if (!user)
				throw new RepositoryError(m.error_user_not_found(), {
					code: "NOT_FOUND",
				});

			if (existingDriver) {
				if (
					existingDriver.studentId === item.studentId ||
					existingDriver.licensePlate === item.licensePlate
				) {
					throw new RepositoryError(
						"Student ID or License Plate already registered",
						{
							code: "CONFLICT",
						},
					);
				}
				if (existingDriver.studentId === item.studentId) {
					throw new RepositoryError(m.error_student_id_already_registered(), {
						code: "CONFLICT",
					});
				}
				if (existingDriver.licensePlate === item.licensePlate) {
					throw new RepositoryError(
						m.error_license_plate_already_registered(),
						{
							code: "CONFLICT",
						},
					);
				}
			}

			const id = v7();
			const fileKeys = {
				studentCard: `SC-${id}.${getFileExtension(item.studentCard)}`,
				driverLicense: `DL-${id}.${getFileExtension(item.driverLicense)}`,
				vehicleCertificate: `VC-${id}.${getFileExtension(item.vehicleCertificate)}`,
			};

			const [operation] = await Promise.all([
				(opts?.tx ?? this.db)
					.insert(tables.driver)
					.values({ ...item, id, ...fileKeys })
					.returning()
					.then((r) => r[0]),
				this.#storage.upload({
					bucket: BUCKET,
					key: fileKeys.studentCard,
					file: item.studentCard,
				}),
				this.#storage.upload({
					bucket: BUCKET,
					key: fileKeys.driverLicense,
					file: item.driverLicense,
				}),
				this.#storage.upload({
					bucket: BUCKET,
					key: fileKeys.vehicleCertificate,
					file: item.vehicleCertificate,
				}),
			]);

			const result = await DriverMainRepository.composeEntity(
				{ ...operation, user },
				this.#storage,
			);
			await this.setCache(result.id, result, {
				expirationTtl: CACHE_TTLS["24h"],
			});
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateDriver, opts?: WithTx): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;

			const existing = await this.#getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`Driver with id "${id}" not found`);

			const user = await tx.query.user.findFirst({
				with: { userBadges: { with: { badge: true } } },
				where: (f, op) => op.eq(f.id, existing.userId),
			});
			if (!user) throw new RepositoryError(m.error_user_not_found());

			const uploads = [
				item.studentCard &&
					this.#storage.upload({
						bucket: BUCKET,
						key: `SC-${id}.${getFileExtension(item.studentCard)}`,
						file: item.studentCard,
					}),
				item.driverLicense &&
					this.#storage.upload({
						bucket: BUCKET,
						key: `DL-${id}.${getFileExtension(item.driverLicense)}`,
						file: item.driverLicense,
					}),
				item.vehicleCertificate &&
					this.#storage.upload({
						bucket: BUCKET,
						key: `VC-${id}.${getFileExtension(item.vehicleCertificate)}`,
						file: item.vehicleCertificate,
					}),
			].filter(Boolean);

			const [operation] = await Promise.all([
				tx
					.update(tables.driver)
					.set({
						...item,
						studentCard: existing.studentCardId,
						driverLicense: existing.driverLicenseId,
						vehicleCertificate: existing.vehicleCertificateId,
						createdAt: new Date(existing.createdAt),
					})
					.where(eq(tables.driver.id, id))
					.returning()
					.then((r) => r[0]),
				...uploads,
			]);

			const result = await DriverMainRepository.composeEntity(
				{ ...operation, user },
				this.#storage,
			);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const find = await this.#getFromDB(id);
			if (!find)
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});

			const [result] = await Promise.all([
				this.db
					.delete(tables.driver)
					.where(eq(tables.driver.id, id))
					.returning({ id: tables.driver.id }),
				this.#storage.delete({ bucket: BUCKET, key: find.studentCardId }),
				this.#storage.delete({
					bucket: BUCKET,
					key: find.driverLicenseId,
				}),
				this.#storage.delete({
					bucket: BUCKET,
					key: find.vehicleCertificateId,
				}),
			]);

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "remove");
		}
	}

	/**
	 * Get comprehensive analytics for a driver
	 * Includes earnings, performance metrics, and time-series data
	 *
	 * @param driverId - Driver ID
	 * @param query - Optional query parameters for filtering by period
	 * @returns Analytics data with earnings breakdown and performance metrics
	 */
	async getAnalytics(
		driverId: string,
		query?: {
			period?: "today" | "week" | "month" | "year";
			startDate?: Date;
			endDate?: Date;
		},
	): Promise<{
		// Earnings metrics
		totalEarnings: number;
		totalCommission: number;
		netEarnings: number;

		// Order metrics
		totalOrders: number;
		completedOrders: number;
		cancelledOrders: number;
		completionRate: number;

		// Performance metrics
		averageRating: number;

		// Breakdown by service type
		earningsByType: Array<{
			type: "RIDE" | "DELIVERY" | "FOOD";
			orders: number;
			earnings: number;
			commission: number;
		}>;

		// Time-series data for charts
		earningsByDay: Array<{
			date: string;
			earnings: number;
			orders: number;
			commission: number;
		}>;

		// Top earning days
		topEarningDays: Array<{
			date: string;
			earnings: number;
			orders: number;
		}>;
	}> {
		try {
			// Calculate date range based on period
			let startDate = query?.startDate ?? new Date();
			let endDate = query?.endDate ?? new Date();

			if (query?.period) {
				endDate = new Date();
				startDate = new Date();
				switch (query.period) {
					case "today":
						startDate.setHours(0, 0, 0, 0);
						break;
					case "week":
						startDate.setDate(startDate.getDate() - 7);
						break;
					case "month":
						startDate.setMonth(startDate.getMonth() - 1);
						break;
					case "year":
						startDate.setFullYear(startDate.getFullYear() - 1);
						break;
				}
			}

			// Get overall statistics
			const statsResult = await this.db.execute<{
				total_orders: number;
				total_earnings: string;
				total_commission: string;
				completed_orders: number;
				cancelled_orders: number;
				average_rating: string;
			}>(sql`
				SELECT
					COUNT(*)::int AS total_orders,
					COALESCE(SUM(CASE WHEN status = 'COMPLETED' THEN total_price END), 0)::text AS total_earnings,
					COALESCE(SUM(CASE WHEN status = 'COMPLETED' THEN driver_commission END), 0)::text AS total_commission,
					COUNT(CASE WHEN status = 'COMPLETED' THEN 1 END)::int AS completed_orders,
					COUNT(CASE WHEN status LIKE 'CANCELLED%' THEN 1 END)::int AS cancelled_orders,
					COALESCE(AVG(CASE WHEN driver_rating IS NOT NULL THEN driver_rating END), 0)::text AS average_rating
				FROM am_orders
				WHERE driver_id = ${driverId}
					AND requested_at >= ${startDate.toISOString()}
					AND requested_at <= ${endDate.toISOString()}
			`);

			// Get earnings by type
			const earningsByTypeResult = await this.db.execute<{
				type: "RIDE" | "DELIVERY" | "FOOD";
				orders: number;
				earnings: string;
				commission: string;
			}>(sql`
				SELECT
					type,
					COUNT(*)::int AS orders,
					COALESCE(SUM(total_price), 0)::text AS earnings,
					COALESCE(SUM(driver_commission), 0)::text AS commission
				FROM am_orders
				WHERE driver_id = ${driverId}
					AND status = 'COMPLETED'
					AND requested_at >= ${startDate.toISOString()}
					AND requested_at <= ${endDate.toISOString()}
				GROUP BY type
			`);

			// Get earnings by day
			const earningsByDayResult = await this.db.execute<{
				date: string;
				earnings: string;
				commission: string;
				orders: number;
			}>(sql`
				SELECT
					TO_CHAR(DATE(requested_at), 'YYYY-MM-DD') AS date,
					COALESCE(SUM(total_price), 0)::text AS earnings,
					COALESCE(SUM(driver_commission), 0)::text AS commission,
					COUNT(*)::int AS orders
				FROM am_orders
				WHERE driver_id = ${driverId}
					AND status = 'COMPLETED'
					AND requested_at >= ${startDate.toISOString()}
					AND requested_at <= ${endDate.toISOString()}
				GROUP BY DATE(requested_at)
				ORDER BY DATE(requested_at) ASC
			`);

			const stats = statsResult[0] ?? {
				total_orders: 0,
				total_earnings: "0",
				total_commission: "0",
				completed_orders: 0,
				cancelled_orders: 0,
				average_rating: "0",
			};

			const totalEarnings = Number.parseFloat(stats.total_earnings);
			const totalCommission = Number.parseFloat(stats.total_commission);
			const completionRate =
				stats.total_orders > 0
					? (stats.completed_orders / stats.total_orders) * 100
					: 0;

			// Calculate top earning days
			const sortedDays = earningsByDayResult
				.map((day) => ({
					date: day.date,
					earnings: Number.parseFloat(day.earnings),
					orders: day.orders,
				}))
				.sort((a, b) => b.earnings - a.earnings)
				.slice(0, 5);

			return {
				totalEarnings,
				totalCommission,
				netEarnings: totalEarnings - totalCommission,
				totalOrders: stats.total_orders,
				completedOrders: stats.completed_orders,
				cancelledOrders: stats.cancelled_orders,
				completionRate,
				averageRating: Number.parseFloat(stats.average_rating),
				earningsByType: earningsByTypeResult.map((item) => ({
					type: item.type,
					orders: item.orders,
					earnings: Number.parseFloat(item.earnings),
					commission: Number.parseFloat(item.commission),
				})),
				earningsByDay: earningsByDayResult.map((day) => ({
					date: day.date,
					earnings: Number.parseFloat(day.earnings),
					orders: day.orders,
					commission: Number.parseFloat(day.commission),
				})),
				topEarningDays: sortedDays,
			};
		} catch (error) {
			throw this.handleError(error, "get analytics");
		}
	}
}

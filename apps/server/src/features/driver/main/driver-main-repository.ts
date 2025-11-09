import type { Driver, InsertDriver, UpdateDriver } from "@repo/schema/driver";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { User } from "@repo/schema/user";
import { getFileExtension } from "@repo/shared";
import { and, eq, isNotNull, sql } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS, type StorageBucket } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import {
	type DatabaseService,
	type DatabaseTransaction,
	tables,
} from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { DriverDatabase } from "@/core/tables/driver";
import type { NearbyQuery } from "./driver-main-spec";

const BUCKET = "driver";

export class DriverMainRepository extends BaseRepository {
	readonly #storage: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super(FEATURE_TAGS.DRIVER, "driver", kv, db);
		this.#storage = storage;
	}

	static async composeEntity(
		item: DriverDatabase & { user: Partial<User> },
		storage: StorageService,
	): Promise<
		Driver & {
			studentCardId: string;
			driverLicenseId: string;
			vehicleCertificateId: string;
		}
	> {
		const bucket = "driver";
		const [studentCard, driverLicense, vehicleCertificate] = await Promise.all([
			storage.getPresignedUrl({
				bucket: bucket,
				key: item.studentCard,
			}),
			storage.getPresignedUrl({
				bucket: bucket,
				key: item.driverLicense,
			}),
			storage.getPresignedUrl({
				bucket: bucket,
				key: item.vehicleCertificate,
			}),
		]);

		return {
			...item,
			currentLocation: item.currentLocation ?? undefined,
			lastLocationUpdate: item.lastLocationUpdate ?? undefined,
			studentCardId: item.studentCard,
			driverLicenseId: item.driverLicense,
			vehicleCertificateId: item.vehicleCertificate,
			studentCard,
			driverLicense,
			vehicleCertificate,
		};
	}

	async #getFromDB(id: string): Promise<
		| (Driver & {
				studentCardId: string;
				driverLicenseId: string;
				vehicleCertificateId: string;
		  })
		| undefined
	> {
		const result = await this.#db.query.driver.findFirst({
			with: { user: { columns: { name: true } } },
			where: (f, op) => op.eq(f.id, id),
		});

		return result
			? await DriverMainRepository.composeEntity(result, this.#storage)
			: undefined;
	}

	async list(query?: UnifiedPaginationQuery): Promise<Driver[]> {
		try {
			let stmt = this.#db.query.driver.findMany({
				with: { user: { columns: { name: true } } },
			});

			if (query) {
				const { cursor, page, limit } = query;
				if (cursor && limit) {
					stmt = this.#db.query.driver.findMany({
						with: { user: { columns: { name: true } } },
						where: (f, op) => op.gt(f.lastLocationUpdate, new Date(cursor)),
						limit: limit + 1,
					});
				} else if (page && limit) {
					const offset = (page - 1) * limit;
					stmt = this.#db.query.driver.findMany({
						with: { user: { columns: { name: true } } },
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return await Promise.all(
				result.map((r) => DriverMainRepository.composeEntity(r, this.#storage)),
			);
		} catch (error) {
			throw this.handleError(error, "list");
		}
	}

	async nearby(query: NearbyQuery): Promise<Driver[]> {
		try {
			const { x, y, limit = 20, radiusKm = 10, gender } = query;

			const point = sql`ST_SetSRID(ST_MakePoint(${x}, ${y}), 4326)::geography`;
			const distance = sql<number>`ST_Distance(${tables.driver.currentLocation}::geography, ${point})`;

			const conditions = [
				eq(tables.driver.isOnline, true),
				isNotNull(tables.driver.currentLocation),
				sql`ST_DWithin(
		${tables.driver.currentLocation}::geography,
		${point},
		${radiusKm * 1000}
	)`,
			];

			if (gender) conditions.push(eq(tables.user.gender, gender));

			const result = await this.#db
				.select({
					driver: tables.driver,
					userName: tables.user.name,
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
						{ ...r.driver, user: { name: r.userName } },
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
				if (!res) throw new RepositoryError("Failed to get driver from DB");
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
			const result = await this.#db.query.driver.findFirst({
				with: { user: { columns: { name: true } } },
				where: (f, op) => op.eq(f.userId, userId),
			});

			if (!result) throw new RepositoryError("Failed to get merchant from DB");

			return await DriverMainRepository.composeEntity(result, this.#storage);
		} catch (error) {
			throw this.handleError(error, "get by user id");
		}
	}

	async create(
		item: InsertDriver & { userId: string },
		opts?: { tx?: DatabaseTransaction },
	): Promise<Driver> {
		try {
			const [user, existingDriver] = await Promise.all([
				(opts?.tx ?? this.#db).query.user.findFirst({
					columns: { name: true },
					where: (f, op) => op.eq(f.id, item.userId),
				}),
				(opts?.tx ?? this.#db).query.driver.findFirst({
					columns: { studentId: true, licensePlate: true },
					where: (f, op) =>
						op.or(
							op.eq(f.studentId, item.studentId),
							op.eq(f.licensePlate, item.licensePlate),
						),
				}),
			]);

			if (!user)
				throw new RepositoryError("User not found", { code: "NOT_FOUND" });

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
					throw new RepositoryError("Student ID already registered", {
						code: "CONFLICT",
					});
				}
				if (existingDriver.licensePlate === item.licensePlate) {
					throw new RepositoryError("License Plate already registered", {
						code: "CONFLICT",
					});
				}
			}

			const id = v7();
			const fileKeys = {
				studentCard: `SC-${id}.${getFileExtension(item.studentCard)}`,
				driverLicense: `DL-${id}.${getFileExtension(item.driverLicense)}`,
				vehicleCertificate: `VC-${id}.${getFileExtension(item.vehicleCertificate)}`,
			};

			const [operation] = await Promise.all([
				(opts?.tx ?? this.#db)
					.insert(tables.driver)
					.values({ ...item, id, ...fileKeys })
					.returning()
					.then((r) => r[0]),
				this.#storage.upload({
					bucket: this.#bucket,
					key: fileKeys.studentCard,
					file: item.studentCard,
				}),
				this.#storage.upload({
					bucket: this.#bucket,
					key: fileKeys.driverLicense,
					file: item.driverLicense,
				}),
				this.#storage.upload({
					bucket: this.#bucket,
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

	async update(id: string, item: UpdateDriver): Promise<Driver> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Driver with id "${id}" not found`);

			const user = await this.#db.query.user.findFirst({
				columns: { name: true },
				where: (f, op) => op.eq(f.id, existing.userId),
			});
			if (!user) throw new RepositoryError("User not found");

			const uploads = [
				item.studentCard &&
					this.#storage.upload({
						bucket: this.#bucket,
						key: `SC-${id}.${getFileExtension(item.studentCard)}`,
						file: item.studentCard,
					}),
				item.driverLicense &&
					this.#storage.upload({
						bucket: this.#bucket,
						key: `DL-${id}.${getFileExtension(item.driverLicense)}`,
						file: item.driverLicense,
					}),
				item.vehicleCertificate &&
					this.#storage.upload({
						bucket: this.#bucket,
						key: `VC-${id}.${getFileExtension(item.vehicleCertificate)}`,
						file: item.vehicleCertificate,
					}),
			].filter(Boolean);

			const [operation] = await Promise.all([
				this.#db
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
				throw new RepositoryError("Driver not found", { code: "NOT_FOUND" });

			const [result] = await Promise.all([
				this.#db
					.delete(tables.driver)
					.where(eq(tables.driver.id, id))
					.returning({ id: tables.driver.id }),
				this.#storage.delete({ bucket: this.#bucket, key: find.studentCardId }),
				this.#storage.delete({
					bucket: this.#bucket,
					key: find.driverLicenseId,
				}),
				this.#storage.delete({
					bucket: this.#bucket,
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
}

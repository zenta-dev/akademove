import type { Driver, InsertDriver, UpdateDriver } from "@repo/schema/driver";
import type { User } from "@repo/schema/user";
import { getFileExtension } from "@repo/shared";
import { and, eq, isNotNull, sql } from "drizzle-orm";
import { v7 } from "uuid";
import {
	CACHE_PREFIXES,
	CACHE_TTLS,
	type StorageBucket,
} from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import {
	type DatabaseService,
	type DatabaseTransaction,
	tables,
} from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { DriverDatabase } from "@/core/tables/driver";
import { log } from "@/utils";
import type { NearbyQuery } from "./driver-spec";

export class DriverRepository {
	readonly #db: DatabaseService;
	readonly #kv: KeyValueService;
	readonly #storage: StorageService;
	readonly #bucket: StorageBucket = "driver";

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		this.#db = db;
		this.#kv = kv;
		this.#storage = storage;
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.DRIVER}${id}`;
	}

	private async composeEntity(
		item: DriverDatabase & { user: Partial<User> },
	): Promise<
		Driver & {
			studentCardId: string;
			driverLicenseId: string;
			vehicleCertificateId: string;
		}
	> {
		const [studentCard, driverLicense, vehicleCertificate] = await Promise.all([
			this.#storage.getPresignedUrl({
				bucket: this.#bucket,
				key: item.studentCard,
			}),
			this.#storage.getPresignedUrl({
				bucket: this.#bucket,
				key: item.driverLicense,
			}),
			this.#storage.getPresignedUrl({
				bucket: this.#bucket,
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

	private async getFromKV(id: string): Promise<Driver | undefined> {
		try {
			return await this.#kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async getFromDB(id: string): Promise<
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

		return result ? await this.composeEntity(result) : undefined;
	}

	private async setCache(id: string, data: Driver | undefined) {
		if (!data) return;
		try {
			await this.#kv.put(this.composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {}
	}

	async list(opts?: GetAllOptions): Promise<Driver[]> {
		try {
			let stmt = this.#db.query.driver.findMany({
				with: { user: { columns: { name: true } } },
			});

			if (opts) {
				const { cursor, page, limit } = opts;
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
			return await Promise.all(result.map((r) => this.composeEntity(r)));
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list drivers");
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

			// Only apply gender filter if provided
			if (gender) {
				conditions.push(eq(tables.user.gender, gender));
			}

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
					this.composeEntity({ ...r.driver, user: { name: r.userName } }),
				),
			);
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list nearby drivers");
		}
	}

	async get(id: string, opts?: GetOptions): Promise<Driver> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getFromKV(id);
				if (cached) return cached;
			}

			const result = await this.getFromDB(id);
			if (!result) throw new RepositoryError("Failed to get driver from DB");

			await this.setCache(id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get driver by id "${id}"`);
		}
	}

	async getByUserId(userId: string): Promise<Driver> {
		try {
			const result = await this.#db.query.driver.findFirst({
				with: { user: { columns: { name: true } } },
				where: (f, op) => op.eq(f.userId, userId),
			});

			if (!result) throw new RepositoryError("Failed to get merchant from DB");

			return await this.composeEntity(result);
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to get merchant by user id "${userId}"`,
			);
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

			const result = await this.composeEntity({ ...operation, user });
			await this.setCache(result.id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to create driver");
		}
	}

	async update(id: string, item: UpdateDriver): Promise<Driver> {
		try {
			const existing = await this.getFromDB(id);
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
						...existing,
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

			const result = await this.composeEntity({ ...operation, user });
			await this.setCache(id, result);
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update driver with id "${id}"`);
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const find = await this.getFromDB(id);
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
				try {
					await this.#kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to delete driver with id "${id}"`);
		}
	}
}

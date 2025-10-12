import type { Driver, InsertDriver, UpdateDriver } from "@repo/schema/driver";
import type { User } from "@repo/schema/user";
import { getFileExtension } from "@repo/shared";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import {
	CACHE_PREFIXES,
	CACHE_TTLS,
	type StorageBucket,
} from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { log } from "@/core/logger";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { DriverDatabase } from "@/core/tables/driver";

export const createDriverRepository = (
	db: DatabaseService,
	kv: KeyValueService,
	storage: StorageService,
) => {
	const bucket: StorageBucket = "driver";

	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.DRIVER}${id}`;
	}

	async function _composeEntity(
		item: DriverDatabase & { user: Partial<User> },
	): Promise<
		Driver & {
			studentCardId: string;
			driverLicenseId: string;
			vehicleCertificateId: string;
		}
	> {
		const [studentCard, driverLicense, vehicleCertificate] = await Promise.all([
			storage.getPresignedUrl({ bucket, key: item.studentCard }),
			storage.getPresignedUrl({ bucket, key: item.driverLicense }),
			storage.getPresignedUrl({ bucket, key: item.vehicleCertificate }),
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

	async function _getFromKV(id: string): Promise<Driver | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(id: string): Promise<
		| (Driver & {
				studentCardId: string;
				driverLicenseId: string;
				vehicleCertificateId: string;
		  })
		| undefined
	> {
		const result = await db.query.driver.findFirst({
			with: { user: { columns: { name: true } } },
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? await _composeEntity(result) : undefined;
	}

	async function _setCache(id: string, data: Driver | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<Driver[]> {
		try {
			let stmt = db.query.driver.findMany({
				with: { user: { columns: { name: true } } },
			});
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.driver.findMany({
						with: { user: { columns: { name: true } } },
						where: (f, op) => op.gt(f.lastLocationUpdate, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.driver.findMany({
						with: { user: { columns: { name: true } } },
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			console.log("RESULT => ", result);

			return await Promise.all(result.map(_composeEntity));
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError("Failed to listing drivers");
		}
	}

	async function get(id: string, opts?: GetOptions) {
		try {
			if (opts?.fromCache) {
				const cached = await _getFromKV(id);
				if (cached) return cached;
			}

			const result = await _getFromDB(id);
			if (!result) throw new RepositoryError("Failed get driver from db");

			await _setCache(id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get driver by id "${id}"`);
		}
	}

	async function create(
		item: InsertDriver & { userId: string },
	): Promise<Driver> {
		try {
			const user = await db.query.user.findFirst({
				columns: { name: true },
				where: (f, op) => op.eq(f.id, item.userId),
			});
			if (!user) throw new RepositoryError("User not found");

			const id = v7();
			const fileKeys = {
				studentCard: `SC-${id}.${getFileExtension(item.studentCard)}`,
				driverLicense: `DL-${id}.${getFileExtension(item.driverLicense)}`,
				vehicleCertificate: `VC-${id}.${getFileExtension(item.vehicleCertificate)}`,
			};

			const [operation] = await Promise.all([
				db
					.insert(tables.driver)
					.values({ ...item, id, ...fileKeys })
					.returning()
					.then((r) => r[0]),
				storage.upload({
					bucket,
					key: fileKeys.studentCard,
					file: item.studentCard,
				}),
				storage.upload({
					bucket,
					key: fileKeys.driverLicense,
					file: item.driverLicense,
				}),
				storage.upload({
					bucket,
					key: fileKeys.vehicleCertificate,
					file: item.vehicleCertificate,
				}),
			]);

			const result = await _composeEntity({ ...operation, user });
			await _setCache(result.id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to create driver");
		}
	}

	async function update(id: string, item: UpdateDriver): Promise<Driver> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Driver with id "${id}" not found`);
			}

			const user = await db.query.user.findFirst({
				columns: { name: true },
				where: (f, op) => op.eq(f.id, existing.userId),
			});
			if (!user) throw new RepositoryError("User not found");

			const uploads = [
				item.studentCard &&
					storage.upload({
						bucket,
						key: `SC-${id}.${getFileExtension(item.studentCard)}`,
						file: item.studentCard,
					}),
				item.driverLicense &&
					storage.upload({
						bucket,
						key: `DL-${id}.${getFileExtension(item.driverLicense)}`,
						file: item.driverLicense,
					}),
				item.vehicleCertificate &&
					storage.upload({
						bucket,
						key: `VC-${id}.${getFileExtension(item.vehicleCertificate)}`,
						file: item.vehicleCertificate,
					}),
			].filter(Boolean);

			const [operation] = await Promise.all([
				db
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

			const result = await _composeEntity({ ...operation, user });
			await _setCache(id, result);
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update driver with id "${id}"`);
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const find = await _getFromDB(id);
			if (!find) {
				throw new RepositoryError("Driver not found", { code: "NOT_FOUND" });
			}

			const [result] = await Promise.all([
				db
					.delete(tables.driver)
					.where(eq(tables.driver.id, id))
					.returning({ id: tables.driver.id }),
				storage.delete({ bucket, key: find.studentCardId }),
				storage.delete({ bucket, key: find.driverLicenseId }),
				storage.delete({ bucket, key: find.vehicleCertificateId }),
			]);

			if (result.length > 0) {
				try {
					await kv.delete(_composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to delete driver with id "${id}"`);
		}
	}

	return { list, get, create, update, remove };
};

export type DriverRepository = ReturnType<typeof createDriverRepository>;

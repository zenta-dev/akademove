/**
 * Core Interfaces for Dependency Inversion Principle (DIP)
 * and Interface Segregation Principle (ISP)
 *
 * These interfaces define contracts for services without coupling to implementations.
 */

import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { PartialWithTx, WithTx } from "../interface";

/**
 * Base repository capabilities split into focused interfaces (ISP)
 */

/**
 * IReadable - For entities that can be read
 */
export interface IReadable<TEntity, TListQuery = UnifiedPaginationQuery> {
	/**
	 * Get a single entity by ID
	 * @throws {RepositoryError} When entity not found or database error
	 */
	get(id: string, opts?: PartialWithTx): Promise<TEntity>;

	/**
	 * List entities with optional pagination and filtering
	 */
	list(
		query?: TListQuery,
		opts?: PartialWithTx,
	): Promise<{ rows: TEntity[]; totalPages?: number }>;
}

/**
 * IWritable - For entities that can be created and updated
 */
export interface IWritable<TEntity, TInsert, TUpdate = Partial<TInsert>> {
	/**
	 * Create a new entity
	 * @throws {RepositoryError} When validation fails or database error
	 */
	create(data: TInsert, opts?: WithTx): Promise<TEntity>;

	/**
	 * Update an existing entity
	 * @throws {RepositoryError} When entity not found or database error
	 */
	update(id: string, data: TUpdate, opts?: WithTx): Promise<TEntity>;
}

/**
 * IDeletable - For entities that can be deleted
 */
export interface IDeletable {
	/**
	 * Delete an entity by ID
	 * @throws {RepositoryError} When entity not found or database error
	 */
	delete(id: string, opts?: WithTx): Promise<void>;
}

/**
 * ICacheable - For repositories that support caching
 */
export interface ICacheable {
	/**
	 * Get data from cache with optional fallback
	 */
	getCache<T>(
		key: string,
		options?: { fallback?: () => Promise<T> },
	): Promise<T>;

	/**
	 * Set data in cache with TTL
	 */
	setCache<T>(
		key: string,
		data: T,
		opts?: { expirationTtl?: number },
	): Promise<void>;

	/**
	 * Delete data from cache
	 */
	deleteCache(key: string): Promise<void>;
}

/**
 * Composed repository interfaces for common patterns
 */

export interface IRepository<TEntity, TInsert, TUpdate = Partial<TInsert>>
	extends IReadable<TEntity>,
		IWritable<TEntity, TInsert, TUpdate>,
		IDeletable {}

export interface IReadOnlyRepository<TEntity>
	extends IReadable<TEntity>,
		ICacheable {}

export interface IBasicRepository<TEntity, TInsert, TUpdate = Partial<TInsert>>
	extends IReadable<TEntity>,
		IWritable<TEntity, TInsert, TUpdate> {}

/**
 * Service Interfaces
 */

/**
 * IKeyValueStore - Abstract key-value storage interface
 */
export interface IKeyValueStore {
	get<T>(key: string, options?: { fallback?: () => Promise<T> }): Promise<T>;
	put<T>(
		key: string,
		value: T,
		opts?: { expirationTtl?: number },
	): Promise<void>;
	delete(key: string): Promise<void>;
}

/**
 * IStorageService - Abstract object storage interface
 */
export interface IStorageService {
	upload(
		bucket: string,
		key: string,
		file: File | Blob,
		opts?: { contentType?: string },
	): Promise<{ url: string; key: string }>;
	getPresignedUrl(
		bucket: string,
		key: string,
		expiresIn?: number,
	): Promise<string>;
	delete(bucket: string, key: string): Promise<void>;
}

/**
 * IMailService - Abstract email service interface
 */
export interface IMailService {
	send(options: {
		to: string | string[];
		subject: string;
		html: string;
		from?: string;
	}): Promise<void>;
}

/**
 * IMapService - Abstract geolocation service interface
 */
export interface IMapService {
	/**
	 * Calculate distance between two coordinates
	 * @returns Distance in kilometers
	 */
	getDistance(
		origin: { lat: number; lng: number },
		destination: { lat: number; lng: number },
	): Promise<number>;

	/**
	 * Get coordinates from an address
	 */
	geocode(address: string): Promise<{ lat: number; lng: number }>;

	/**
	 * Get address from coordinates
	 */
	reverseGeocode(lat: number, lng: number): Promise<string>;
}

/**
 * IPaymentService - Abstract payment gateway interface
 */
export interface IPaymentService {
	/**
	 * Create a payment charge
	 */
	createCharge(options: {
		amount: number;
		currency: string;
		description: string;
		metadata?: Record<string, unknown>;
	}): Promise<{
		id: string;
		status: string;
		paymentUrl?: string;
		expiresAt?: Date;
	}>;

	/**
	 * Check payment status
	 */
	getChargeStatus(chargeId: string): Promise<{
		id: string;
		status: string;
		paidAt?: Date;
	}>;

	/**
	 * Cancel a payment charge
	 */
	cancelCharge(chargeId: string): Promise<void>;
}

/**
 * IAuthService - Abstract authentication service interface
 */
export interface IAuthService {
	verifyToken(token: string): Promise<{
		uid: string;
		email?: string;
		phone?: string;
	}>;
	createCustomToken(uid: string): Promise<string>;
	revokeRefreshTokens(uid: string): Promise<void>;
}

/**
 * IRBACService - Abstract authorization service interface
 */
export interface IRBACService<TRole, TPermissions> {
	/**
	 * Check if a role has specific permissions
	 */
	hasPermission(input: { role: TRole; permissions: TPermissions }): boolean;

	/**
	 * Get all permissions for a role
	 */
	getPermissions(role: TRole): TPermissions;
}

/**
 * IPasswordManager - Abstract password hashing interface
 */
export interface IPasswordManager {
	hash(password: string): Promise<string>;
	verify(password: string, hash: string): Promise<boolean>;
}

/**
 * IJwtManager - Abstract JWT token manager interface
 */
export interface IJwtManager {
	sign(payload: Record<string, unknown>, expiresIn?: string): Promise<string>;
	verify<T = Record<string, unknown>>(token: string): Promise<T>;
	decode<T = Record<string, unknown>>(token: string): T;
}

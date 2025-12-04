import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import { log } from "@/utils";

/**
 * Service responsible for driver availability management
 *
 * Handles:
 * - Online/offline status toggling
 * - Order taking management (isOnline + isTakingOrder flags)
 * - Availability state validation
 *
 * @example
 * ```typescript
 * const availabilityService = new DriverAvailabilityService();
 *
 * // Toggle driver online
 * await availabilityService.setOnlineStatus(driverId, true, {
 *   update: async (id, data, opts) => await db.update(...).set(data).where(eq(id, driverId))
 * });
 * ```
 */
export class DriverAvailabilityService {
	/**
	 * Sets driver online/offline status
	 *
	 * When going offline:
	 * - Also sets isTakingOrder = false
	 * - Prevents driver from being matched with new orders
	 *
	 * When going online:
	 * - Sets isOnline = true
	 * - Keeps isTakingOrder as-is (allows driver to control)
	 *
	 * @param driverId - Driver ID
	 * @param isOnline - Target online status
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 * @returns Updated online status
	 */
	async setOnlineStatus(
		driverId: string,
		isOnline: boolean,
		deps: {
			update: (
				driverId: string,
				data: { isOnline: boolean; isTakingOrder?: boolean },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			// When going offline, also stop taking orders
			const updateData: { isOnline: boolean; isTakingOrder?: boolean } = {
				isOnline,
			};

			if (!isOnline) {
				updateData.isTakingOrder = false;
			}

			await deps.update(driverId, updateData, opts);

			log.info(
				{ driverId, isOnline, isTakingOrder: updateData.isTakingOrder },
				"[DriverAvailabilityService] Updated online status",
			);

			return isOnline;
		} catch (error) {
			log.error(
				{ error, driverId, isOnline },
				"[DriverAvailabilityService] Failed to set online status",
			);
			throw new RepositoryError("Failed to update driver online status", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Sets driver order-taking status
	 *
	 * Controls whether driver accepts new order assignments.
	 * Driver must be online to take orders.
	 *
	 * @param driverId - Driver ID
	 * @param isTakingOrder - Target order-taking status
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 * @returns Updated order-taking status
	 * @throws RepositoryError if trying to take orders while offline
	 */
	async setOrderTakingStatus(
		driverId: string,
		isTakingOrder: boolean,
		deps: {
			get: (
				driverId: string,
				opts?: PartialWithTx,
			) => Promise<{
				isOnline: boolean;
			}>;
			update: (
				driverId: string,
				data: { isTakingOrder: boolean },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			// Validate: Cannot take orders while offline
			if (isTakingOrder) {
				const driver = await deps.get(driverId, opts);

				if (!driver.isOnline) {
					throw new RepositoryError("Driver must be online to take orders", {
						code: "BAD_REQUEST",
					});
				}
			}

			await deps.update(driverId, { isTakingOrder }, opts);

			log.info(
				{ driverId, isTakingOrder },
				"[DriverAvailabilityService] Updated order-taking status",
			);

			return isTakingOrder;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;

			log.error(
				{ error, driverId, isTakingOrder },
				"[DriverAvailabilityService] Failed to set order-taking status",
			);
			throw new RepositoryError("Failed to update driver order-taking status", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Checks if driver is available for new orders
	 *
	 * Available when:
	 * - isOnline = true
	 * - isTakingOrder = false (not currently assigned to an order)
	 * - currentLocation is set (has reported location recently)
	 *
	 * @param driver - Driver data
	 * @returns true if available for matching
	 */
	isAvailableForOrders(driver: {
		isOnline: boolean;
		isTakingOrder: boolean;
		currentLocation: unknown;
	}): boolean {
		return (
			driver.isOnline &&
			!driver.isTakingOrder &&
			driver.currentLocation !== null &&
			driver.currentLocation !== undefined
		);
	}

	/**
	 * Validates driver can be assigned to an order
	 *
	 * More strict than isAvailableForOrders:
	 * - Must be available for orders (isOnline + !isTakingOrder + has location)
	 * - Must not be cancelled recently (within cancellation cooldown)
	 *
	 * @param driver - Driver data
	 * @param deps - Dependency functions
	 * @returns true if can be assigned
	 */
	canBeAssignedToOrder(
		driver: {
			isOnline: boolean;
			isTakingOrder: boolean;
			currentLocation: unknown;
			lastCancellationDate: Date | null;
		},
		deps: {
			getCancellationCooldownMinutes: () => number;
		},
	): boolean {
		// Basic availability check
		if (!this.isAvailableForOrders(driver)) {
			return false;
		}

		// Check cancellation cooldown
		if (driver.lastCancellationDate) {
			const cooldownMs = deps.getCancellationCooldownMinutes() * 60 * 1000;
			const timeSinceCancellation =
				Date.now() - driver.lastCancellationDate.getTime();

			if (timeSinceCancellation < cooldownMs) {
				return false;
			}
		}

		return true;
	}

	/**
	 * Marks driver as taking an order (busy)
	 *
	 * Sets isTakingOrder = true to prevent new assignments
	 *
	 * @param driverId - Driver ID
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 */
	async markBusy(
		driverId: string,
		deps: {
			update: (
				driverId: string,
				data: { isTakingOrder: boolean },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			await deps.update(driverId, { isTakingOrder: true }, opts);

			log.info(
				{ driverId },
				"[DriverAvailabilityService] Marked driver as busy",
			);
		} catch (error) {
			log.error(
				{ error, driverId },
				"[DriverAvailabilityService] Failed to mark driver as busy",
			);
			throw new RepositoryError("Failed to mark driver as busy", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Marks driver as available (not taking order)
	 *
	 * Sets isTakingOrder = false to allow new assignments
	 *
	 * @param driverId - Driver ID
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 */
	async markAvailable(
		driverId: string,
		deps: {
			update: (
				driverId: string,
				data: { isTakingOrder: boolean },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			await deps.update(driverId, { isTakingOrder: false }, opts);

			log.info(
				{ driverId },
				"[DriverAvailabilityService] Marked driver as available",
			);
		} catch (error) {
			log.error(
				{ error, driverId },
				"[DriverAvailabilityService] Failed to mark driver as available",
			);
			throw new RepositoryError("Failed to mark driver as available", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}
}

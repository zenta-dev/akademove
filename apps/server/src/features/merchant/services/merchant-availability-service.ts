import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import { logger } from "@/utils/logger";

/**
 * Service responsible for merchant availability management
 *
 * Handles:
 * - Online/offline status toggling
 * - Order taking management (isOnline + isTakingOrders flags)
 * - Operating status management (OPEN, CLOSED, BREAK, MAINTENANCE)
 * - Availability state validation
 *
 * @example
 * ```typescript
 * const availabilityService = new MerchantAvailabilityService();
 *
 * // Toggle merchant online
 * await availabilityService.setOnlineStatus(merchantId, true, {
 *   update: async (id, data, opts) => await db.update(...).set(data).where(eq(id, merchantId))
 * });
 * ```
 */
export class MerchantAvailabilityService {
	/**
	 * Sets merchant online/offline status
	 *
	 * When going offline:
	 * - Also sets isTakingOrders = false
	 * - Prevents merchant from being matched with new orders
	 *
	 * When going online:
	 * - Sets isOnline = true
	 * - Keeps isTakingOrders as-is (allows merchant to control)
	 *
	 * @param merchantId - Merchant ID
	 * @param isOnline - Target online status
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 * @returns Updated online status
	 */
	async setOnlineStatus(
		merchantId: string,
		isOnline: boolean,
		deps: {
			update: (
				merchantId: string,
				data: { isOnline: boolean; isTakingOrders?: boolean },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			// When going offline, also stop taking orders
			const updateData: { isOnline: boolean; isTakingOrders?: boolean } = {
				isOnline,
			};

			if (!isOnline) {
				updateData.isTakingOrders = false;
			}

			await deps.update(merchantId, updateData, opts);

			logger.info(
				{ merchantId, isOnline, isTakingOrders: updateData.isTakingOrders },
				"[MerchantAvailabilityService] Updated online status",
			);

			return isOnline;
		} catch (error) {
			logger.error(
				{ error, merchantId, isOnline },
				"[MerchantAvailabilityService] Failed to set online status",
			);
			throw new RepositoryError("Failed to update merchant online status", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Sets merchant order-taking status
	 *
	 * Controls whether merchant accepts new order assignments.
	 * Merchant must be online to take orders.
	 *
	 * @param merchantId - Merchant ID
	 * @param isTakingOrders - Target order-taking status
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 * @returns Updated order-taking status
	 * @throws RepositoryError if trying to take orders while offline
	 */
	async setOrderTakingStatus(
		merchantId: string,
		isTakingOrders: boolean,
		deps: {
			get: (
				merchantId: string,
				opts?: PartialWithTx,
			) => Promise<{
				isOnline: boolean;
			}>;
			update: (
				merchantId: string,
				data: { isTakingOrders: boolean },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			// Validate: Cannot take orders while offline
			if (isTakingOrders) {
				const merchant = await deps.get(merchantId, opts);

				if (!merchant.isOnline) {
					throw new RepositoryError("Merchant must be online to take orders", {
						code: "BAD_REQUEST",
					});
				}
			}

			await deps.update(merchantId, { isTakingOrders }, opts);

			logger.info(
				{ merchantId, isTakingOrders },
				"[MerchantAvailabilityService] Updated order-taking status",
			);

			return isTakingOrders;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;

			logger.error(
				{ error, merchantId, isTakingOrders },
				"[MerchantAvailabilityService] Failed to set order-taking status",
			);
			throw new RepositoryError(
				"Failed to update merchant order-taking status",
				{
					code: "INTERNAL_SERVER_ERROR",
				},
			);
		}
	}

	/**
	 * Sets merchant operating status
	 *
	 * Controls the merchant's operational state (OPEN, CLOSED, BREAK, MAINTENANCE).
	 * This is distinct from online status and provides more granular control.
	 *
	 * @param merchantId - Merchant ID
	 * @param operatingStatus - Target operating status
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 * @returns Updated operating status
	 */
	async setOperatingStatus(
		merchantId: string,
		operatingStatus: "OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE",
		deps: {
			update: (
				merchantId: string,
				data: { operatingStatus: "OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE" },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<"OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE"> {
		try {
			await deps.update(merchantId, { operatingStatus }, opts);

			logger.info(
				{ merchantId, operatingStatus },
				"[MerchantAvailabilityService] Updated operating status",
			);

			return operatingStatus;
		} catch (error) {
			logger.error(
				{ error, merchantId, operatingStatus },
				"[MerchantAvailabilityService] Failed to set operating status",
			);
			throw new RepositoryError("Failed to update merchant operating status", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Checks if merchant is available for new orders
	 *
	 * Available when:
	 * - isOnline = true
	 * - isTakingOrders = true
	 * - operatingStatus = "OPEN"
	 *
	 * @param merchant - Merchant data
	 * @returns true if available for matching
	 */
	isAvailableForOrders(merchant: {
		isOnline: boolean;
		isTakingOrders: boolean;
		operatingStatus: string;
	}): boolean {
		return (
			merchant.isOnline &&
			merchant.isTakingOrders &&
			merchant.operatingStatus === "OPEN"
		);
	}

	/**
	 * Checks if merchant is online
	 *
	 * @param merchant - Merchant data
	 * @returns true if online
	 */
	isOnline(merchant: { isOnline: boolean }): boolean {
		return merchant.isOnline;
	}

	/**
	 * Checks if merchant is taking orders
	 *
	 * @param merchant - Merchant data
	 * @returns true if taking orders
	 */
	isTakingOrders(merchant: { isTakingOrders: boolean }): boolean {
		return merchant.isTakingOrders;
	}

	/**
	 * Checks if merchant is operating
	 *
	 * @param merchant - Merchant data
	 * @returns true if operating status is OPEN
	 */
	isOperating(merchant: { operatingStatus: string }): boolean {
		return merchant.operatingStatus === "OPEN";
	}

	/**
	 * Marks merchant as taking orders (busy)
	 *
	 * Sets isTakingOrders = true to indicate the merchant is actively serving orders
	 *
	 * @param merchantId - Merchant ID
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 */
	async markBusy(
		merchantId: string,
		deps: {
			update: (
				merchantId: string,
				data: { isTakingOrders: boolean },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			await deps.update(merchantId, { isTakingOrders: true }, opts);

			logger.info(
				{ merchantId },
				"[MerchantAvailabilityService] Marked merchant as busy",
			);
		} catch (error) {
			logger.error(
				{ error, merchantId },
				"[MerchantAvailabilityService] Failed to mark merchant as busy",
			);
			throw new RepositoryError("Failed to mark merchant as busy", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Marks merchant as available (not taking orders)
	 *
	 * Sets isTakingOrders = false to allow order assignment
	 *
	 * @param merchantId - Merchant ID
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 */
	async markAvailable(
		merchantId: string,
		deps: {
			update: (
				merchantId: string,
				data: { isTakingOrders: boolean },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			await deps.update(merchantId, { isTakingOrders: false }, opts);

			logger.info(
				{ merchantId },
				"[MerchantAvailabilityService] Marked merchant as available",
			);
		} catch (error) {
			logger.error(
				{ error, merchantId },
				"[MerchantAvailabilityService] Failed to mark merchant as available",
			);
			throw new RepositoryError("Failed to mark merchant as available", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}
}

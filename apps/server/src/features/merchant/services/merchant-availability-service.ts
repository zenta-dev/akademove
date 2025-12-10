import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import { logger } from "@/utils/logger";

/**
 * Service responsible for merchant availability management
 *
 * Handles:
 * - Online/offline status toggling
 * - Operating status management (OPEN, CLOSED, BREAK, MAINTENANCE)
 * - Availability state validation
 * - Active order count tracking
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
	 * - Also sets operatingStatus = CLOSED
	 * - Prevents merchant from being matched with new orders
	 *
	 * When going online:
	 * - Sets isOnline = true
	 * - Keeps operatingStatus as-is (allows merchant to control)
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
				data: {
					isOnline: boolean;
					operatingStatus?: "OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE";
				},
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			// When going offline, also set operating status to CLOSED
			const updateData: {
				isOnline: boolean;
				operatingStatus?: "OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE";
			} = {
				isOnline,
			};

			if (!isOnline) {
				updateData.operatingStatus = "CLOSED";
			}

			await deps.update(merchantId, updateData, opts);

			logger.info(
				{ merchantId, isOnline, operatingStatus: updateData.operatingStatus },
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
	 * Sets merchant operating status
	 *
	 * Controls the merchant's operational state (OPEN, CLOSED, BREAK, MAINTENANCE).
	 * - OPEN: Accepting new orders
	 * - BREAK: Temporarily not accepting new orders (merchant is busy)
	 * - CLOSED: Not operating
	 * - MAINTENANCE: Under maintenance
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
	 * - operatingStatus = "OPEN"
	 *
	 * @param merchant - Merchant data
	 * @returns true if available for matching
	 */
	isAvailableForOrders(merchant: {
		isOnline: boolean;
		operatingStatus: string;
	}): boolean {
		return merchant.isOnline && merchant.operatingStatus === "OPEN";
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
	 * Checks if merchant is operating
	 *
	 * @param merchant - Merchant data
	 * @returns true if operating status is OPEN
	 */
	isOperating(merchant: { operatingStatus: string }): boolean {
		return merchant.operatingStatus === "OPEN";
	}

	/**
	 * Marks merchant as on break (temporarily not accepting new orders)
	 *
	 * Sets operatingStatus = BREAK to indicate the merchant is busy
	 * and not accepting new orders temporarily
	 *
	 * @param merchantId - Merchant ID
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 */
	async markOnBreak(
		merchantId: string,
		deps: {
			update: (
				merchantId: string,
				data: { operatingStatus: "BREAK" },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			await deps.update(merchantId, { operatingStatus: "BREAK" }, opts);

			logger.info(
				{ merchantId },
				"[MerchantAvailabilityService] Marked merchant as on break",
			);
		} catch (error) {
			logger.error(
				{ error, merchantId },
				"[MerchantAvailabilityService] Failed to mark merchant as on break",
			);
			throw new RepositoryError("Failed to mark merchant as on break", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Marks merchant as open (accepting orders)
	 *
	 * Sets operatingStatus = OPEN to allow order assignment
	 *
	 * @param merchantId - Merchant ID
	 * @param deps - Dependency functions
	 * @param opts - Optional transaction context
	 */
	async markOpen(
		merchantId: string,
		deps: {
			update: (
				merchantId: string,
				data: { operatingStatus: "OPEN" },
				opts?: PartialWithTx,
			) => Promise<unknown>;
		},
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			await deps.update(merchantId, { operatingStatus: "OPEN" }, opts);

			logger.info(
				{ merchantId },
				"[MerchantAvailabilityService] Marked merchant as open",
			);
		} catch (error) {
			logger.error(
				{ error, merchantId },
				"[MerchantAvailabilityService] Failed to mark merchant as open",
			);
			throw new RepositoryError("Failed to mark merchant as open", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}
}

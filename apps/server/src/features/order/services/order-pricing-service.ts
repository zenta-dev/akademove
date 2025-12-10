/**
 * OrderPricingService - Handles all order pricing calculations
 *
 * SOLID Principles:
 * - SRP: Single responsibility for pricing logic
 * - OCP: Open for extension with new order types
 * - DIP: Depends on IMapService interface
 *
 * NOTE: All pricing-related values MUST come from the database configuration.
 * Static pricing constants are forbidden.
 */

import type {
	BusinessConfiguration,
	DeliveryPricingConfiguration,
	FoodPricingConfiguration,
	PricingConfiguration,
	RidePricingConfiguration,
} from "@repo/schema/configuration";
import type {
	EstimateOrder,
	OrderSummary,
	OrderType,
} from "@repo/schema/order";
import Decimal from "decimal.js";
import type { IMapService } from "@/core/abstractions/interfaces";
import { RepositoryError } from "@/core/error";
import { logger } from "@/utils/logger";
import { PricingCalculator } from "@/utils/pricing";

export interface IPricingConfigProvider {
	getRidePricing(): Promise<RidePricingConfiguration>;
	getDeliveryPricing(): Promise<DeliveryPricingConfiguration>;
	getFoodPricing(): Promise<FoodPricingConfiguration>;
	getBusinessConfig(): Promise<BusinessConfiguration>;
}

/**
 * OrderPricingService
 *
 * Responsibilities:
 * - Calculate order estimates
 * - Calculate distance-based pricing
 * - Apply minimum fares
 * - Calculate platform fees and taxes
 */
export class OrderPricingService {
	constructor(
		private readonly mapService: IMapService,
		private readonly configProvider: IPricingConfigProvider,
	) {}

	/**
	 * Estimate order cost based on type and locations
	 *
	 * @param input - Order estimation parameters
	 * @returns Order summary with cost breakdown
	 * @throws {RepositoryError} When distance calculation fails or configuration missing
	 */
	async estimateOrder(input: EstimateOrder): Promise<OrderSummary> {
		try {
			logger.debug({ input }, "[OrderPricingService] Estimating order");

			// Calculate distance using map service
			const distanceKm = await this.mapService.getDistance(
				{ lat: input.pickupLocation.y, lng: input.pickupLocation.x },
				{ lat: input.dropoffLocation.y, lng: input.dropoffLocation.x },
			);

			logger.debug({ distanceKm }, "[OrderPricingService] Distance calculated");

			// Get pricing based on order type
			const pricing = await this.#getPricingForType(input.type);

			// Calculate cost using pricing calculator
			const summary = this.#calculatePricing(
				input.type,
				distanceKm,
				pricing,
				input.weight,
			);

			logger.info(
				{ type: input.type, distanceKm, totalCost: summary.totalCost },
				"[OrderPricingService] Order estimated",
			);

			return summary;
		} catch (error) {
			logger.error({ error, input }, "[OrderPricingService] Estimation failed");
			throw this.#handleError(error, "estimate order");
		}
	}

	/**
	 * Calculate commission for completed order using dynamic pricing config
	 *
	 * @param orderType - Type of order
	 * @param totalPrice - Total order price
	 * @param badgeCommissionReduction - Optional reduction from driver badges (0-0.5)
	 * @returns Object with platform and merchant commission
	 */
	async calculateCommission(
		orderType: OrderType,
		totalPrice: number,
		badgeCommissionReduction = 0,
	): Promise<{
		platformCommission: number;
		merchantCommission?: number;
		driverEarning: number;
		commissionRate: number;
	}> {
		const amount = new Decimal(totalPrice);

		// Get pricing config for the order type
		const config = await this.#getPricingForType(orderType);

		// Use platformFeeRate from config as the commission rate
		let platformRate = new Decimal(config.platformFeeRate);

		// Apply badge commission reduction (max 50%)
		if (badgeCommissionReduction > 0) {
			const reduction = Math.min(badgeCommissionReduction, 0.5);
			platformRate = platformRate.mul(1 - reduction);
			logger.info(
				{
					orderType,
					originalRate: config.platformFeeRate,
					reduction,
					finalRate: platformRate.toNumber(),
				},
				"[OrderPricingService] Applied badge commission reduction",
			);
		}

		const platformCommission = amount.mul(platformRate);
		const driverEarning = amount.minus(platformCommission);

		// Calculate merchant commission for FOOD orders
		// merchantCommissionRate MUST come from database config, no fallback allowed
		let merchantCommission: number | undefined;
		if (orderType === "FOOD") {
			const foodConfig = config as FoodPricingConfiguration;
			merchantCommission = Number(
				amount.mul(foodConfig.merchantCommissionRate).toFixed(2),
			);
		}

		return {
			platformCommission: Number(platformCommission.toFixed(2)),
			merchantCommission,
			driverEarning: Number(driverEarning.toFixed(2)),
			commissionRate: platformRate.toNumber(),
		};
	}

	/**
	 * Calculate cancellation fee based on order status.
	 * Fee rates are fetched from database configuration.
	 *
	 * @param totalPrice - Total order price
	 * @param isAccepted - Whether driver has accepted
	 * @returns Cancellation fee amount
	 */
	async calculateCancellationFee(
		totalPrice: number,
		isAccepted: boolean,
	): Promise<number> {
		const businessConfig = await this.configProvider.getBusinessConfig();
		const amount = new Decimal(totalPrice);
		const rate = isAccepted
			? businessConfig.userCancellationFeeAfterAccept
			: businessConfig.userCancellationFeeBeforeAccept;

		return Number(amount.mul(rate).toFixed(2));
	}

	/**
	 * Calculate no-show fee.
	 * Fee rate is fetched from database configuration.
	 *
	 * @param totalPrice - Total order price
	 * @returns No-show fee amount
	 */
	async calculateNoShowFee(totalPrice: number): Promise<number> {
		const businessConfig = await this.configProvider.getBusinessConfig();
		const amount = new Decimal(totalPrice);
		return Number(amount.mul(businessConfig.noShowFee).toFixed(2));
	}

	/**
	 * Get pricing configuration for order type
	 */
	async #getPricingForType(type: OrderType): Promise<PricingConfiguration> {
		switch (type) {
			case "RIDE":
				return await this.configProvider.getRidePricing();
			case "DELIVERY":
				return await this.configProvider.getDeliveryPricing();
			case "FOOD":
				return await this.configProvider.getFoodPricing();
			default:
				throw new RepositoryError(`Unknown order type: ${type}`, {
					code: "BAD_REQUEST",
				});
		}
	}

	/**
	 * Calculate pricing using appropriate calculator
	 */
	#calculatePricing(
		type: OrderType,
		distanceKm: number,
		config: PricingConfiguration,
		weight?: number,
	): OrderSummary {
		switch (type) {
			case "RIDE":
				return PricingCalculator.calculateRide(
					distanceKm,
					config as RidePricingConfiguration,
				);
			case "DELIVERY":
				return PricingCalculator.calculateDelivery(
					distanceKm,
					weight,
					config as DeliveryPricingConfiguration,
				);
			case "FOOD":
				return PricingCalculator.calculateFood(
					distanceKm,
					config as FoodPricingConfiguration,
				);
		}
	}

	/**
	 * Handle and transform errors
	 */
	#handleError(
		error: unknown,
		action: string,
	): InstanceType<typeof RepositoryError> {
		const ErrorClass = RepositoryError;
		if (error instanceof ErrorClass) {
			return error;
		}
		return new ErrorClass(`Failed to ${action}`, {
			code: "INTERNAL_SERVER_ERROR",
		});
	}
}

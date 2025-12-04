/**
 * OrderPricingService - Handles all order pricing calculations
 *
 * SOLID Principles:
 * - SRP: Single responsibility for pricing logic
 * - OCP: Open for extension with new order types
 * - DIP: Depends on IMapService interface
 */

import type {
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
import { BUSINESS_CONSTANTS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import { log } from "@/utils";
import { PricingCalculator } from "@/utils/pricing";

export interface IPricingConfigProvider {
	getRidePricing(): Promise<RidePricingConfiguration>;
	getDeliveryPricing(): Promise<DeliveryPricingConfiguration>;
	getFoodPricing(): Promise<FoodPricingConfiguration>;
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
			log.debug({ input }, "[OrderPricingService] Estimating order");

			// Calculate distance using map service
			const distanceKm = await this.mapService.getDistance(
				{ lat: input.pickupLocation.y, lng: input.pickupLocation.x },
				{ lat: input.dropoffLocation.y, lng: input.dropoffLocation.x },
			);

			log.debug({ distanceKm }, "[OrderPricingService] Distance calculated");

			// Get pricing based on order type
			const pricing = await this.#getPricingForType(input.type);

			// Calculate cost using pricing calculator
			const summary = this.#calculatePricing(
				input.type,
				distanceKm,
				pricing,
				input.weight,
			);

			log.info(
				{ type: input.type, distanceKm, totalCost: summary.totalCost },
				"[OrderPricingService] Order estimated",
			);

			return summary;
		} catch (error) {
			log.error({ error, input }, "[OrderPricingService] Estimation failed");
			throw this.#handleError(error, "estimate order");
		}
	}

	/**
	 * Calculate commission for completed order
	 *
	 * @param orderType - Type of order
	 * @param totalPrice - Total order price
	 * @returns Object with platform and merchant commission
	 */
	calculateCommission(
		orderType: OrderType,
		totalPrice: number,
	): {
		platformCommission: number;
		merchantCommission?: number;
		driverEarning: number;
	} {
		const amount = new Decimal(totalPrice);
		let platformRate: Decimal;
		let merchantCommission: number | undefined;

		switch (orderType) {
			case "RIDE":
				platformRate = new Decimal(BUSINESS_CONSTANTS.RIDE_COMMISSION_RATE);
				break;
			case "DELIVERY":
				platformRate = new Decimal(BUSINESS_CONSTANTS.DELIVERY_COMMISSION_RATE);
				break;
			case "FOOD":
				platformRate = new Decimal(BUSINESS_CONSTANTS.FOOD_COMMISSION_RATE);
				merchantCommission = amount
					.mul(BUSINESS_CONSTANTS.MERCHANT_FOOD_COMMISSION_RATE)
					.toNumber();
				break;
			default: {
				const err: never = orderType;
				throw new RepositoryError(`Unknown order type: ${err}`);
			}
		}

		const platformCommission = amount.mul(platformRate).toNumber();
		const driverEarning = amount.minus(platformCommission).toNumber();

		return {
			platformCommission: Number(platformCommission.toFixed(2)),
			merchantCommission: merchantCommission
				? Number(merchantCommission.toFixed(2))
				: undefined,
			driverEarning: Number(driverEarning.toFixed(2)),
		};
	}

	/**
	 * Calculate cancellation fee based on order status
	 *
	 * @param totalPrice - Total order price
	 * @param isAccepted - Whether driver has accepted
	 * @returns Cancellation fee amount
	 */
	calculateCancellationFee(totalPrice: number, isAccepted: boolean): number {
		const amount = new Decimal(totalPrice);
		const rate = isAccepted
			? BUSINESS_CONSTANTS.USER_CANCELLATION_FEE_AFTER_ACCEPT
			: BUSINESS_CONSTANTS.USER_CANCELLATION_FEE_BEFORE_ACCEPT;

		return Number(amount.mul(rate).toFixed(2));
	}

	/**
	 * Calculate no-show fee
	 *
	 * @param totalPrice - Total order price
	 * @returns No-show fee amount (50% of order)
	 */
	calculateNoShowFee(totalPrice: number): number {
		const amount = new Decimal(totalPrice);
		return Number(amount.mul(BUSINESS_CONSTANTS.NO_SHOW_FEE).toFixed(2));
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

import type {
	DeliveryPricingConfiguration,
	FoodPricingConfiguration,
	RidePricingConfiguration,
} from "@repo/schema/configuration";
import type { OrderSummary } from "@repo/schema/order";

function _formatNumber(num: number): number {
	return Number(num.toFixed(2));
}
export const PricingCalculator = {
	calculateRide(
		distanceKm: number,
		config: RidePricingConfiguration,
	): Omit<OrderSummary, "driverEarning" | "currency"> {
		const baseFare = _formatNumber(config.baseFare);
		const distanceFare = _formatNumber(distanceKm * config.perKmRate);
		const additionalFees = _formatNumber(0);

		let subtotal = _formatNumber(baseFare + distanceFare + additionalFees);

		if (subtotal < config.minimumFare) {
			subtotal = _formatNumber(config.minimumFare);
		}

		const platformFee = _formatNumber(subtotal * config.platformFeeRate);
		const tax = _formatNumber((subtotal + platformFee) * config.taxRate);
		const totalCost = _formatNumber(subtotal + platformFee + tax);

		return {
			distanceKm: _formatNumber(distanceKm),
			baseFare: _formatNumber(baseFare),
			distanceFare: _formatNumber(distanceFare),
			additionalFees: _formatNumber(additionalFees),
			subtotal: _formatNumber(subtotal),
			platformFee: _formatNumber(platformFee),
			tax: _formatNumber(tax),
			totalCost: _formatNumber(totalCost),
			breakdown: {
				distance: _formatNumber(distanceKm),
			},
		};
	},
	calculateDelivery(
		distanceKm: number,
		weight: number | undefined,
		config: DeliveryPricingConfiguration,
	): Omit<OrderSummary, "driverEarning" | "currency"> {
		const baseFare = _formatNumber(config.baseFare);
		const distanceFare = _formatNumber(distanceKm * config.perKmRate);
		const additionalFees = weight
			? _formatNumber(weight * config.perKgRate)
			: _formatNumber(0);

		let subtotal = _formatNumber(baseFare + distanceFare + additionalFees);

		if (subtotal < config.minimumFare) {
			subtotal = _formatNumber(config.minimumFare);
		}

		const platformFee = _formatNumber(subtotal * config.platformFeeRate);
		const tax = _formatNumber((subtotal + platformFee) * config.taxRate);
		const totalCost = _formatNumber(subtotal + platformFee + tax);

		return {
			distanceKm: _formatNumber(distanceKm),
			baseFare: _formatNumber(baseFare),
			distanceFare: _formatNumber(distanceFare),
			additionalFees: _formatNumber(additionalFees),
			subtotal: _formatNumber(subtotal),
			platformFee: _formatNumber(platformFee),
			tax: _formatNumber(tax),
			totalCost: _formatNumber(totalCost),
			breakdown: {
				distance: _formatNumber(distanceKm),
				weight: weight || 0,
				perKgRate: config.perKgRate,
			},
		};
	},

	calculateFood(
		distanceKm: number,
		config: FoodPricingConfiguration,
	): Omit<OrderSummary, "driverEarning" | "currency"> {
		const baseFare = _formatNumber(config.baseFare);
		const distanceFare = _formatNumber(distanceKm * config.perKmRate);
		const additionalFees = _formatNumber(0);

		let subtotal = _formatNumber(baseFare + distanceFare + additionalFees);

		if (subtotal < config.minimumFare) {
			subtotal = _formatNumber(config.minimumFare);
		}

		const platformFee = _formatNumber(subtotal * config.platformFeeRate);
		const tax = _formatNumber((subtotal + platformFee) * config.taxRate);
		const totalCost = _formatNumber(subtotal + platformFee + tax);

		return {
			distanceKm: _formatNumber(distanceKm),
			baseFare: _formatNumber(baseFare),
			distanceFare: _formatNumber(distanceFare),
			additionalFees: _formatNumber(additionalFees),
			subtotal: _formatNumber(subtotal),
			platformFee: _formatNumber(platformFee),
			tax: _formatNumber(tax),
			totalCost: _formatNumber(totalCost),
			breakdown: {
				distance: _formatNumber(distanceKm),
			},
		};
	},
};

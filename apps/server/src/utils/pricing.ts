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
		const baseFare = config.baseFare;
		const distanceFare = distanceKm * config.perKmRate;
		const additionalFees = 0;

		let subtotal = baseFare + distanceFare + additionalFees;

		if (subtotal < config.minimumFare) {
			subtotal = config.minimumFare;
		}

		const platformFee = subtotal * config.platformFeeRate;
		const tax = (subtotal + platformFee) * config.taxRate;
		const totalCost = subtotal + platformFee + tax;

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
		const baseFare = config.baseFare;
		const distanceFare = distanceKm * config.perKmRate;
		const additionalFees = weight ? weight * config.perKgRate : 0;

		let subtotal = baseFare + distanceFare + additionalFees;

		if (subtotal < config.minimumFare) {
			subtotal = config.minimumFare;
		}

		const platformFee = subtotal * config.platformFeeRate;
		const tax = (subtotal + platformFee) * config.taxRate;
		const totalCost = subtotal + platformFee + tax;

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
		const baseFare = config.baseFare;
		const distanceFare = distanceKm * config.perKmRate;
		const additionalFees = 0;

		let subtotal = baseFare + distanceFare + additionalFees;

		if (subtotal < config.minimumFare) {
			subtotal = config.minimumFare;
		}

		const platformFee = subtotal * config.platformFeeRate;
		const tax = (subtotal + platformFee) * config.taxRate;
		const totalCost = subtotal + platformFee + tax;

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

export const CONSTANTS = Object.freeze({
	DRIVER_STATUSES: [
		"pending",
		"approved",
		"rejected",
		"active",
		"inactive",
		"suspended",
	] as const,
	MERCHANT_TYPES: ["merchant", "tenant"] as const,
	ORDER_TYPES: ["ride", "delivery", "food"] as const,
	DAY_OF_WEEK: [
		"sunday",
		"monday",
		"tuesday",
		"wednesday",
		"thursday",
		"friday",
		"saturday",
	] as const,
} as const);

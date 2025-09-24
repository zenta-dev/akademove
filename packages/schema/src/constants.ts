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
	ORDER_STATUSES: [
		"requested",
		"matching",
		"accepted",
		"arriving",
		"in_trip",
		"completed",
		"cancelled_by_user",
		"cancelled_by_driver",
		"cancelled_by_system",
	] as const,
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
	REPORT_CATEGORIES: ["behavior", "safety", "fraud", "other"] as const,
	REPORT_STATUS: ["pending", "investigating", "resolved", "dismissed"] as const,
	REVIEW_CATEGORIES: ["cleanliness", "courtesy", "other"] as const,
	GENERAL_RULE_TYPES: ["percentage", "fixed"] as const,
	USER_ROLES: ["admin", "operator", "merchant", "driver", "user"] as const,
} as const);

export const AUTH_CONSTANTS = Object.freeze({
	SESSION_TOKEN: "AkadeMove-AMST",
	SESSION_DATA: "AkadeMove-AMSD",
	SESSION_DONT_REMEMBER: "AkadeMove-AMDR",
} as const);

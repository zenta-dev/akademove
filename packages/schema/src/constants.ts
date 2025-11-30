export const CONSTANTS = Object.freeze({
	DRIVER_STATUSES: [
		"PENDING",
		"APPROVED",
		"REJECTED",
		"ACTIVE",
		"INACTIVE",
		"SUSPENDED",
	] as const,
	MERCHANT_TYPES: ["MERCHANT", "TENANT"] as const,
	MERCHANT_CATEGORIES: ["ATK", "Printing", "Food"] as const,
	ORDER_STATUSES: [
		"REQUESTED",
		"MATCHING",
		"ACCEPTED",
		"ARRIVING",
		"IN_TRIP",
		"COMPLETED",
		"CANCELLED_BY_USER",
		"CANCELLED_BY_DRIVER",
		"CANCELLED_BY_SYSTEM",
	] as const,
	ORDER_TYPES: ["RIDE", "DELIVERY", "FOOD"] as const,
	DAY_OF_WEEK: [
		"SUNDAY",
		"MONDAY",
		"TUESDAY",
		"WEDNESDAY",
		"THURSDAY",
		"FRIDAY",
		"SATURDAY",
	] as const,
	REPORT_CATEGORIES: ["BEHAVIOR", "SAFETY", "FRAUD", "OTHER"] as const,
	REPORT_STATUS: ["PENDING", "INVESTIGATING", "RESOLVED", "DISMISSED"] as const,
	REVIEW_CATEGORIES: ["CLEANLINESS", "COURTESY", "OTHER"] as const,
	GENERAL_RULE_TYPES: ["PERCENTAGE", "FIXED"] as const,
	USER_ROLES: ["ADMIN", "OPERATOR", "MERCHANT", "DRIVER", "USER"] as const,
	USER_GENDERS: ["MALE", "FEMALE"] as const,
	BANK_PROVIDERS: ["BCA", "BNI", "BRI", "MANDIRI", "PERMATA"] as const,
} as const);

export const AUTH_CONSTANTS = Object.freeze({
	SESSION_TOKEN: "AkadeMove-AMST",
	SESSION_DATA: "AkadeMove-AMSD",
	SESSION_DONT_REMEMBER: "AkadeMove-AMDR",
} as const);

export const TRANSACTION_TYPE = [
	"TOPUP",
	"WITHDRAW",
	"PAYMENT",
	"REFUND",
	"ADJUSTMENT",
] as const;
export const TRANSACTION_STATUS = [
	"PENDING",
	"SUCCESS",
	"FAILED",
	"CANCELLED",
	"EXPIRED",
	"REFUNDED",
] as const;
export const CURRENCY = ["IDR"] as const;
export const PAYMENT_PROVIDER = ["MIDTRANS", "MANUAL"] as const;
export const PAYMENT_METHOD = [
	"QRIS",
	// "VA",
	"BANK_TRANSFER",
	"WALLET",
] as const;

export const BADGE_TYPES = [
	"ACHIEVEMENT",
	"PERFORMANCE",
	"VOLUME",
	"STREAK",
	"MILESTONE",
	"SPECIAL",
] as const;

export const BADGE_LEVELS = [
	"BRONZE",
	"SILVER",
	"GOLD",
	"PLATINUM",
	"DIAMOND",
] as const;

export const BADGE_TARGET_ROLES = ["DRIVER", "MERCHANT", "USER"] as const;
export const LEADERBOARD_PERIODS = [
	"DAILY",
	"WEEKLY",
	"MONTHLY",
	"QUARTERLY",
	"YEARLY",
	"ALL-TIME",
] as const;

export const LEADERBOARD_CATEGORIES = [
	"RATING",
	"VOLUME",
	"EARNINGS",
	"STREAK",
	"ON-TIME",
	"COMPLETION-RATE",
] as const;

import { m } from "@repo/i18n";
import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

const _BasePricingConfigurationSchema = z.object({
	baseFare: z.coerce.number<number>().positive(),
	perKmRate: z.coerce.number<number>().positive(),
	minimumFare: z.coerce.number<number>().positive(),
	platformFeeRate: z.coerce.number<number>().positive(),
	taxRate: z.coerce.number<number>().positive(),
});
export type BasePricingConfiguration = z.infer<
	typeof _BasePricingConfigurationSchema
>;

export const RidePricingConfigurationSchema = _BasePricingConfigurationSchema;
export type RidePricingConfiguration = z.infer<
	typeof RidePricingConfigurationSchema
>;

export const DeliveryPricingConfigurationSchema =
	_BasePricingConfigurationSchema.safeExtend({
		perKgRate: z.coerce.number().positive(),
	});
export type DeliveryPricingConfiguration = z.infer<
	typeof DeliveryPricingConfigurationSchema
>;

export const FoodPricingConfigurationSchema =
	_BasePricingConfigurationSchema.safeExtend({
		merchantCommissionRate: z.coerce.number().min(0).max(1),
	});
export type FoodPricingConfiguration = z.infer<
	typeof FoodPricingConfigurationSchema
>;

export const PricingConfigurationSchema = z.union([
	RidePricingConfigurationSchema,
	DeliveryPricingConfigurationSchema,
	FoodPricingConfigurationSchema,
]);
export type PricingConfiguration = z.infer<typeof PricingConfigurationSchema>;

/**
 * Business configuration schema for configurable business rules.
 * All pricing-related values MUST come from database, not static constants.
 */
export const BusinessConfigurationSchema = z.object({
	// Wallet limits (in IDR)
	minTransferAmount: z.coerce.number().positive(),
	minWithdrawalAmount: z.coerce.number().positive(),
	minTopUpAmount: z.coerce.number().positive(),
	quickTopUpAmounts: z.array(z.coerce.number().positive()),

	// Cancellation fees (as decimal, e.g., 0.1 = 10%)
	userCancellationFeeBeforeAccept: z.coerce.number().min(0).max(1),
	userCancellationFeeAfterAccept: z.coerce.number().min(0).max(1),
	noShowFee: z.coerce.number().min(0).max(1),

	// No-show driver compensation (as decimal, e.g., 0.8 = 80% of penalty goes to driver)
	noShowDriverCompensationRate: z.coerce.number().min(0).max(1),

	// Delivery verification
	highValueOrderThreshold: z.coerce.number().positive(),

	// ========================================================================
	// Order Matching Configuration (Gojek-like resilient matching)
	// ========================================================================

	/**
	 * Maximum duration in minutes for finding a driver (default: 15 minutes)
	 * After this timeout, order is cancelled and user gets full refund
	 * Configurable via admin/operator dashboard
	 */
	driverMatchingTimeoutMinutes: z.coerce.number().positive().default(15),

	/**
	 * Initial search radius in kilometers (default: 5km)
	 * This is the starting radius for driver search
	 */
	driverMatchingInitialRadiusKm: z.coerce.number().positive().default(5),

	/**
	 * Maximum search radius in kilometers (default: 20km)
	 * Radius will not expand beyond this limit
	 */
	driverMatchingMaxRadiusKm: z.coerce.number().positive().default(20),

	/**
	 * Radius expansion rate per attempt (as decimal, e.g., 0.2 = 20%)
	 * Each failed attempt expands radius by this percentage
	 */
	driverMatchingRadiusExpansionRate: z.coerce.number().positive().default(0.2),

	/**
	 * Interval between matching attempts in seconds (default: 30s)
	 * After each interval, system searches for drivers again with expanded radius
	 */
	driverMatchingIntervalSeconds: z.coerce.number().positive().default(30),

	/**
	 * Maximum number of drivers to broadcast order to (default: 10)
	 * Limits concurrent order offers to prevent overwhelming the system
	 */
	driverMatchingBroadcastLimit: z.coerce.number().int().positive().default(10),

	/**
	 * Maximum driver cancellations per day before suspension (default: 3)
	 * Drivers exceeding this limit get temporarily suspended
	 */
	driverMaxCancellationsPerDay: z.coerce.number().int().positive().default(3),

	// ========================================================================
	// Order Payment Configuration
	// ========================================================================

	/**
	 * Maximum duration in minutes for payment to be completed (default: 15 minutes)
	 * Orders in REQUESTED status (waiting for payment confirmation) will be
	 * auto-cancelled after this timeout. This applies to non-wallet payments
	 * (BANK_TRANSFER, QRIS) where payment is not immediate.
	 */
	paymentPendingTimeoutMinutes: z.coerce.number().positive().default(15),

	// ========================================================================
	// Order Lifecycle Configuration
	// ========================================================================

	/**
	 * Duration in minutes after which COMPLETED orders without ratings
	 * will be auto-finalized (default: 60 minutes / 1 hour)
	 */
	orderCompletionTimeoutMinutes: z.coerce.number().positive().default(60),

	/**
	 * Duration in minutes after which NO_SHOW orders will be processed
	 * for cleanup and refund if not already done (default: 30 minutes)
	 */
	noShowTimeoutMinutes: z.coerce.number().positive().default(30),

	/**
	 * Duration in minutes to consider an in-transit order timestamp as stale
	 * Orders in ACCEPTED/ARRIVING/IN_TRIP will have their timestamps refreshed
	 * if older than this threshold (default: 5 minutes)
	 */
	orderStaleTimestampMinutes: z.coerce.number().positive().default(5),

	// ========================================================================
	// Driver Location Tracking Configuration
	// ========================================================================

	/**
	 * Duration in minutes after which a driver's location is considered stale
	 * Drivers with stale locations will be automatically set offline
	 * (default: 15 minutes)
	 */
	driverLocationStaleThresholdMinutes: z.coerce.number().positive().default(15),

	// ========================================================================
	// Driver Rebroadcast Configuration
	// ========================================================================

	/**
	 * Interval in minutes between rebroadcast attempts for unmatched orders
	 * Orders in MATCHING status without a driver will be rebroadcast
	 * to the driver pool every X minutes (default: 2 minutes)
	 */
	driverRebroadcastIntervalMinutes: z.coerce.number().positive().default(1),

	/**
	 * Multiplier for radius expansion during rebroadcast (default: 1.5)
	 * Rebroadcast uses initialRadiusKm * this multiplier to find more drivers
	 */
	driverRebroadcastRadiusMultiplier: z.coerce.number().positive().default(1.5),

	/**
	 * Maximum number of rebroadcast attempts before giving up (default: 5)
	 * This prevents spamming drivers with the same order too many times
	 * After max attempts, the order will wait for the timeout handler to cancel it
	 */
	driverRebroadcastMaxAttempts: z.coerce.number().int().positive().default(5),

	// ========================================================================
	// Commission Configuration
	// ========================================================================

	/**
	 * Maximum badge commission reduction allowed (default: 0.5 = 50%)
	 * Driver badges can reduce platform commission up to this percentage
	 */
	maxBadgeCommissionReduction: z.coerce.number().min(0).max(1).default(0.5),

	// ========================================================================
	// Scheduled Order Configuration
	// ========================================================================

	/**
	 * Minimum minutes in advance required for scheduling an order (default: 30 minutes)
	 */
	scheduledOrderMinAdvanceMinutes: z.coerce.number().positive().default(30),

	/**
	 * Maximum days in advance allowed for scheduling an order (default: 7 days)
	 */
	scheduledOrderMaxAdvanceDays: z.coerce.number().positive().default(7),

	/**
	 * Minutes before scheduled time when driver matching begins (default: 15 minutes)
	 */
	scheduledOrderMatchingLeadTimeMinutes: z.coerce
		.number()
		.positive()
		.default(5),

	/**
	 * Minimum hours before scheduled time required to allow rescheduling (default: 1 hour)
	 */
	scheduledOrderMinRescheduleHours: z.coerce.number().positive().default(1),

	// ========================================================================
	// On-Time Delivery Configuration
	// ========================================================================

	/**
	 * Threshold in minutes for considering a delivery as "on-time" (default: 10 minutes)
	 * Used for driver metrics and leaderboard calculations
	 */
	onTimeDeliveryThresholdMinutes: z.coerce.number().positive().default(10),
});
export type BusinessConfiguration = z.infer<typeof BusinessConfigurationSchema>;

export type ConfigurationValue =
	| RidePricingConfiguration
	| DeliveryPricingConfiguration
	| FoodPricingConfiguration
	| BusinessConfiguration;

export const BannerConfigurationSchema = z.object({
	title: z.string(),
	description: z.string(),
	imageUrl: z.string(),
});
export type Banner = z.infer<typeof BannerConfigurationSchema>;

export const EmergencyContactConfigurationSchema = z.object({
	name: z.string().min(1),
	phone: z.string().min(1),
	type: z.enum([
		"CAMPUS_SECURITY",
		"POLICE",
		"AMBULANCE",
		"FIRE_DEPT",
		"OTHER",
	]),
	description: z.string().optional(),
	isActive: z.boolean().default(true),
});
export type EmergencyContactConfiguration = z.infer<
	typeof EmergencyContactConfigurationSchema
>;

export const ConfigurationSchema = z.object({
	key: z.string().max(256),
	name: z
		.string()
		.min(1, m.required_placeholder({ field: m.name() }))
		.max(256),
	value: z.any(),
	description: z.string().optional(),
	updatedById: z.string(),
	updatedAt: DateSchema,
});
export type Configuration = z.infer<typeof ConfigurationSchema>;

export const ConfigurationKeySchema = extractSchemaKeysAsEnum(
	ConfigurationSchema,
).exclude(["value"]);

export const InsertConfigurationSchema = ConfigurationSchema.omit({
	key: true,
	updatedById: true,
	updatedAt: true,
});
export type InsertConfiguration = z.infer<typeof InsertConfigurationSchema>;

export const UpdateConfigurationSchema = ConfigurationSchema.omit({
	key: true,
	updatedById: true,
	updatedAt: true,
}).partial();
export type UpdateConfiguration = z.infer<typeof UpdateConfigurationSchema>;

export const ConfigurationSchemaRegistries = {
	RidePricingConfiguration: {
		schema: RidePricingConfigurationSchema,
		strategy: "output",
	},
	DeliveryPricingConfiguration: {
		schema: DeliveryPricingConfigurationSchema,
		strategy: "output",
	},
	FoodPricingConfiguration: {
		schema: FoodPricingConfigurationSchema,
		strategy: "output",
	},
	PricingConfiguration: {
		schema: PricingConfigurationSchema,
		strategy: "output",
	},
	BannerConfiguration: {
		schema: BannerConfigurationSchema,
		strategy: "output",
	},
	EmergencyContactConfiguration: {
		schema: EmergencyContactConfigurationSchema,
		strategy: "output",
	},
	BusinessConfiguration: {
		schema: BusinessConfigurationSchema,
		strategy: "output",
	},
	Configuration: { schema: ConfigurationSchema, strategy: "output" },
	InsertConfiguration: { schema: InsertConfigurationSchema, strategy: "input" },
	UpdateConfiguration: { schema: UpdateConfigurationSchema, strategy: "input" },
	ConfigurationKey: { schema: ConfigurationKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

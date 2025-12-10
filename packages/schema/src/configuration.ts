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

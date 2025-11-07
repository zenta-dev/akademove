import { m } from "@repo/i18n";
import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.ts";

const _BasePricingConfigurationSchema = z.object({
	baseFare: z.number().positive(),
	perKmRate: z.number().positive(),
	minimumFare: z.number().positive(),
	platformFeeRate: z.number().positive(),
	taxRate: z.number().positive(),
});

export const RidePricingConfigurationSchema = _BasePricingConfigurationSchema
	.extend({})
	.meta({ title: "RidePricingConfiguration" });

export const DeliveryPricingConfigurationSchema =
	_BasePricingConfigurationSchema
		.extend({
			perKgRate: z.number().positive(),
		})
		.meta({ title: "DeliveryPricingConfiguration" });

export const FoodPricingConfigurationSchema = _BasePricingConfigurationSchema
	.extend({})
	.meta({ title: "FoodPricingConfiguration" });

export const BannerConfigurationSchema = z
	.object({
		title: z.string(),
		description: z.string(),
		imageUrl: z.string(),
	})
	.meta({ title: "BannerConfiguration" });

export const ConfigurationSchema = z
	.object({
		key: z.string().max(256),
		name: z
			.string()
			.min(1, m.required_placeholder({ field: m.name() }))
			.max(256),
		value: z.any(),
		description: z.string().optional(),
		updatedById: z.string(),
		updatedAt: DateSchema,
	})
	.meta({ title: "Configuration" });

export const InsertConfigurationSchema = ConfigurationSchema.omit({
	key: true,
	updatedById: true,
	updatedAt: true,
}).meta({ title: "InsertConfigurationRequest" });

export const UpdateConfigurationSchema = ConfigurationSchema.omit({
	key: true,
	updatedById: true,
	updatedAt: true,
})
	.partial()
	.meta({ title: "UpdateConfigurationRequest" });

export type BasePricingConfiguration = z.infer<
	typeof _BasePricingConfigurationSchema
>;
export type RidePricingConfiguration = z.infer<
	typeof RidePricingConfigurationSchema
>;
export type DeliveryPricingConfiguration = z.infer<
	typeof DeliveryPricingConfigurationSchema
>;
export type FoodPricingConfiguration = z.infer<
	typeof FoodPricingConfigurationSchema
>;
export type Banner = z.infer<typeof BannerConfigurationSchema>;
export type ConfigurationValue =
	| RidePricingConfiguration
	| DeliveryPricingConfiguration
	| FoodPricingConfiguration;
export type Configuration = z.infer<typeof ConfigurationSchema>;
export type InsertConfiguration = z.infer<typeof InsertConfigurationSchema>;
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
	BannerConfiguration: {
		schema: BannerConfigurationSchema,
		strategy: "output",
	},
	InsertConfiguration: { schema: InsertConfigurationSchema, strategy: "input" },
	UpdateConfiguration: { schema: UpdateConfigurationSchema, strategy: "input" },
} satisfies SchemaRegistries;

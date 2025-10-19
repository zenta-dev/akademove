import { m } from "@repo/i18n";
import * as z from "zod";
import { DateSchema } from "./common.ts";

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
}).meta({ title: "UpdateConfigurationRequest" });

export type Configuration = z.infer<typeof ConfigurationSchema>;
export type InsertConfiguration = z.infer<typeof InsertConfigurationSchema>;
export type UpdateConfiguration = z.infer<typeof UpdateConfigurationSchema>;

import * as z from "zod";
import { DateSchema } from "./common.ts";

export const ConfigurationSchema = z
	.object({
		key: z.string(),
		name: z.string(),
		value: z.any(),
		description: z.string().optional(),
		updatedById: z.string(),
		updatedAt: DateSchema,
	})
	.meta({
		title: "Configuration",
		ref: "Configuration",
	});

export const InsertConfigurationSchema = ConfigurationSchema.omit({
	key: true,
	updatedById: true,
	updatedAt: true,
});

export const UpdateConfigurationSchema = ConfigurationSchema.omit({
	key: true,
	updatedById: true,
	updatedAt: true,
}).partial();

export type Configuration = z.infer<typeof ConfigurationSchema>;
export type InsertConfiguration = z.infer<typeof InsertConfigurationSchema>;
export type UpdateConfiguration = z.infer<typeof UpdateConfigurationSchema>;

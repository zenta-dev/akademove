import * as z from "zod";
import type { SchemaRegistries } from "./common.js";
import { DateSchema } from "./common.js";
import { CONSTANTS } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const QuickMessageTemplateSchema = z.object({
	id: z.string(),
	role: z.enum(CONSTANTS.USER_ROLES),
	message: z.string(),
	orderType: z.enum(CONSTANTS.ORDER_TYPES).nullable(),
	locale: z.string().default("en"),
	isActive: z.boolean(),
	displayOrder: z.number().int(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type QuickMessageTemplate = z.infer<typeof QuickMessageTemplateSchema>;

export const QuickMessageTemplateKeySchema = extractSchemaKeysAsEnum(
	QuickMessageTemplateSchema,
);

export const InsertQuickMessageTemplateSchema = QuickMessageTemplateSchema.omit(
	{
		id: true,
		createdAt: true,
		updatedAt: true,
	},
);
export type InsertQuickMessageTemplate = z.infer<
	typeof InsertQuickMessageTemplateSchema
>;

export const UpdateQuickMessageTemplateSchema =
	InsertQuickMessageTemplateSchema.partial();
export type UpdateQuickMessageTemplate = z.infer<
	typeof UpdateQuickMessageTemplateSchema
>;

export const ListQuickMessageQuerySchema = z.object({
	role: z.enum(CONSTANTS.USER_ROLES).optional(),
	orderType: z.enum(CONSTANTS.ORDER_TYPES).optional(),
	locale: z.string().optional(),
	isActive: z.boolean().optional(),
});
export type ListQuickMessageQuery = z.infer<typeof ListQuickMessageQuerySchema>;

export const QuickMessageSchemaRegistries = {
	QuickMessageTemplate: {
		schema: QuickMessageTemplateSchema,
		strategy: "output",
	},
	InsertQuickMessageTemplate: {
		schema: InsertQuickMessageTemplateSchema,
		strategy: "input",
	},
	UpdateQuickMessageTemplate: {
		schema: UpdateQuickMessageTemplateSchema,
		strategy: "input",
	},
	ListQuickMessageQuery: {
		schema: ListQuickMessageQuerySchema,
		strategy: "input",
	},
} satisfies SchemaRegistries;

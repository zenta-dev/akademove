import { m } from "@repo/i18n";
import * as z from "zod";
import {
	BankSchema,
	DateSchema,
	PhoneSchema,
	type SchemaRegistries,
} from "./common.ts";
import { extractSchemaKeysAsEnum } from "./enum.helper.ts";
import { flattenZodObject } from "./flatten.helper.ts";
import { CoordinateSchema } from "./position.ts";

export const MerchantSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	name: z.string().min(1, m.required_placeholder({ field: m.name() })),
	email: z.email(
		m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
	),
	phone: PhoneSchema,
	address: z.string(),
	location: CoordinateSchema.optional(),
	isActive: z.boolean(),
	rating: z.number(),
	document: z.url().optional(),
	image: z.url().optional(),
	categories: z.array(z.string()),
	bank: BankSchema,
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Merchant = z.infer<typeof MerchantSchema>;

export const MerchantKeySchema = extractSchemaKeysAsEnum(MerchantSchema);

export const InsertMerchantSchema = MerchantSchema.omit({
	id: true,
	userId: true,
	rating: true,
	isActive: true,
	document: true,
	image: true,
	categories: true,
	createdAt: true,
	updatedAt: true,
}).extend({
	document: z
		.file()
		.mime(["image/png", "image/jpg", "image/jpeg", "application/pdf"])
		.optional(),
	image: z.file().mime(["image/png", "image/jpg", "image/jpeg"]).optional(),
});
export type InsertMerchant = z.infer<typeof InsertMerchantSchema>;

export const UpdateMerchantSchema = InsertMerchantSchema.partial();
export type UpdateMerchant = z.infer<typeof UpdateMerchantSchema>;

export const FlatUpdateMerchantSchema = flattenZodObject(UpdateMerchantSchema);
export type FlatUpdateMerchant = z.infer<typeof FlatUpdateMerchantSchema>;

export const MerchantMenuSchema = z.object({
	id: z.uuid(),
	merchantId: z.uuid(),
	name: z.string(),
	image: z.url().optional(),
	category: z.string().optional(),
	price: z.coerce.number<number>().nonnegative(),
	stock: z.coerce.number<number>().int().nonnegative(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type MerchantMenu = z.infer<typeof MerchantMenuSchema>;

export const MerchantMenuKeySchema =
	extractSchemaKeysAsEnum(MerchantMenuSchema);

export const InsertMerchantMenuSchema = MerchantMenuSchema.omit({
	id: true,
	image: true,
	merchantId: true,
	createdAt: true,
	updatedAt: true,
}).extend({
	image: z.file().mime(["image/png", "image/jpg", "image/jpeg"]).optional(),
});
export type InsertMerchantMenu = z.infer<typeof InsertMerchantMenuSchema>;

export const UpdateMerchantMenuSchema = InsertMerchantMenuSchema.partial();
export type UpdateMerchantMenu = z.infer<typeof UpdateMerchantMenuSchema>;

export const MerchantSchemaRegistries = {
	Merchant: { schema: MerchantSchema, strategy: "output" },
	MerchantMenu: { schema: MerchantMenuSchema, strategy: "output" },
	MerchantKey: { schema: MerchantKeySchema, strategy: "input" },
	MerchantMenuKey: { schema: MerchantMenuKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

import * as z from "zod";
import {
	BankSchema,
	DateSchema,
	LocationSchema,
	PhoneSchema,
} from "./common.ts";
import { CONSTANTS } from "./constants.ts";
import { flattenZodObject } from "./flatten.helper.ts";

export const MerchantTypeSchema = z.enum(CONSTANTS.MERCHANT_TYPES);

export const MerchantSchema = z
	.object({
		id: z.uuid(),
		userId: z.string(),
		type: MerchantTypeSchema,
		name: z.string(),
		email: z.email(),
		phone: PhoneSchema,
		address: z.string(),
		location: LocationSchema.optional(),
		isActive: z.boolean(),
		rating: z.number(),
		document: z.url().optional(),
		bank: BankSchema,
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({
		title: "Merchant",
		ref: "Merchant",
	});
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

export const InsertMerchantSchema = MerchantSchema.omit({
	id: true,
	userId: true,
	rating: true,
	isActive: true,
	document: true,
	createdAt: true,
	updatedAt: true,
}).extend({
	document: z
		.file()
		.mime(["image/png", "image/jpg", "image/jpeg", "application/pdf"])
		.optional(),
});
export const InsertMerchantMenuSchema = MerchantMenuSchema.omit({
	id: true,
	image: true,
	merchantId: true,
	createdAt: true,
	updatedAt: true,
}).extend({
	image: z
		.file()
		.mime(["image/png", "image/jpg", "image/jpeg", "application/pdf"])
		.optional(),
});

export const UpdateMerchantSchema = InsertMerchantSchema.partial();
export const UpdateMerchantMenuSchema = InsertMerchantMenuSchema.partial();

export const FlatUpdateMerchantSchema = flattenZodObject(UpdateMerchantSchema);

export type MerchantType = z.infer<typeof MerchantTypeSchema>;
export type Merchant = z.infer<typeof MerchantSchema>;
export type MerchantMenu = z.infer<typeof MerchantMenuSchema>;
export type InsertMerchant = z.infer<typeof InsertMerchantSchema>;
export type InsertMerchantMenu = z.infer<typeof InsertMerchantMenuSchema>;
export type UpdateMerchant = z.infer<typeof UpdateMerchantSchema>;
export type UpdateMerchantMenu = z.infer<typeof UpdateMerchantMenuSchema>;
export type FlatUpdateMerchant = z.infer<typeof FlatUpdateMerchantSchema>;

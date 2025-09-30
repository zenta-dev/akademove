import * as z from "zod";
import { DateSchema, LocationSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

export const MerchantTypeSchema = z.enum(CONSTANTS.MERCHANT_TYPES);

export const MerchantSchema = z
	.object({
		id: z.uuid(),
		userId: z.string(),
		type: MerchantTypeSchema.default("merchant"),
		name: z.string(),
		address: z.string(),
		location: LocationSchema.optional(),
		isActive: z.boolean(),
		rating: z.number(),
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
	category: z.string().optional(),
	price: z.number(),
	stock: z.number(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});

export const InsertMerchantSchema = MerchantSchema.omit({
	id: true,
	userId: true,
	rating: true,
	createdAt: true,
	updatedAt: true,
});
export const InsertMerchantMenuSchema = MerchantMenuSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
});

export const UpdateMerchantSchema = InsertMerchantSchema.partial();
export const UpdateMerchantMenuSchema = InsertMerchantMenuSchema.partial();

export type MerchantType = z.infer<typeof MerchantTypeSchema>;
export type Merchant = z.infer<typeof MerchantSchema>;
export type MerchantMenu = z.infer<typeof MerchantMenuSchema>;
export type InsertMerchant = z.infer<typeof InsertMerchantSchema>;
export type InsertMerchantMenu = z.infer<typeof InsertMerchantMenuSchema>;
export type UpdateMerchant = z.infer<typeof UpdateMerchantSchema>;
export type UpdateMerchantMenu = z.infer<typeof UpdateMerchantMenuSchema>;

import * as z from "zod";
import { DateSchema, LocationSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

export const MerchantTypeSchema = z.enum(CONSTANTS.MERCHANT_TYPES);

export const MerchantSchema = z
	.object({
		id: z.uuid(),
		userId: z.string(),
		type: MerchantTypeSchema,
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

export const InsertMerchantSchema = MerchantSchema.omit({
	id: true,
	userId: true,
	rating: true,
	createdAt: true,
	updatedAt: true,
});

export const UpdateMerchantSchema = InsertMerchantSchema.partial();

export type MerchantType = z.infer<typeof MerchantTypeSchema>;
export type Merchant = z.infer<typeof MerchantSchema>;
export type InsertMerchant = z.infer<typeof InsertMerchantSchema>;
export type UpdateMerchant = z.infer<typeof UpdateMerchantSchema>;

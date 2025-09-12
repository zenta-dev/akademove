import * as z from "zod";
import { LocationSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

export const MerchantTypeSchema = z.enum(CONSTANTS.MERCHANT_TYPES);

export const MerchantSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	type: MerchantTypeSchema,
	name: z.string(),
	address: z.string(),
	location: LocationSchema.nullable(),
	isActive: z.boolean().default(true),
	rating: z.number(),
	createdAt: z.date(),
	updatedAt: z.date(),
});

export type MerchantType = z.infer<typeof MerchantTypeSchema>;
export type Merchant = z.infer<typeof MerchantSchema>;

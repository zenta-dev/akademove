import * as z from "zod";
import { DateSchema } from "./common.ts";

export const PromoSchema = z
	.object({
		id: z.uuid(),
		name: z.string(),
		code: z.string(),
		rules: z.any(),
		discountAmount: z.number(),
		discountPercentage: z.number(),
		minOrderAmount: z.number(),
		maxOrderAmount: z.number(),
		usageLimit: z.number(),
		usedCount: z.number(),
		periodStart: DateSchema,
		periodEnd: DateSchema,
		isActive: z.boolean(),
		createdById: z.string(),
		createdAt: DateSchema,
	})
	.meta({
		title: "Promo",
		ref: "Promo",
	});

export const InsertPromoSchema = PromoSchema.omit({
	id: true,
	usedCount: true,
	createdAt: true,
});

export const UpdatePromoSchema = PromoSchema.omit({
	id: true,
	usedCount: true,
	createdAt: true,
}).partial();

export type Promo = z.infer<typeof PromoSchema>;
export type InsertPromo = z.infer<typeof InsertPromoSchema>;
export type UpdatePromo = z.infer<typeof UpdatePromoSchema>;

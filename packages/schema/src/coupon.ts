import * as z from "zod";
import { DateSchema } from "./common.ts";

export const CouponSchema = z
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
		title: "Coupon",
		ref: "Coupon",
	});

export const InsertCouponSchema = CouponSchema.omit({
	id: true,
	usedCount: true,
	createdAt: true,
});

export const UpdateCouponSchema = CouponSchema.omit({
	id: true,
	usedCount: true,
	createdAt: true,
}).partial();

export type Coupon = z.infer<typeof CouponSchema>;
export type InsertCoupon = z.infer<typeof InsertCouponSchema>;
export type UpdateCoupon = z.infer<typeof UpdateCouponSchema>;

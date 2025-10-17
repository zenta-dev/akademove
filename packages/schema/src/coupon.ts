import { m } from "@repo/i18n";
import * as z from "zod";
import { DateSchema, DayOfWeekSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

const GeneralRulesSchema = z.object({
	type: z.enum(CONSTANTS.GENERAL_RULE_TYPES).optional(),
	minOrderAmount: z.number().nonnegative().optional(),
	maxDiscountAmount: z.number().nonnegative().optional(),
});
const UserRulesSchema = z.object({
	newUserOnly: z.boolean().optional(),
});
const TimeRulesSchema = z.object({
	allowedDays: z.array(DayOfWeekSchema).optional(),
	allowedHours: z.array(z.number().int().min(0).max(23)).optional(),
});
const CouponRulesSchema = z.object({
	general: GeneralRulesSchema.optional(),
	user: UserRulesSchema.optional(),
	time: TimeRulesSchema.optional(),
});

export const CouponSchema = z
	.object({
		id: z.uuid(),
		name: z
			.string()
			.min(1, m.required_placeholder({ field: m.coupon() }))
			.max(256),
		code: z
			.string()
			.min(1, m.required_placeholder({ field: m.code() }))
			.max(256),
		rules: CouponRulesSchema,
		discountAmount: z.number().optional(),
		discountPercentage: z.number().optional(),
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
	createdById: true,
	createdAt: true,
});

export const UpdateCouponSchema = CouponSchema.omit({
	id: true,
	usedCount: true,
	createdById: true,
	createdAt: true,
}).partial();

export type GeneralRuleType = z.infer<typeof GeneralRulesSchema>["type"];
export type CouponRules = z.infer<typeof CouponRulesSchema>;
export type Coupon = z.infer<typeof CouponSchema>;
export type InsertCoupon = z.infer<typeof InsertCouponSchema>;
export type UpdateCoupon = z.infer<typeof UpdateCouponSchema>;

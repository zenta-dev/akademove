import { m } from "@repo/i18n";
import * as z from "zod";
import {
	DateSchema,
	DayOfWeekSchema,
	type SchemaRegistries,
} from "./common.js";
import { CONSTANTS } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

const GeneralRuleTypeSchema = z.enum(CONSTANTS.GENERAL_RULE_TYPES);
export type GeneralRuleType = z.infer<typeof GeneralRuleTypeSchema>;

const GeneralRulesSchema = z.object({
	type: GeneralRuleTypeSchema.optional(),
	minOrderAmount: z.number().nonnegative().optional(),
	maxDiscountAmount: z.number().nonnegative().optional(),
});
export type GeneralRules = z.infer<typeof GeneralRulesSchema>;

const UserRulesSchema = z.object({
	newUserOnly: z.boolean().optional(),
	perUserLimit: z.number().int().positive().optional(),
});
export type UserRules = z.infer<typeof UserRulesSchema>;

const TimeRulesSchema = z.object({
	allowedDays: z.array(DayOfWeekSchema).optional(),
	allowedHours: z.array(z.number().int().min(0).max(23)).optional(),
});
export type TimeRules = z.infer<typeof TimeRulesSchema>;

const CouponRulesSchema = z.object({
	general: GeneralRulesSchema.optional(),
	user: UserRulesSchema.optional(),
	time: TimeRulesSchema.optional(),
});
export type CouponRules = z.infer<typeof CouponRulesSchema>;

export const CouponSchema = z.object({
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
	merchantId: z.string().uuid().nullable().optional(), // For merchant-specific coupons
	createdById: z.string(),
	createdAt: DateSchema,
});
export type Coupon = z.infer<typeof CouponSchema>;

export const CouponKeySchema = extractSchemaKeysAsEnum(CouponSchema);

export const InsertCouponSchema = CouponSchema.omit({
	id: true,
	usedCount: true,
	createdById: true,
	createdAt: true,
});
export type InsertCoupon = z.infer<typeof InsertCouponSchema>;

export const UpdateCouponSchema = CouponSchema.omit({
	id: true,
	usedCount: true,
	createdById: true,
	createdAt: true,
}).partial();
export type UpdateCoupon = z.infer<typeof UpdateCouponSchema>;

export const ActivateCouponSchema = z.object({
	id: z.string().uuid(),
});
export type ActivateCoupon = z.infer<typeof ActivateCouponSchema>;

export const DeactivateCouponSchema = z.object({
	id: z.string().uuid(),
});
export type DeactivateCoupon = z.infer<typeof DeactivateCouponSchema>;

export const CouponSchemaRegistries = {
	GeneralRuleType: { schema: GeneralRuleTypeSchema, strategy: "output" },
	GeneralRules: { schema: GeneralRulesSchema, strategy: "output" },
	UserRules: { schema: UserRulesSchema, strategy: "output" },
	TimeRules: { schema: TimeRulesSchema, strategy: "output" },
	CouponRules: { schema: CouponRulesSchema, strategy: "output" },
	Coupon: { schema: CouponSchema, strategy: "output" },
	InsertCoupon: { schema: InsertCouponSchema, strategy: "input" },
	UpdateCoupon: { schema: UpdateCouponSchema, strategy: "input" },
	CouponKey: { schema: CouponKeySchema, strategy: "input" },
} satisfies SchemaRegistries;

import { z } from "zod";
import { DateSchema, type SchemaRegistries } from "./common.ts";
import { BADGE_LEVELS, BADGE_TARGET_ROLES, BADGE_TYPES } from "./constants.ts";
import { extractSchemaKeysAsEnum } from "./enum.helper.ts";

export const BadgeCriteriaSchema = z.object({
	minOrders: z.number().int().min(0).optional(),
	minRating: z.number().min(0).max(5).optional(),
	minOnTimeRate: z.number().min(0).max(1).optional(),
	minStreak: z.number().int().min(0).optional(),
	minEarnings: z.number().min(0).optional(),
});
export type BadgeCriteria = z.infer<typeof BadgeCriteriaSchema>;

export const BadgeBenefitsSchema = z.object({
	priorityBoost: z.number().int().min(0).max(100).optional(),
	commissionReduction: z.number().min(0).max(0.5).optional(),
});
export type BadgeBenefits = z.infer<typeof BadgeBenefitsSchema>;

export const BadgeTypeSchema = z.enum(BADGE_TYPES);
export const BadgeLevelSchema = z.enum(BADGE_LEVELS);
export const BadgeTargetRoleSchema = z.enum(BADGE_TARGET_ROLES);

export const BadgeSchema = z.object({
	id: z.uuid(),
	code: z.string().min(1).max(100),
	name: z.string().min(1).max(255),
	description: z.string().min(1),
	type: BadgeTypeSchema,
	level: BadgeLevelSchema,
	targetRole: BadgeTargetRoleSchema,
	icon: z.url().optional(),
	criteria: BadgeCriteriaSchema,
	benefits: BadgeBenefitsSchema.optional(),
	isActive: z.boolean().default(true),
	displayOrder: z.number().int().min(0).default(0),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Badge = z.infer<typeof BadgeSchema>;

export const BadgeKeySchema = extractSchemaKeysAsEnum(BadgeSchema);

export const InsertBadgeSchema = BadgeSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
});
export type InsertBadge = z.infer<typeof InsertBadgeSchema>;

export const UpdateBadgeSchema = BadgeSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
}).partial();
export type UpdateBadge = z.infer<typeof UpdateBadgeSchema>;

export const UserBadgeMetadataSchema = z.object({
	ordersCompleted: z.number().int().min(0).optional(),
	finalRating: z.number().min(0).max(5).optional(),
	streakDays: z.number().int().min(0).optional(),
});
export type UserBadgeMetadata = z.infer<typeof UserBadgeMetadataSchema>;

export const UserBadgeSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	badgeId: z.uuid(),
	earnedAt: DateSchema,
	metadata: UserBadgeMetadataSchema.optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type UserBadge = z.infer<typeof UserBadgeSchema>;

export const UserBadgeKeySchema = extractSchemaKeysAsEnum(UserBadgeSchema);

export const InsertUserBadgeSchema = UserBadgeSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
	earnedAt: true,
});
export type InsertUserBadge = z.infer<typeof InsertUserBadgeSchema>;

export const UpdateUserBadgeSchema = UserBadgeSchema.omit({
	id: true,
	userId: true,
	badgeId: true,
	createdAt: true,
	updatedAt: true,
	earnedAt: true,
}).partial();
export type UpdateUserBadge = z.infer<typeof UpdateUserBadgeSchema>;

export const BadgeSchemaRegistries = {
	BadgeType: { schema: BadgeTypeSchema, strategy: "output" },
	BadgeLevel: { schema: BadgeLevelSchema, strategy: "output" },
	BadgeTargetRole: { schema: BadgeTargetRoleSchema, strategy: "output" },
	BadgeBenefits: { schema: BadgeBenefitsSchema, strategy: "output" },
	Badge: { schema: BadgeSchema, strategy: "output" },
	UserBadgeMetadata: { schema: UserBadgeMetadataSchema, strategy: "output" },
	UserBadge: { schema: UserBadgeSchema, strategy: "output" },
} satisfies SchemaRegistries;

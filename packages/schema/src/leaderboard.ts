import { z } from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { LEADERBOARD_CATEGORIES, LEADERBOARD_PERIODS } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const LeaderboardCategorySchema = z.enum(LEADERBOARD_CATEGORIES);
export type LeaderboardCategory = z.infer<typeof LeaderboardCategorySchema>;

export const LeaderboardPeriodSchema = z.enum(LEADERBOARD_PERIODS);
export type LeaderboardPeriod = z.infer<typeof LeaderboardPeriodSchema>;

export const LeaderboardSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	driverId: z.uuid().optional(),
	merchantId: z.uuid().optional(),
	category: LeaderboardCategorySchema,
	period: LeaderboardPeriodSchema,
	rank: z.coerce.number().int().min(1),
	score: z.coerce.number().int().min(0),
	periodStart: DateSchema,
	periodEnd: DateSchema,
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Leaderboard = z.infer<typeof LeaderboardSchema>;

export const LeaderboardKeySchema = extractSchemaKeysAsEnum(LeaderboardSchema);

export const InsertLeaderboardSchema = LeaderboardSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
});
export type InsertLeaderboard = z.infer<typeof InsertLeaderboardSchema>;

export const UpdateLeaderboardSchema = InsertLeaderboardSchema.partial();
export type UpdateLeaderboard = z.infer<typeof UpdateLeaderboardSchema>;

// Driver info included with leaderboard entry
export const LeaderboardDriverInfoSchema = z.object({
	id: z.uuid(),
	name: z.string(),
	image: z.url().optional(),
	rating: z.coerce.number().min(0).max(5),
});
export type LeaderboardDriverInfo = z.infer<typeof LeaderboardDriverInfoSchema>;

// Leaderboard entry with driver info for display
export const LeaderboardWithDriverSchema = LeaderboardSchema.extend({
	driver: LeaderboardDriverInfoSchema.optional(),
	previousRank: z.coerce.number().int().min(1).optional(),
});
export type LeaderboardWithDriver = z.infer<typeof LeaderboardWithDriverSchema>;

// Query params for leaderboard list
export const LeaderboardQuerySchema = z.object({
	category: LeaderboardCategorySchema.optional(),
	period: LeaderboardPeriodSchema.optional(),
	limit: z.coerce.number().int().min(1).max(100).optional(),
	cursor: z.string().optional(),
	page: z.coerce.number().int().min(1).optional(),
	sortBy: z.string().optional(),
	order: z.enum(["asc", "desc"]).optional(),
	includeDriver: z.coerce.boolean().optional(),
});
export type LeaderboardQuery = z.infer<typeof LeaderboardQuerySchema>;

export const LeaderboardSchemaRegistries = {
	LeaderboardCategory: {
		schema: LeaderboardCategorySchema,
		strategy: "output",
	},
	LeaderboardPeriod: { schema: LeaderboardPeriodSchema, strategy: "output" },
	Leaderboard: { schema: LeaderboardSchema, strategy: "output" },
	LeaderboardWithDriver: {
		schema: LeaderboardWithDriverSchema,
		strategy: "output",
	},
	LeaderboardDriverInfo: {
		schema: LeaderboardDriverInfoSchema,
		strategy: "output",
	},
	LeaderboardQuery: { schema: LeaderboardQuerySchema, strategy: "input" },
	InsertLeaderboard: { schema: InsertLeaderboardSchema, strategy: "input" },
	UpdateLeaderboard: { schema: UpdateLeaderboardSchema, strategy: "input" },
} satisfies SchemaRegistries;

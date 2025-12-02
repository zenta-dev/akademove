import { z } from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { LEADERBOARD_CATEGORIES, LEADERBOARD_PERIODS } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const LeaderboardSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	driverId: z.uuid().optional(),
	merchantId: z.uuid().optional(),
	category: z.enum(LEADERBOARD_CATEGORIES),
	period: z.enum(LEADERBOARD_PERIODS),
	rank: z.number().int().min(1),
	score: z.number().int().min(0),
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

export const LeaderboardSchemaRegistries = {
	Leaderboard: { schema: LeaderboardSchema, strategy: "output" },
	InsertLeaderboard: { schema: InsertLeaderboardSchema, strategy: "input" },
	UpdateLeaderboard: { schema: UpdateLeaderboardSchema, strategy: "input" },
} satisfies SchemaRegistries;

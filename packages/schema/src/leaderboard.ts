import { z } from "zod";
import { LEADERBOARD_CATEGORIES, LEADERBOARD_PERIODS } from "./constants.ts";
import { extractSchemaKeysAsEnum } from "./enum.helper.ts";

export const LeaderboardSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	driverId: z.uuid().optional(),
	merchantId: z.uuid().optional(),
	category: z.enum(LEADERBOARD_CATEGORIES),
	period: z.enum(LEADERBOARD_PERIODS),
	rank: z.number().int().min(1),
	score: z.number().int().min(0),
	periodStart: z.date(),
	periodEnd: z.date(),
	createdAt: z.date(),
	updatedAt: z.date(),
});
export type Leaderboard = z.infer<typeof LeaderboardSchema>;

export const LeaderboardKeySchema = extractSchemaKeysAsEnum(LeaderboardSchema);

export const InsertLeaderboardSchema = LeaderboardSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
	calculatedAt: true,
});
export type InsertLeaderboard = z.infer<typeof InsertLeaderboardSchema>;

export const UpdateLeaderboardSchema = InsertLeaderboardSchema.partial();
export type UpdateLeaderboard = z.infer<typeof UpdateLeaderboardSchema>;

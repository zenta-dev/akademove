import type { ExecutionContext } from "@cloudflare/workers-types";
import { getServices } from "@/core/factory";
import { logger } from "@/utils/logger";
import { LeaderboardCalculationService } from "./services/leaderboard-calculation-service";

/**
 * Scheduled handler for leaderboard updates
 * Called by Cloudflare Workers cron trigger
 */
export async function handleLeaderboardCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info(
			{},
			"[LeaderboardCron] Starting scheduled leaderboard calculation",
		);

		const svc = getServices();
		const leaderboardService = new LeaderboardCalculationService(svc.db);

		// Calculate all leaderboards (all periods and categories)
		await leaderboardService.calculateAllLeaderboards();

		logger.info(
			{},
			"[LeaderboardCron] Completed scheduled leaderboard calculation",
		);

		return new Response("Leaderboard calculation completed", { status: 200 });
	} catch (error) {
		logger.error(
			{ error },
			"[LeaderboardCron] Failed to calculate leaderboards",
		);
		return new Response("Leaderboard calculation failed", { status: 500 });
	}
}

import { m } from "@repo/i18n";
import { createORPCRouter } from "@/core/router/orpc";
import { LeaderboardSpec } from "./leaderboard-spec";

const { priv } = createORPCRouter(LeaderboardSpec);

export const LeaderboardHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.leaderboard.list(query);
		return {
			status: 200,
			body: {
				message: m.server_leaderboards_retrieved(),
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params, query } }) => {
		const result = await context.repo.leaderboard.getById(params.id, {
			includeDriver: query?.includeDriver,
		});

		return {
			status: 200,
			body: {
				message: m.server_leaderboard_retrieved(),
				data: result,
			},
		};
	}),
	me: priv.me.handler(async ({ context, input: { query } }) => {
		const result = await context.repo.leaderboard.getMyRankings(
			context.user.id,
			{
				category: query?.category,
				period: query?.period,
			},
		);

		return {
			status: 200,
			body: {
				message: m.server_leaderboards_retrieved(),
				data: result,
			},
		};
	}),
});

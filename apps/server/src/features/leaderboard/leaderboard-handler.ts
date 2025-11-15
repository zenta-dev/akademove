import { createORPCRouter } from "@/core/router/orpc";
import { LeaderboardSpec } from "./leaderboard-spec";

const { priv } = createORPCRouter(LeaderboardSpec);

export const LeaderboardHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.leaderboard.list(query);
		return {
			status: 200,
			body: {
				message: "Successfully retrieved leaderboards data",
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.leaderboard.get(params.id);

		return {
			status: 200,
			body: {
				message: "Successfully retrieved leaderboard data",
				data: result,
			},
		};
	}),
});

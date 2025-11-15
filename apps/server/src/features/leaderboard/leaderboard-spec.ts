import { oc } from "@orpc/contract";
import { LeaderboardSchema } from "@repo/schema/leaderboard";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const LeaderboardSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.LEADERBOARD],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(LeaderboardSchema),
				"Successfully retrieved leaderboards data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.LEADERBOARD],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(
				LeaderboardSchema,
				"Successfully retrieved leaderboard data",
			),
		),
};

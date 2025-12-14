import { oc } from "@orpc/contract";
import {
	LeaderboardQuerySchema,
	LeaderboardWithDriverSchema,
} from "@repo/schema/leaderboard";
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
		.input(z.object({ query: LeaderboardQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(LeaderboardWithDriverSchema),
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
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				query: z.object({ includeDriver: z.coerce.boolean().optional() }),
			}),
		)
		.output(
			createSuccesSchema(
				LeaderboardWithDriverSchema,
				"Successfully retrieved leaderboard data",
			),
		),
	me: oc
		.route({
			tags: [FEATURE_TAGS.LEADERBOARD],
			method: "GET",
			path: "/me",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				query: z.object({
					category: LeaderboardQuerySchema.shape.category,
					period: LeaderboardQuerySchema.shape.period,
				}),
			}),
		)
		.output(
			createSuccesSchema(
				z.array(LeaderboardWithDriverSchema),
				"Successfully retrieved your rankings",
			),
		),
};

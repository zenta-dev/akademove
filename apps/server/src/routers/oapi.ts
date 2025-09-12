import { describeRoute, resolver } from "hono-openapi";
import * as z from "zod";

const responses = Object.freeze({
	index: {
		200: {
			description: "Server is running",
			content: {
				"application/json": {
					vSchema: z.object({
						success: z.literal(true),
						message: z.string(),
					}),
				},
			},
		},
	},
});

export const OAPISpecs = Object.freeze({
	index: {
		responses: responses.index,
		route: describeRoute({
			responses: {
				200: {
					description: responses.index[200].description,
					content: {
						"application/json": {
							schema: resolver(
								responses.index[200].content["application/json"].vSchema,
							),
						},
					},
				},
			},
		}),
	},
} as const);

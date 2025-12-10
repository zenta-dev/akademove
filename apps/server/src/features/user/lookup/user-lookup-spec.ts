import { oc } from "@orpc/contract";
import {
	UserLookupQuerySchema,
	UserLookupResultSchema,
} from "@repo/schema/user";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const UserLookupSpec = {
	byPhone: oc
		.route({
			tags: [FEATURE_TAGS.USER],
			method: "GET",
			path: "/phone",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description:
				"Lookup user by phone number for wallet transfer. Returns minimal user info with masked phone number for privacy.",
		})
		.input(
			z.object({
				query: UserLookupQuerySchema,
			}),
		)
		.output(
			createSuccesSchema(
				UserLookupResultSchema.nullable(),
				"User lookup completed",
			),
		),
};

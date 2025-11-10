import { oc } from "@orpc/contract";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { TransactionSchema } from "@repo/schema/transaction";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const TransactionSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.TRANSACTION],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(TransactionSchema),
				"Successfully retrieved transactions data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.TRANSACTION],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(
				TransactionSchema,
				"Successfully retrieved transaction data",
			),
		),
};

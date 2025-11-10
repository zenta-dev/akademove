import { oc } from "@orpc/contract";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const FCMSpec = {
	// list: oc
	// 	.route({
	// 		tags: [FEATURE_TAGS.FCM],
	// 		method: "GET",
	// 		path: "/",
	// 		inputStructure: "detailed",
	// 		outputStructure: "detailed",
	// 	})
	// 	.input(z.object({ query: UnifiedPaginationQuerySchema }))
	// 	.output(
	// 		createSuccesSchema(
	// 			z.array(FCMNotificationLogSchema),
	// 			"List notification success",
	// 		),
	// 	),
	subscribeToTopic: oc
		.route({
			tags: [FEATURE_TAGS.FCM],
			method: "POST",
			path: "/subscribe",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({ body: z.object({ topic: z.string(), token: z.string() }) }),
		)
		.output(
			createSuccesSchema(
				z.object({
					successCount: z.number(),
					failureCount: z.number(),
					errors: z.array(z.any()),
				}),
				"Subscribe to topic success",
			),
		),
	unsubscribeToTopic: oc
		.route({
			tags: [FEATURE_TAGS.FCM],
			method: "POST",
			path: "/unsubscribe",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({ body: z.object({ topic: z.string(), token: z.string() }) }),
		)
		.output(
			createSuccesSchema(
				z.object({
					successCount: z.number(),
					failureCount: z.number(),
					errors: z.array(z.any()),
				}),
				"Unsubscribe to topic success",
			),
		),
	save: oc
		.route({
			tags: [FEATURE_TAGS.FCM],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: z.object({ token: z.string() }) }))
		.output(
			createSuccesSchema(
				z.object({
					ok: z.boolean(),
				}),
				"Save FCM token success",
			),
		),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.FCM],
			method: "DELETE",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: z.object({ token: z.string() }) }))
		.output(
			createSuccesSchema(
				z.object({
					ok: z.boolean(),
				}),
				"Save FCM token success",
			),
		),
};

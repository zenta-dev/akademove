import { oc } from "@orpc/contract";
import { UserNotificationSchema } from "@repo/schema/notification";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

const ListNotificationQuerySchema = UnifiedPaginationQuerySchema.extend({
	read: z.enum(["all", "unread", "readed"]),
});

export type ListNotificationQuery = z.infer<typeof ListNotificationQuerySchema>;

export const FCMSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.FCM],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: ListNotificationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(UserNotificationSchema),
				"List notification success",
			),
		),
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
	saveToken: oc
		.route({
			tags: [FEATURE_TAGS.FCM],
			method: "POST",
			path: "/token",
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
	removeToken: oc
		.route({
			tags: [FEATURE_TAGS.FCM],
			method: "DELETE",
			path: "/token/{token}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ token: z.string() }) }))
		.output(
			createSuccesSchema(
				z.object({
					ok: z.boolean(),
				}),
				"Delete FCM token success",
			),
		),
};

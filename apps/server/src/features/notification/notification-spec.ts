import { oc } from "@orpc/contract";
import { UserNotificationSchema } from "@repo/schema/notification";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

const ListNotificationQuerySchema = UnifiedPaginationQuerySchema.safeExtend({
	read: z.enum(["all", "unread", "readed"]),
});

export type ListNotificationQuery = z.infer<typeof ListNotificationQuerySchema>;

export const NotificationSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.NOTIFICATION],
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
	getUnreadCount: oc
		.route({
			tags: [FEATURE_TAGS.NOTIFICATION],
			method: "GET",
			path: "/unread-count",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({}))
		.output(
			createSuccesSchema(
				z.object({ count: z.number() }),
				"Get unread count success",
			),
		),
	markAsRead: oc
		.route({
			tags: [FEATURE_TAGS.NOTIFICATION],
			method: "PATCH",
			path: "/{id}/read",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string().uuid() }) }))
		.output(createSuccesSchema(UserNotificationSchema, "Mark as read success")),
	markAllAsRead: oc
		.route({
			tags: [FEATURE_TAGS.NOTIFICATION],
			method: "PATCH",
			path: "/read-all",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({}))
		.output(
			createSuccesSchema(
				z.object({ count: z.number() }),
				"Mark all as read success",
			),
		),
	delete: oc
		.route({
			tags: [FEATURE_TAGS.NOTIFICATION],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string().uuid() }) }))
		.output(
			createSuccesSchema(z.object({ ok: z.boolean() }), "Delete success"),
		),
	subscribeToTopic: oc
		.route({
			tags: [FEATURE_TAGS.NOTIFICATION],
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
					errors: z.any(),
				}),
				"Subscribe to topic success",
			),
		),
	unsubscribeToTopic: oc
		.route({
			tags: [FEATURE_TAGS.NOTIFICATION],
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
					errors: z.any(),
				}),
				"Unsubscribe to topic success",
			),
		),
	saveToken: oc
		.route({
			tags: [FEATURE_TAGS.NOTIFICATION],
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
			tags: [FEATURE_TAGS.NOTIFICATION],
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

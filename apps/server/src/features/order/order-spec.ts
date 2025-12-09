import { oc } from "@orpc/contract";
import {
	InsertOrderChatMessageSchema,
	OrderChatMessageListQuerySchema,
	OrderChatMessageSchema,
} from "@repo/schema/chat";
import {
	FlatEstimateOrderSchema,
	OrderSchema,
	OrderStatusSchema,
	OrderSummarySchema,
	OrderTypeSchema,
	PlaceOrderResponseSchema,
	PlaceOrderSchema,
	PlaceScheduledOrderResponseSchema,
	PlaceScheduledOrderSchema,
	UpdateOrderSchema,
	UpdateScheduledOrderSchema,
} from "@repo/schema/order";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

const OrderListQuerySchema = UnifiedPaginationQuerySchema.safeExtend({
	statuses: z
		.preprocess((val) => {
			if (val === undefined) return undefined;

			if (Array.isArray(val)) return val;

			if (typeof val === "string") {
				try {
					const parsed = JSON.parse(val);
					if (Array.isArray(parsed)) return parsed;
				} catch (_) {}
				return [val];
			}
			return val;
		}, z.array(OrderStatusSchema).optional())
		.optional(),
	type: z
		.preprocess((val) => {
			if (val === undefined || val === "") return undefined;
			return val;
		}, OrderTypeSchema.optional())
		.optional(),
	startDate: z.coerce.date().optional(),
	endDate: z.coerce.date().optional(),
});

export type OrderListQuery = z.infer<typeof OrderListQuerySchema>;

export const OrderSortBySchema = z.enum(["id"]);

export const OrderSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: OrderListQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(OrderSchema),
				"Successfully retrieved orders data",
			),
		),
	estimate: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "GET",
			path: "/estimate",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				query: FlatEstimateOrderSchema,
			}),
		)
		.output(
			createSuccesSchema(OrderSummarySchema, "Successfully estimate order"),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(OrderSchema, "Successfully retrieved order data"),
		),
	placeOrder: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: PlaceOrderSchema,
			}),
		)
		.output(
			createSuccesSchema(
				PlaceOrderResponseSchema,
				"Order created successfully",
			),
		),
	update: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateOrderSchema,
			}),
		)
		.output(createSuccesSchema(OrderSchema, "Order updated successfully")),
	cancel: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/{id}/cancel",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: z.object({
					reason: z.string().optional(),
				}),
			}),
		)
		.output(createSuccesSchema(OrderSchema, "Order cancelled successfully")),
	listMessages: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "GET",
			path: "/{id}/messages",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				query: OrderChatMessageListQuerySchema.omit({ orderId: true }),
			}),
		)
		.output(
			createSuccesSchema(
				z.object({
					rows: z.array(OrderChatMessageSchema),
					hasMore: z.boolean(),
					nextCursor: z.uuid().optional(),
				}),
				"Successfully retrieved chat messages",
			),
		),
	sendMessage: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/{id}/messages",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: InsertOrderChatMessageSchema.omit({ orderId: true }),
			}),
		)
		.output(
			createSuccesSchema(OrderChatMessageSchema, "Message sent successfully"),
		),
	uploadDeliveryProof: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/{id}/delivery-proof",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: z.object({
					file: z.instanceof(File),
				}),
			}),
		)
		.output(
			createSuccesSchema(
				z.object({ url: z.string().url() }),
				"Proof uploaded successfully",
			),
		),
	verifyDeliveryOTP: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/{id}/verify-otp",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: z.object({
					otp: z.string().length(6),
				}),
			}),
		)
		.output(
			createSuccesSchema(z.object({ verified: z.boolean() }), "OTP verified"),
		),

	// Scheduled order endpoints
	placeScheduledOrder: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/scheduled",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: PlaceScheduledOrderSchema,
			}),
		)
		.output(
			createSuccesSchema(
				PlaceScheduledOrderResponseSchema,
				"Scheduled order created successfully",
			),
		),
	listScheduledOrders: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "GET",
			path: "/scheduled",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: OrderListQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(OrderSchema),
				"Successfully retrieved scheduled orders",
			),
		),
	updateScheduledOrder: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "PUT",
			path: "/scheduled/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: UpdateScheduledOrderSchema,
			}),
		)
		.output(
			createSuccesSchema(OrderSchema, "Scheduled order updated successfully"),
		),
	cancelScheduledOrder: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/scheduled/{id}/cancel",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: z.object({
					reason: z.string().optional(),
				}),
			}),
		)
		.output(
			createSuccesSchema(OrderSchema, "Scheduled order cancelled successfully"),
		),
};

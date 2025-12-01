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
	PlaceOrderResponseSchema,
	PlaceOrderSchema,
	UpdateOrderSchema,
} from "@repo/schema/order";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

const _UnifiedPaginationQuerySchema = UnifiedPaginationQuerySchema.safeExtend({
	statuses: z
		.preprocess((val) => {
			console.log("STATUSES => ", val);
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
});

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
		.input(z.object({ query: _UnifiedPaginationQuerySchema }))
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
				params: z.object({ id: z.string().uuid() }),
				query: OrderChatMessageListQuerySchema.omit({ orderId: true }),
			}),
		)
		.output(
			createSuccesSchema(
				z.object({
					rows: z.array(OrderChatMessageSchema),
					hasMore: z.boolean(),
					nextCursor: z.string().uuid().optional(),
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
				params: z.object({ id: z.string().uuid() }),
				body: InsertOrderChatMessageSchema.omit({ orderId: true }),
			}),
		)
		.output(
			createSuccesSchema(OrderChatMessageSchema, "Message sent successfully"),
		),
};

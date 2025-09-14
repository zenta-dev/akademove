import {
	createSuccessResponseSchema,
	EmptySchema,
	listifySchema,
} from "@repo/schema/common";
import { OrderSchema } from "@repo/schema/order";
import { describeRoute, resolver } from "hono-openapi";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const OrderSpec = Object.freeze({
	list: describeRoute({
		operationId: "getAllOrder",
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "List of order",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(OrderSchema)).meta({
								title: "GetAllOrderSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.ORDER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		operationId: "getOrderById",
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "Get order by id success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(OrderSchema).meta({
								title: "GetOrderByIdSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.ORDER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		operationId: "createOrder",
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "Create order success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(OrderSchema).meta({
								title: "CreateOrderSuccessResponse",
							}),
						),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		operationId: "updateOrder",
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "Update order success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(OrderSchema).meta({
								title: "UpdateOrderSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.ORDER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		operationId: "deleteOrder",
		tags: [FEATURE_TAGS.ORDER],
		responses: {
			200: {
				description: "Delete order success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(EmptySchema).meta({
								title: "DeleteOrderSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.ORDER),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);

import { oc } from "@orpc/contract";
import {
	InsertOrderSchema,
	OrderSchema,
	UpdateOrderSchema,
} from "@repo/schema/order";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const OrderSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(OrderSchema),
				"Successfully retrieved orders data",
			),
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
	create: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertOrderSchema }))
		.output(createSuccesSchema(OrderSchema, "Order created successfully")),
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
	remove: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Order deleted successfully")),
};

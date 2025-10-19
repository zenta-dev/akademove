import { oc } from "@orpc/contract";
import {
	InsertOrderSchema,
	OrderSchema,
	OrderStatusSchema,
	UpdateOrderSchema,
} from "@repo/schema/order";
import {
	CursorPaginationQuerySchema,
	OffsetPaginationQuerySchema,
} from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

const UnifiedPaginationQuerySchema = z
	.object({
		...CursorPaginationQuerySchema.shape,
		...OffsetPaginationQuerySchema.shape,
		query: z.string().optional(),
		sortBy: z.string().optional(),
		order: z.enum(["asc", "desc"]).optional().default("desc"),
		statuses: z.preprocess((val) => {
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
		}, z.array(OrderStatusSchema).optional()),
	})
	.refine((data) => !(data.cursor && data.page), {
		message: "Cannot use both cursor and page at the same time.",
	});

export const OrderSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.ORDER],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				query: UnifiedPaginationQuerySchema,
			}),
		)
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
	// remove: oc
	// 	.route({
	// 		tags: [FEATURE_TAGS.ORDER],
	// 		method: "DELETE",
	// 		path: "/{id}",
	// 		inputStructure: "detailed",
	// 		outputStructure: "detailed",
	// 	})
	// 	.input(z.object({ params: z.object({ id: z.string() }) }))
	// 	.output(createSuccesSchema(z.null(), "Order deleted successfully")),
};

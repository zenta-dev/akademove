import { oc } from "@orpc/contract";
import { CONSTANTS } from "@repo/schema/constants";
import { OrderSchema } from "@repo/schema/order";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";
import { toOAPIRequestBody } from "@/utils/oapi";

const OrderRejectionReasonSchema = z.enum(CONSTANTS.ORDER_REJECTION_REASONS);
const RejectOrderBodySchema = z.object({
	reason: OrderRejectionReasonSchema,
	note: z.string().optional(),
});

export const MerchantOrderSpec = {
	accept: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/orders/{id}/accept",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({
					merchantId: z.string(),
					id: z.string(),
				}),
			}),
		)
		.output(createSuccesSchema(OrderSchema, "Order accepted successfully")),

	reject: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/orders/{id}/reject",
			inputStructure: "detailed",
			outputStructure: "detailed",
			spec: (spec) => ({
				...spec,
				...toOAPIRequestBody(RejectOrderBodySchema),
			}),
		})
		.input(
			z.object({
				params: z.object({
					merchantId: z.string(),
					id: z.string(),
				}),
				body: RejectOrderBodySchema,
			}),
		)
		.output(createSuccesSchema(OrderSchema, "Order rejected successfully")),

	markPreparing: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "PUT",
			path: "/orders/{id}/preparing",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({
					merchantId: z.string(),
					id: z.string(),
				}),
			}),
		)
		.output(
			createSuccesSchema(OrderSchema, "Order marked as preparing successfully"),
		),

	markReady: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "PUT",
			path: "/orders/{id}/ready",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({
					merchantId: z.string(),
					id: z.string(),
				}),
			}),
		)
		.output(
			createSuccesSchema(
				OrderSchema,
				"Order marked as ready for pickup successfully",
			),
		),
};

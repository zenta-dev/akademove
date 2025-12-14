import { oc } from "@orpc/contract";
import {
	CouponSchema,
	InsertCouponSchema,
	UpdateCouponSchema,
} from "@repo/schema/coupon";
import { OrderTypeSchema } from "@repo/schema/order";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const CouponSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(CouponSchema),
				"Successfully retrieved coupons data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(CouponSchema, "Successfully retrieved coupon data"),
		),
	validate: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "POST",
			path: "/validate",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: z.object({
					code: z.string(),
					orderAmount: z.coerce.number(),
					serviceType: OrderTypeSchema.optional(),
					merchantId: z.uuid().optional(),
				}),
			}),
		)
		.output(
			createSuccesSchema(
				z.object({
					valid: z.boolean(),
					coupon: CouponSchema.optional(),
					discountAmount: z.coerce.number(),
					finalAmount: z.coerce.number(),
					reason: z.string().optional(),
				}),
				"Coupon validated successfully",
			),
		),
	getEligibleCoupons: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "POST",
			path: "/eligible",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: z.object({
					serviceType: OrderTypeSchema,
					totalAmount: z.coerce.number().positive(),
					merchantId: z.uuid().optional(),
				}),
			}),
		)
		.output(
			createSuccesSchema(
				z.object({
					coupons: z.array(CouponSchema),
					bestCoupon: CouponSchema.nullable(),
					bestDiscountAmount: z.coerce.number(),
				}),
				"Successfully retrieved eligible coupons",
			),
		),
	getAvailableCoupons: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "GET",
			path: "/available",
			inputStructure: "detailed",
			outputStructure: "detailed",
			description:
				"Get all available coupons for browsing (active and within validity period)",
		})
		.input(
			z.object({
				query: z.object({
					serviceType: OrderTypeSchema.optional(),
				}),
			}),
		)
		.output(
			createSuccesSchema(
				z.array(CouponSchema),
				"Successfully retrieved available coupons",
			),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertCouponSchema }))
		.output(createSuccesSchema(CouponSchema, "Coupon created successfully")),
	update: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateCouponSchema,
			}),
		)
		.output(createSuccesSchema(CouponSchema, "Coupon updated successfully")),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Coupon deleted successfully")),
	activate: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "POST",
			path: "/{id}/activate",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(CouponSchema, "Coupon activated successfully")),
	deactivate: oc
		.route({
			tags: [FEATURE_TAGS.COUPON],
			method: "POST",
			path: "/{id}/deactivate",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(CouponSchema, "Coupon deactivated successfully"),
		),
};

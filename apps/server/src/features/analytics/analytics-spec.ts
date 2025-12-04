import { oc } from "@orpc/contract";
import * as z from "zod";
import { FEATURE_TAGS } from "@/core/constants";

const ExportQuerySchema = z.object({
	startDate: z.coerce.date(),
	endDate: z.coerce.date(),
});

export const AnalyticsSpec = {
	exportDriverAnalytics: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "GET",
			path: "/driver/{driverId}/export",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ driverId: z.string() }),
				query: ExportQuerySchema,
			}),
		)
		.output(z.string()),
	exportMerchantAnalytics: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/merchant/{merchantId}/export",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ merchantId: z.string() }),
				query: ExportQuerySchema,
			}),
		)
		.output(z.string()),
	exportOperatorAnalytics: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "GET",
			path: "/operator/export",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: ExportQuerySchema }))
		.output(z.string()),
};

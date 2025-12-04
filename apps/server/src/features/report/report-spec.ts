import { oc } from "@orpc/contract";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import {
	DismissReportSchema,
	InsertReportSchema,
	ReportSchema,
	ResolveReportSchema,
	StartInvestigationSchema,
	UpdateReportSchema,
} from "@repo/schema/report";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const ReportSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.REPORT],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UnifiedPaginationQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(ReportSchema),
				"Successfully retrieved reports data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.REPORT],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(ReportSchema, "Successfully retrieved report data"),
		),
	create: oc
		.route({
			tags: [FEATURE_TAGS.REPORT],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertReportSchema }))
		.output(createSuccesSchema(ReportSchema, "Report created successfully")),
	update: oc
		.route({
			tags: [FEATURE_TAGS.REPORT],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateReportSchema,
			}),
		)
		.output(createSuccesSchema(ReportSchema, "Report updated successfully")),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.REPORT],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "Report deleted successfully")),
	startInvestigation: oc
		.route({
			tags: [FEATURE_TAGS.REPORT],
			method: "POST",
			path: "/{id}/start-investigation",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: StartInvestigationSchema,
			}),
		)
		.output(
			createSuccesSchema(ReportSchema, "Investigation started successfully"),
		),
	resolve: oc
		.route({
			tags: [FEATURE_TAGS.REPORT],
			method: "POST",
			path: "/{id}/resolve",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: ResolveReportSchema,
			}),
		)
		.output(createSuccesSchema(ReportSchema, "Report resolved successfully")),
	dismiss: oc
		.route({
			tags: [FEATURE_TAGS.REPORT],
			method: "POST",
			path: "/{id}/dismiss",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: DismissReportSchema,
			}),
		)
		.output(createSuccesSchema(ReportSchema, "Report dismissed successfully")),
};

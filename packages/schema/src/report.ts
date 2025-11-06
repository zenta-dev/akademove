import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

export const ReportCategorySchema = z
	.enum(CONSTANTS.REPORT_CATEGORIES)
	.meta({ title: "ReportCategory" });

export const ReportStatusSchema = z
	.enum(CONSTANTS.REPORT_STATUS)
	.meta({ title: "ReportStatus" });

export const ReportSchema = z
	.object({
		id: z.uuid(),
		orderId: z.uuid().optional(),
		reporterId: z.uuid(),
		targetUserId: z.uuid(),
		category: ReportCategorySchema,
		description: z.string(),
		evidenceUrl: z.string().optional(),
		status: ReportStatusSchema,
		handledById: z.string().optional(),
		resolution: z.string().optional(),
		reportedAt: DateSchema,
		resolvedAt: DateSchema.optional(),
	})
	.meta({ title: "Report" });

export const InsertReportSchema = ReportSchema.omit({
	id: true,
	reportedAt: true,
	resolvedAt: true,
}).meta({ title: "InsertReportRequest" });

export const UpdateReportSchema = ReportSchema.omit({
	id: true,
	reportedAt: true,
	resolvedAt: true,
})
	.partial()
	.meta({ title: "UpdateReportRequest" });

export type ReportCategory = z.infer<typeof ReportCategorySchema>;
export type ReportStatus = z.infer<typeof ReportStatusSchema>;
export type Report = z.infer<typeof ReportSchema>;
export type InsertReport = z.infer<typeof InsertReportSchema>;
export type UpdateReport = z.infer<typeof UpdateReportSchema>;

export const ReportSchemaRegistries = {
	ReportCategory: { schema: ReportCategorySchema, strategy: "output" },
	ReportStatus: { schema: ReportStatusSchema, strategy: "output" },
	Report: { schema: ReportSchema, strategy: "output" },
	InsertReport: { schema: InsertReportSchema, strategy: "input" },
	UpdateReport: { schema: UpdateReportSchema, strategy: "input" },
} satisfies SchemaRegistries;

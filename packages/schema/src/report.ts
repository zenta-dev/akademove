import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { CONSTANTS } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const ReportCategorySchema = z.enum(CONSTANTS.REPORT_CATEGORIES);
export type ReportCategory = z.infer<typeof ReportCategorySchema>;

export const ReportStatusSchema = z.enum(CONSTANTS.REPORT_STATUS);
export type ReportStatus = z.infer<typeof ReportStatusSchema>;

export const ReportSchema = z.object({
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
});
export type Report = z.infer<typeof ReportSchema>;

export const ReportKeySchema = extractSchemaKeysAsEnum(ReportSchema);

export const InsertReportSchema = ReportSchema.omit({
	id: true,
	reportedAt: true,
	resolvedAt: true,
});
export type InsertReport = z.infer<typeof InsertReportSchema>;

export const UpdateReportSchema = ReportSchema.omit({
	id: true,
	reportedAt: true,
	resolvedAt: true,
}).partial();
export type UpdateReport = z.infer<typeof UpdateReportSchema>;

export const StartInvestigationSchema = z.object({
	notes: z.string().min(1, "Investigation notes are required"),
});
export type StartInvestigation = z.infer<typeof StartInvestigationSchema>;

export const ResolveReportSchema = z.object({
	resolution: z.string().min(1, "Resolution description is required"),
});
export type ResolveReport = z.infer<typeof ResolveReportSchema>;

export const DismissReportSchema = z.object({
	reason: z.string().min(1, "Dismissal reason is required"),
});
export type DismissReport = z.infer<typeof DismissReportSchema>;

export const ReportSchemaRegistries = {
	ReportCategory: { schema: ReportCategorySchema, strategy: "output" },
	ReportStatus: { schema: ReportStatusSchema, strategy: "output" },
	Report: { schema: ReportSchema, strategy: "output" },
	InsertReport: { schema: InsertReportSchema, strategy: "input" },
	UpdateReport: { schema: UpdateReportSchema, strategy: "input" },
	ReportKey: { schema: ReportKeySchema, strategy: "input" },
	StartInvestigation: { schema: StartInvestigationSchema, strategy: "input" },
	ResolveReport: { schema: ResolveReportSchema, strategy: "input" },
	DismissReport: { schema: DismissReportSchema, strategy: "input" },
} satisfies SchemaRegistries;

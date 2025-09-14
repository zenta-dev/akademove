import * as z from "zod";
import { DateSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

export const ReportCategorySchema = z.enum(CONSTANTS.REPORT_CATEGORIES);

export const ReportStatusSchema = z.enum(CONSTANTS.REPORT_STATUS);

export const ReportSchema = z.object({
	id: z.uuid(),
	orderId: z.uuid().nullable(),
	reporterId: z.uuid(),
	targetUserId: z.uuid(),
	category: ReportCategorySchema,
	description: z.string(),
	evidenceUrl: z.string(),
	status: ReportStatusSchema.default("pending"),
	handleById: z.string().nullable(),
	resolution: z.string().nullable(),
	reportedAt: DateSchema,
	resolvedAt: DateSchema.nullable(),
});

export const InsertReportSchema = ReportSchema.omit({
	id: true,
	reportedAt: true,
	resolvedAt: true,
});

export const UpdateReportSchema = ReportSchema.omit({
	id: true,
	reportedAt: true,
	resolvedAt: true,
});

export type ReportCategory = z.infer<typeof ReportCategorySchema>;
export type ReportStatus = z.infer<typeof ReportStatusSchema>;
export type Report = z.infer<typeof ReportSchema>;
export type InsertReport = z.infer<typeof InsertReportSchema>;
export type UpdateReport = z.infer<typeof UpdateReportSchema>;

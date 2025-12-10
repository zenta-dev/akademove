import { oc } from "@orpc/contract";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { z } from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

const AuditLogSchema = z.object({
	id: z.coerce.number().int().nonnegative(),
	tableName: z.enum([
		"configurations",
		"contact",
		"coupon",
		"report",
		"user",
		"wallet",
	]),
	recordId: z.string(),
	operation: z.enum(["INSERT", "UPDATE", "DELETE"]),
	oldData: z.any().optional(),
	newData: z.any().optional(),
	updatedById: z.string().optional(),
	ipAddress: z.string().optional(),
	userAgent: z.string().optional(),
	sessionId: z.string().optional(),
	reason: z.string().optional(),
	updatedAt: z.date(),
});

export type AuditLog = z.infer<typeof AuditLogSchema>;

const AuditLogFilterSchema = UnifiedPaginationQuerySchema.safeExtend({
	tableName: z
		.enum(["configurations", "contact", "coupon", "report", "user", "wallet"])
		.optional(),
	recordId: z.string().optional(),
	operation: z.enum(["INSERT", "UPDATE", "DELETE"]).optional(),
	updatedById: z.string().optional(),
	startDate: z.coerce.date().optional(),
	endDate: z.coerce.date().optional(),
});

export const AuditSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.CONFIGURATION],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: AuditLogFilterSchema }))
		.output(
			createSuccesSchema(z.array(AuditLogSchema), "Audit logs retrieved"),
		),
};

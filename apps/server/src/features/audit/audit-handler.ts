import { createORPCRouter } from "@/core/router/orpc";
import { AuditSpec } from "./audit-spec";

const { priv } = createORPCRouter(AuditSpec);

export const AuditHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows } = await context.repo.audit.list({
			tableName: query.tableName,
			recordId: query.recordId,
			operation: query.operation,
			updatedById: query.updatedById,
			startDate: query.startDate,
			endDate: query.endDate,
			page: query.page,
			limit: query.limit,
			sortBy: query.sortBy,
			order: query.order,
		});

		return {
			status: 200,
			body: {
				message: "Audit logs retrieved",
				data: rows,
			},
		};
	}),
});

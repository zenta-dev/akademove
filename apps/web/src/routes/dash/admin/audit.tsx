import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { createFileRoute, redirect } from "@tanstack/react-router";
import { z } from "zod";
import { AuditLogTable } from "@/components/tables/audit-log/table";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";

const AuditSearchSchema = UnifiedPaginationQuerySchema.safeExtend({
	tableName: z
		.enum(["configurations", "contact", "coupon", "report", "user", "wallet"])
		.optional(),
	recordId: z.string().optional(),
	operation: z.enum(["INSERT", "UPDATE", "DELETE"]).optional(),
	updatedById: z.string().optional(),
	startDate: z.coerce.date().optional(),
	endDate: z.coerce.date().optional(),
});

export const Route = createFileRoute("/dash/admin/audit")({
	validateSearch: (values) => {
		const search = AuditSearchSchema.parse(values);
		if (!values.limit) {
			return { ...search, page: search.page ?? 1, limit: 50 };
		}
		return search;
	},
	head: () => ({ meta: [{ title: m.audit_logs() }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["ADMIN"]);
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

function RouteComponent() {
	const search = Route.useSearch();

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.audit_logs()}</h2>
					<p className="text-muted-foreground">{m.audit_logs_desc()}</p>
				</div>
			</div>
			<Card className="p-0">
				<CardContent className="p-0">
					<AuditLogTable search={search} to="/dash/admin/audit" />
				</CardContent>
			</Card>
		</>
	);
}

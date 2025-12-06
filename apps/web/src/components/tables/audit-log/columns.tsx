import { m } from "@repo/i18n";
import type { ColumnDef } from "@tanstack/react-table";
import { format } from "date-fns";
import { Badge } from "@/components/ui/badge";
import type { AuditLog } from "@/lib/types/audit";
import { AuditLogAction } from "./action";

export const AUDIT_LOG_COLUMNS: ColumnDef<AuditLog>[] = [
	{
		accessorKey: "tableName",
		header: m.table(),
		cell: ({ row }) => {
			const tableName = row.original.tableName;
			return <Badge variant="outline">{tableName}</Badge>;
		},
	},
	{
		accessorKey: "operation",
		header: m.operation(),
		cell: ({ row }) => {
			const operation = row.original.operation;
			const variant =
				operation === "INSERT"
					? "default"
					: operation === "UPDATE"
						? "secondary"
						: "destructive";
			return <Badge variant={variant}>{operation}</Badge>;
		},
	},
	{
		accessorKey: "recordId",
		header: m.record_id(),
		cell: ({ row }) => {
			const recordId = row.original.recordId;
			return (
				<code className="rounded bg-muted px-2 py-1 text-xs">
					{recordId.slice(0, 8)}...
				</code>
			);
		},
	},
	{
		accessorKey: "updatedById",
		header: m.updated_by(),
		cell: ({ row }) => {
			const userId = row.original.updatedById;
			if (!userId)
				return <span className="text-muted-foreground">{m.system()}</span>;
			return (
				<code className="rounded bg-muted px-2 py-1 text-xs">
					{userId.slice(0, 8)}...
				</code>
			);
		},
	},
	{
		accessorKey: "ipAddress",
		header: m.ip_address(),
		cell: ({ row }) => {
			const ip = row.original.ipAddress;
			if (!ip) return <span className="text-muted-foreground">-</span>;
			return <span className="font-mono text-xs">{ip}</span>;
		},
	},
	{
		accessorKey: "reason",
		header: m.ban_reason(),
		cell: ({ row }) => {
			const reason = row.original.reason;
			if (!reason) return <span className="text-muted-foreground">-</span>;
			return <span className="text-sm">{reason}</span>;
		},
	},
	{
		accessorKey: "updatedAt",
		header: m.timestamp(),
		cell: ({ row }) => {
			const date = new Date(row.original.updatedAt);
			return (
				<span className="text-muted-foreground text-sm">
					{format(date, "MMM dd, yyyy HH:mm:ss")}
				</span>
			);
		},
	},
	{
		id: "actions",
		header: m.actions(),
		cell: ({ row }) => <AuditLogAction auditLog={row.original} />,
	},
];

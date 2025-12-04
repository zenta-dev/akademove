import { m } from "@repo/i18n";
import type { Report, ReportCategory, ReportStatus } from "@repo/schema/report";
import type { ColumnDef } from "@tanstack/react-table";
import {
	AlertTriangle,
	ArrowUpDown,
	CheckCircle2,
	Clock,
	Search,
	Shield,
	XCircle,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { ReportActionTable } from "./action";

const getStatusConfig = (status: ReportStatus) => {
	switch (status) {
		case "PENDING":
			return {
				label: "Pending",
				variant: "secondary" as const,
				icon: Clock,
				color: "bg-yellow-500/20 text-yellow-600",
			};
		case "INVESTIGATING":
			return {
				label: "Investigating",
				variant: "default" as const,
				icon: Search,
				color: "bg-blue-500/20 text-blue-600",
			};
		case "RESOLVED":
			return {
				label: "Resolved",
				variant: "default" as const,
				icon: CheckCircle2,
				color: "bg-green-500/20 text-green-600",
			};
		case "DISMISSED":
			return {
				label: "Dismissed",
				variant: "secondary" as const,
				icon: XCircle,
				color: "bg-gray-500/20 text-gray-600",
			};
	}
};

const getCategoryConfig = (category: ReportCategory) => {
	switch (category) {
		case "BEHAVIOR":
			return {
				label: "Behavior",
				icon: AlertTriangle,
				color: "text-orange-600",
			};
		case "SAFETY":
			return { label: "Safety", icon: Shield, color: "text-red-600" };
		case "FRAUD":
			return { label: "Fraud", icon: AlertTriangle, color: "text-purple-600" };
		case "OTHER":
			return { label: "Other", icon: AlertTriangle, color: "text-gray-600" };
	}
};

export const REPORT_COLUMNS = [
	{
		id: "category",
		accessorKey: "category",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.category()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const category = row.getValue("category") as ReportCategory;
			const config = getCategoryConfig(category);
			const Icon = config.icon;
			return (
				<div className="flex items-center gap-2">
					<Icon className={`h-4 w-4 ${config.color}`} />
					<span className="font-medium">{config.label}</span>
				</div>
			);
		},
	},
	{
		id: "description",
		accessorKey: "description",
		enableHiding: false,
		header: () => "Description",
		cell: ({ row }) => {
			return (
				<div className="max-w-[300px] truncate">
					{row.getValue("description")}
				</div>
			);
		},
	},
	{
		id: "status",
		accessorKey: "status",
		header: m.status(),
		cell: ({ row }) => {
			const status = row.getValue("status") as ReportStatus;
			const config = getStatusConfig(status);
			const StatusIcon = config.icon;
			return (
				<Badge variant={config.variant} className={config.color}>
					<StatusIcon className="mr-1 h-3 w-3" />
					{config.label}
				</Badge>
			);
		},
	},
	{
		id: "reportedAt",
		accessorKey: "reportedAt",
		header: () => "Reported At",
		cell: ({ row }) => {
			const date = new Date(row.getValue("reportedAt"));
			return (
				<div className="text-start font-medium">
					{date.toLocaleDateString("id-ID", {
						day: "numeric",
						month: "short",
						year: "numeric",
					})}
				</div>
			);
		},
	},
	{
		id: "actions",
		enableHiding: false,
		header: m.actions(),
		cell: ({ row }) => {
			return <ReportActionTable val={row.original} />;
		},
	},
] as const satisfies ColumnDef<Report>[];

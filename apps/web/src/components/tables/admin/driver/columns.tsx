import { m } from "@repo/i18n";
import type { Driver, DriverStatus } from "@repo/schema/driver";
import { capitalizeFirstLetter } from "@repo/shared";
import type { ColumnDef } from "@tanstack/react-table";
import { cva } from "class-variance-authority";
import {
	ArrowUpDown,
	BadgeCheckIcon,
	BadgeXIcon,
	Ban,
	CheckCircle,
	Clock,
	PauseCircle,
	PlayCircle,
	XCircle,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";

export const STATUS_ICONS: Record<
	"pending" | "approved" | "rejected" | "active" | "inactive" | "suspended",
	React.ElementType
> = {
	pending: Clock,
	approved: CheckCircle,
	rejected: XCircle,
	active: PlayCircle,
	inactive: PauseCircle,
	suspended: Ban,
};
export const statusVariants = cva("", {
	variants: {
		intent: {
			pending: "bg-yellow-500/10 text-yellow-500",
			approved: "bg-green-500/10 text-green-500",
			rejected: "bg-red-500/10 text-red-500",
			active: "bg-blue-500/10 text-blue-500",
			inactive: "bg-gray-500/10 text-gray-500",
			suspended: "bg-orange-500/10 text-orange-500",
		},
	},
	defaultVariants: {
		intent: "inactive",
	},
});

export const DRIVER_COLUMNS = [
	{
		id: "user.name",
		accessorKey: "user.name",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.name()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
	},
	{
		id: "studentId",
		accessorKey: "studentId",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.student_id()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
	},
	{
		id: "licenseNumber",
		accessorKey: "licenseNumber",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.license_number()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
	},
	{
		id: "rating",
		accessorKey: "rating",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.rating()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
	},
	{
		id: "status",
		accessorKey: "status",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.status()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = String(row.getValue("status")) as DriverStatus;

			const Icon = STATUS_ICONS[value];

			return (
				<Badge className={statusVariants({ intent: value })}>
					<Icon className="mr-1 h-4 w-4" />
					{capitalizeFirstLetter(value)}
				</Badge>
			);
		},
	},
	{
		id: "isOnline",
		accessorKey: "isOnline",
		header: m.is_online(),
		cell: ({ row }) => {
			const value = Boolean(row.getValue("isOnline"));
			if (value) {
				return (
					<Badge
						variant="secondary"
						className="bg-green-500/20 text-green-500 dark:bg-green-600/20 dark:text-green-600"
					>
						<BadgeCheckIcon />
						{m.yes().toUpperCase()}
					</Badge>
				);
			}
			return (
				<Badge
					variant="secondary"
					className="bg-red-500/20 text-red-500 dark:bg-red-600/20 dark:text-red-600"
				>
					<BadgeXIcon />
					{m.no().toUpperCase()}
				</Badge>
			);
		},
	},
	{
		id: "createdAt",
		accessorKey: "createdAt",
		header: m.joined_at(),
		cell: ({ row }) => {
			const date = new Date(row.getValue("createdAt"));

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
	// {
	// 	id: "actions",
	// 	enableHiding: false,
	// 	header: m.actions(),
	// 	cell: ({ row }) => {
	// 		return <UserActionTable val={row.original} />;
	// 	},
	// },
] as const satisfies ColumnDef<Driver>[];

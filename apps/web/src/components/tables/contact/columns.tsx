import { m } from "@repo/i18n";
import type { Contact } from "@repo/schema/contact";
import { capitalizeFirstLetter } from "@repo/shared";
import type { ColumnDef } from "@tanstack/react-table";
import { ArrowUpDown } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { cn } from "@/utils/cn";
import { ContactActionTable } from "./action";

export const CONTACT_COLUMNS = [
	{
		id: "name",
		accessorKey: "name",
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
		id: "email",
		accessorKey: "email",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.email()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
	},
	{
		id: "subject",
		accessorKey: "subject",
		enableHiding: false,
		header: m.subject(),
		cell: ({ row }) => {
			const value = String(row.getValue("subject"));
			return (
				<div className="max-w-md truncate" title={value}>
					{value}
				</div>
			);
		},
	},
	{
		id: "status",
		accessorKey: "status",
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
			const value = String(row.getValue("status"));

			return (
				<Badge
					variant="secondary"
					className={cn(
						"bg-yellow-500/10 text-yellow-500 dark:bg-yellow-600/10 dark:text-yellow-600",
						value === "REVIEWING" &&
							"bg-blue-500/10 text-blue-500 dark:bg-blue-600/10 dark:text-blue-600",
						value === "RESOLVED" &&
							"bg-green-500/10 text-green-500 dark:bg-green-600/10 dark:text-green-600",
						value === "CLOSED" &&
							"bg-gray-500/10 text-gray-500 dark:bg-gray-600/10 dark:text-gray-600",
					)}
				>
					{capitalizeFirstLetter(value.toLowerCase())}
				</Badge>
			);
		},
	},
	{
		id: "createdAt",
		accessorKey: "createdAt",
		header: m.created_at(),
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
	{
		id: "actions",
		enableHiding: false,
		header: m.actions(),
		cell: ({ row }) => {
			return <ContactActionTable val={row.original} />;
		},
	},
] as const satisfies ColumnDef<Contact>[];

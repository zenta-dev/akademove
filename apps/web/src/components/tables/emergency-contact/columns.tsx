import type { EmergencyContact } from "@repo/schema/emergency-contact";
import type { ColumnDef } from "@tanstack/react-table";
import { ArrowUpDown, BadgeCheckIcon, BadgeXIcon } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { EmergencyContactActionTable } from "./action";

export const createEmergencyContactColumns =
	(): ColumnDef<EmergencyContact>[] =>
		[
			{
				id: "name",
				accessorKey: "name",
				enableHiding: false,
				header: ({ column }) => {
					return (
						<Button
							variant="ghost"
							className="has-[>svg]:p-0"
							onClick={() =>
								column.toggleSorting(column.getIsSorted() === "asc")
							}
						>
							Name
							<ArrowUpDown className="ml-2 h-4 w-4" />
						</Button>
					);
				},
			},
			{
				id: "phone",
				accessorKey: "phone",
				header: "Phone",
				cell: ({ row }) => {
					const phone = row.getValue("phone") as string;
					return (
						<a href={`tel:${phone}`} className="text-blue-600 hover:underline">
							{phone}
						</a>
					);
				},
			},
			{
				id: "description",
				accessorKey: "description",
				header: "Description",
				cell: ({ row }) => {
					const description = row.getValue("description") as string | null;
					return description ? (
						<span className="line-clamp-2 max-w-xs">{description}</span>
					) : (
						<span className="text-muted-foreground">-</span>
					);
				},
			},
			{
				id: "priority",
				accessorKey: "priority",
				header: ({ column }) => {
					return (
						<Button
							variant="ghost"
							className="has-[>svg]:p-0"
							onClick={() =>
								column.toggleSorting(column.getIsSorted() === "asc")
							}
						>
							Priority
							<ArrowUpDown className="ml-2 h-4 w-4" />
						</Button>
					);
				},
			},
			{
				id: "isActive",
				accessorKey: "isActive",
				header: "Active",
				cell: ({ row }) => {
					const value = Boolean(row.getValue("isActive"));
					if (value) {
						return (
							<Badge
								variant="secondary"
								className="bg-green-500/20 text-green-500 dark:bg-green-600/20 dark:text-green-600"
							>
								<BadgeCheckIcon />
								YES
							</Badge>
						);
					}
					return (
						<Badge
							variant="secondary"
							className="bg-red-500/20 text-red-500 dark:bg-red-600/20 dark:text-red-600"
						>
							<BadgeXIcon />
							NO
						</Badge>
					);
				},
			},
			{
				id: "createdAt",
				accessorKey: "createdAt",
				header: "Created",
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
				header: "Actions",
				cell: ({ row }) => {
					return <EmergencyContactActionTable val={row.original} />;
				},
			},
		] as const satisfies ColumnDef<EmergencyContact>[];

import { m } from "@repo/i18n";
import type { User } from "@repo/schema/user";
import { capitalizeFirstLetter } from "@repo/shared";
import type { ColumnDef } from "@tanstack/react-table";
import { ArrowUpDown, BadgeCheckIcon, BadgeXIcon } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { cn } from "@/utils/cn";
import { UserActionTable } from "./action";

export const USER_COLUMNS = [
	{
		id: "name",
		accessorKey: "name",
		enableHiding: false,
		meta: () => {},
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
		id: "role",
		accessorKey: "role",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.role()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = String(row.getValue("role"));

			return (
				<Badge
					variant="secondary"
					className={cn(
						"bg-emerald-500/10 text-emerald-500 dark:bg-emerald-600/10 dark:text-emerald-600",
						value === "admin" &&
							"bg-amber-500/10 text-amber-500 dark:bg-amber-600/10 dark:text-amber-600",
						value === "operator" &&
							"bg-indigo-500/10 text-indigo-500 dark:bg-indigo-600/10 dark:text-indigo-600",
						value === "merchant" &&
							"bg-lime-500/10 text-lime-500 dark:bg-lime-600/10 dark:text-lime-600",
						value === "driver" &&
							"bg-fuchsia-500/10 text-fuchsia-500 dark:bg-fuchsia-600/10 dark:text-fuchsia-600",
					)}
				>
					<BadgeXIcon />
					{capitalizeFirstLetter(value.toLowerCase())}
				</Badge>
			);
		},
	},
	{
		id: "emailVerified",
		accessorKey: "emailVerified",
		header: m.verified(),
		cell: ({ row }) => {
			const value = Boolean(row.getValue("emailVerified"));
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
		id: "banned",
		accessorKey: "banned",
		header: m.banned(),
		cell: ({ row }) => {
			const value = Boolean(row.getValue("banned"));
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
	{
		id: "actions",
		enableHiding: false,
		header: m.actions(),
		cell: ({ row }) => {
			return <UserActionTable val={row.original} />;
		},
	},
] as const satisfies ColumnDef<User>[];

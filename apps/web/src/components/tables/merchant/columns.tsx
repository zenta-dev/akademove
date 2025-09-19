import { m } from "@repo/i18n";
import type { Merchant, MerchantType } from "@repo/schema/merchant";
import { capitalizeFirstLetter } from "@repo/shared";
import type { ColumnDef } from "@tanstack/react-table";
import { cva } from "class-variance-authority";
import {
	ArrowUpDown,
	BadgeCheckIcon,
	BadgeXIcon,
	HomeIcon,
	StoreIcon,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";

export const STATUS_ICONS: Record<MerchantType, React.ElementType> = {
	merchant: StoreIcon,
	tenant: HomeIcon,
};
export const merchantTypeVariants = cva("", {
	variants: {
		intent: {
			merchant: "bg-blue-500/10 text-blue-500",
			tenant: "bg-yellow-500/10 text-yellow-500",
		},
	},
	defaultVariants: {
		intent: "merchant",
	},
});

export const MERCHANT_COLUMNS = [
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
		id: "address",
		accessorKey: "address",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.address()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
	},
	{
		id: "type",
		accessorKey: "type",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.type()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = String(row.getValue("type")) as MerchantType;

			const Icon = STATUS_ICONS[value];

			return (
				<Badge className={merchantTypeVariants({ intent: value })}>
					<Icon className="mr-1 h-4 w-4" />
					{capitalizeFirstLetter(value)}
				</Badge>
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
		id: "isActive",
		accessorKey: "isActive",
		header: m.is_active(),
		cell: ({ row }) => {
			const value = Boolean(row.getValue("isActive"));
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
] as const satisfies ColumnDef<Merchant>[];

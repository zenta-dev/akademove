import { m } from "@repo/i18n";
import type { Merchant, MerchantType } from "@repo/schema/merchant";
import type { ColumnDef } from "@tanstack/react-table";
import { cva } from "class-variance-authority";
import {
	ArrowUpDown,
	BadgeCheckIcon,
	BadgeXIcon,
	HomeIcon,
	Star,
	StoreIcon,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { cn } from "@/utils/cn";

export const TYPE_ICONS: Record<
	MerchantType,
	{
		name: string;
		icon: React.ElementType;
	}
> = {
	merchant: { name: m.merchant(), icon: StoreIcon },
	tenant: { name: m.tenant(), icon: HomeIcon },
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

			const status = TYPE_ICONS[value];

			return (
				<Badge className={merchantTypeVariants({ intent: value })}>
					<status.icon className="mr-1 h-4 w-4" />
					{status.name}
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
		cell: ({ row }) => {
			const rating = row.getValue<number>("rating") ?? 0;
			const id = `rating-${row.index}`;
			return (
				<div className="flex items-center text-muted-foreground">
					{[...Array(5)].map((_, i) => (
						<Star
							key={`${id}-star-${
								// biome-ignore lint/suspicious/noArrayIndexKey: for now its just work
								i
							}`}
							className={cn(
								"h-4 w-4",
								i < rating
									? "fill-amber-400/80 text-amber-400/80"
									: "text-gray-300 dark:text-gray-600",
							)}
						/>
					))}
					/({rating})
				</div>
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

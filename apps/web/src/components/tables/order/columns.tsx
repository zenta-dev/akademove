import { m } from "@repo/i18n";
import type { Order, OrderStatus, OrderType } from "@repo/schema/order";
import { capitalizeFirstLetter } from "@repo/shared";
import type { ColumnDef } from "@tanstack/react-table";
import { cva } from "class-variance-authority";
import {
	AlertTriangle,
	ArrowUpDown,
	BadgeCheckIcon,
	BadgeXIcon,
	BikeIcon,
	Car,
	CheckCircle2,
	Clock,
	Flag,
	Navigation,
	PackageIcon,
	PizzaIcon,
	Search,
	Star,
	UserX,
	XOctagon,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { cn } from "@/utils/cn";

export const STATUS: Record<
	OrderStatus,
	{
		name: string;
		icon: React.ElementType;
	}
> = {
	requested: { name: m.requested(), icon: Clock },
	matching: { name: m.matching(), icon: Search },
	accepted: { name: m.accepted(), icon: CheckCircle2 },
	arriving: { name: m.arriving(), icon: Navigation },
	in_trip: { name: m.in_trip(), icon: Car },
	completed: { name: m.completed(), icon: Flag },
	cancelled_by_user: { name: m.cancelled_by_user(), icon: UserX },
	cancelled_by_driver: { name: m.cancelled_by_driver(), icon: XOctagon },
	cancelled_by_system: { name: m.cancelled_by_system(), icon: AlertTriangle },
};

export const TYPES: Record<
	OrderType,
	{
		name: string;
		icon: React.ElementType;
	}
> = {
	ride: { name: m.ride(), icon: BikeIcon },
	delivery: { name: m.delivery(), icon: PackageIcon },
	food: { name: m.food(), icon: PizzaIcon },
};

export const statusVariants = cva("", {
	variants: {
		intent: {
			requested: "bg-blue-500/10 text-blue-500",
			matching: "bg-indigo-500/10 text-indigo-500",
			accepted: "bg-teal-500/10 text-teal-500",
			arriving: "bg-yellow-500/10 text-yellow-500",
			in_trip: "bg-purple-500/10 text-purple-500",
			completed: "bg-green-500/10 text-green-500",
			cancelled_by_user: "bg-red-500/10 text-red-500",
			cancelled_by_driver: "bg-orange-500/10 text-orange-500",
			cancelled_by_system: "bg-gray-500/10 text-gray-700 dark:text-gray-200",
		},
	},
	defaultVariants: { intent: "requested" },
});

export const typeVariants = cva("", {
	variants: {
		intent: {
			ride: "bg-blue-500/10 text-blue-500",
			delivery: "bg-green-500/10 text-green-500",
			food: "bg-yellow-500/10 text-yellow-500",
		},
	},
	defaultVariants: { intent: "ride" },
});

export const ORDER_COLUMNS = [
	{
		id: "user.name",
		accessorKey: "user.name",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.customer_name()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
	},
	{
		id: "driver.user.name",
		accessorKey: "driver.user.name",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.driver_name()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = row.getValue("driver.user.name") as string | undefined;
			if (value) return value;
			return (
				<Badge className="bg-destructive/10 text-destructive">
					{m.no_driver()}
				</Badge>
			);
		},
	},
	{
		id: "merchant.name",
		accessorKey: "merchant.name",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.merchant_name()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = row.getValue("merchant.name") as string | undefined;
			if (value) return value;
			return (
				<Badge className="bg-destructive/10 text-destructive">
					{m.no_merchant()}
				</Badge>
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
			const value = String(row.getValue("type")) as OrderType;

			const status = TYPES[value];

			return (
				<Badge className={typeVariants({ intent: value })}>
					<status.icon className="mr-1 h-4 w-4" />
					{status.name}
				</Badge>
			);
		},
	},
	{
		id: "distanceKm",
		accessorKey: "distanceKm",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.distance()} (KM)
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
	},
	{
		id: "basePrice",
		accessorKey: "basePrice",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.base_price()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = Number(row.getValue("basePrice"));
			return `Rp ${value}`;
		},
	},
	{
		id: "totalPrice",
		accessorKey: "totalPrice",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.total_price()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = Number(row.getValue("totalPrice"));
			return `Rp ${value}`;
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
			const value = String(row.getValue("status")) as OrderStatus;

			const status = STATUS[value];

			return (
				<Badge className={statusVariants({ intent: value })}>
					<status.icon className="mr-1 h-4 w-4" />
					{status.name}
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
] as const satisfies ColumnDef<Order>[];

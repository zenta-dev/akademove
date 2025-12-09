import { m } from "@repo/i18n";
import type { Order, OrderStatus, OrderType } from "@repo/schema/order";
import type { ColumnDef } from "@tanstack/react-table";
import { cva } from "class-variance-authority";
import {
	AlertTriangle,
	ArrowUpDown,
	BikeIcon,
	Car,
	CheckCircle2,
	Clock,
	Flag,
	Navigation,
	PackageIcon,
	PizzaIcon,
	Search,
	UserX,
	XOctagon,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { OrderActionTable } from "./action";

export const STATUS: Record<
	OrderStatus,
	{
		name: string;
		icon: React.ElementType;
	}
> = {
	REQUESTED: { name: m.requested(), icon: Clock },
	MATCHING: { name: m.matching(), icon: Search },
	ACCEPTED: { name: m.accepted(), icon: CheckCircle2 },
	PREPARING: { name: "Preparing", icon: Clock },
	READY_FOR_PICKUP: { name: "Ready for Pickup", icon: CheckCircle2 },
	ARRIVING: { name: m.arriving(), icon: Navigation },
	IN_TRIP: { name: m.in_trip(), icon: Car },
	COMPLETED: { name: m.completed(), icon: Flag },
	CANCELLED_BY_USER: { name: m.cancelled_by_user(), icon: UserX },
	CANCELLED_BY_DRIVER: { name: m.cancelled_by_driver(), icon: XOctagon },
	CANCELLED_BY_MERCHANT: { name: "Cancelled by Merchant", icon: XOctagon },
	CANCELLED_BY_SYSTEM: { name: m.cancelled_by_system(), icon: AlertTriangle },
	NO_SHOW: { name: "No Show", icon: UserX },
	SCHEDULED: { name: "Scheduled", icon: Clock },
};

export const TYPES: Record<
	OrderType,
	{
		name: string;
		icon: React.ElementType;
	}
> = {
	RIDE: { name: m.ride(), icon: BikeIcon },
	DELIVERY: { name: m.delivery(), icon: PackageIcon },
	FOOD: { name: m.food(), icon: PizzaIcon },
};

export const statusVariants = cva("", {
	variants: {
		intent: {
			REQUESTED: "bg-blue-500/10 text-blue-500",
			MATCHING: "bg-indigo-500/10 text-indigo-500",
			ACCEPTED: "bg-teal-500/10 text-teal-500",
			PREPARING: "bg-cyan-500/10 text-cyan-500",
			READY_FOR_PICKUP: "bg-sky-500/10 text-sky-500",
			ARRIVING: "bg-yellow-500/10 text-yellow-500",
			IN_TRIP: "bg-purple-500/10 text-purple-500",
			COMPLETED: "bg-green-500/10 text-green-500",
			CANCELLED_BY_USER: "bg-red-500/10 text-red-500",
			CANCELLED_BY_DRIVER: "bg-orange-500/10 text-orange-500",
			CANCELLED_BY_MERCHANT: "bg-pink-500/10 text-pink-500",
			CANCELLED_BY_SYSTEM: "bg-gray-500/10 text-gray-700 dark:text-gray-200",
			NO_SHOW: "bg-amber-500/10 text-amber-500",
			SCHEDULED: "bg-lime-500/10 text-lime-500",
		},
	},
	defaultVariants: { intent: "REQUESTED" },
});

export const typeVariants = cva("", {
	variants: {
		intent: {
			RIDE: "bg-blue-500/10 text-blue-500",
			DELIVERY: "bg-green-500/10 text-green-500",
			FOOD: "bg-yellow-500/10 text-yellow-500",
		},
	},
	defaultVariants: { intent: "RIDE" },
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
	{
		id: "actions",
		enableHiding: false,
		header: m.actions(),
		cell: ({ row }) => {
			return <OrderActionTable val={row.original} />;
		},
	},
] as const satisfies ColumnDef<Order>[];

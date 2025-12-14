import { m } from "@repo/i18n";
import type { Coupon } from "@repo/schema/coupon";
import type { OrderType } from "@repo/schema/order";
import type { ColumnDef } from "@tanstack/react-table";
import { ArrowUpDown, BadgeCheckIcon, BadgeXIcon } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { CouponActionTable } from "./action";

const getServiceTypeLabel = (type: OrderType): string => {
	switch (type) {
		case "RIDE":
			return m.ride();
		case "DELIVERY":
			return m.delivery();
		case "FOOD":
			return m.food();
		default:
			return type;
	}
};

const getServiceTypeColor = (type: OrderType): { bg: string; text: string } => {
	switch (type) {
		case "RIDE":
			return { bg: "bg-blue-500/20", text: "text-blue-600" };
		case "DELIVERY":
			return { bg: "bg-green-500/20", text: "text-green-600" };
		case "FOOD":
			return { bg: "bg-amber-500/20", text: "text-amber-600" };
		default:
			return { bg: "bg-gray-500/20", text: "text-gray-600" };
	}
};

export const createCouponColumns = (
	userRole: "ADMIN" | "OPERATOR",
): ColumnDef<Coupon>[] =>
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
						onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
					>
						{m.name()}
						<ArrowUpDown className="ml-2 h-4 w-4" />
					</Button>
				);
			},
		},
		{
			id: "code",
			accessorKey: "code",
			enableHiding: false,
			header: ({ column }) => {
				return (
					<Button
						variant="ghost"
						className="has-[>svg]:p-0"
						onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
					>
						{m.code()}
						<ArrowUpDown className="ml-2 h-4 w-4" />
					</Button>
				);
			},
		},
		{
			id: "periodStart",
			accessorKey: "periodStart",
			enableHiding: false,
			header: ({ column }) => {
				return (
					<Button
						variant="ghost"
						className="has-[>svg]:p-0"
						onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
					>
						{m.period_start()}
						<ArrowUpDown className="ml-2 h-4 w-4" />
					</Button>
				);
			},
			cell: ({ row }) => {
				const date = new Date(row.getValue("periodStart"));
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
			id: "periodEnd",
			accessorKey: "periodEnd",
			enableHiding: false,
			header: ({ column }) => {
				return (
					<Button
						variant="ghost"
						className="has-[>svg]:p-0"
						onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
					>
						{m.period_end()}
						<ArrowUpDown className="ml-2 h-4 w-4" />
					</Button>
				);
			},
			cell: ({ row }) => {
				const date = new Date(row.getValue("periodEnd"));

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
			id: "usedCount",
			accessorKey: "usedCount",
			enableHiding: false,
			header: ({ column }) => {
				return (
					<Button
						variant="ghost"
						className="has-[>svg]:p-0"
						onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
					>
						{m.used_count()}
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
			id: "serviceTypes",
			accessorKey: "serviceTypes",
			header: m.service_types(),
			cell: ({ row }) => {
				const serviceTypes = row.original.serviceTypes;
				if (!serviceTypes || serviceTypes.length === 0) {
					return (
						<Badge variant="outline" className="text-muted-foreground">
							{m.all()}
						</Badge>
					);
				}
				return (
					<div className="flex flex-wrap gap-1">
						{serviceTypes.map((type) => {
							const colors = getServiceTypeColor(type);
							return (
								<Badge
									key={type}
									variant="secondary"
									className={`${colors.bg} ${colors.text}`}
								>
									{getServiceTypeLabel(type)}
								</Badge>
							);
						})}
					</div>
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
				return <CouponActionTable val={row.original} userRole={userRole} />;
			},
		},
	] as const satisfies ColumnDef<Coupon>[];

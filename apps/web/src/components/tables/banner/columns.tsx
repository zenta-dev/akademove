import { m } from "@repo/i18n";
import type { Banner } from "@repo/schema/banner";
import type { ColumnDef } from "@tanstack/react-table";
import { ArrowUpDown, BadgeCheckIcon, BadgeXIcon } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { BannerActionTable } from "./action";

const PlacementBadge = ({ placement }: { placement: string }) => {
	const labels: Record<string, string> = {
		USER_HOME: m.banner_placement_user_home(),
		DRIVER_HOME: m.banner_placement_driver_home(),
		MERCHANT_HOME: m.banner_placement_merchant_home(),
	};
	const colors: Record<string, string> = {
		USER_HOME: "bg-blue-500/20 text-blue-600",
		DRIVER_HOME: "bg-green-500/20 text-green-600",
		MERCHANT_HOME: "bg-purple-500/20 text-purple-600",
	};
	return (
		<Badge variant="secondary" className={colors[placement] ?? ""}>
			{labels[placement] ?? placement}
		</Badge>
	);
};

const TargetAudienceBadge = ({ audience }: { audience: string }) => {
	const labels: Record<string, string> = {
		ALL: m.banner_target_audience_all(),
		USERS: m.banner_target_audience_users(),
		DRIVERS: m.banner_target_audience_drivers(),
		MERCHANTS: m.banner_target_audience_merchants(),
	};
	return <Badge variant="outline">{labels[audience] ?? audience}</Badge>;
};

export const createBannerColumns = (
	role: "ADMIN" | "OPERATOR",
): ColumnDef<Banner>[] =>
	[
		{
			id: "title",
			accessorKey: "title",
			enableHiding: false,
			header: ({ column }) => {
				return (
					<Button
						variant="ghost"
						className="has-[>svg]:p-0"
						onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
					>
						{m.banner_title()}
						<ArrowUpDown className="ml-2 h-4 w-4" />
					</Button>
				);
			},
		},
		{
			id: "imageUrl",
			accessorKey: "imageUrl",
			header: m.banner_image_url(),
			cell: ({ row }) => {
				const url = row.getValue("imageUrl") as string;
				return url ? (
					<a
						href={url}
						target="_blank"
						rel="noopener noreferrer"
						className="text-blue-600 hover:underline"
					>
						<img
							src={url}
							alt="Banner preview"
							className="h-10 w-16 rounded object-cover"
						/>
					</a>
				) : (
					<span className="text-muted-foreground">-</span>
				);
			},
		},
		{
			id: "placement",
			accessorKey: "placement",
			header: m.banner_placement(),
			cell: ({ row }) => {
				return <PlacementBadge placement={row.getValue("placement")} />;
			},
		},
		{
			id: "targetAudience",
			accessorKey: "targetAudience",
			header: m.banner_target_audience(),
			cell: ({ row }) => {
				return (
					<TargetAudienceBadge audience={row.getValue("targetAudience")} />
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
						onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
					>
						{m.banner_priority()}
						<ArrowUpDown className="ml-2 h-4 w-4" />
					</Button>
				);
			},
		},
		{
			id: "isActive",
			accessorKey: "isActive",
			header: m.banner_is_active(),
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
				return <BannerActionTable val={row.original} role={role} />;
			},
		},
	] as const satisfies ColumnDef<Banner>[];

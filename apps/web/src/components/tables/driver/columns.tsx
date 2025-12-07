import { m } from "@repo/i18n";
import type { Driver, DriverStatus } from "@repo/schema/driver";
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
	Star,
	XCircle,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { cn } from "@/utils/cn";
import { DriverActionTable } from "./action";

export const STATUS_DICT: Record<
	DriverStatus,
	{
		name: string;
		icon: React.ElementType;
	}
> = {
	PENDING: { name: m.pending(), icon: Clock },
	APPROVED: { name: m.approved(), icon: CheckCircle },
	REJECTED: { name: m.rejected(), icon: XCircle },
	ACTIVE: { name: m.active(), icon: PlayCircle },
	INACTIVE: { name: m.inactive(), icon: PauseCircle },
	SUSPENDED: { name: m.suspended(), icon: Ban },
};
export const statusVariants = cva("", {
	variants: {
		intent: {
			PENDING: "bg-yellow-500/10 text-yellow-500",
			APPROVED: "bg-green-500/10 text-green-500",
			REJECTED: "bg-red-500/10 text-red-500",
			ACTIVE: "bg-blue-500/10 text-blue-500",
			INACTIVE: "bg-gray-500/10 text-gray-500",
			SUSPENDED: "bg-orange-500/10 text-orange-500",
		},
	},
	defaultVariants: {
		intent: "INACTIVE",
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
		id: "licensePlate",
		accessorKey: "licensePlate",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.license_plate()}
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
		cell: ({ row }) => {
			const rating = row.getValue<number>("rating") ?? 0;
			const roundedRating = Math.round(rating);
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
								i < roundedRating
									? "fill-amber-400/80 text-amber-400/80"
									: "text-gray-300 dark:text-gray-600",
							)}
						/>
					))}
					/({rating.toFixed(1)})
				</div>
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

			const status = STATUS_DICT[value];

			return (
				<Badge className={statusVariants({ intent: value })}>
					<status.icon className="mr-1 h-4 w-4" />
					{status.name}
				</Badge>
			);
		},
	},
	{
		id: "quizStatus",
		accessorKey: "quizStatus",
		header: "Quiz Status",
		cell: ({ row }) => {
			const quizStatus = row.getValue("quizStatus") as string;
			const quizScore = row.original.quizScore;

			const statusColors: Record<string, string> = {
				NOT_STARTED: "bg-gray-100 text-gray-700",
				IN_PROGRESS: "bg-blue-100 text-blue-700",
				PASSED: "bg-green-100 text-green-700",
				FAILED: "bg-red-100 text-red-700",
			};

			const color = statusColors[quizStatus] || "bg-gray-100 text-gray-700";

			return (
				<div className="flex flex-col items-start gap-1">
					<Badge variant="secondary" className={color}>
						{quizStatus}
					</Badge>
					{quizScore && (
						<span className="text-muted-foreground text-xs">{quizScore}%</span>
					)}
				</div>
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
	{
		id: "actions",
		enableHiding: false,
		header: m.actions(),
		cell: ({ row }) => {
			return <DriverActionTable val={row.original} />;
		},
	},
] as const satisfies ColumnDef<Driver>[];

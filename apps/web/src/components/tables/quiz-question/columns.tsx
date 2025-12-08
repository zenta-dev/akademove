import { m } from "@repo/i18n";
import type { DriverQuizQuestion } from "@repo/schema/driver-quiz-question";
import { capitalizeFirstLetter } from "@repo/shared";
import type { ColumnDef } from "@tanstack/react-table";
import { ArrowUpDown, BadgeCheckIcon, BadgeXIcon } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { cn } from "@/utils/cn";
import { QuizQuestionActionTable } from "./action";

export const QUIZ_QUESTION_COLUMNS = [
	{
		id: "question",
		accessorKey: "question",
		enableHiding: false,
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.question()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = String(row.getValue("question"));
			return (
				<div className="max-w-md truncate" title={value}>
					{value}
				</div>
			);
		},
	},
	{
		id: "type",
		accessorKey: "type",
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
			const value = String(row.getValue("type"));
			return (
				<Badge
					variant="secondary"
					className={cn(
						"bg-gray-500/10 text-gray-500 dark:bg-gray-600/10 dark:text-gray-600",
						value === "MULTIPLE_CHOICE" &&
							"bg-blue-500/10 text-blue-500 dark:bg-blue-600/10 dark:text-blue-600",
						value === "TRUE_FALSE" &&
							"bg-green-500/10 text-green-500 dark:bg-green-600/10 dark:text-green-600",
					)}
				>
					<BadgeXIcon />
					{capitalizeFirstLetter(value.toLowerCase().replace("_", " "))}
				</Badge>
			);
		},
	},
	{
		id: "category",
		accessorKey: "category",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.category()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = String(row.getValue("category"));
			return (
				<Badge
					variant="secondary"
					className={cn(
						"bg-purple-500/10 text-purple-500 dark:bg-purple-600/10 dark:text-purple-600",
						value === "SAFETY" &&
							"bg-red-500/10 text-red-500 dark:bg-red-600/10 dark:text-red-600",
						value === "NAVIGATION" &&
							"bg-blue-500/10 text-blue-500 dark:bg-blue-600/10 dark:text-blue-600",
						value === "CUSTOMER_SERVICE" &&
							"bg-green-500/10 text-green-500 dark:bg-green-600/10 dark:text-green-600",
						value === "PLATFORM_RULES" &&
							"bg-amber-500/10 text-amber-500 dark:bg-amber-600/10 dark:text-amber-600",
						value === "EMERGENCY_PROCEDURES" &&
							"bg-orange-500/10 text-orange-500 dark:bg-orange-600/10 dark:text-orange-600",
						value === "VEHICLE_MAINTENANCE" &&
							"bg-slate-500/10 text-slate-500 dark:bg-slate-600/10 dark:text-slate-600",
					)}
				>
					<BadgeXIcon />
					{capitalizeFirstLetter(value.toLowerCase().replace("_", " "))}
				</Badge>
			);
		},
	},
	{
		id: "points",
		accessorKey: "points",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.points()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = Number(row.getValue("points"));
			return (
				<Badge variant="outline">
					{value} {value === 1 ? "pt" : "pts"}
				</Badge>
			);
		},
	},
	{
		id: "displayOrder",
		accessorKey: "displayOrder",
		header: ({ column }) => {
			return (
				<Button
					variant="ghost"
					className="has-[>svg]:p-0"
					onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
				>
					{m.display_order()}
					<ArrowUpDown className="ml-2 h-4 w-4" />
				</Button>
			);
		},
		cell: ({ row }) => {
			const value = Number(row.getValue("displayOrder"));
			return <div className="text-center">{value}</div>;
		},
	},
	{
		id: "isActive",
		accessorKey: "isActive",
		header: m.active(),
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
			return <QuizQuestionActionTable val={row.original} />;
		},
	},
] as const satisfies ColumnDef<DriverQuizQuestion>[];

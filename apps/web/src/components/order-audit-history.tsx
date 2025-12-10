import { m } from "@repo/i18n";
import type { OrderStatusHistory } from "@repo/schema/order";
import { useQuery } from "@tanstack/react-query";
import { AlertCircle, ArrowRight, Clock, History, User } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Separator } from "@/components/ui/separator";
import { Skeleton } from "@/components/ui/skeleton";
import { orpcQuery } from "@/lib/orpc";
import { cn } from "@/utils/cn";

interface OrderAuditHistoryProps {
	orderId: string;
	className?: string;
}

const statusColorMap: Record<string, string> = {
	SCHEDULED:
		"bg-slate-100 text-slate-800 dark:bg-slate-900 dark:text-slate-300",
	REQUESTED:
		"bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300",
	MATCHING: "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300",
	ACCEPTED: "bg-cyan-100 text-cyan-800 dark:bg-cyan-900 dark:text-cyan-300",
	PREPARING:
		"bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-300",
	READY_FOR_PICKUP:
		"bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-300",
	ARRIVING:
		"bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-300",
	IN_TRIP: "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300",
	COMPLETED:
		"bg-emerald-100 text-emerald-800 dark:bg-emerald-900 dark:text-emerald-300",
	CANCELLED_BY_USER:
		"bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
	CANCELLED_BY_DRIVER:
		"bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
	CANCELLED_BY_MERCHANT:
		"bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
	CANCELLED_BY_SYSTEM:
		"bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-300",
	NO_SHOW: "bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-300",
};

const roleColorMap: Record<string, string> = {
	USER: "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300",
	DRIVER: "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300",
	MERCHANT:
		"bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-300",
	OPERATOR:
		"bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-300",
	ADMIN: "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
	SYSTEM: "bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-300",
};

const formatDate = (date: Date | string) => {
	const dateObj = typeof date === "string" ? new Date(date) : date;
	return new Intl.DateTimeFormat("id-ID", {
		year: "numeric",
		month: "short",
		day: "numeric",
		hour: "2-digit",
		minute: "2-digit",
		second: "2-digit",
		timeZone: "Asia/Jakarta",
	}).format(dateObj);
};

const formatStatusLabel = (status: string) => {
	return status.replace(/_/g, " ");
};

function AuditHistoryItem({ item }: { item: OrderStatusHistory }) {
	return (
		<div className="flex flex-col gap-2 rounded-lg border p-4">
			{/* Status transition */}
			<div className="flex flex-wrap items-center gap-2">
				{item.previousStatus ? (
					<>
						<Badge
							variant="secondary"
							className={cn("text-xs", statusColorMap[item.previousStatus])}
						>
							{formatStatusLabel(item.previousStatus)}
						</Badge>
						<ArrowRight className="h-4 w-4 text-muted-foreground" />
					</>
				) : (
					<span className="text-muted-foreground text-xs">
						{m.order_history_initial_status()}
					</span>
				)}
				<Badge
					variant="secondary"
					className={cn("text-xs", statusColorMap[item.newStatus])}
				>
					{formatStatusLabel(item.newStatus)}
				</Badge>
			</div>

			{/* Changed by info */}
			<div className="flex flex-wrap items-center gap-2 text-muted-foreground text-sm">
				<div className="flex items-center gap-1">
					<Clock className="h-3 w-3" />
					<span>{formatDate(item.changedAt)}</span>
				</div>
				<Separator orientation="vertical" className="h-4" />
				<div className="flex items-center gap-1">
					<User className="h-3 w-3" />
					{item.changedByRole && (
						<Badge
							variant="outline"
							className={cn("text-xs", roleColorMap[item.changedByRole])}
						>
							{item.changedByRole}
						</Badge>
					)}
					{item.changedByUser?.name && (
						<span className="text-xs">{item.changedByUser.name}</span>
					)}
					{!item.changedByUser?.name && !item.changedByRole && (
						<span className="text-xs italic">
							{m.order_history_unknown_user()}
						</span>
					)}
				</div>
			</div>

			{/* Reason if provided */}
			{item.reason && (
				<div className="rounded-md bg-muted/50 p-2 text-muted-foreground text-sm">
					<span className="font-medium">{m.order_history_reason()}:</span>{" "}
					{item.reason}
				</div>
			)}
		</div>
	);
}

function AuditHistorySkeleton() {
	return (
		<div className="space-y-3">
			{[1, 2, 3].map((i) => (
				<div key={i} className="flex flex-col gap-2 rounded-lg border p-4">
					<div className="flex items-center gap-2">
						<Skeleton className="h-5 w-20" />
						<Skeleton className="h-4 w-4" />
						<Skeleton className="h-5 w-20" />
					</div>
					<div className="flex items-center gap-2">
						<Skeleton className="h-4 w-32" />
						<Skeleton className="h-4 w-16" />
					</div>
				</div>
			))}
		</div>
	);
}

export function OrderAuditHistory({
	orderId,
	className,
}: OrderAuditHistoryProps) {
	const { data, isLoading, error } = useQuery(
		orpcQuery.order.getStatusHistory.queryOptions({
			input: { params: { id: orderId } },
		}),
	);

	const history = data?.body?.data ?? [];

	return (
		<Card className={cn("w-full", className)}>
			<CardHeader className="pb-3">
				<CardTitle className="flex items-center gap-2 text-base">
					<History className="h-4 w-4" />
					{m.order_history_title()}
				</CardTitle>
				<CardDescription>{m.order_history_description()}</CardDescription>
			</CardHeader>
			<CardContent>
				{isLoading && <AuditHistorySkeleton />}

				{error && (
					<div className="flex items-center gap-2 rounded-lg border border-red-200 bg-red-50 p-4 text-red-800 dark:border-red-800 dark:bg-red-950 dark:text-red-200">
						<AlertCircle className="h-4 w-4" />
						<span className="text-sm">{m.order_history_error_loading()}</span>
					</div>
				)}

				{!isLoading && !error && history.length === 0 && (
					<div className="flex flex-col items-center gap-2 py-6 text-center text-muted-foreground">
						<History className="h-8 w-8" />
						<p className="text-sm">{m.order_history_no_history()}</p>
					</div>
				)}

				{!isLoading && !error && history.length > 0 && (
					<ScrollArea className="h-[300px] pr-4">
						<div className="space-y-3">
							{history.map((item) => (
								<AuditHistoryItem key={item.id} item={item} />
							))}
						</div>
					</ScrollArea>
				)}
			</CardContent>
		</Card>
	);
}

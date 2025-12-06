import { m } from "@repo/i18n";
import type { UserNotification } from "@repo/schema/notification";
import { useMutation, useQuery } from "@tanstack/react-query";
import { formatDistanceToNow } from "date-fns";
import { Bell, Check, CheckCheck, Loader2, Trash2 } from "lucide-react";
import { useFCM } from "@/hooks/use-fcm";
import { orpcClient, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";
import { Button } from "../ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuGroup,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "../ui/dropdown-menu";
import { ScrollArea } from "../ui/scroll-area";
import { Skeleton } from "../ui/skeleton";

export const NotificationDropdown = () => {
	const fcm = useFCM();

	const unreadCountQuery = useQuery({
		queryKey: ["notifications", "unread-count"],
		queryFn: async () => {
			const res = await orpcClient.notification.getUnreadCount({});
			return res.body.data.count;
		},
		refetchInterval: 30000, // Refetch every 30 seconds
	});

	const notificationsQuery = useQuery({
		queryKey: ["notifications", "list"],
		queryFn: async () => {
			const res = await orpcClient.notification.list({
				query: { limit: 10, read: "all", order: "desc", sortBy: "createdAt" },
			});
			return res.body.data;
		},
	});

	const markAsReadMutation = useMutation({
		mutationFn: async (variables: { params: { id: string } }) => {
			const result = await orpcClient.notification.markAsRead(variables);
			if (result.status !== 200) {
				throw new Error(result.body.message || "Failed to mark as read");
			}
			return result;
		},
		onSuccess: () => {
			queryClient.invalidateQueries({ queryKey: ["notifications"] });
		},
	});

	const markAllAsReadMutation = useMutation({
		mutationFn: async () => {
			const result = await orpcClient.notification.markAllAsRead({});
			if (result.status !== 200) {
				throw new Error(result.body.message || "Failed to mark all as read");
			}
			return result;
		},
		onSuccess: () => {
			queryClient.invalidateQueries({ queryKey: ["notifications"] });
		},
	});

	const deleteMutation = useMutation({
		mutationFn: async (variables: { params: { id: string } }) => {
			const result = await orpcClient.notification.delete(variables);
			if (result.status !== 200) {
				throw new Error(result.body.message || "Failed to delete notification");
			}
			return result;
		},
		onSuccess: () => {
			queryClient.invalidateQueries({ queryKey: ["notifications"] });
		},
	});

	const handleMarkAsRead = async (id: string) => {
		await markAsReadMutation.mutateAsync({ params: { id } });
	};

	const handleMarkAllAsRead = async () => {
		await markAllAsReadMutation.mutateAsync();
	};

	const handleDelete = async (
		e: React.MouseEvent<HTMLButtonElement>,
		id: string,
	) => {
		e.stopPropagation();
		await deleteMutation.mutateAsync({ params: { id } });
	};

	if (fcm.isLoading) {
		return <Skeleton className="size-8" />;
	}

	const unreadCount = unreadCountQuery.data ?? 0;
	const notifications = notificationsQuery.data ?? [];

	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" size="icon" className="relative">
					<Bell className="size-5" />
					{unreadCount > 0 && (
						<span className="-top-0.5 -right-0.5 absolute flex h-4 min-w-4 items-center justify-center rounded-full bg-destructive px-1 font-semibold text-destructive-foreground text-xs">
							{unreadCount > 99 ? "99+" : unreadCount}
						</span>
					)}
					<span className="sr-only">{m.notifications()}</span>
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end" className="w-80">
				<DropdownMenuLabel className="flex items-center justify-between">
					<span>{m.notifications()}</span>
					{unreadCount > 0 && (
						<Button
							variant="ghost"
							size="sm"
							className="h-auto p-1 text-muted-foreground text-xs hover:text-foreground"
							onClick={handleMarkAllAsRead}
							disabled={markAllAsReadMutation.isPending}
						>
							{markAllAsReadMutation.isPending ? (
								<Loader2 className="mr-1 size-3 animate-spin" />
							) : (
								<CheckCheck className="mr-1 size-3" />
							)}
							Mark all read
						</Button>
					)}
				</DropdownMenuLabel>
				<DropdownMenuSeparator />
				{notificationsQuery.isPending ? (
					<div className="space-y-2 p-2">
						<Skeleton className="h-16 w-full" />
						<Skeleton className="h-16 w-full" />
						<Skeleton className="h-16 w-full" />
					</div>
				) : notifications.length === 0 ? (
					<div className="flex flex-col items-center justify-center py-8 text-center">
						<Bell className="mb-2 size-8 text-muted-foreground" />
						<p className="text-muted-foreground text-sm">
							No notifications yet
						</p>
					</div>
				) : (
					<ScrollArea className="h-[300px]">
						<DropdownMenuGroup>
							{notifications.map((notification: UserNotification) => (
								<NotificationItem
									key={notification.id}
									notification={notification}
									onMarkAsRead={handleMarkAsRead}
									onDelete={handleDelete}
									isDeleting={
										deleteMutation.isPending &&
										deleteMutation.variables?.params?.id === notification.id
									}
								/>
							))}
						</DropdownMenuGroup>
					</ScrollArea>
				)}
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

interface NotificationItemProps {
	notification: UserNotification;
	onMarkAsRead: (id: string) => Promise<void>;
	onDelete: (e: React.MouseEvent<HTMLButtonElement>, id: string) => void;
	isDeleting: boolean;
}

function NotificationItem({
	notification,
	onMarkAsRead,
	onDelete,
	isDeleting,
}: NotificationItemProps) {
	const timeAgo = formatDistanceToNow(new Date(notification.createdAt), {
		addSuffix: true,
	});

	return (
		<DropdownMenuItem
			className={cn(
				"flex cursor-pointer flex-col items-start gap-1 p-3",
				!notification.isRead && "bg-accent/50",
			)}
			onClick={() => {
				if (!notification.isRead) {
					onMarkAsRead(notification.id);
				}
			}}
		>
			<div className="flex w-full items-start justify-between gap-2">
				<div className="flex-1 space-y-1">
					<div className="flex items-center gap-2">
						{!notification.isRead && (
							<span className="size-2 shrink-0 rounded-full bg-primary" />
						)}
						<p className="line-clamp-1 font-medium text-sm">
							{notification.title}
						</p>
					</div>
					<p className="line-clamp-2 text-muted-foreground text-xs">
						{notification.body}
					</p>
					<p className="text-muted-foreground/70 text-xs">{timeAgo}</p>
				</div>
				<div className="flex shrink-0 items-center gap-1">
					{!notification.isRead && (
						<Button
							variant="ghost"
							size="icon"
							className="size-6"
							onClick={(e) => {
								e.stopPropagation();
								onMarkAsRead(notification.id);
							}}
						>
							<Check className="size-3" />
						</Button>
					)}
					<Button
						variant="ghost"
						size="icon"
						className="size-6 text-muted-foreground hover:text-destructive"
						onClick={(e) => onDelete(e, notification.id)}
						disabled={isDeleting}
					>
						{isDeleting ? (
							<Loader2 className="size-3 animate-spin" />
						) : (
							<Trash2 className="size-3" />
						)}
					</Button>
				</div>
			</div>
		</DropdownMenuItem>
	);
}

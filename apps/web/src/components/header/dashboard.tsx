import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { useNavigate } from "@tanstack/react-router";
import { SidebarIcon, UserRound } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Separator } from "@/components/ui/separator";
import { useSidebar } from "@/components/ui/sidebar";
import { authClient } from "@/lib/auth-client";
import { Avatar, AvatarFallback, AvatarImage } from "../ui/avatar";
import { Skeleton } from "../ui/skeleton";
import { Tooltip, TooltipContent, TooltipTrigger } from "../ui/tooltip";

export const DashboardHeader = ({ scope }: { scope: string }) => {
	const sidebar = useSidebar();
	return (
		<header className="sticky top-0 z-50 flex w-full items-center border-b bg-sidebar">
			<div className="flex h-(--header-height) w-full items-center justify-between px-2">
				<div className="flex h-(--header-height) items-center gap-[7px]">
					<Tooltip>
						<TooltipTrigger asChild>
							<Button
								className="h-8 w-8"
								variant="ghost"
								size="icon"
								onClick={sidebar.toggleSidebar}
							>
								<SidebarIcon />
							</Button>
						</TooltipTrigger>
						<TooltipContent side="right">
							<p>{sidebar.open ? m.close_sidebar() : m.open_sidebar()}</p>
						</TooltipContent>
					</Tooltip>
					<Separator orientation="vertical" className="mr-2 h-4" />
					<h1 className="font-semibold text-xl">
						<span className="hidden md:inline">AkadeMove</span>
						<span className="ml-1 font-normal text-muted-foreground">
							{scope}
						</span>
					</h1>
				</div>
				<UserDropdwon />
			</div>
		</header>
	);
};

const UserDropdwon = () => {
	const navigate = useNavigate();
	const { data: user, isPending } = useQuery({
		queryKey: ["my-session"],
		queryFn: async () => {
			const ses = await authClient.getSession();
			return ses.data?.user;
		},
	});

	if (isPending) {
		return <Skeleton className="size-8 rounded-full" />;
	}

	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Avatar>
					<AvatarImage src={user?.image || ""} />
					<AvatarFallback>
						<UserRound />
					</AvatarFallback>
				</Avatar>
			</DropdownMenuTrigger>
			<DropdownMenuContent className="bg-card">
				<DropdownMenuLabel>My Account</DropdownMenuLabel>
				<DropdownMenuSeparator />
				<DropdownMenuItem>{user?.email}</DropdownMenuItem>
				<DropdownMenuItem asChild>
					<Button
						variant="destructive"
						className="w-full"
						onClick={() => {
							authClient.signOut({
								fetchOptions: {
									onSuccess: () => {
										navigate({ to: "/sign-in" });
									},
								},
							});
						}}
					>
						Sign Out
					</Button>
				</DropdownMenuItem>
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

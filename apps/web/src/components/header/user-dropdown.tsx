import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { Link, useNavigate } from "@tanstack/react-router";
import { UserRound } from "lucide-react";
import { Button, buttonVariants } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { authClient } from "@/lib/client/auth";
import { cn } from "@/utils/cn";
import { Avatar, AvatarFallback, AvatarImage } from "../ui/avatar";
import { Skeleton } from "../ui/skeleton";
import { DashboardNavigator } from "./dashboard-navigator";

export const UserDropdwon = () => {
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

	if (!user) {
		return (
			<div className="flex items-center gap-2">
				<Link
					to="/sign-in"
					className={cn(buttonVariants({ variant: "outline" }))}
				>
					{m.sign_in()}
				</Link>
				<Link to="/sign-up" className={cn(buttonVariants())}>
					{m.sign_up()}
				</Link>
			</div>
		);
	}

	return (
		<div className="flex items-center gap-2">
			<DashboardNavigator />
			<DropdownMenu>
				<DropdownMenuTrigger asChild>
					<Avatar className="border">
						<AvatarImage src={user.image || ""} />
						<AvatarFallback>
							<UserRound />
						</AvatarFallback>
					</Avatar>
				</DropdownMenuTrigger>
				<DropdownMenuContent align="end">
					<DropdownMenuLabel>My Account</DropdownMenuLabel>
					<DropdownMenuSeparator />
					<DropdownMenuItem>{user.email}</DropdownMenuItem>
					<DropdownMenuSeparator />
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
		</div>
	);
};

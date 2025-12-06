import { ORPCError } from "@orpc/client";
import { localizeHref, m } from "@repo/i18n";
import { useMutation, useQuery } from "@tanstack/react-query";
import { Link, useRouter } from "@tanstack/react-router";
import {
	BadgeCheck,
	LogOut,
	Settings,
	User as UserIcon,
	UserRound,
	Wallet,
} from "lucide-react";
import { useState } from "react";
import { SignUpDialog } from "@/components/dialogs/sign-up-dialog";
import { DashboardNavigator } from "@/components/header/dashboard-navigator";
import { Submitting } from "@/components/misc/submitting";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Button, buttonVariants } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Skeleton } from "@/components/ui/skeleton";
import { orpcClient, orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const UserDropdwon = () => {
	const router = useRouter();
	const [errorCount, setErrorCount] = useState(0);
	const { data, isPending } = useQuery(
		orpcQuery.auth.getSession.queryOptions({
			retry: 1,
			queryFn: async () => {
				if (errorCount > 2) {
					throw new ORPCError("UNAUTHORIZED", { message: "Invalid session" });
				}
				const res = await orpcQuery.auth.getSession.call();
				return res;
			},
			onSuccess: () => {
				setErrorCount(0);
			},
			onError: async () => {
				setErrorCount((prev) => prev + 1);
				queryClient.clear();
				await Promise.all([
					queryClient.invalidateQueries(),
					router.invalidate(),
				]);
			},
		}),
	);

	const walletQuery = useQuery({
		queryKey: ["wallet", "balance"],
		queryFn: async () => {
			if (!data?.body.data) return null;
			if (!["USER", "DRIVER"].includes(data.body.data.user.role)) return null;
			try {
				const result = await orpcClient.wallet.get({});
				return result;
			} catch {
				return null;
			}
		},
		enabled:
			!!data?.body.data &&
			["USER", "DRIVER"].includes(data.body.data.user.role),
		retry: false,
	});

	const mutation = useMutation(
		orpcQuery.auth.signOut.mutationOptions({
			onSuccess: async () => {
				setErrorCount(0);
				queryClient.clear();
				await Promise.all([
					queryClient.invalidateQueries(),
					router.invalidate(),
					router.navigate({ to: localizeHref("/sign-in") }),
				]);
			},
			onError: async () => {
				queryClient.clear();
				await Promise.all([
					queryClient.invalidateQueries(),
					router.invalidate(),
					router.navigate({ to: localizeHref("/sign-in") }),
				]);
			},
		}),
	);

	if (isPending) {
		return (
			<div className="flex items-center gap-2">
				<div className="p-1.5">
					<Skeleton className="size-6" />
				</div>
				<Skeleton className="h-10 w-32 rounded-full" />
			</div>
		);
	}

	if (!data?.body.data) {
		return (
			<div className="flex items-center gap-2">
				<Link
					to={localizeHref("/sign-in")}
					className={cn(buttonVariants({ variant: "outline" }))}
				>
					{m.sign_in()}
				</Link>
				<SignUpDialog asChild>
					<Button>{m.sign_up()}</Button>
				</SignUpDialog>
			</div>
		);
	}

	const user = data.body.data.user;

	const getRoleBadgeVariant = (
		role: string,
	): "default" | "secondary" | "outline" | "destructive" => {
		switch (role) {
			case "ADMIN":
				return "destructive";
			case "OPERATOR":
				return "default";
			case "MERCHANT":
				return "secondary";
			case "DRIVER":
				return "outline";
			default:
				return "secondary";
		}
	};

	function limitString(str: string, maxLength: number) {
		if (str.length <= maxLength) return str;
		return `${str.slice(0, maxLength)}...`;
	}

	return (
		<div className="flex items-center gap-2">
			<DashboardNavigator role={user.role} />
			<DropdownMenu>
				<DropdownMenuTrigger asChild>
					<Button
						variant="ghost"
						className="relative h-10 gap-2 rounded-full px-2"
					>
						<Avatar className="h-8 w-8 border">
							<AvatarImage src={user.image || ""} />
							<AvatarFallback>
								<UserRound className="h-4 w-4" />
							</AvatarFallback>
						</Avatar>
						<span className="hidden font-medium text-sm md:inline-block">
							{limitString(user.name, 10)}
						</span>
					</Button>
				</DropdownMenuTrigger>
				<DropdownMenuContent align="end" className="w-72">
					<DropdownMenuLabel className="font-normal">
						<div className="flex flex-col gap-2">
							<div className="flex items-center gap-2">
								<p className="font-medium text-sm leading-none">{user.name}</p>
								<Badge
									variant={getRoleBadgeVariant(user.role)}
									className="text-xs"
								>
									{user.role}
								</Badge>
							</div>
							<p className="text-muted-foreground text-xs leading-none">
								{user.email}
							</p>
						</div>
					</DropdownMenuLabel>

					{walletQuery.data?.body?.data && (
						<>
							<DropdownMenuSeparator />
							<div className="px-2 py-2">
								<div className="flex items-center justify-between rounded-md bg-muted/50 p-2">
									<div className="flex items-center gap-2">
										<Wallet className="h-4 w-4 text-muted-foreground" />
										<span className="text-muted-foreground text-sm">
											{m.wallet()} Balance
										</span>
									</div>
									<span className="font-semibold text-sm">
										Rp{" "}
										{Number(
											walletQuery.data.body.data.balance || 0,
										).toLocaleString("id-ID")}
									</span>
								</div>
							</div>
						</>
					)}

					<DropdownMenuSeparator />

					<DropdownMenuItem asChild>
						<Link
							to={localizeHref(`/dash/${user.role.toLowerCase()}/profile`)}
							className="cursor-pointer"
						>
							<UserIcon className="mr-2 h-4 w-4" />
							<span>{m.profile()}</span>
						</Link>
					</DropdownMenuItem>

					{["USER", "DRIVER"].includes(user.role) && (
						<DropdownMenuItem asChild>
							<Link
								to={localizeHref(`/dash/${user.role.toLowerCase()}/wallet`)}
								className="cursor-pointer"
							>
								<Wallet className="mr-2 h-4 w-4" />
								<span>{m.wallet()}</span>
							</Link>
						</DropdownMenuItem>
					)}

					{user.userBadges && user.userBadges.length > 0 && (
						<DropdownMenuItem disabled>
							<BadgeCheck className="mr-2 h-4 w-4" />
							<span>Badges ({user.userBadges.length})</span>
						</DropdownMenuItem>
					)}

					<DropdownMenuItem disabled>
						<Settings className="mr-2 h-4 w-4" />
						<span>Settings</span>
					</DropdownMenuItem>

					<DropdownMenuSeparator />

					<DropdownMenuItem asChild>
						<Button
							variant="ghost"
							className="w-full justify-start px-2 font-normal"
							disabled={mutation.isPending}
							onClick={async () => await mutation.mutateAsync({})}
						>
							{mutation.isPending ? (
								<Submitting />
							) : (
								<>
									<LogOut className="mr-2 h-4 w-4" />
									<span>{m.sign_out()}</span>
								</>
							)}
						</Button>
					</DropdownMenuItem>
				</DropdownMenuContent>
			</DropdownMenu>
		</div>
	);
};

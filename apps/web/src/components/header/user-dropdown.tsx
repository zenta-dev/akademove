import { localizeHref, m } from "@repo/i18n";
import { useMutation, useQuery } from "@tanstack/react-query";
import { Link, useRouter } from "@tanstack/react-router";
import { UserRound } from "lucide-react";
import { SignUpDialog } from "@/components/dialogs/sign-up-dialog";
import { DashboardNavigator } from "@/components/header/dashboard-navigator";
import { Submitting } from "@/components/misc/submitting";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
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
import { orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const UserDropdwon = () => {
	const router = useRouter();
	const { data, isPending } = useQuery(
		orpcQuery.auth.getSession.queryOptions({
			retry: 1,
		}),
	);

	const mutation = useMutation(
		orpcQuery.auth.signOut.mutationOptions({
			onSuccess: async () => {
				await Promise.all([
					queryClient.invalidateQueries(),
					router.invalidate(),
					router.navigate({ to: localizeHref("/sign-in") }),
				]);
			},
			onError: async () => {
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
				<Skeleton className="size-8 rounded-full" />
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

	return (
		<div className="flex items-center gap-2">
			<DashboardNavigator role={data.body.data.user.role} />
			<DropdownMenu>
				<DropdownMenuTrigger asChild>
					<Avatar className="border">
						<AvatarImage src={data.body.data.user.image || ""} />
						<AvatarFallback>
							<UserRound />
						</AvatarFallback>
					</Avatar>
				</DropdownMenuTrigger>
				<DropdownMenuContent align="end">
					<DropdownMenuLabel>My Account</DropdownMenuLabel>
					<DropdownMenuSeparator />
					<DropdownMenuItem>{data.body.data.user.email}</DropdownMenuItem>
					<DropdownMenuSeparator />
					<DropdownMenuItem asChild>
						<Button
							variant="destructive"
							className="w-full"
							disabled={mutation.isPending}
							onClick={async () => await mutation.mutateAsync({})}
						>
							{mutation.isPending ? <Submitting /> : m.sign_out()}
						</Button>
					</DropdownMenuItem>
				</DropdownMenuContent>
			</DropdownMenu>
		</div>
	);
};

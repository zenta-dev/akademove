import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import { useQuery } from "@tanstack/react-query";
import {
	createFileRoute,
	Link,
	redirect,
	useNavigate,
} from "@tanstack/react-router";
import {
	ArrowRight,
	Award,
	CalendarDays,
	Clock,
	CreditCard,
	DollarSign,
	Loader2,
	MapPin,
	Package,
	Ticket,
	TrendingUp,
	Wallet,
} from "lucide-react";
import { useMemo } from "react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardAction,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/user/")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.USER.OVERVIEW }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			user: ["get", "update"],
			order: ["create", "get", "update", "cancel"],
			review: ["create", "get", "update"],
			merchant: ["get"],
			coupon: ["get"],
			bookings: ["create", "get", "update", "delete"],
		});
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

function RouteComponent() {
	const { allowed } = Route.useLoaderData();
	const navigate = useNavigate();

	if (!allowed) navigate({ to: "/" });

	// Fetch wallet data
	const { data: walletData, isLoading: walletLoading } = useQuery({
		queryKey: ["wallet"],
		queryFn: async () => {
			const result = await orpcClient.wallet.get({});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		refetchInterval: 60000,
	});

	// Fetch wallet monthly summary
	const { data: walletSummary } = useQuery({
		queryKey: ["wallet", "summary", new Date().getMonth()],
		queryFn: async () => {
			const now = new Date();
			const result = await orpcClient.wallet.getMonthlySummary({
				query: {
					month: now.getMonth() + 1,
					year: now.getFullYear(),
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		refetchInterval: 60000,
	});

	// Fetch recent orders
	const { data: recentOrders, isLoading: ordersLoading } = useQuery({
		queryKey: ["user", "orders", "recent"],
		queryFn: async () => {
			const result = await orpcClient.order.list({
				query: {
					limit: 5,
					sortBy: "id",
					order: "desc",
					statuses: [
						"REQUESTED",
						"MATCHING",
						"ACCEPTED",
						"ARRIVING",
						"IN_TRIP",
					],
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		refetchInterval: 15000,
	});

	// Fetch completed orders for stats
	const { data: completedOrders } = useQuery({
		queryKey: ["user", "orders", "completed"],
		queryFn: async () => {
			const result = await orpcClient.order.list({
				query: {
					limit: 100,
					sortBy: "id",
					order: "desc",
					statuses: ["COMPLETED"],
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	// Fetch user badges
	const { data: userBadges } = useQuery({
		queryKey: ["user", "badges"],
		queryFn: async () => {
			const result = await orpcClient.badge.user.list({
				query: { limit: 10, sortBy: "id", order: "desc", mode: "offset" },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	// Fetch available coupons
	const { data: coupons } = useQuery({
		queryKey: ["user", "coupons"],
		queryFn: async () => {
			const result = await orpcClient.coupon.list({
				query: { limit: 5, sortBy: "id", order: "desc", mode: "offset" },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	const totalSpent = useMemo(() => {
		if (!completedOrders) return 0;
		return completedOrders.reduce(
			(sum, order) => sum + (order.totalPrice ?? 0),
			0,
		);
	}, [completedOrders]);

	const statusColors: Record<string, string> = {
		REQUESTED: "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300",
		MATCHING:
			"bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300",
		ACCEPTED: "bg-cyan-100 text-cyan-800 dark:bg-cyan-900 dark:text-cyan-300",
		ARRIVING:
			"bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-300",
		IN_TRIP:
			"bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300",
	};

	const formatStatus = (status: string) => {
		return status
			.split("_")
			.map((word) => word.charAt(0) + word.slice(1).toLowerCase())
			.join(" ");
	};

	const formatPrice = (price: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(price);
	};

	const formatDate = (date: Date) => {
		return new Intl.DateTimeFormat("id-ID", {
			month: "short",
			day: "numeric",
			hour: "2-digit",
			minute: "2-digit",
		}).format(new Date(date));
	};

	if (walletLoading) {
		return (
			<div className="flex min-h-[50vh] items-center justify-center">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.overview()}</h2>
					<p className="text-muted-foreground">
						Track your trips, wallet, and rewards
					</p>
				</div>
				<Button size="lg" asChild>
					<Link to="/dash/user/bookings">
						<Package className="mr-2 h-5 w-5" />
						New Booking
					</Link>
				</Button>
			</div>

			{/* Top Stats Cards */}
			<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							wallet Balance
						</CardTitle>
						<Wallet className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{formatPrice(walletData?.balance ?? 0)}
						</div>
						<p className="text-muted-foreground text-xs">
							Available for spending
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Spent</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">{formatPrice(totalSpent)}</div>
						<p className="text-muted-foreground text-xs">
							From {completedOrders?.length ?? 0} completed orders
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Monthly Spending
						</CardTitle>
						<CalendarDays className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{formatPrice(walletSummary?.totalExpense ?? 0)}
						</div>
						<p className="text-muted-foreground text-xs">This month</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Achievements</CardTitle>
						<Award className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">{userBadges?.length ?? 0}</div>
						<p className="text-muted-foreground text-xs">Badges earned</p>
					</CardContent>
				</Card>
			</div>

			{/* Active Orders & Quick Actions */}
			<div className="grid gap-4 md:grid-cols-2">
				{/* Active Orders */}
				<Card>
					<CardHeader className="border-b">
						<CardTitle>Active Orders</CardTitle>
						<CardDescription>Your current and upcoming trips</CardDescription>
						<CardAction>
							<Button variant="ghost" size="sm" asChild>
								<Link to="/dash/user/history">
									View All
									<ArrowRight className="ml-2 h-4 w-4" />
								</Link>
							</Button>
						</CardAction>
					</CardHeader>
					<CardContent className="space-y-4">
						{ordersLoading ? (
							<div className="flex items-center justify-center py-8">
								<Loader2 className="h-6 w-6 animate-spin text-muted-foreground" />
							</div>
						) : recentOrders && recentOrders.length > 0 ? (
							recentOrders.map((order: Order) => (
								<div
									key={order.id}
									className="flex items-center justify-between border-b pb-3 last:border-0 last:pb-0"
								>
									<div className="space-y-1">
										<div className="flex items-center gap-2">
											<p className="font-medium text-sm">
												Order #{order.id.slice(0, 8)}
											</p>
											<Badge
												variant="secondary"
												className={cn(
													"text-xs",
													statusColors[order.status] ?? "",
												)}
											>
												{formatStatus(order.status)}
											</Badge>
										</div>
										<div className="flex items-center gap-1 text-muted-foreground text-xs">
											<MapPin className="h-3 w-3" />
											<span>{order.distanceKm?.toFixed(1)} km</span>
											<span>•</span>
											<Clock className="h-3 w-3" />
											<span>{formatDate(order.createdAt)}</span>
										</div>
									</div>
									<div className="text-right">
										<p className="font-semibold text-sm">
											{formatPrice(order.totalPrice ?? 0)}
										</p>
										<p className="text-muted-foreground text-xs capitalize">
											{order.type.toLowerCase()}
										</p>
									</div>
								</div>
							))
						) : (
							<div className="flex flex-col items-center justify-center py-8 text-center">
								<Package className="mb-2 h-10 w-10 text-muted-foreground" />
								<p className="text-muted-foreground text-sm">
									No active orders
								</p>
								<Button variant="link" size="sm" asChild className="mt-2">
									<Link to="/dash/user/bookings">Place your first booking</Link>
								</Button>
							</div>
						)}
					</CardContent>
				</Card>

				{/* Quick Actions */}
				<div className="space-y-4">
					{/* wallet Card */}
					<Card>
						<CardHeader className="border-b">
							<CardTitle>wallet</CardTitle>
							<CardDescription>Manage your balance</CardDescription>
						</CardHeader>
						<CardContent className="space-y-3">
							<div className="flex items-center justify-between">
								<div>
									<p className="text-muted-foreground text-sm">
										Current Balance
									</p>
									<p className="font-bold text-2xl">
										{formatPrice(walletData?.balance ?? 0)}
									</p>
								</div>
								<CreditCard className="h-8 w-8 text-muted-foreground" />
							</div>
							<div className="grid grid-cols-2 gap-2">
								<Button variant="outline" size="sm" asChild>
									<Link to="/dash/user/wallet">
										<TrendingUp className="mr-2 h-4 w-4" />
										Top Up
									</Link>
								</Button>
								<Button variant="outline" size="sm" asChild>
									<Link to="/dash/user/wallet">
										<Clock className="mr-2 h-4 w-4" />
										History
									</Link>
								</Button>
							</div>
						</CardContent>
					</Card>

					{/* Available Coupons */}
					<Card>
						<CardHeader className="border-b">
							<CardTitle>Available Coupons</CardTitle>
							<CardDescription>Save on your next trip</CardDescription>
							<CardAction>
								<Button variant="ghost" size="sm" asChild>
									<Link to="/dash/user/profile">
										View All
										<ArrowRight className="ml-2 h-4 w-4" />
									</Link>
								</Button>
							</CardAction>
						</CardHeader>
						<CardContent className="space-y-3">
							{coupons && coupons.length > 0 ? (
								coupons.slice(0, 3).map((coupon) => (
									<div
										key={coupon.id}
										className="flex items-center justify-between rounded-lg border p-3"
									>
										<div className="flex items-center gap-3">
											<Ticket className="h-5 w-5 text-primary" />
											<div>
												<p className="font-medium text-sm">{coupon.code}</p>
												<p className="text-muted-foreground text-xs">
													{coupon.name}
												</p>
											</div>
										</div>
										<Badge variant="secondary">
											{coupon.rules?.general?.type === "PERCENTAGE"
												? `${coupon.discountPercentage ?? 0}%`
												: formatPrice(coupon.discountAmount ?? 0)}
										</Badge>
									</div>
								))
							) : (
								<div className="flex flex-col items-center justify-center py-4 text-center">
									<Ticket className="mb-2 h-8 w-8 text-muted-foreground" />
									<p className="text-muted-foreground text-sm">
										No coupons available
									</p>
								</div>
							)}
						</CardContent>
					</Card>
				</div>
			</div>

			{/* Achievements & Stats */}
			<div className="grid gap-4 md:grid-cols-2">
				{/* Recent Badges */}
				<Card>
					<CardHeader className="border-b">
						<CardTitle>Recent Achievements</CardTitle>
						<CardDescription>Your earned badges and milestones</CardDescription>
						<CardAction>
							<Button variant="ghost" size="sm" asChild>
								<Link to="/dash/user/profile">
									View Profile
									<ArrowRight className="ml-2 h-4 w-4" />
								</Link>
							</Button>
						</CardAction>
					</CardHeader>
					<CardContent className="space-y-3">
						{userBadges && userBadges.length > 0 ? (
							userBadges.slice(0, 4).map((userBadge) => (
								<div
									key={userBadge.id}
									className="flex items-center gap-3 rounded-lg border p-3"
								>
									<div className="flex h-10 w-10 items-center justify-center rounded-full bg-primary/10">
										<Award className="h-5 w-5 text-primary" />
									</div>
									<div className="flex-1">
										<p className="font-medium text-sm">
											{userBadge.badge?.name ?? "Badge"}
										</p>
										<p className="text-muted-foreground text-xs">
											Earned on {formatDate(userBadge.earnedAt ?? new Date())}
										</p>
									</div>
									<Badge variant="secondary" className="capitalize">
										{userBadge.badge?.level?.toLowerCase() ?? "bronze"}
									</Badge>
								</div>
							))
						) : (
							<div className="flex flex-col items-center justify-center py-8 text-center">
								<Award className="mb-2 h-10 w-10 text-muted-foreground" />
								<p className="text-muted-foreground text-sm">No badges yet</p>
								<p className="text-muted-foreground text-xs">
									Complete trips to earn achievements
								</p>
							</div>
						)}
					</CardContent>
				</Card>

				{/* Monthly Summary */}
				<Card>
					<CardHeader className="border-b">
						<CardTitle>Monthly Summary</CardTitle>
						<CardDescription>Your activity this month</CardDescription>
					</CardHeader>
					<CardContent>
						<div className="grid gap-4 md:grid-cols-2">
							<div className="space-y-2">
								<p className="text-muted-foreground text-sm">Total Spent</p>
								<p className="font-bold text-2xl text-orange-600">
									{formatPrice(walletSummary?.totalExpense ?? 0)}
								</p>
								<p className="text-muted-foreground text-xs">
									From wallet transactions
								</p>
							</div>
							<div className="space-y-2">
								<p className="text-muted-foreground text-sm">Orders</p>
								<p className="font-bold text-2xl text-green-600">
									{completedOrders?.length ?? 0}
								</p>
								<p className="text-muted-foreground text-xs">
									Completed this month
								</p>
							</div>
						</div>

						{walletData && (walletData.balance ?? 0) < 10000 && (
							<div className="mt-6 flex items-center justify-between rounded-lg bg-orange-50 p-4 dark:bg-orange-950">
								<div>
									<p className="font-medium text-orange-800 text-sm dark:text-orange-200">
										Low wallet balance
									</p>
									<p className="text-orange-600 text-xs dark:text-orange-400">
										Top up your wallet to place orders
									</p>
								</div>
								<Button variant="default" size="sm" asChild>
									<Link to="/dash/user/wallet">Top Up</Link>
								</Button>
							</div>
						)}
					</CardContent>
				</Card>
			</div>
		</>
	);
}

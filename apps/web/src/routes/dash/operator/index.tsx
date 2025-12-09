import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	DollarSign,
	Loader2,
	Package,
	ShoppingCart,
	TrendingUp,
	Users,
} from "lucide-react";
import { useMemo } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery } from "@/lib/orpc";

export const Route = createFileRoute("/dash/operator/")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.OVERVIEW }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["OPERATOR"]);
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

	const { data: statsResponse, isLoading } = useQuery(
		orpcQuery.user.admin.dashboardStats.queryOptions({
			input: { query: { period: "month" } },
		}),
	);

	const stats = useMemo(() => {
		return statsResponse?.body.data;
	}, [statsResponse]);

	if (isLoading) {
		return (
			<div className="flex min-h-[50vh] items-center justify-center">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.overview()}</h2>
				<p className="text-muted-foreground">
					Monitor campus operations and service metrics
				</p>
			</div>

			{/* Top Stats Cards */}
			<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Users</CardTitle>
						<Users className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{stats?.totalUsers?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							Active user accounts
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Drivers</CardTitle>
						<Users className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{stats?.totalDrivers?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							{stats?.onlineDrivers ?? 0} online now
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Total Merchants
						</CardTitle>
						<Package className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{stats?.totalMerchants?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							Registered merchants
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Active Orders</CardTitle>
						<ShoppingCart className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{stats?.activeOrders?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							Currently in progress
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Revenue & Order Stats */}
			<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Revenue</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							IDR {stats?.totalRevenue?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							From {stats?.completedOrders?.toLocaleString() ?? 0} completed
							orders
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Today's Revenue
						</CardTitle>
						<TrendingUp className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							IDR {stats?.todayRevenue?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							From {stats?.todayOrders?.toLocaleString() ?? 0} orders today
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Orders</CardTitle>
						<ShoppingCart className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{stats?.totalOrders?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							{stats?.cancelledOrders?.toLocaleString() ?? 0} cancelled
						</p>
					</CardContent>
				</Card>
			</div>
		</>
	);
}

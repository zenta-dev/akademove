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
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useFCM } from "@/hooks/use-fcm";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery } from "@/lib/orpc";

export const Route = createFileRoute("/dash/admin/")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.ADMIN.OVERVIEW }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["ADMIN"]);
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
	const fcm = useFCM();
	if (!allowed) navigate({ to: "/" });
	console.log("FCM initialized:", !!fcm);

	const { data: stats, isLoading } = useQuery(
		orpcQuery.user.admin.dashboardStats.queryOptions({
			input: { query: {} },
			refreshInterval: 60000, // Refetch every minute
		}),
	);

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
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
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
							{stats?.body.data.totalUsers?.toLocaleString() ?? 0}
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
							{stats?.body.data.totalDrivers?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							{stats?.body.data.onlineDrivers ?? 0} online now
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
							{stats?.body.data.totalMerchants?.toLocaleString() ?? 0}
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
							{stats?.body.data.activeOrders?.toLocaleString() ?? 0}
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
							IDR {stats?.body.data.totalRevenue?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							From {stats?.body.data.completedOrders?.toLocaleString() ?? 0}{" "}
							completed orders
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
							IDR {stats?.body.data.todayRevenue?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							From {stats?.body.data.todayOrders?.toLocaleString() ?? 0} orders
							today
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
							{stats?.body.data.totalOrders?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							{stats?.body.data.cancelledOrders?.toLocaleString() ?? 0}{" "}
							cancelled
						</p>
					</CardContent>
				</Card>
			</div>
		</>
	);
}

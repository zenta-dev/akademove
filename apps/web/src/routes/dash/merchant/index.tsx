import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	CircleDollarSign,
	Package,
	ShoppingCart,
	TrendingUp,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { useOrderUpdates } from "@/hooks/use-order-updates";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery } from "@/lib/orpc";
import { useMyMerchant } from "@/providers/merchant";

export const Route = createFileRoute("/dash/merchant/")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.MERCHANT.OVERVIEW }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["MERCHANT"]);
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
	const merchant = useMyMerchant();

	// Enable real-time order updates on dashboard (refreshes analytics too)
	useOrderUpdates({ enabled: true, interval: 10000 });

	// Fetch today's analytics
	const analytics = useQuery(
		orpcQuery.merchant.analytics.queryOptions({
			input: {
				params: { id: merchant.value?.id ?? "" },
				query: { period: "today" },
			},
			enabled: !!merchant.value?.id,
		}),
	);

	const formatCurrency = (value: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(value);
	};

	if (!allowed) navigate({ to: "/" });

	const statsData = analytics.data?.body.data;

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.overview()}</h2>
				<p className="text-muted-foreground">
					Monitor your orders, revenue, and performance
				</p>
			</div>

			{/* Today's Statistics */}
			<div className="grid gap-4 md:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Today's Revenue
						</CardTitle>
						<CircleDollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{analytics.isLoading ? (
							<Skeleton className="h-7 w-24" />
						) : (
							<>
								<div className="font-bold text-2xl">
									{formatCurrency(statsData?.totalRevenue ?? 0)}
								</div>
								<p className="text-muted-foreground text-xs">
									after {formatCurrency(statsData?.totalCommission ?? 0)}{" "}
									commission
								</p>
							</>
						)}
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Orders</CardTitle>
						<ShoppingCart className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{analytics.isLoading ? (
							<Skeleton className="h-7 w-16" />
						) : (
							<>
								<div className="font-bold text-2xl">
									{statsData?.totalOrders ?? 0}
								</div>
								<p className="text-muted-foreground text-xs">
									{statsData?.cancelledOrders ?? 0} cancelled
								</p>
							</>
						)}
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Avg Order Value
						</CardTitle>
						<TrendingUp className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{analytics.isLoading ? (
							<Skeleton className="h-7 w-24" />
						) : (
							<>
								<div className="font-bold text-2xl">
									{formatCurrency(statsData?.averageOrderValue ?? 0)}
								</div>
								<p className="text-muted-foreground text-xs">per order</p>
							</>
						)}
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Completion Rate
						</CardTitle>
						<Package className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{analytics.isLoading ? (
							<Skeleton className="h-7 w-16" />
						) : (
							<>
								<div className="font-bold text-2xl">
									{statsData && statsData.totalOrders > 0
										? `${((statsData.completedOrders / statsData.totalOrders) * 100).toFixed(1)}%`
										: "0%"}
								</div>
								<p className="text-muted-foreground text-xs">
									{statsData?.completedOrders ?? 0} of{" "}
									{statsData?.totalOrders ?? 0} completed
								</p>
							</>
						)}
					</CardContent>
				</Card>
			</div>

			{/* Quick Actions */}
			<div className="grid gap-4 md:grid-cols-3">
				<Card>
					<CardHeader>
						<CardTitle className="text-base">Orders</CardTitle>
						<CardDescription>Manage incoming orders</CardDescription>
					</CardHeader>
					<CardContent>
						<Button
							onClick={() =>
								navigate({
									to: "/dash/merchant/orders",
									search: { page: 1, limit: 15, mode: "offset", order: "desc" },
								})
							}
						>
							View Orders
						</Button>
					</CardContent>
				</Card>

				<Card>
					<CardHeader>
						<CardTitle className="text-base">Menu</CardTitle>
						<CardDescription>Update your menu items</CardDescription>
					</CardHeader>
					<CardContent>
						<Button
							onClick={() =>
								navigate({
									to: "/dash/merchant/menu",
									search: { page: 1, limit: 7, mode: "offset", order: "desc" },
								})
							}
							variant="outline"
						>
							Manage Menu
						</Button>
					</CardContent>
				</Card>

				<Card>
					<CardHeader>
						<CardTitle className="text-base">Sales</CardTitle>
						<CardDescription>View sales analytics</CardDescription>
					</CardHeader>
					<CardContent>
						<Button
							onClick={() =>
								navigate({
									to: "/dash/merchant/sales",
									search: { tab: "overview" },
								})
							}
							variant="outline"
						>
							View Sales
						</Button>
					</CardContent>
				</Card>
			</div>

			{/* Recent Activity Placeholder */}
			<Card className="flex-1">
				<CardHeader>
					<CardTitle>Recent Activity</CardTitle>
					<CardDescription>
						Your latest orders and important updates
					</CardDescription>
				</CardHeader>
				<CardContent className="flex flex-col items-center justify-center py-8">
					<Package className="mb-4 h-12 w-12 text-muted-foreground" />
					<p className="mb-4 text-center text-muted-foreground text-sm">
						View detailed analytics and order history in their respective
						sections
					</p>
					<div className="flex gap-2">
						<Button
							onClick={() =>
								navigate({
									to: "/dash/merchant/orders",
									search: { page: 1, limit: 15, mode: "offset", order: "desc" },
								})
							}
							variant="outline"
						>
							View All Orders
						</Button>
						<Button
							onClick={() =>
								navigate({
									to: "/dash/merchant/sales",
									search: { tab: "overview" },
								})
							}
							variant="outline"
						>
							View Sales Analytics
						</Button>
					</div>
				</CardContent>
			</Card>
		</>
	);
}

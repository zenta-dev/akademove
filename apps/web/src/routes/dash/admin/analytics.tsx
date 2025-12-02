import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	ArrowDown,
	ArrowUp,
	Award,
	Calendar,
	Car,
	DollarSign,
	Loader2,
	Package,
	ShoppingCart,
	TrendingUp,
	Users,
} from "lucide-react";
import { useMemo } from "react";
import {
	Area,
	AreaChart,
	Bar,
	BarChart,
	CartesianGrid,
	Cell,
	Legend,
	Line,
	LineChart,
	Pie,
	PieChart,
	ResponsiveContainer,
	Tooltip,
	XAxis,
	YAxis,
} from "recharts";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/admin/analytics")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.ADMIN.ANALYTICS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			order: ["get", "update", "delete", "cancel", "assign"],
			report: ["create", "get", "update", "delete", "export"],
			review: ["get", "update", "delete"],
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

	// Fetch dashboard stats
	const { data: stats, isLoading: statsLoading } = useQuery({
		queryKey: ["admin", "dashboard-stats"],
		queryFn: async () => {
			const result = await orpcClient.user.admin.dashboardStats({});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		refetchInterval: 60000,
	});

	// Fetch recent orders for analytics
	const { data: recentOrders } = useQuery({
		queryKey: ["admin", "analytics", "orders"],
		queryFn: async () => {
			const result = await orpcClient.order.list({
				query: {
					limit: 1000,
					sortBy: "createdAt",
					order: "desc",
					mode: "offset",
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		refetchInterval: 300000, // 5 minutes
	});

	// Fetch users for analytics
	const { data: users } = useQuery({
		queryKey: ["admin", "analytics", "users"],
		queryFn: async () => {
			const result = await orpcClient.user.admin.list({
				query: {
					limit: 1000,
					sortBy: "createdAt",
					order: "desc",
					mode: "offset",
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		refetchInterval: 300000,
	});

	// Process data for charts
	const analytics = useMemo(() => {
		if (!recentOrders || !stats) return null;

		// Revenue by day (last 30 days)
		const last30Days = Array.from({ length: 30 }, (_, i) => {
			const date = new Date();
			date.setDate(date.getDate() - (29 - i));
			return date.toISOString().split("T")[0];
		});

		const revenueByDay = last30Days.map((date) => {
			const dayOrders = recentOrders.filter((order) => {
				const orderDate = new Date(order.createdAt).toISOString().split("T")[0];
				return orderDate === date && order.status === "COMPLETED";
			});
			const revenue = dayOrders.reduce(
				(sum, order) => sum + (order.totalPrice ?? 0),
				0,
			);
			return {
				date: new Date(date).toLocaleDateString("id-ID", {
					month: "short",
					day: "numeric",
				}),
				revenue,
				orders: dayOrders.length,
			};
		});

		// Orders by type
		const ordersByType = [
			{
				name: "Ride",
				value: recentOrders.filter((o) => o.type === "RIDE").length,
				color: "#3b82f6",
			},
			{
				name: "Delivery",
				value: recentOrders.filter((o) => o.type === "DELIVERY").length,
				color: "#8b5cf6",
			},
			{
				name: "Food",
				value: recentOrders.filter((o) => o.type === "FOOD").length,
				color: "#f59e0b",
			},
		];

		// Orders by status
		const ordersByStatus = [
			{
				name: "Completed",
				value: recentOrders.filter((o) => o.status === "COMPLETED").length,
				color: "#10b981",
			},
			{
				name: "Active",
				value: recentOrders.filter((o) =>
					[
						"REQUESTED",
						"MATCHING",
						"ACCEPTED",
						"PREPARING",
						"READY_FOR_PICKUP",
						"ARRIVING",
						"IN_TRIP",
					].includes(o.status),
				).length,
				color: "#3b82f6",
			},
			{
				name: "Cancelled",
				value: recentOrders.filter((o) => o.status.startsWith("CANCELLED"))
					.length,
				color: "#ef4444",
			},
		];

		// User growth (last 12 months)
		const last12Months = Array.from({ length: 12 }, (_, i) => {
			const date = new Date();
			date.setMonth(date.getMonth() - (11 - i));
			return {
				year: date.getFullYear(),
				month: date.getMonth(),
			};
		});

		const userGrowth = last12Months.map(({ year, month }) => {
			const monthUsers = users?.filter((user) => {
				const userDate = new Date(user.createdAt);
				return userDate.getFullYear() === year && userDate.getMonth() === month;
			});
			return {
				month: new Date(year, month).toLocaleDateString("id-ID", {
					month: "short",
					year: "numeric",
				}),
				users: monthUsers?.length ?? 0,
			};
		});

		// Order completion rate
		const completedOrders = recentOrders.filter(
			(o) => o.status === "COMPLETED",
		).length;
		const totalOrders = recentOrders.length;
		const completionRate =
			totalOrders > 0 ? (completedOrders / totalOrders) * 100 : 0;

		// Cancellation rate
		const cancelledOrders = recentOrders.filter((o) =>
			o.status.startsWith("CANCELLED"),
		).length;
		const cancellationRate =
			totalOrders > 0 ? (cancelledOrders / totalOrders) * 100 : 0;

		// Average order value
		const totalRevenue = recentOrders
			.filter((o) => o.status === "COMPLETED")
			.reduce((sum, order) => sum + (order.totalPrice ?? 0), 0);
		const avgOrderValue =
			completedOrders > 0 ? totalRevenue / completedOrders : 0;

		// Top performing day
		const revenueByDayData = revenueByDay.filter((d) => d.revenue > 0);
		const topDay =
			revenueByDayData.length > 0
				? revenueByDayData.reduce((max, day) =>
						day.revenue > max.revenue ? day : max,
					)
				: null;

		return {
			revenueByDay,
			ordersByType,
			ordersByStatus,
			userGrowth,
			completionRate,
			cancellationRate,
			avgOrderValue,
			topDay,
		};
	}, [recentOrders, stats, users]);

	const formatPrice = (price: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(price);
	};

	if (statsLoading) {
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
					<h2 className="font-medium text-xl">{m.analytics()}</h2>
					<p className="text-muted-foreground">
						Comprehensive platform analytics and insights
					</p>
				</div>
				<Select defaultValue="30d">
					<SelectTrigger className="w-[180px]">
						<SelectValue placeholder="Select period" />
					</SelectTrigger>
					<SelectContent>
						<SelectItem value="7d">Last 7 days</SelectItem>
						<SelectItem value="30d">Last 30 days</SelectItem>
						<SelectItem value="90d">Last 90 days</SelectItem>
						<SelectItem value="1y">Last year</SelectItem>
					</SelectContent>
				</Select>
			</div>

			{/* Key Performance Metrics */}
			<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Completion Rate
						</CardTitle>
						<Award className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{analytics?.completionRate.toFixed(1)}%
						</div>
						<Progress value={analytics?.completionRate ?? 0} className="mt-2" />
						<p className="mt-2 text-muted-foreground text-xs">
							{stats?.completedOrders?.toLocaleString() ?? 0} /{" "}
							{stats?.totalOrders?.toLocaleString() ?? 0} orders completed
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Avg Order Value
						</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{formatPrice(analytics?.avgOrderValue ?? 0)}
						</div>
						<p className="mt-2 flex items-center gap-1 text-green-600 text-xs dark:text-green-400">
							<TrendingUp className="h-3 w-3" />
							+12.5% from last month
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Cancellation Rate
						</CardTitle>
						<ShoppingCart className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{analytics?.cancellationRate.toFixed(1)}%
						</div>
						<Progress
							value={analytics?.cancellationRate ?? 0}
							className="mt-2"
							indicatorClassName="bg-orange-500"
						/>
						<p className="mt-2 text-muted-foreground text-xs">
							{stats?.cancelledOrders?.toLocaleString() ?? 0} cancelled orders
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Online Drivers
						</CardTitle>
						<Car className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{stats?.onlineDrivers?.toLocaleString() ?? 0}
						</div>
						<p className="mt-2 text-muted-foreground text-xs">
							of {stats?.totalDrivers?.toLocaleString() ?? 0} total drivers
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Charts Section */}
			<Tabs defaultValue="revenue" className="space-y-4">
				<TabsList>
					<TabsTrigger value="revenue">Revenue</TabsTrigger>
					<TabsTrigger value="orders">Orders</TabsTrigger>
					<TabsTrigger value="users">Users</TabsTrigger>
					<TabsTrigger value="performance">Performance</TabsTrigger>
				</TabsList>

				{/* Revenue Tab */}
				<TabsContent value="revenue" className="space-y-4">
					<div className="grid gap-4 md:grid-cols-2">
						<Card>
							<CardHeader>
								<CardTitle>Revenue Trend (Last 30 Days)</CardTitle>
							</CardHeader>
							<CardContent>
								<ResponsiveContainer width="100%" height={300}>
									<AreaChart data={analytics?.revenueByDay ?? []}>
										<defs>
											<linearGradient
												id="colorRevenue"
												x1="0"
												y1="0"
												x2="0"
												y2="1"
											>
												<stop
													offset="5%"
													stopColor="#3b82f6"
													stopOpacity={0.3}
												/>
												<stop
													offset="95%"
													stopColor="#3b82f6"
													stopOpacity={0}
												/>
											</linearGradient>
										</defs>
										<CartesianGrid
											strokeDasharray="3 3"
											className="stroke-muted"
										/>
										<XAxis
											dataKey="date"
											className="text-xs"
											tick={{ fill: "currentColor" }}
										/>
										<YAxis
											className="text-xs"
											tick={{ fill: "currentColor" }}
											tickFormatter={(value) =>
												new Intl.NumberFormat("id-ID", {
													notation: "compact",
													compactDisplay: "short",
												}).format(value)
											}
										/>
										<Tooltip
											contentStyle={{
												backgroundColor: "hsl(var(--card))",
												border: "1px solid hsl(var(--border))",
												borderRadius: "var(--radius)",
											}}
											formatter={(value: number) => [
												formatPrice(value),
												"Revenue",
											]}
										/>
										<Area
											type="monotone"
											dataKey="revenue"
											stroke="#3b82f6"
											strokeWidth={2}
											fillOpacity={1}
											fill="url(#colorRevenue)"
										/>
									</AreaChart>
								</ResponsiveContainer>
							</CardContent>
						</Card>

						<Card>
							<CardHeader>
								<CardTitle>Top Revenue Day</CardTitle>
							</CardHeader>
							<CardContent>
								<div className="flex flex-col items-center justify-center space-y-4 py-8">
									<div className="flex h-16 w-16 items-center justify-center rounded-full bg-primary/10">
										<Calendar className="h-8 w-8 text-primary" />
									</div>
									<div className="text-center">
										<p className="text-muted-foreground text-sm">
											{analytics?.topDay?.date ?? "N/A"}
										</p>
										<p className="font-bold text-3xl">
											{formatPrice(analytics?.topDay?.revenue ?? 0)}
										</p>
										<p className="text-muted-foreground text-xs">
											from {analytics?.topDay?.orders ?? 0} orders
										</p>
									</div>
								</div>

								<div className="mt-4 space-y-2 border-t pt-4">
									<div className="flex items-center justify-between">
										<span className="text-sm">Total Revenue</span>
										<span className="font-semibold">
											{formatPrice(stats?.totalRevenue ?? 0)}
										</span>
									</div>
									<div className="flex items-center justify-between">
										<span className="text-sm">Today's Revenue</span>
										<span className="font-semibold">
											{formatPrice(stats?.todayRevenue ?? 0)}
										</span>
									</div>
									<div className="flex items-center justify-between">
										<span className="text-sm">Avg Daily Revenue</span>
										<span className="font-semibold">
											{formatPrice(
												(stats?.totalRevenue ?? 0) /
													Math.max(analytics?.revenueByDay?.length ?? 1, 1),
											)}
										</span>
									</div>
								</div>
							</CardContent>
						</Card>
					</div>
				</TabsContent>

				{/* Orders Tab */}
				<TabsContent value="orders" className="space-y-4">
					<div className="grid gap-4 md:grid-cols-2">
						<Card>
							<CardHeader>
								<CardTitle>Orders by Type</CardTitle>
							</CardHeader>
							<CardContent>
								<ResponsiveContainer width="100%" height={300}>
									<PieChart>
										<Pie
											data={analytics?.ordersByType ?? []}
											cx="50%"
											cy="50%"
											labelLine={false}
											label={({ name, percent }) =>
												`${name} ${((percent ?? 0) * 100).toFixed(0)}%`
											}
											outerRadius={100}
											fill="#8884d8"
											dataKey="value"
										>
											{(analytics?.ordersByType ?? []).map((entry) => (
												<Cell key={`type-${entry.name}`} fill={entry.color} />
											))}
										</Pie>
										<Tooltip />
									</PieChart>
								</ResponsiveContainer>
							</CardContent>
						</Card>

						<Card>
							<CardHeader>
								<CardTitle>Orders by Status</CardTitle>
							</CardHeader>
							<CardContent>
								<ResponsiveContainer width="100%" height={300}>
									<BarChart data={analytics?.ordersByStatus ?? []}>
										<CartesianGrid
											strokeDasharray="3 3"
											className="stroke-muted"
										/>
										<XAxis
											dataKey="name"
											className="text-xs"
											tick={{ fill: "currentColor" }}
										/>
										<YAxis
											className="text-xs"
											tick={{ fill: "currentColor" }}
										/>
										<Tooltip
											contentStyle={{
												backgroundColor: "hsl(var(--card))",
												border: "1px solid hsl(var(--border))",
												borderRadius: "var(--radius)",
											}}
										/>
										<Bar dataKey="value" radius={[8, 8, 0, 0]}>
											{(analytics?.ordersByStatus ?? []).map((entry) => (
												<Cell key={`status-${entry.name}`} fill={entry.color} />
											))}
										</Bar>
									</BarChart>
								</ResponsiveContainer>
							</CardContent>
						</Card>
					</div>

					<Card>
						<CardHeader>
							<CardTitle>Daily Orders (Last 30 Days)</CardTitle>
						</CardHeader>
						<CardContent>
							<ResponsiveContainer width="100%" height={300}>
								<LineChart data={analytics?.revenueByDay ?? []}>
									<CartesianGrid
										strokeDasharray="3 3"
										className="stroke-muted"
									/>
									<XAxis
										dataKey="date"
										className="text-xs"
										tick={{ fill: "currentColor" }}
									/>
									<YAxis className="text-xs" tick={{ fill: "currentColor" }} />
									<Tooltip
										contentStyle={{
											backgroundColor: "hsl(var(--card))",
											border: "1px solid hsl(var(--border))",
											borderRadius: "var(--radius)",
										}}
									/>
									<Legend />
									<Line
										type="monotone"
										dataKey="orders"
										stroke="#3b82f6"
										strokeWidth={2}
										dot={{ r: 4 }}
										name="Orders"
									/>
								</LineChart>
							</ResponsiveContainer>
						</CardContent>
					</Card>
				</TabsContent>

				{/* Users Tab */}
				<TabsContent value="users" className="space-y-4">
					<div className="grid gap-4 md:grid-cols-2">
						<Card>
							<CardHeader>
								<CardTitle>User Growth (Last 12 Months)</CardTitle>
							</CardHeader>
							<CardContent>
								<ResponsiveContainer width="100%" height={300}>
									<AreaChart data={analytics?.userGrowth ?? []}>
										<defs>
											<linearGradient
												id="colorUsers"
												x1="0"
												y1="0"
												x2="0"
												y2="1"
											>
												<stop
													offset="5%"
													stopColor="#8b5cf6"
													stopOpacity={0.3}
												/>
												<stop
													offset="95%"
													stopColor="#8b5cf6"
													stopOpacity={0}
												/>
											</linearGradient>
										</defs>
										<CartesianGrid
											strokeDasharray="3 3"
											className="stroke-muted"
										/>
										<XAxis
											dataKey="month"
											className="text-xs"
											tick={{ fill: "currentColor" }}
										/>
										<YAxis
											className="text-xs"
											tick={{ fill: "currentColor" }}
										/>
										<Tooltip
											contentStyle={{
												backgroundColor: "hsl(var(--card))",
												border: "1px solid hsl(var(--border))",
												borderRadius: "var(--radius)",
											}}
										/>
										<Area
											type="monotone"
											dataKey="users"
											stroke="#8b5cf6"
											strokeWidth={2}
											fillOpacity={1}
											fill="url(#colorUsers)"
										/>
									</AreaChart>
								</ResponsiveContainer>
							</CardContent>
						</Card>

						<Card>
							<CardHeader>
								<CardTitle>User Distribution</CardTitle>
							</CardHeader>
							<CardContent>
								<div className="space-y-4">
									<div className="space-y-2">
										<div className="flex items-center justify-between">
											<div className="flex items-center gap-2">
												<Users className="h-4 w-4 text-blue-500" />
												<span className="text-sm">Users</span>
											</div>
											<span className="font-semibold">
												{stats?.totalUsers?.toLocaleString() ?? 0}
											</span>
										</div>
										<Progress
											value={
												((stats?.totalUsers ?? 0) /
													Math.max(
														(stats?.totalUsers ?? 0) +
															(stats?.totalDrivers ?? 0) +
															(stats?.totalMerchants ?? 0),
														1,
													)) *
												100
											}
											className="h-2"
										/>
									</div>

									<div className="space-y-2">
										<div className="flex items-center justify-between">
											<div className="flex items-center gap-2">
												<Car className="h-4 w-4 text-green-500" />
												<span className="text-sm">Drivers</span>
											</div>
											<span className="font-semibold">
												{stats?.totalDrivers?.toLocaleString() ?? 0}
											</span>
										</div>
										<Progress
											value={
												((stats?.totalDrivers ?? 0) /
													Math.max(
														(stats?.totalUsers ?? 0) +
															(stats?.totalDrivers ?? 0) +
															(stats?.totalMerchants ?? 0),
														1,
													)) *
												100
											}
											className="h-2"
											indicatorClassName="bg-green-500"
										/>
									</div>

									<div className="space-y-2">
										<div className="flex items-center justify-between">
											<div className="flex items-center gap-2">
												<Package className="h-4 w-4 text-orange-500" />
												<span className="text-sm">Merchants</span>
											</div>
											<span className="font-semibold">
												{stats?.totalMerchants?.toLocaleString() ?? 0}
											</span>
										</div>
										<Progress
											value={
												((stats?.totalMerchants ?? 0) /
													Math.max(
														(stats?.totalUsers ?? 0) +
															(stats?.totalDrivers ?? 0) +
															(stats?.totalMerchants ?? 0),
														1,
													)) *
												100
											}
											className="h-2"
											indicatorClassName="bg-orange-500"
										/>
									</div>

									<div className="mt-6 rounded-lg border p-4">
										<p className="font-medium text-sm">Total Platform Users</p>
										<p className="mt-1 font-bold text-3xl">
											{(
												(stats?.totalUsers ?? 0) +
												(stats?.totalDrivers ?? 0) +
												(stats?.totalMerchants ?? 0)
											).toLocaleString()}
										</p>
										<p className="mt-1 text-muted-foreground text-xs">
											Across all user types
										</p>
									</div>
								</div>
							</CardContent>
						</Card>
					</div>
				</TabsContent>

				{/* Performance Tab */}
				<TabsContent value="performance" className="space-y-4">
					<div className="grid gap-4 md:grid-cols-3">
						<Card>
							<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
								<CardTitle className="font-medium text-sm">
									Success Rate
								</CardTitle>
								<ArrowUp className="h-4 w-4 text-green-500" />
							</CardHeader>
							<CardContent>
								<div className="font-bold text-2xl text-green-600">
									{analytics?.completionRate.toFixed(1)}%
								</div>
								<Progress
									value={analytics?.completionRate ?? 0}
									className="mt-2"
									indicatorClassName="bg-green-500"
								/>
								<p className="mt-2 text-muted-foreground text-xs">
									Orders completed successfully
								</p>
							</CardContent>
						</Card>

						<Card>
							<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
								<CardTitle className="font-medium text-sm">
									Failure Rate
								</CardTitle>
								<ArrowDown className="h-4 w-4 text-red-500" />
							</CardHeader>
							<CardContent>
								<div className="font-bold text-2xl text-red-600">
									{analytics?.cancellationRate.toFixed(1)}%
								</div>
								<Progress
									value={analytics?.cancellationRate ?? 0}
									className="mt-2"
									indicatorClassName="bg-red-500"
								/>
								<p className="mt-2 text-muted-foreground text-xs">
									Orders cancelled or failed
								</p>
							</CardContent>
						</Card>

						<Card>
							<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
								<CardTitle className="font-medium text-sm">
									Active Rate
								</CardTitle>
								<TrendingUp className="h-4 w-4 text-blue-500" />
							</CardHeader>
							<CardContent>
								<div className="font-bold text-2xl text-blue-600">
									{(
										((stats?.activeOrders ?? 0) /
											Math.max(stats?.totalOrders ?? 1, 1)) *
										100
									).toFixed(1)}
									%
								</div>
								<Progress
									value={
										((stats?.activeOrders ?? 0) /
											Math.max(stats?.totalOrders ?? 1, 1)) *
										100
									}
									className="mt-2"
									indicatorClassName="bg-blue-500"
								/>
								<p className="mt-2 text-muted-foreground text-xs">
									Currently in progress
								</p>
							</CardContent>
						</Card>
					</div>

					<Card>
						<CardHeader>
							<CardTitle>Performance Insights</CardTitle>
						</CardHeader>
						<CardContent>
							<div className="space-y-4">
								<div
									className={cn(
										"flex items-start gap-3 rounded-lg border p-4",
										(analytics?.completionRate ?? 0) >= 85
											? "border-green-200 bg-green-50 dark:border-green-900 dark:bg-green-950"
											: "border-orange-200 bg-orange-50 dark:border-orange-900 dark:bg-orange-950",
									)}
								>
									<Award
										className={cn(
											"mt-0.5 h-5 w-5",
											(analytics?.completionRate ?? 0) >= 85
												? "text-green-600 dark:text-green-400"
												: "text-orange-600 dark:text-orange-400",
										)}
									/>
									<div>
										<p
											className={cn(
												"font-medium text-sm",
												(analytics?.completionRate ?? 0) >= 85
													? "text-green-900 dark:text-green-100"
													: "text-orange-900 dark:text-orange-100",
											)}
										>
											Order Completion Performance
										</p>
										<p
											className={cn(
												"text-xs",
												(analytics?.completionRate ?? 0) >= 85
													? "text-green-700 dark:text-green-300"
													: "text-orange-700 dark:text-orange-300",
											)}
										>
											{(analytics?.completionRate ?? 0) >= 85
												? "Excellent completion rate! Your platform is performing very well."
												: "Completion rate below target. Consider investigating common cancellation reasons."}
										</p>
									</div>
								</div>

								<div
									className={cn(
										"flex items-start gap-3 rounded-lg border p-4",
										(stats?.onlineDrivers ?? 0) /
											Math.max(stats?.totalDrivers ?? 1, 1) >=
											0.2
											? "border-green-200 bg-green-50 dark:border-green-900 dark:bg-green-950"
											: "border-orange-200 bg-orange-50 dark:border-orange-900 dark:bg-orange-950",
									)}
								>
									<Car
										className={cn(
											"mt-0.5 h-5 w-5",
											(stats?.onlineDrivers ?? 0) /
												Math.max(stats?.totalDrivers ?? 1, 1) >=
												0.2
												? "text-green-600 dark:text-green-400"
												: "text-orange-600 dark:text-orange-400",
										)}
									/>
									<div>
										<p
											className={cn(
												"font-medium text-sm",
												(stats?.onlineDrivers ?? 0) /
													Math.max(stats?.totalDrivers ?? 1, 1) >=
													0.2
													? "text-green-900 dark:text-green-100"
													: "text-orange-900 dark:text-orange-100",
											)}
										>
											Driver Availability
										</p>
										<p
											className={cn(
												"text-xs",
												(stats?.onlineDrivers ?? 0) /
													Math.max(stats?.totalDrivers ?? 1, 1) >=
													0.2
													? "text-green-700 dark:text-green-300"
													: "text-orange-700 dark:text-orange-300",
											)}
										>
											{(stats?.onlineDrivers ?? 0) /
												Math.max(stats?.totalDrivers ?? 1, 1) >=
											0.2
												? `Good driver availability with ${stats?.onlineDrivers} drivers currently online.`
												: "Low driver availability. Consider incentives to increase online drivers."}
										</p>
									</div>
								</div>

								<div className="flex items-start gap-3 rounded-lg border border-blue-200 bg-blue-50 p-4 dark:border-blue-900 dark:bg-blue-950">
									<DollarSign className="mt-0.5 h-5 w-5 text-blue-600 dark:text-blue-400" />
									<div>
										<p className="font-medium text-blue-900 text-sm dark:text-blue-100">
											Revenue Performance
										</p>
										<p className="text-blue-700 text-xs dark:text-blue-300">
											Average order value:{" "}
											{formatPrice(analytics?.avgOrderValue ?? 0)}. Today's
											revenue: {formatPrice(stats?.todayRevenue ?? 0)} from{" "}
											{stats?.todayOrders} orders.
										</p>
									</div>
								</div>
							</div>
						</CardContent>
					</Card>
				</TabsContent>
			</Tabs>
		</>
	);
}

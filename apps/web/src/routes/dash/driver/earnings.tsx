import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	Calendar,
	DollarSign,
	Download,
	Loader2,
	Package,
	Star,
	TrendingUp,
} from "lucide-react";
import { useState } from "react";
import {
	Area,
	AreaChart,
	Bar,
	BarChart,
	CartesianGrid,
	Cell,
	Legend,
	Pie,
	PieChart,
	ResponsiveContainer,
	Tooltip,
	XAxis,
	YAxis,
} from "recharts";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Skeleton } from "@/components/ui/skeleton";
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/driver/earnings")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.DRIVER.EARNINGS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			order: ["get"],
		});
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

type Period = "today" | "week" | "month" | "year";

function RouteComponent() {
	const { allowed } = Route.useLoaderData();
	const navigate = useNavigate();
	const [selectedPeriod, setSelectedPeriod] = useState<Period>("month");

	if (!allowed) navigate({ to: "/" });

	// Fetch current driver info
	const { data: driver, isLoading: driverLoading } = useQuery({
		queryKey: ["driver", "me"],
		queryFn: async () => {
			const result = await orpcClient.driver.main.getMine({});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	// Fetch driver analytics
	const { data: analytics, isLoading: analyticsLoading } = useQuery({
		queryKey: ["driver", driver?.id, "analytics", selectedPeriod],
		queryFn: async () => {
			if (!driver?.id) throw new Error("Driver not found");
			const result = await orpcClient.driver.main.getAnalytics({
				params: { id: driver.id },
				query: { period: selectedPeriod },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		enabled: !!driver?.id,
	});

	const formatPrice = (price: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(price);
	};

	const handleExport = async () => {
		if (!driver?.id) return;

		try {
			// Calculate date range based on period
			const endDate = new Date();
			const startDate = new Date();

			switch (selectedPeriod) {
				case "today":
					startDate.setHours(0, 0, 0, 0);
					break;
				case "week":
					startDate.setDate(startDate.getDate() - 7);
					break;
				case "month":
					startDate.setMonth(startDate.getMonth() - 1);
					break;
				case "year":
					startDate.setFullYear(startDate.getFullYear() - 1);
					break;
			}

			const result = await orpcClient.analytics.exportDriverAnalytics({
				params: { driverId: driver.id },
				query: {
					startDate: startDate.toISOString(),
					endDate: endDate.toISOString(),
				},
			});

			// Create download link
			const blob = new Blob([result], { type: "text/csv" });
			const url = window.URL.createObjectURL(blob);
			const a = document.createElement("a");
			a.href = url;
			a.download = `driver-earnings-${selectedPeriod}-${new Date().toISOString().split("T")[0]}.csv`;
			document.body.appendChild(a);
			a.click();
			window.URL.revokeObjectURL(url);
			document.body.removeChild(a);
		} catch (error) {
			console.error("Export failed:", error);
		}
	};

	// Prepare chart colors
	const SERVICE_TYPE_COLORS: Record<string, string> = {
		RIDE: "#3b82f6",
		DELIVERY: "#8b5cf6",
		FOOD: "#f59e0b",
	};

	const earningsByTypeData = analytics?.earningsByType.map((item) => ({
		...item,
		color: SERVICE_TYPE_COLORS[item.type] || "#6b7280",
	}));

	const isLoading = driverLoading || analyticsLoading;

	if (isLoading) {
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
					<h2 className="font-medium text-xl">{m.earnings()}</h2>
					<p className="text-muted-foreground">
						Track your earnings and performance analytics
					</p>
				</div>
				<div className="flex gap-2">
					<Select
						value={selectedPeriod}
						onValueChange={(v) => setSelectedPeriod(v as Period)}
					>
						<SelectTrigger className="w-[150px]">
							<SelectValue />
						</SelectTrigger>
						<SelectContent>
							<SelectItem value="today">Today</SelectItem>
							<SelectItem value="week">This Week</SelectItem>
							<SelectItem value="month">This Month</SelectItem>
							<SelectItem value="year">This Year</SelectItem>
						</SelectContent>
					</Select>
					<Button variant="outline" size="sm" onClick={handleExport}>
						<Download className="mr-2 h-4 w-4" />
						Export CSV
					</Button>
				</div>
			</div>

			{/* Earnings Stats */}
			<div className="grid gap-4 md:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Total Earnings
						</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{formatPrice(analytics?.totalEarnings ?? 0)}
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							From {analytics?.completedOrders ?? 0} completed orders
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Commission Paid
						</CardTitle>
						<Package className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl text-orange-600">
							{formatPrice(analytics?.totalCommission ?? 0)}
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							Platform commission
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Net Earnings</CardTitle>
						<TrendingUp className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl text-green-600">
							{formatPrice(analytics?.netEarnings ?? 0)}
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							After commission
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Completion Rate
						</CardTitle>
						<Calendar className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div
							className={cn(
								"font-bold text-2xl",
								(analytics?.completionRate ?? 0) >= 85
									? "text-green-600"
									: "text-orange-600",
							)}
						>
							{(analytics?.completionRate ?? 0).toFixed(1)}%
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							{analytics?.completedOrders ?? 0} of {analytics?.totalOrders ?? 0}{" "}
							orders
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Additional Stats */}
			<div className="grid gap-4 md:grid-cols-3">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Average Rating
						</CardTitle>
						<Star className="h-4 w-4 text-yellow-500" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{(analytics?.averageRating ?? 0).toFixed(2)}
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							From completed orders
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Cancelled Orders
						</CardTitle>
						<Package className="h-4 w-4 text-red-500" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl text-red-600">
							{analytics?.cancelledOrders ?? 0}
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							{(
								((analytics?.cancelledOrders ?? 0) /
									Math.max(analytics?.totalOrders ?? 1, 1)) *
								100
							).toFixed(1)}
							% cancellation rate
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Orders</CardTitle>
						<Package className="h-4 w-4 text-blue-500" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{analytics?.totalOrders ?? 0}
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							All orders in period
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Charts Section */}
			<Tabs defaultValue="trends" className="space-y-4">
				<TabsList>
					<TabsTrigger value="trends">Trends</TabsTrigger>
					<TabsTrigger value="breakdown">Breakdown</TabsTrigger>
					<TabsTrigger value="top-days">Top Days</TabsTrigger>
				</TabsList>

				{/* Trends Tab */}
				<TabsContent value="trends" className="space-y-4">
					<Card>
						<CardHeader>
							<CardTitle>Earnings Trend</CardTitle>
							<CardDescription>
								Daily earnings over the selected period
							</CardDescription>
						</CardHeader>
						<CardContent>
							<ResponsiveContainer width="100%" height={350}>
								<AreaChart data={analytics?.earningsByDay ?? []}>
									<defs>
										<linearGradient
											id="colorEarnings"
											x1="0"
											y1="0"
											x2="0"
											y2="1"
										>
											<stop offset="5%" stopColor="#10b981" stopOpacity={0.3} />
											<stop offset="95%" stopColor="#10b981" stopOpacity={0} />
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
											"Earnings",
										]}
									/>
									<Legend />
									<Area
										type="monotone"
										dataKey="earnings"
										stroke="#10b981"
										strokeWidth={2}
										fillOpacity={1}
										fill="url(#colorEarnings)"
										name="Earnings"
									/>
								</AreaChart>
							</ResponsiveContainer>
						</CardContent>
					</Card>

					<Card>
						<CardHeader>
							<CardTitle>Daily Orders</CardTitle>
							<CardDescription>Number of orders per day</CardDescription>
						</CardHeader>
						<CardContent>
							<ResponsiveContainer width="100%" height={300}>
								<BarChart data={analytics?.earningsByDay ?? []}>
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
									<Bar dataKey="orders" fill="#3b82f6" radius={[8, 8, 0, 0]} />
								</BarChart>
							</ResponsiveContainer>
						</CardContent>
					</Card>
				</TabsContent>

				{/* Breakdown Tab */}
				<TabsContent value="breakdown" className="space-y-4">
					<div className="grid gap-4 md:grid-cols-2">
						<Card>
							<CardHeader>
								<CardTitle>Earnings by Service Type</CardTitle>
								<CardDescription>
									Distribution of earnings across services
								</CardDescription>
							</CardHeader>
							<CardContent>
								<ResponsiveContainer width="100%" height={300}>
									<PieChart>
										<Pie
											data={earningsByTypeData ?? []}
											cx="50%"
											cy="50%"
											labelLine={false}
											label={({ name, earnings }) =>
												`${name}: ${formatPrice(earnings)}`
											}
											outerRadius={100}
											fill="#8884d8"
											dataKey="earnings"
										>
											{(earningsByTypeData ?? []).map((entry) => (
												<Cell key={`type-${entry.type}`} fill={entry.color} />
											))}
										</Pie>
										<Tooltip
											formatter={(value: number) => formatPrice(value)}
										/>
									</PieChart>
								</ResponsiveContainer>
							</CardContent>
						</Card>

						<Card>
							<CardHeader>
								<CardTitle>Orders by Service Type</CardTitle>
								<CardDescription>
									Number of orders per service type
								</CardDescription>
							</CardHeader>
							<CardContent>
								<ResponsiveContainer width="100%" height={300}>
									<BarChart data={earningsByTypeData ?? []}>
										<CartesianGrid
											strokeDasharray="3 3"
											className="stroke-muted"
										/>
										<XAxis
											dataKey="type"
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
										<Bar dataKey="orders" radius={[8, 8, 0, 0]}>
											{(earningsByTypeData ?? []).map((entry) => (
												<Cell
													key={`type-bar-${entry.type}`}
													fill={entry.color}
												/>
											))}
										</Bar>
									</BarChart>
								</ResponsiveContainer>
							</CardContent>
						</Card>
					</div>
				</TabsContent>

				{/* Top Days Tab */}
				<TabsContent value="top-days" className="space-y-4">
					<Card>
						<CardHeader>
							<CardTitle>Top Earning Days</CardTitle>
							<CardDescription>
								Your best performing days this period
							</CardDescription>
						</CardHeader>
						<CardContent>
							{!analytics?.topEarningDays ||
							analytics.topEarningDays.length === 0 ? (
								<div className="flex flex-col items-center justify-center py-12 text-center">
									<Calendar className="mb-4 h-12 w-12 text-muted-foreground" />
									<h3 className="mb-2 font-semibold text-lg">No data yet</h3>
									<p className="text-muted-foreground text-sm">
										Complete orders to see your top earning days
									</p>
								</div>
							) : (
								<Table>
									<TableHeader>
										<TableRow>
											<TableHead>Rank</TableHead>
											<TableHead>Date</TableHead>
											<TableHead className="text-right">Orders</TableHead>
											<TableHead className="text-right">Earnings</TableHead>
										</TableRow>
									</TableHeader>
									<TableBody>
										{analytics.topEarningDays.map((day, index) => (
											<TableRow key={day.date}>
												<TableCell>
													<div className="flex items-center gap-2">
														{index === 0 && (
															<span className="text-2xl">🥇</span>
														)}
														{index === 1 && (
															<span className="text-2xl">🥈</span>
														)}
														{index === 2 && (
															<span className="text-2xl">🥉</span>
														)}
														{index > 2 && (
															<span className="font-medium">{index + 1}</span>
														)}
													</div>
												</TableCell>
												<TableCell className="font-medium">
													{day.date}
												</TableCell>
												<TableCell className="text-right">
													{day.orders}
												</TableCell>
												<TableCell className="text-right font-semibold text-green-600">
													{formatPrice(day.earnings)}
												</TableCell>
											</TableRow>
										))}
									</TableBody>
								</Table>
							)}
						</CardContent>
					</Card>
				</TabsContent>
			</Tabs>
		</>
	);
}

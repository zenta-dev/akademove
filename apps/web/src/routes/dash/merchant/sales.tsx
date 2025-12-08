import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";
import {
	ArrowDown,
	ArrowUp,
	CircleDollarSign,
	Download,
	FileText,
	Package,
	ShoppingCart,
	TrendingUp,
	XCircle,
} from "lucide-react";
import { useCallback, useMemo, useState } from "react";
import {
	Area,
	AreaChart,
	Bar,
	BarChart,
	CartesianGrid,
	ResponsiveContainer,
	Tooltip,
	XAxis,
	YAxis,
} from "recharts";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
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
import { orpcClient, orpcQuery } from "@/lib/orpc";
import { useMyMerchant } from "@/providers/merchant";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/merchant/sales")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.MERCHANT.SALES }] }),
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
	const [period, setPeriod] = useState<"today" | "week" | "month" | "year">(
		"week",
	);

	const analytics = useQuery(
		orpcQuery.merchant.analytics.queryOptions({
			input: {
				params: { id: merchant.value?.id ?? "" },
				query: { period },
			},
			enabled: !!merchant.value?.id,
		}),
	);

	const formatCurrency = useCallback((value: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(value);
	}, []);

	const statsCards = useMemo(() => {
		if (!analytics.data?.body.data) return null;
		const data = analytics.data.body.data;

		return [
			{
				title: m.total_revenue(),
				value: formatCurrency(data.totalRevenue),
				icon: CircleDollarSign,
				description: m.total_revenue_from_completed_orders(),
				trend: null,
				color: "text-green-600",
			},
			{
				title: m.total_orders(),
				value: data.totalOrders.toString(),
				icon: ShoppingCart,
				description: `${data.completedOrders} ${m.completed().toLowerCase()}`,
				trend: null,
				color: "text-blue-600",
			},
			{
				title: m.commission_earned(),
				value: formatCurrency(data.totalCommission),
				icon: TrendingUp,
				description: m.platform_commission(),
				trend: null,
				color: "text-purple-600",
			},
			{
				title: m.cancelled_orders(),
				value: data.cancelledOrders.toString(),
				icon: XCircle,
				description: m.cancelled_by_user_or_system(),
				trend: null,
				color: "text-red-600",
			},
			{
				title: m.average_order_value(),
				value: formatCurrency(data.averageOrderValue),
				icon: Package,
				description: m.per_completed_order(),
				trend: null,
				color: "text-orange-600",
			},
		];
	}, [analytics.data, formatCurrency]);

	const getPeriodLabel = useCallback((period: string) => {
		switch (period) {
			case "today":
				return m.today();
			case "week":
				return m.this_week();
			case "month":
				return m.this_month();
			case "year":
				return m.this_year();
			default:
				return period;
		}
	}, []);

	const handleExportPDF = useCallback(() => {
		if (!analytics.data?.body.data || !merchant.value) return;

		const data = analytics.data.body.data;
		const doc = new jsPDF();
		const pageWidth = doc.internal.pageSize.getWidth();

		// Header
		doc.setFontSize(20);
		doc.setFont("helvetica", "bold");
		doc.text("Sales Report", pageWidth / 2, 20, {
			align: "center",
		});

		doc.setFontSize(12);
		doc.setFont("helvetica", "normal");
		doc.text(merchant.value.name, pageWidth / 2, 28, { align: "center" });

		doc.setFontSize(10);
		doc.text(`Period: ${getPeriodLabel(period)}`, pageWidth / 2, 35, {
			align: "center",
		});
		doc.text(
			`Generated on: ${new Date().toLocaleDateString("id-ID", {
				weekday: "long",
				year: "numeric",
				month: "long",
				day: "numeric",
			})}`,
			pageWidth / 2,
			41,
			{ align: "center" },
		);

		// Summary Section
		doc.setFontSize(14);
		doc.setFont("helvetica", "bold");
		doc.text("Summary", 14, 55);

		autoTable(doc, {
			startY: 60,
			head: [["Metric", "Value"]],
			body: [
				[m.total_revenue(), formatCurrency(data.totalRevenue)],
				[m.total_orders(), data.totalOrders.toString()],
				["Completed Orders", data.completedOrders.toString()],
				[m.cancelled_orders(), data.cancelledOrders.toString()],
				[m.commission_earned(), formatCurrency(data.totalCommission)],
				[m.average_order_value(), formatCurrency(data.averageOrderValue)],
			],
			theme: "striped",
			headStyles: { fillColor: [34, 197, 94] },
		});

		// Revenue by Day Section
		if (data.revenueByDay.length > 0) {
			const finalY = (doc as unknown as { lastAutoTable: { finalY: number } })
				.lastAutoTable.finalY;

			doc.setFontSize(14);
			doc.setFont("helvetica", "bold");
			doc.text("Daily Breakdown", 14, finalY + 15);

			autoTable(doc, {
				startY: finalY + 20,
				head: [["Date", m.revenue(), m.orders()]],
				body: data.revenueByDay.map((day) => [
					new Date(`${day.date}T00:00:00`).toLocaleDateString("id-ID", {
						weekday: "short",
						year: "numeric",
						month: "short",
						day: "numeric",
					}),
					formatCurrency(day.revenue),
					day.orders.toString(),
				]),
				theme: "striped",
				headStyles: { fillColor: [59, 130, 246] },
			});
		}

		// Top Selling Items Section
		if (data.topSellingItems.length > 0) {
			const finalY = (doc as unknown as { lastAutoTable: { finalY: number } })
				.lastAutoTable.finalY;

			doc.setFontSize(14);
			doc.setFont("helvetica", "bold");
			doc.text(m.top_selling_items(), 14, finalY + 15);

			autoTable(doc, {
				startY: finalY + 20,
				head: [[m.item(), m.total_orders(), m.total_revenue()]],
				body: data.topSellingItems.map((item) => [
					item.menuName,
					item.totalOrders.toString(),
					formatCurrency(item.totalRevenue),
				]),
				theme: "striped",
				headStyles: { fillColor: [168, 85, 247] },
			});
		}

		// Footer
		const pageCount = doc.getNumberOfPages();
		for (let i = 1; i <= pageCount; i++) {
			doc.setPage(i);
			doc.setFontSize(8);
			doc.setFont("helvetica", "normal");
			doc.text(
				`Page ${i} of ${pageCount}`,
				pageWidth / 2,
				doc.internal.pageSize.getHeight() - 10,
				{ align: "center" },
			);
		}

		doc.save(
			`sales-report-${period}-${new Date().toISOString().split("T")[0]}.pdf`,
		);
		toast.success("Report exported successfully");
	}, [analytics.data, merchant.value, period, formatCurrency, getPeriodLabel]);

	const handleExportCSV = useCallback(async () => {
		if (!merchant.value?.id) return;

		try {
			const endDate = new Date();
			const startDate = new Date();

			switch (period) {
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

			const result = await orpcClient.analytics.exportMerchantAnalytics({
				params: { merchantId: merchant.value.id },
				query: {
					startDate: startDate.toISOString(),
					endDate: endDate.toISOString(),
				},
			});

			const csvData = result.status === 200 ? result.body : "";
			const blob = new Blob([csvData], { type: "text/csv" });
			const url = window.URL.createObjectURL(blob);
			const a = document.createElement("a");
			a.href = url;
			a.download = `sales-report-${period}-${new Date().toISOString().split("T")[0]}.csv`;
			document.body.appendChild(a);
			a.click();
			window.URL.revokeObjectURL(url);
			document.body.removeChild(a);
			toast.success("Report exported successfully");
		} catch (error) {
			console.error("Export failed:", error);
			toast.error("Failed to export report");
		}
	}, [merchant.value?.id, period]);

	if (!allowed) navigate({ to: "/" });

	if (merchant.isLoading || analytics.isLoading) {
		return (
			<>
				<div className="flex items-center justify-between">
					<div>
						<h2 className="font-medium text-xl">{m.sales()}</h2>
						<p className="text-muted-foreground">
							{m.view_your_sales_analytics()}
						</p>
					</div>
					<Skeleton className="h-10 w-32" />
				</div>
				<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
					{Array.from({ length: 5 }).map((_, i) => (
						<Skeleton key={`skeleton-${i + 1}`} className="h-32" />
					))}
				</div>
			</>
		);
	}

	if (analytics.isError || !analytics.data?.body.data) {
		return (
			<>
				<div>
					<h2 className="font-medium text-xl">{m.sales()}</h2>
					<p className="text-muted-foreground">
						{m.view_your_sales_analytics()}
					</p>
				</div>
				<Card>
					<CardContent className="p-8 text-center text-muted-foreground">
						{m.failed_to_load_analytics()}
					</CardContent>
				</Card>
			</>
		);
	}

	const data = analytics.data.body.data;

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.sales()}</h2>
					<p className="text-muted-foreground">
						{m.view_your_sales_analytics()}
					</p>
				</div>
				<div className="flex items-center gap-2">
					<DropdownMenu>
						<DropdownMenuTrigger asChild>
							<Button variant="outline" size="sm">
								<Download className="mr-2 h-4 w-4" />
								Export
							</Button>
						</DropdownMenuTrigger>
						<DropdownMenuContent align="end">
							<DropdownMenuItem onClick={handleExportPDF}>
								<FileText className="mr-2 h-4 w-4" />
								Export as PDF
							</DropdownMenuItem>
							<DropdownMenuItem onClick={handleExportCSV}>
								<Download className="mr-2 h-4 w-4" />
								Export as CSV
							</DropdownMenuItem>
						</DropdownMenuContent>
					</DropdownMenu>
					<Select
						value={period}
						onValueChange={(v) =>
							setPeriod(v as "today" | "week" | "month" | "year")
						}
					>
						<SelectTrigger className="w-32">
							<SelectValue />
						</SelectTrigger>
						<SelectContent>
							<SelectItem value="today">{m.today()}</SelectItem>
							<SelectItem value="week">{m.this_week()}</SelectItem>
							<SelectItem value="month">{m.this_month()}</SelectItem>
							<SelectItem value="year">{m.this_year()}</SelectItem>
						</SelectContent>
					</Select>
				</div>
			</div>

			{/* Stats Cards */}
			<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5">
				{statsCards?.map((stat) => (
					<Card key={stat.title}>
						<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
							<CardTitle className="font-medium text-sm">
								{stat.title}
							</CardTitle>
							<stat.icon className={cn("h-4 w-4", stat.color)} />
						</CardHeader>
						<CardContent>
							<div className="font-bold text-2xl">{stat.value}</div>
							<p className="text-muted-foreground text-xs">
								{stat.description}
							</p>
							{stat.trend && (
								<div
									className={cn(
										"mt-2 flex items-center gap-1 text-xs",
										stat.trend > 0 ? "text-green-600" : "text-red-600",
									)}
								>
									{stat.trend > 0 ? (
										<ArrowUp className="h-3 w-3" />
									) : (
										<ArrowDown className="h-3 w-3" />
									)}
									<span>
										{Math.abs(stat.trend)}% {m.from_last_period()}
									</span>
								</div>
							)}
						</CardContent>
					</Card>
				))}
			</div>

			{/* Charts Section */}
			<Tabs defaultValue="revenue" className="space-y-4">
				<TabsList>
					<TabsTrigger value="revenue">{m.revenue_trend()}</TabsTrigger>
					<TabsTrigger value="orders">{m.orders_trend()}</TabsTrigger>
				</TabsList>

				<TabsContent value="revenue" className="space-y-4">
					<Card>
						<CardHeader>
							<CardTitle>{m.revenue_over_time()}</CardTitle>
							<CardDescription>{m.daily_revenue_breakdown()}</CardDescription>
						</CardHeader>
						<CardContent className="h-[400px]">
							{data.revenueByDay.length === 0 ? (
								<div className="flex h-full items-center justify-center text-muted-foreground">
									{m.no_data_available()}
								</div>
							) : (
								<ResponsiveContainer width="100%" height="100%">
									<AreaChart data={data.revenueByDay}>
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
													stopColor="#10b981"
													stopOpacity={0.8}
												/>
												<stop
													offset="95%"
													stopColor="#10b981"
													stopOpacity={0}
												/>
											</linearGradient>
										</defs>
										<CartesianGrid strokeDasharray="3 3" />
										<XAxis
											dataKey="date"
											tick={{ fontSize: 12 }}
											tickFormatter={(value) => {
												// Handle YYYY-MM-DD format from database
												const date = new Date(`${value}T00:00:00`);
												return date.toLocaleDateString("id-ID", {
													month: "short",
													day: "numeric",
												});
											}}
										/>
										<YAxis
											tick={{ fontSize: 12 }}
											tickFormatter={(value) =>
												`Rp ${(value / 1000).toFixed(0)}k`
											}
										/>
										<Tooltip
											formatter={(value: number) => [
												formatCurrency(value),
												m.revenue(),
											]}
											labelFormatter={(label) => {
												// Handle YYYY-MM-DD format from database
												const date = new Date(`${label}T00:00:00`);
												return date.toLocaleDateString("id-ID", {
													weekday: "long",
													year: "numeric",
													month: "long",
													day: "numeric",
												});
											}}
										/>
										<Area
											type="monotone"
											dataKey="revenue"
											stroke="#10b981"
											fillOpacity={1}
											fill="url(#colorRevenue)"
										/>
									</AreaChart>
								</ResponsiveContainer>
							)}
						</CardContent>
					</Card>
				</TabsContent>

				<TabsContent value="orders" className="space-y-4">
					<Card>
						<CardHeader>
							<CardTitle>{m.orders_over_time()}</CardTitle>
							<CardDescription>{m.daily_orders_breakdown()}</CardDescription>
						</CardHeader>
						<CardContent className="h-[400px]">
							{data.revenueByDay.length === 0 ? (
								<div className="flex h-full items-center justify-center text-muted-foreground">
									{m.no_data_available()}
								</div>
							) : (
								<ResponsiveContainer width="100%" height="100%">
									<BarChart data={data.revenueByDay}>
										<CartesianGrid strokeDasharray="3 3" />
										<XAxis
											dataKey="date"
											tick={{ fontSize: 12 }}
											tickFormatter={(value) => {
												// Handle YYYY-MM-DD format from database
												const date = new Date(`${value}T00:00:00`);
												return date.toLocaleDateString("id-ID", {
													month: "short",
													day: "numeric",
												});
											}}
										/>
										<YAxis tick={{ fontSize: 12 }} />
										<Tooltip
											formatter={(value: number) => [value, m.orders()]}
											labelFormatter={(label) => {
												// Handle YYYY-MM-DD format from database
												const date = new Date(`${label}T00:00:00`);
												return date.toLocaleDateString("id-ID", {
													weekday: "long",
													year: "numeric",
													month: "long",
													day: "numeric",
												});
											}}
										/>
										<Bar
											dataKey="orders"
											fill="#3b82f6"
											radius={[8, 8, 0, 0]}
										/>
									</BarChart>
								</ResponsiveContainer>
							)}
						</CardContent>
					</Card>
				</TabsContent>
			</Tabs>

			{/* Top Selling Items */}
			<Card>
				<CardHeader>
					<CardTitle>{m.top_selling_items()}</CardTitle>
					<CardDescription>
						{m.most_popular_menu_items_in_period()}
					</CardDescription>
				</CardHeader>
				<CardContent>
					<Table>
						<TableHeader>
							<TableRow>
								<TableHead>{m.item()}</TableHead>
								<TableHead className="text-right">{m.total_orders()}</TableHead>
								<TableHead className="text-right">
									{m.total_revenue()}
								</TableHead>
							</TableRow>
						</TableHeader>
						<TableBody>
							{data.topSellingItems.length === 0 ? (
								<TableRow>
									<TableCell
										colSpan={3}
										className="text-center text-muted-foreground"
									>
										{m.no_data_available()}
									</TableCell>
								</TableRow>
							) : (
								data.topSellingItems.map((item) => (
									<TableRow key={item.menuId}>
										<TableCell>
											<div className="flex items-center gap-3">
												{item.menuImage && (
													<img
														src={item.menuImage}
														alt={item.menuName}
														className="h-10 w-10 rounded object-cover"
													/>
												)}
												<span className="font-medium">{item.menuName}</span>
											</div>
										</TableCell>
										<TableCell className="text-right">
											{item.totalOrders}
										</TableCell>
										<TableCell className="text-right">
											{formatCurrency(item.totalRevenue)}
										</TableCell>
									</TableRow>
								))
							)}
						</TableBody>
					</Table>
				</CardContent>
			</Card>
		</>
	);
}

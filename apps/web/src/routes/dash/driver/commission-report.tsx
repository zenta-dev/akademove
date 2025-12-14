import { m } from "@repo/i18n";
import type {
	CommissionReportPeriod,
	CommissionReportResponse,
	CommissionTransaction,
} from "@repo/schema/wallet";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";
import {
	ArrowDownLeft,
	ArrowUpRight,
	DollarSign,
	Download,
	FileText,
	Loader2,
	TrendingUp,
	Wallet as WalletIcon,
} from "lucide-react";
import { useCallback, useMemo, useState } from "react";
import {
	Area,
	AreaChart,
	CartesianGrid,
	Legend,
	ResponsiveContainer,
	Tooltip,
	XAxis,
	YAxis,
} from "recharts";
import { toast } from "sonner";
import { WithdrawDialog } from "@/components/dialogs/withdraw-wallet";
import { Badge } from "@/components/ui/badge";
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
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient, orpcQuery } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/driver/commission-report")({
	head: () => ({
		meta: [{ title: SUB_ROUTE_TITLES.DRIVER.COMMISSION_REPORT }],
	}),
	beforeLoad: async () => {
		const ok = await hasAccess(["DRIVER"]);
		if (!ok) redirect({ to: "/", throw: true });

		// Check if driver has passed quiz
		try {
			const driverResult = await orpcClient.driver.getMine();
			if (driverResult.body.data.quizStatus !== "PASSED") {
				redirect({ to: "/quiz/driver", throw: true });
			}
		} catch (error) {
			console.error("Failed to check quiz status:", error);
			redirect({ to: "/", throw: true });
		}

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
	const [withdrawDialogOpen, setWithdrawDialogOpen] = useState(false);
	const [selectedPeriod, setSelectedPeriod] =
		useState<CommissionReportPeriod>("daily");

	if (!allowed) navigate({ to: "/" });

	// Fetch driver data
	const { data: driverData, isLoading: driverLoading } = useQuery(
		orpcQuery.driver.getMine.queryOptions({
			input: {},
		}),
	);

	// Fetch commission report
	const { data: commissionReport, isLoading: reportLoading } = useQuery({
		queryKey: ["wallet", "commissionReport", selectedPeriod],
		queryFn: async () => {
			const result = await orpcClient.wallet.getCommissionReport({
				query: { period: selectedPeriod },
			});
			return result as {
				body: { data: CommissionReportResponse };
			};
		},
		refetchInterval: 60000,
	});

	const report = useMemo(
		() => commissionReport?.body.data,
		[commissionReport],
	) as CommissionReportResponse | undefined;

	const formatPrice = useCallback((price: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(price);
	}, []);

	const formatDate = useCallback((date: Date | string | undefined) => {
		if (!date) return "N/A";
		return new Intl.DateTimeFormat("id-ID", {
			weekday: "short",
			month: "short",
			day: "numeric",
			hour: "2-digit",
			minute: "2-digit",
		}).format(new Date(date));
	}, []);

	const transactionTypeConfig = useMemo<
		Record<string, { label: string; icon: typeof ArrowUpRight; color: string }>
	>(
		() => ({
			EARNING: {
				label: m.income(),
				icon: ArrowDownLeft,
				color: "text-green-600",
			},
			COMMISSION: {
				label: m.commission(),
				icon: ArrowUpRight,
				color: "text-orange-600",
			},
		}),
		[],
	);

	const handleExportPDF = useCallback(() => {
		if (!report || !driverData?.body.data) return;

		const doc = new jsPDF();
		const pageWidth = doc.internal.pageSize.getWidth();
		const periodLabel =
			selectedPeriod === "daily"
				? m.daily()
				: selectedPeriod === "weekly"
					? m.weekly()
					: m.monthly();

		// Header
		doc.setFontSize(20);
		doc.setFont("helvetica", "bold");
		doc.text(m.title_commission_report(), pageWidth / 2, 20, {
			align: "center",
		});

		doc.setFontSize(12);
		doc.setFont("helvetica", "normal");
		doc.text(driverData.body.data.user?.name ?? "Driver", pageWidth / 2, 28, {
			align: "center",
		});

		doc.setFontSize(10);
		doc.text(`Period: ${periodLabel}`, pageWidth / 2, 35, { align: "center" });
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
				[m.current_saldo(), formatPrice(report.currentBalance)],
				[m.incoming_balance(), formatPrice(report.incomingBalance)],
				[m.outgoing_balance(), formatPrice(report.outgoingBalance)],
				[m.earnings(), formatPrice(report.totalEarnings)],
				[m.commission(), formatPrice(report.totalCommission)],
				["Net Income", formatPrice(report.netIncome)],
				["Commission Rate", `${report.commissionRate.toFixed(2)}%`],
			],
			theme: "striped",
			headStyles: { fillColor: [59, 130, 246] },
		});

		// Transactions Section
		if (report.transactions.length > 0) {
			const finalY = (doc as unknown as { lastAutoTable: { finalY: number } })
				.lastAutoTable.finalY;

			doc.setFontSize(14);
			doc.setFont("helvetica", "bold");
			doc.text("Transactions", 14, finalY + 15);

			autoTable(doc, {
				startY: finalY + 20,
				head: [["Date", "Type", "Description", "Amount"]],
				body: report.transactions.map((t: CommissionTransaction) => [
					formatDate(t.createdAt),
					transactionTypeConfig[t.type]?.label ?? t.type,
					t.description ?? t.orderType ?? "N/A",
					`${t.type === "EARNING" ? "+" : "-"}${formatPrice(t.amount)}`,
				]),
				theme: "striped",
				headStyles: { fillColor: [34, 197, 94] },
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
			`driver-commission-report-${selectedPeriod}-${new Date().toISOString().split("T")[0]}.pdf`,
		);
		toast.success("Report exported successfully");
	}, [
		report,
		driverData?.body.data,
		selectedPeriod,
		formatPrice,
		formatDate,
		transactionTypeConfig,
	]);

	const handleExportCSV = useCallback(() => {
		if (!report || report.transactions.length === 0) {
			toast.error("No transactions to export");
			return;
		}

		const headers = ["Date", "Type", "Description", "Order Type", "Amount"];
		const rows = report.transactions.map((t: CommissionTransaction) => [
			formatDate(t.createdAt),
			transactionTypeConfig[t.type]?.label ?? t.type,
			t.description ?? "N/A",
			t.orderType ?? "N/A",
			`${t.type === "EARNING" ? "+" : "-"}${t.amount}`,
		]);

		const csvContent = [headers, ...rows]
			.map((row) => row.map((cell: string | number) => `"${cell}"`).join(","))
			.join("\n");

		const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
		const url = window.URL.createObjectURL(blob);
		const a = document.createElement("a");
		a.href = url;
		a.download = `driver-commission-report-${selectedPeriod}-${new Date().toISOString().split("T")[0]}.csv`;
		document.body.appendChild(a);
		a.click();
		window.URL.revokeObjectURL(url);
		document.body.removeChild(a);
		toast.success("Report exported successfully");
	}, [report, selectedPeriod, formatDate, transactionTypeConfig]);

	if (driverLoading || reportLoading) {
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
					<h2 className="font-medium text-xl">{m.title_commission_report()}</h2>
					<p className="text-muted-foreground">
						Track your earnings, commissions, and wallet balance
					</p>
				</div>
				<div className="flex items-center gap-2">
					<Select
						value={selectedPeriod}
						onValueChange={(v) =>
							setSelectedPeriod(v as CommissionReportPeriod)
						}
					>
						<SelectTrigger className="w-[130px]">
							<SelectValue />
						</SelectTrigger>
						<SelectContent>
							<SelectItem value="daily">{m.daily()}</SelectItem>
							<SelectItem value="weekly">{m.weekly()}</SelectItem>
							<SelectItem value="monthly">{m.monthly()}</SelectItem>
						</SelectContent>
					</Select>
				</div>
			</div>

			{/* Balance Stats */}
			<div className="grid gap-4 md:grid-cols-3">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							{m.current_saldo()}
						</CardTitle>
						<WalletIcon className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{reportLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl">
								{formatPrice(report?.currentBalance ?? 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							Available for withdrawal
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							{m.incoming_balance()}
						</CardTitle>
						<ArrowDownLeft className="h-4 w-4 text-green-600" />
					</CardHeader>
					<CardContent>
						{reportLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl text-green-600">
								{formatPrice(report?.incomingBalance ?? 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							Total earnings in period
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							{m.outgoing_balance()}
						</CardTitle>
						<ArrowUpRight className="h-4 w-4 text-orange-600" />
					</CardHeader>
					<CardContent>
						{reportLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl text-orange-600">
								{formatPrice(report?.outgoingBalance ?? 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							Commission & withdrawals
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Earnings & Commission Stats */}
			<div className="grid gap-4 md:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							{m.earnings()}
						</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{reportLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl">
								{formatPrice(report?.totalEarnings ?? 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							From completed orders
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							{m.commission()}
						</CardTitle>
						<TrendingUp className="h-4 w-4 text-orange-500" />
					</CardHeader>
					<CardContent>
						{reportLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl text-orange-600">
								{formatPrice(report?.totalCommission ?? 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							{(report?.commissionRate ?? 0).toFixed(2)}% of earnings
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Net Income</CardTitle>
						<TrendingUp className="h-4 w-4 text-green-500" />
					</CardHeader>
					<CardContent>
						{reportLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl text-green-600">
								{formatPrice(report?.netIncome ?? 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							After commission
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Commission Rate
						</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{reportLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl">
								{(report?.commissionRate ?? 0).toFixed(2)}%
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">Platform fee</p>
					</CardContent>
				</Card>
			</div>

			{/* Chart */}
			<Card>
				<CardHeader>
					<CardTitle>{m.income_outcome_chart()}</CardTitle>
					<CardDescription>
						{selectedPeriod === "daily"
							? "Hourly breakdown"
							: selectedPeriod === "weekly"
								? "Daily breakdown"
								: "Weekly breakdown"}
					</CardDescription>
				</CardHeader>
				<CardContent>
					{reportLoading ? (
						<Skeleton className="h-[350px] w-full" />
					) : report?.chartData && report.chartData.length > 0 ? (
						<ResponsiveContainer width="100%" height={350}>
							<AreaChart data={report.chartData}>
								<defs>
									<linearGradient id="colorIncome" x1="0" y1="0" x2="0" y2="1">
										<stop offset="5%" stopColor="#10b981" stopOpacity={0.3} />
										<stop offset="95%" stopColor="#10b981" stopOpacity={0} />
									</linearGradient>
									<linearGradient id="colorOutcome" x1="0" y1="0" x2="0" y2="1">
										<stop offset="5%" stopColor="#f97316" stopOpacity={0.3} />
										<stop offset="95%" stopColor="#f97316" stopOpacity={0} />
									</linearGradient>
								</defs>
								<CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
								<XAxis
									dataKey="label"
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
									formatter={(value: number, name: string) => [
										formatPrice(value),
										name === "income" ? m.income() : m.outcome(),
									]}
								/>
								<Legend />
								<Area
									type="monotone"
									dataKey="income"
									stroke="#10b981"
									strokeWidth={2}
									fillOpacity={1}
									fill="url(#colorIncome)"
									name={m.income()}
								/>
								<Area
									type="monotone"
									dataKey="outcome"
									stroke="#f97316"
									strokeWidth={2}
									fillOpacity={1}
									fill="url(#colorOutcome)"
									name={m.outcome()}
								/>
							</AreaChart>
						</ResponsiveContainer>
					) : (
						<div className="flex flex-col items-center justify-center py-12 text-center">
							<WalletIcon className="mb-4 h-12 w-12 text-muted-foreground" />
							<h3 className="mb-2 font-semibold text-lg">No data available</h3>
							<p className="text-muted-foreground text-sm">
								Complete orders to see your earnings chart
							</p>
						</div>
					)}
				</CardContent>
			</Card>

			{/* Transaction History */}
			<Card>
				<CardHeader>
					<div className="flex items-center justify-between">
						<div>
							<CardTitle>{m.balance_details()}</CardTitle>
							<CardDescription>
								Recent earnings and commission transactions
							</CardDescription>
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
										{m.export_pdf()}
									</DropdownMenuItem>
									<DropdownMenuItem onClick={handleExportCSV}>
										<Download className="mr-2 h-4 w-4" />
										Export as CSV
									</DropdownMenuItem>
								</DropdownMenuContent>
							</DropdownMenu>
							<Button onClick={() => setWithdrawDialogOpen(true)}>
								{m.withdrawal()}
							</Button>
						</div>
					</div>
				</CardHeader>
				<CardContent>
					{reportLoading ? (
						<div className="space-y-3">
							<Skeleton className="h-12 w-full" />
							<Skeleton className="h-12 w-full" />
							<Skeleton className="h-12 w-full" />
						</div>
					) : !report?.transactions || report.transactions.length === 0 ? (
						<div className="flex flex-col items-center justify-center py-12 text-center">
							<WalletIcon className="mb-4 h-12 w-12 text-muted-foreground" />
							<h3 className="mb-2 font-semibold text-lg">
								{m.no_transactions_yet()}
							</h3>
							<p className="text-muted-foreground text-sm">
								Your earnings will appear here once you complete orders
							</p>
						</div>
					) : (
						<Table>
							<TableHeader>
								<TableRow>
									<TableHead>Type</TableHead>
									<TableHead>Description</TableHead>
									<TableHead>Order Type</TableHead>
									<TableHead className="text-right">Amount</TableHead>
									<TableHead>Date</TableHead>
								</TableRow>
							</TableHeader>
							<TableBody>
								{report.transactions.map((transaction) => {
									const config =
										transactionTypeConfig[transaction.type] ??
										transactionTypeConfig.EARNING;
									const Icon = config.icon;
									const isIncome = transaction.type === "EARNING";

									return (
										<TableRow key={transaction.id}>
											<TableCell>
												<div className="flex items-center gap-2">
													<Icon className={cn("h-4 w-4", config.color)} />
													<span className="font-medium">{config.label}</span>
												</div>
											</TableCell>
											<TableCell className="text-muted-foreground">
												{transaction.description ?? "N/A"}
											</TableCell>
											<TableCell>
												{transaction.orderType ? (
													<Badge variant="secondary">
														{transaction.orderType}
													</Badge>
												) : (
													"N/A"
												)}
											</TableCell>
											<TableCell
												className={cn(
													"text-right font-semibold",
													isIncome ? "text-green-600" : "text-red-600",
												)}
											>
												{isIncome ? "+" : "-"}
												{formatPrice(transaction.amount)}
											</TableCell>
											<TableCell className="text-muted-foreground">
												{formatDate(transaction.createdAt)}
											</TableCell>
										</TableRow>
									);
								})}
							</TableBody>
						</Table>
					)}
				</CardContent>
			</Card>

			<WithdrawDialog
				open={withdrawDialogOpen}
				onOpenChange={setWithdrawDialogOpen}
				availableBalance={report?.currentBalance ?? 0}
			/>
		</>
	);
}

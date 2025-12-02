import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import type { Transaction } from "@repo/schema/transaction";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	ArrowDownLeft,
	ArrowUpRight,
	Calendar,
	DollarSign,
	TrendingUp,
	Wallet as WalletIcon,
} from "lucide-react";
import { useState } from "react";
import { WithdrawDialog } from "@/components/dialogs/withdraw-wallet";

import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/driver/earnings")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.DRIVER.EARNINGS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			report: ["get"],
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
	const search = Route.useSearch();
	const [selectedPeriod, setSelectedPeriod] = useState<
		"week" | "month" | "all"
	>("month");
	const [withdrawDialogOpen, setWithdrawDialogOpen] = useState(false);

	if (!allowed) navigate({ to: "/" });

	// Fetch wallet data
	const { data: wallet, isLoading: walletLoading } = useQuery({
		queryKey: ["wallet"],
		queryFn: async () => {
			const result = await orpcClient.wallet.get({});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	// Fetch transactions
	const { data: transactionsResult, isLoading: transactionsLoading } = useQuery(
		{
			queryKey: ["transactions", search],
			queryFn: async () => {
				const result = await orpcClient.transaction.list({
					query: search,
				});
				if (result.status !== 200) throw new Error(result.body.message);
				return result.body;
			},
		},
	);

	// Fetch monthly summary
	const { data: monthlySummary, isLoading: monthlySummaryLoading } = useQuery({
		queryKey: ["wallet", "summary", "month"],
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
	});

	// Fetch weekly summary (last 7 days)
	const { data: weeklySummary } = useQuery({
		queryKey: ["wallet", "summary", "week"],
		queryFn: async () => {
			const now = new Date();
			const weekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
			const result = await orpcClient.wallet.getMonthlySummary({
				query: {
					month: weekAgo.getMonth() + 1,
					year: weekAgo.getFullYear(),
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	const formatPrice = (price: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(price);
	};

	const formatDate = (date: Date | string | undefined) => {
		if (!date) return "N/A";
		return new Intl.DateTimeFormat("id-ID", {
			weekday: "short",
			month: "short",
			day: "numeric",
			hour: "2-digit",
			minute: "2-digit",
		}).format(new Date(date));
	};

	const transactionTypeConfig: Record<
		string,
		{ label: string; icon: typeof ArrowUpRight; color: string }
	> = {
		EARNING: {
			label: "Earning",
			icon: ArrowDownLeft,
			color: "text-green-600",
		},
		COMMISSION: {
			label: "Commission",
			icon: ArrowUpRight,
			color: "text-orange-600",
		},
		WITHDRAWAL: {
			label: "Withdrawal",
			icon: ArrowUpRight,
			color: "text-blue-600",
		},
		REFUND: {
			label: "Refund",
			icon: ArrowDownLeft,
			color: "text-purple-600",
		},
		PAYMENT: {
			label: "Payment",
			icon: ArrowUpRight,
			color: "text-red-600",
		},
	};

	const currentSummary =
		selectedPeriod === "week" ? weeklySummary : monthlySummary;

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.earnings()}</h2>
				<p className="text-muted-foreground">
					Track your earnings and transaction history
				</p>
			</div>

			{/* Period Selector */}
			<Tabs
				value={selectedPeriod}
				onValueChange={(v) => setSelectedPeriod(v as typeof selectedPeriod)}
			>
				<TabsList>
					<TabsTrigger value="week">This Week</TabsTrigger>
					<TabsTrigger value="month">This Month</TabsTrigger>
					<TabsTrigger value="all">All Time</TabsTrigger>
				</TabsList>
			</Tabs>

			{/* Earnings Stats */}
			<div className="grid gap-4 md:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Current Balance
						</CardTitle>
						<WalletIcon className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{walletLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl">
								{formatPrice(wallet?.balance ?? 0)}
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
							{selectedPeriod === "week" ? "Weekly" : "Monthly"} Earnings
						</CardTitle>
						<TrendingUp className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{monthlySummaryLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl text-green-600">
								{formatPrice(currentSummary?.totalIncome ?? 0)}
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
							Commission Paid
						</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{monthlySummaryLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl text-orange-600">
								{formatPrice(currentSummary?.totalExpense ?? 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							Platform commission
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Net Income</CardTitle>
						<Calendar className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{monthlySummaryLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div
								className={cn(
									"font-bold text-2xl",
									(currentSummary?.net ?? 0) >= 0
										? "text-green-600"
										: "text-red-600",
								)}
							>
								{formatPrice(currentSummary?.net ?? 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							After commission
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Withdrawal Button */}
			{wallet && wallet.balance >= 50000 && (
				<Card className="border-green-200 bg-green-50 dark:border-green-800 dark:bg-green-950">
					<CardContent className="flex items-center justify-between py-4">
						<div>
							<p className="font-medium text-green-800 text-sm dark:text-green-200">
								Ready to withdraw?
							</p>
							<p className="text-green-600 text-xs dark:text-green-400">
								You have {formatPrice(wallet.balance)} available for withdrawal
							</p>
						</div>
						<Button
							variant="default"
							onClick={() => setWithdrawDialogOpen(true)}
						>
							Request Withdrawal
						</Button>
					</CardContent>
				</Card>
			)}

			{/* Transaction History */}
			<Card>
				<CardHeader>
					<CardTitle>Transaction History</CardTitle>
					<CardDescription>View all your earnings and expenses</CardDescription>
				</CardHeader>
				<CardContent>
					{transactionsLoading ? (
						<div className="space-y-3">
							<Skeleton className="h-12 w-full" />
							<Skeleton className="h-12 w-full" />
							<Skeleton className="h-12 w-full" />
						</div>
					) : !transactionsResult?.data ||
						transactionsResult.data.length === 0 ? (
						<div className="flex flex-col items-center justify-center py-12 text-center">
							<WalletIcon className="mb-4 h-12 w-12 text-muted-foreground" />
							<h3 className="mb-2 font-semibold text-lg">
								No transactions yet
							</h3>
							<p className="text-muted-foreground text-sm">
								Complete orders to start earning
							</p>
						</div>
					) : (
						<Table>
							<TableHeader>
								<TableRow>
									<TableHead>Type</TableHead>
									<TableHead>Description</TableHead>
									<TableHead>Date</TableHead>
									<TableHead className="text-right">Amount</TableHead>
								</TableRow>
							</TableHeader>
							<TableBody>
								{transactionsResult.data.map((transaction: Transaction) => {
									const config = transactionTypeConfig[transaction.type] ?? {
										label: transaction.type,
										icon: ArrowDownLeft,
										color: "text-gray-600",
									};
									const Icon = config.icon;
									const isCredit =
										transaction.type === "EARNING" ||
										transaction.type === "REFUND";

									return (
										<TableRow key={transaction.id}>
											<TableCell>
												<div className="flex items-center gap-2">
													<div
														className={cn(
															"rounded-full p-1",
															isCredit
																? "bg-green-100 dark:bg-green-900"
																: "bg-red-100 dark:bg-red-900",
														)}
													>
														<Icon className={cn("h-4 w-4", config.color)} />
													</div>
													<span className="font-medium text-sm">
														{config.label}
													</span>
												</div>
											</TableCell>
											<TableCell className="text-muted-foreground text-sm">
												{transaction.description || "No description"}
											</TableCell>
											<TableCell className="text-muted-foreground text-sm">
												{formatDate(transaction.createdAt)}
											</TableCell>
											<TableCell className="text-right">
												<span
													className={cn(
														"font-semibold",
														isCredit ? "text-green-600" : "text-red-600",
													)}
												>
													{isCredit ? "+" : "-"}
													{formatPrice(Math.abs(transaction.amount))}
												</span>
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
				availableBalance={wallet?.balance || 0}
			/>
		</>
	);
}

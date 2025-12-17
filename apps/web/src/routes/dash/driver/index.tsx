import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, Link, redirect } from "@tanstack/react-router";
import {
	Activity,
	AlertCircle,
	ArrowRight,
	Calendar,
	Car,
	DollarSign,
	Loader2,
	MapPin,
	ShoppingCart,
	Star,
	TrendingUp,
} from "lucide-react";
import { useCallback, useEffect, useMemo } from "react";
import { toast } from "sonner";
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
import { orpcClient, orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/driver/")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.DRIVER.OVERVIEW }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["DRIVER"]);
		if (!ok) redirect({ to: "/", throw: true });

		// Check driver verification status
		try {
			const driverResult = await orpcClient.driver.getMine();
			const driver = driverResult.body.data;

			// If quiz not passed, redirect to quiz page
			if (driver.quizStatus !== "PASSED") {
				redirect({ to: "/quiz/driver", throw: true });
			}
		} catch (error) {
			console.error("Failed to check driver status:", error);
			redirect({ to: "/", throw: true });
		}

		return { allowed: ok };
	},
	component: RouteComponent,
});

function RouteComponent() {
	// Fetch driver data
	const { data: driverData, isLoading: driverLoading } = useQuery(
		orpcQuery.driver.getMine.queryOptions({
			input: {},
			refreshInterval: 30000,
		}),
	);

	// Show verification status toast on mount or when driverData changes
	useEffect(() => {
		if (!driverData?.body?.data) return;

		const status = driverData.body.data.status;
		if (status === "PENDING") {
			toast.info("Account Pending Approval", {
				description:
					"An admin will review your documents and activate your account soon.",
				duration: 5000,
			});
		} else if (status === "REJECTED") {
			toast.error("Account Rejected", {
				description:
					"Your account has been rejected. Please contact support for more information.",
				duration: 10000,
			});
		} else if (status === "INACTIVE") {
			toast.warning("Account Inactive", {
				description:
					"Your account has been deactivated. Please contact support.",
				duration: 10000,
			});
		}
	}, [driverData?.body?.data?.status, driverData?.body?.data]);

	// Fetch wallet data for earnings
	const { data: walletData, isLoading: walletLoading } = useQuery(
		orpcQuery.wallet.get.queryOptions({
			input: {},
			refreshInterval: 60000,
		}),
	);

	// Fetch wallet monthly summary
	const { data: walletSummary } = useQuery(
		orpcQuery.wallet.getMonthlySummary.queryOptions({
			input: {
				query: (() => {
					const now = new Date();
					return {
						month: now.getMonth() + 1,
						year: now.getFullYear(),
					};
				})(),
			},
			refreshInterval: 60000,
		}),
	);

	// Fetch recent orders
	const { data: recentOrders, isLoading: ordersLoading } = useQuery(
		orpcQuery.order.list.queryOptions({
			input: {
				query: {
					limit: 5,
					sortBy: "id",
					order: "desc",
					statuses: ["ACCEPTED", "ARRIVING", "IN_TRIP"],
				},
			},
			refreshInterval: 15000,
		}),
	);

	// Fetch commission report for all-time total earnings
	const { data: commissionReport } = useQuery({
		queryKey: orpcQuery.wallet.getCommissionReport.queryKey({
			input: { query: { period: "daily" } },
		}),
		queryFn: async () => {
			const result = await orpcClient.wallet.getCommissionReport({
				query: { period: "daily" },
			});
			return result;
		},
		refetchInterval: 60000,
	});

	// Toggle online status mutation
	const toggleOnlineMutation = useMutation(
		orpcQuery.driver.update.mutationOptions({
			onSuccess: async (data) => {
				await queryClient.invalidateQueries();
				toast.success(
					data.body.data.isTakingOrder
						? "You are now online and accepting orders"
						: "You are now offline",
				);
			},
			onError: (error) => {
				toast.error(`Failed to update status: ${error.message}`);
			},
		}),
	);

	const handleToggleOnline = useCallback(() => {
		if (!driverData) return;
		toggleOnlineMutation.mutate({
			params: { id: driverData.body.data.id },
			// eslint-disable-next-line @typescript-eslint/no-explicit-any
			body: {
				isTakingOrder: !driverData.body.data.isTakingOrder,
			},
		});
	}, [driverData, toggleOnlineMutation]);

	const driverStatusBadge = useMemo(() => {
		if (!driverData) return null;
		if (driverData.body.data.status === "PENDING") {
			return (
				<Badge variant="secondary" className="bg-yellow-100 text-yellow-800">
					Pending Approval
				</Badge>
			);
		}
		if (driverData.body.data.status === "REJECTED") {
			return (
				<Badge variant="secondary" className="bg-red-100 text-red-800">
					Rejected
				</Badge>
			);
		}
		if (driverData.body.data.status === "INACTIVE") {
			return (
				<Badge variant="secondary" className="bg-gray-100 text-gray-800">
					Inactive
				</Badge>
			);
		}
		return null;
	}, [driverData]);

	// Get today's earnings from commission report (daily period)
	const todaysEarnings = useMemo(() => {
		return commissionReport?.body?.data?.totalEarnings ?? 0;
	}, [commissionReport?.body?.data?.totalEarnings]);

	const statusColors: Record<string, string> = {
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

	if (driverLoading || walletLoading) {
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
						Track your earnings and manage your trips
					</p>
				</div>
				{driverData?.body.data.status === "APPROVED" && (
					<Button
						size="lg"
						variant={
							driverData.body.data.isTakingOrder ? "destructive" : "default"
						}
						onClick={handleToggleOnline}
						disabled={toggleOnlineMutation.isPending}
						className="gap-2"
					>
						{toggleOnlineMutation.isPending ? (
							<Loader2 className="h-5 w-5 animate-spin" />
						) : (
							<Activity className="h-5 w-5" />
						)}
						{driverData.body.data.isTakingOrder ? "Go Offline" : "Go Online"}
					</Button>
				)}
			</div>

			{/* Status Alert */}
			{driverStatusBadge && (
				<Card className="border-yellow-200 bg-yellow-50 dark:border-yellow-800 dark:bg-yellow-950">
					<CardContent className="flex items-center gap-3">
						<AlertCircle className="h-5 w-5 text-yellow-600" />
						<div className="flex-1">
							<p className="font-medium text-sm text-yellow-800 dark:text-yellow-200">
								Account Status: {driverStatusBadge}
							</p>
							<p className="text-xs text-yellow-700 dark:text-yellow-300">
								{driverData?.body.data.status === "PENDING" &&
									"Your driver account is under review. You'll be notified once approved."}
								{driverData?.body.data.status === "REJECTED" &&
									"Your driver application was rejected. Please contact support for more information."}
								{driverData?.body.data.status === "INACTIVE" &&
									"Your account is currently inactive. Please contact support to reactivate."}
							</p>
						</div>
					</CardContent>
				</Card>
			)}

			{/* Top Stats Cards */}
			<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Wallet Balance
						</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{formatPrice(walletData?.body.data.balance ?? 0)}
						</div>
						<p className="text-muted-foreground text-xs">
							Available for withdrawal
						</p>
					</CardContent>
				</Card>

				<Link to="/dash/driver/commission-report" className="block">
					<Card className="cursor-pointer transition-colors hover:bg-muted/50">
						<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
							<CardTitle className="font-medium text-sm">
								Today's Earnings
							</CardTitle>
							<TrendingUp className="h-4 w-4 text-muted-foreground" />
						</CardHeader>
						<CardContent>
							<div className="font-bold text-2xl">
								{formatPrice(todaysEarnings)}
							</div>
							<p className="text-muted-foreground text-xs">
								Click for detailed report
							</p>
						</CardContent>
					</Card>
				</Link>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Monthly Income
						</CardTitle>
						<Calendar className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{formatPrice(walletSummary?.body.data.totalIncome ?? 0)}
						</div>
						<p className="text-muted-foreground text-xs">This month's income</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Rating</CardTitle>
						<Star className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="flex items-center gap-1 font-bold text-2xl">
							{driverData?.body.data.rating?.toFixed(1) ?? "0.0"}
							<Star className="h-5 w-5 fill-yellow-400 text-yellow-400" />
						</div>
						<p className="text-muted-foreground text-xs">
							Customer satisfaction
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Active Orders & Driver Info */}
			<div className="grid gap-4 md:grid-cols-2">
				{/* Active Orders */}
				<Card>
					<CardHeader className="border-b">
						<CardTitle>Active Trips</CardTitle>
						<CardDescription>Your current and upcoming orders</CardDescription>
						<CardAction>
							<Button variant="ghost" size="sm" asChild>
								<Link
									to="/dash/driver/orders"
									search={{ page: 1, limit: 15, order: "desc", mode: "offset" }}
								>
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
						) : recentOrders && recentOrders.body.data.length > 0 ? (
							recentOrders.body.data.map((order: Order) => (
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
											<span>{formatDate(order.createdAt)}</span>
										</div>
									</div>
									<div className="text-right">
										<p className="font-semibold text-sm">
											{formatPrice(
												order.driverEarning ?? order.totalPrice * 0.8,
											)}
										</p>
										<p className="text-muted-foreground text-xs">
											Your earning
										</p>
									</div>
								</div>
							))
						) : (
							<div className="flex flex-col items-center justify-center py-8 text-center">
								<ShoppingCart className="mb-2 h-10 w-10 text-muted-foreground" />
								<p className="text-muted-foreground text-sm">
									{driverData?.body.data.isTakingOrder
										? "No active trips. Waiting for orders..."
										: "Go online to start accepting orders"}
								</p>
							</div>
						)}
					</CardContent>
				</Card>

				{/* Driver Info */}
				<Card>
					<CardHeader className="border-b">
						<CardTitle>Driver Information</CardTitle>
						<CardDescription>Your account details and status</CardDescription>
						<CardAction>
							<Button variant="ghost" size="sm" asChild>
								<Link to="/dash/driver/profile">
									Edit Profile
									<ArrowRight className="ml-2 h-4 w-4" />
								</Link>
							</Button>
						</CardAction>
					</CardHeader>
					<CardContent className="space-y-4">
						<div className="space-y-3">
							<div className="flex items-center justify-between">
								<div className="flex items-center gap-2 text-muted-foreground text-sm">
									<Car className="h-4 w-4" />
									<span>Vehicle</span>
								</div>
								<p className="font-medium text-sm">
									{driverData?.body.data.licensePlate ?? "N/A"}
								</p>
							</div>

							<div className="flex items-center justify-between">
								<div className="flex items-center gap-2 text-muted-foreground text-sm">
									<Activity className="h-4 w-4" />
									<span>Status</span>
								</div>
								<Badge
									variant={
										driverData?.body.data.isTakingOrder
											? "default"
											: "secondary"
									}
								>
									{driverData?.body.data.isTakingOrder ? "Online" : "Offline"}
								</Badge>
							</div>

							<div className="flex items-center justify-between">
								<div className="flex items-center gap-2 text-muted-foreground text-sm">
									<Star className="h-4 w-4" />
									<span>Rating</span>
								</div>
								<p className="font-medium text-sm">
									{driverData?.body.data.rating?.toFixed(2) ?? "0.00"} / 5.00
								</p>
							</div>

							<div className="flex items-center justify-between">
								<div className="flex items-center gap-2 text-muted-foreground text-sm">
									<AlertCircle className="h-4 w-4" />
									<span>Cancellations</span>
								</div>
								<p className="font-medium text-sm">
									{driverData?.body.data.cancellationCount ?? 0}
								</p>
							</div>
						</div>

						{(driverData?.body.data.cancellationCount ?? 0) >= 3 && (
							<div className="mt-4 rounded-lg bg-red-50 p-3 dark:bg-red-950">
								<p className="font-medium text-red-800 text-sm dark:text-red-200">
									Warning: High Cancellation Rate
								</p>
								<p className="text-red-600 text-xs dark:text-red-400">
									Multiple cancellations may affect your account status. Please
									complete accepted orders.
								</p>
							</div>
						)}
					</CardContent>
				</Card>
			</div>

			{/* Earnings Breakdown */}
			<Card>
				<CardHeader className="border-b">
					<CardTitle>Monthly Summary</CardTitle>
					<CardDescription>Your income and expenses this month</CardDescription>
				</CardHeader>
				<CardContent>
					<div className="grid gap-4 md:grid-cols-3">
						<div className="space-y-2">
							<p className="text-muted-foreground text-sm">Total Income</p>
							<p className="font-bold text-2xl text-green-600">
								{formatPrice(walletSummary?.body.data.totalIncome ?? 0)}
							</p>
							<p className="text-muted-foreground text-xs">Money earned</p>
						</div>
						<div className="space-y-2">
							<p className="text-muted-foreground text-sm">Total Expenses</p>
							<p className="font-bold text-2xl text-orange-600">
								{formatPrice(walletSummary?.body.data.totalExpense ?? 0)}
							</p>
							<p className="text-muted-foreground text-xs">Money spent</p>
						</div>
						<div className="space-y-2">
							<p className="text-muted-foreground text-sm">Net Balance</p>
							<p
								className={cn(
									"font-bold text-2xl",
									(walletSummary?.body.data.net ?? 0) >= 0
										? "text-green-600"
										: "text-red-600",
								)}
							>
								{formatPrice(walletSummary?.body.data.net ?? 0)}
							</p>
							<p className="text-muted-foreground text-xs">Overall balance</p>
						</div>
					</div>

					{walletSummary &&
						walletData &&
						(walletData.body.data.balance ?? 0) > 50000 && (
							<div className="mt-6 flex items-center justify-between rounded-lg bg-green-50 p-4 dark:bg-green-950">
								<div>
									<p className="font-medium text-green-800 text-sm dark:text-green-200">
										Ready to withdraw?
									</p>
									<p className="text-green-600 text-xs dark:text-green-400">
										You have {formatPrice(walletData.body.data.balance)}{" "}
										available for withdrawal
									</p>
								</div>
								<Button variant="default" size="sm" asChild>
									<Link to="/dash/driver/earnings">Withdraw</Link>
								</Button>
							</div>
						)}
				</CardContent>
			</Card>
		</>
	);
}

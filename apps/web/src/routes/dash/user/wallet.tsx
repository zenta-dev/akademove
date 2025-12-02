import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import type { Transaction } from "@repo/schema/transaction";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	ArrowDownLeft,
	ArrowUpRight,
	DollarSign,
	Plus,
	TrendingDown,
	Wallet as WalletIcon,
} from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
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
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
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
import { orpcClient, orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/user/wallet")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.USER.WALLET }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			user: ["get"],
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
	const [topUpDialogOpen, setTopUpDialogOpen] = useState(false);
	const [topUpAmount, setTopUpAmount] = useState("");
	const [paymentMethod, setPaymentMethod] = useState<string>("QRIS");

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
	const { data: summary, isLoading: summaryLoading } = useQuery({
		queryKey: ["wallet", "summary"],
		queryFn: async () => {
			const now = new Date();
			const result = await orpcClient.wallet.getMonthlySummary({
				query: {
					year: now.getFullYear(),
					month: now.getMonth() + 1,
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	// Top-up mutation
	const topUpMutation = useMutation(
		orpcQuery.wallet.topUp.mutationOptions({
			onSuccess: (result) => {
				queryClient.invalidateQueries({ queryKey: ["wallet"] });
				queryClient.invalidateQueries({ queryKey: ["transactions"] });
				setTopUpDialogOpen(false);
				setTopUpAmount("");

				const data = result.body.data;
				// Open payment URL if available
				if (data.response?.redirect_url) {
					window.open(data.response.redirect_url, "_blank");
					toast.success("Payment link opened. Complete payment to top up.");
				} else {
					toast.success("Top-up initiated successfully");
				}
			},
			onError: (error) => {
				toast.error(error.message || "Failed to initiate top-up");
			},
		}),
	);

	if (!allowed) navigate({ to: "/" });

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
		TOPUP: {
			label: "Top Up",
			icon: ArrowDownLeft,
			color: "text-green-600 dark:text-green-400",
		},
		PAYMENT: {
			label: "Payment",
			icon: ArrowUpRight,
			color: "text-red-600 dark:text-red-400",
		},
		REFUND: {
			label: "Refund",
			icon: ArrowDownLeft,
			color: "text-purple-600 dark:text-purple-400",
		},
		WITHDRAW: {
			label: "Withdraw",
			icon: ArrowUpRight,
			color: "text-blue-600 dark:text-blue-400",
		},
	};

	const handleTopUp = () => {
		const amount = Number.parseFloat(topUpAmount);
		if (Number.isNaN(amount) || amount <= 0) {
			toast.error("Please enter a valid amount");
			return;
		}
		if (amount < 10000) {
			toast.error("Minimum top-up amount is Rp 10,000");
			return;
		}

		topUpMutation.mutate({
			body: {
				amount,
				provider: "MIDTRANS",
				method: paymentMethod as "QRIS" | "BANK_TRANSFER",
			},
		});
	};

	const quickAmounts = [10000, 25000, 50000, 100000, 250000, 500000];

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.wallet()}</h2>
				<p className="text-muted-foreground">
					Manage your balance and transaction history
				</p>
			</div>

			{/* Wallet Stats */}
			<div className="grid gap-4 md:grid-cols-3">
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
								{formatPrice(wallet?.balance || 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							Available for orders
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							This Month Spending
						</CardTitle>
						<TrendingDown className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{summaryLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl">
								{formatPrice(summary?.totalExpense || 0)}
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
							This Month Top-ups
						</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						{summaryLoading ? (
							<Skeleton className="h-8 w-32" />
						) : (
							<div className="font-bold text-2xl">
								{formatPrice(summary?.totalIncome || 0)}
							</div>
						)}
						<p className="mt-1 text-muted-foreground text-xs">
							Total funds added
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Transaction History */}
			<Card>
				<CardHeader>
					<div className="flex items-center justify-between">
						<div>
							<CardTitle>Transaction History</CardTitle>
							<CardDescription>
								View all your transactions and top-ups
							</CardDescription>
						</div>
						<Button onClick={() => setTopUpDialogOpen(true)}>
							<Plus className="mr-2 h-4 w-4" />
							Top Up Balance
						</Button>
					</div>
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
							<p className="mb-4 text-muted-foreground text-sm">
								Top up your wallet to start using AkadeMove services
							</p>
							<Button onClick={() => setTopUpDialogOpen(true)}>
								<Plus className="mr-2 h-4 w-4" />
								Top Up Now
							</Button>
						</div>
					) : (
						<Table>
							<TableHeader>
								<TableRow>
									<TableHead>Type</TableHead>
									<TableHead>Description</TableHead>
									<TableHead>Status</TableHead>
									<TableHead className="text-right">Amount</TableHead>
									<TableHead>Date</TableHead>
								</TableRow>
							</TableHeader>
							<TableBody>
								{transactionsResult.data.map((transaction: Transaction) => {
									const config =
										transactionTypeConfig[transaction.type] ||
										transactionTypeConfig.PAYMENT;
									const Icon = config.icon;
									const isIncome =
										transaction.type === "TOPUP" ||
										transaction.type === "REFUND";

									return (
										<TableRow key={transaction.id}>
											<TableCell>
												<div className="flex items-center gap-2">
													<Icon className={cn("h-4 w-4", config.color)} />
													<span className="font-medium">{config.label}</span>
												</div>
											</TableCell>
											<TableCell className="text-muted-foreground">
												{transaction.description || "N/A"}
											</TableCell>
											<TableCell>
												<Badge
													variant={
														transaction.status === "SUCCESS"
															? "default"
															: transaction.status === "PENDING"
																? "secondary"
																: "destructive"
													}
												>
													{transaction.status}
												</Badge>
											</TableCell>
											<TableCell
												className={cn(
													"text-right font-semibold",
													isIncome
														? "text-green-600 dark:text-green-400"
														: "text-red-600 dark:text-red-400",
												)}
											>
												{isIncome ? "+" : "-"}
												{formatPrice(Math.abs(transaction.amount))}
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

			{/* Top-up Dialog */}
			<Dialog open={topUpDialogOpen} onOpenChange={setTopUpDialogOpen}>
				<DialogContent>
					<DialogHeader>
						<DialogTitle>Top Up Wallet</DialogTitle>
						<DialogDescription>
							Add funds to your wallet to use AkadeMove services
						</DialogDescription>
					</DialogHeader>

					<div className="space-y-4">
						<div className="space-y-2">
							<Label htmlFor="amount">Amount (IDR)</Label>
							<Input
								id="amount"
								type="number"
								placeholder="Enter amount (min. 10,000)"
								value={topUpAmount}
								onChange={(e) => setTopUpAmount(e.target.value)}
								min={10000}
							/>
						</div>

						{/* Quick Amount Buttons */}
						<div className="space-y-2">
							<Label>Quick Select</Label>
							<div className="grid grid-cols-3 gap-2">
								{quickAmounts.map((amount) => (
									<Button
										key={amount}
										variant="outline"
										size="sm"
										onClick={() => setTopUpAmount(amount.toString())}
										type="button"
									>
										{formatPrice(amount)}
									</Button>
								))}
							</div>
						</div>

						<div className="space-y-2">
							<Label htmlFor="method">Payment Method</Label>
							<Select value={paymentMethod} onValueChange={setPaymentMethod}>
								<SelectTrigger id="method">
									<SelectValue placeholder="Select payment method" />
								</SelectTrigger>
								<SelectContent>
									<SelectItem value="QRIS">QRIS</SelectItem>
									<SelectItem value="BANK_TRANSFER">Bank Transfer</SelectItem>
									<SelectItem value="CREDIT_CARD">Credit Card</SelectItem>
									<SelectItem value="E_WALLET">E-Wallet</SelectItem>
								</SelectContent>
							</Select>
						</div>

						{/* Current Balance Display */}
						<div className="rounded-lg border bg-muted/50 p-3">
							<div className="flex items-center justify-between text-sm">
								<span className="text-muted-foreground">Current Balance:</span>
								<span className="font-semibold">
									{formatPrice(wallet?.balance || 0)}
								</span>
							</div>
							{topUpAmount && !Number.isNaN(Number.parseFloat(topUpAmount)) && (
								<div className="mt-2 flex items-center justify-between border-t pt-2 text-sm">
									<span className="text-muted-foreground">New Balance:</span>
									<span className="font-semibold text-green-600 dark:text-green-400">
										{formatPrice(
											(wallet?.balance || 0) + Number.parseFloat(topUpAmount),
										)}
									</span>
								</div>
							)}
						</div>
					</div>

					<DialogFooter>
						<Button
							variant="outline"
							onClick={() => setTopUpDialogOpen(false)}
							disabled={topUpMutation.isPending}
						>
							Cancel
						</Button>
						<Button
							onClick={handleTopUp}
							disabled={
								topUpMutation.isPending ||
								!topUpAmount ||
								Number.parseFloat(topUpAmount) < 10000
							}
						>
							{topUpMutation.isPending
								? "Processing..."
								: "Continue to Payment"}
						</Button>
					</DialogFooter>
				</DialogContent>
			</Dialog>
		</>
	);
}

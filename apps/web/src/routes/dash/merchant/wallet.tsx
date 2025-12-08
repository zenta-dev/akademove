import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import type { Transaction } from "@repo/schema/transaction";
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
	TrendingUp,
	Wallet as WalletIcon,
} from "lucide-react";
import { useCallback, useMemo, useState } from "react";
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
import { orpcQuery } from "@/lib/orpc";
import { useMyMerchant } from "@/providers/merchant";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/merchant/wallet")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.MERCHANT.wallet }] }),
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
	const search = Route.useSearch();
	const [withdrawDialogOpen, setWithdrawDialogOpen] = useState(false);
	const merchant = useMyMerchant();

	// Fetch wallet data
	const { data: walletResponse, isLoading: walletLoading } = useQuery(
		orpcQuery.wallet.get.queryOptions({ input: {} }),
	);

	const wallet = useMemo(() => walletResponse?.body.data, [walletResponse]);

	// Fetch transactions
	const { data: transactionResponse, isLoading: transactionsLoading } =
		useQuery(
			orpcQuery.transaction.list.queryOptions({ input: { query: search } }),
		);

	const transactionsResult = useMemo(
		() => transactionResponse?.body.data,
		[transactionResponse],
	);

	// Fetch monthly summary
	const { data: summaryResponse, isLoading: summaryLoading } = useQuery(
		orpcQuery.wallet.getMonthlySummary.queryOptions({
			input: {
				query: {
					year: new Date().getFullYear(),
					month: new Date().getMonth() + 1,
				},
			},
		}),
	);

	const summary = useMemo(() => summaryResponse?.body.data, [summaryResponse]);

	if (!allowed) navigate({ to: "/" });

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
		}),
		[],
	);

	const commissionTransactions = useMemo(() => {
		if (!transactionsResult) return [];
		return transactionsResult.filter((t) => t.type === "COMMISSION");
	}, [transactionsResult]);

	const handleExportCommissionPDF = useCallback(() => {
		if (!merchant.value) return;

		const doc = new jsPDF();
		const pageWidth = doc.internal.pageSize.getWidth();
		const currentMonth = new Date().toLocaleDateString("id-ID", {
			month: "long",
			year: "numeric",
		});

		// Header
		doc.setFontSize(20);
		doc.setFont("helvetica", "bold");
		doc.text("Commission Report", pageWidth / 2, 20, { align: "center" });

		doc.setFontSize(12);
		doc.setFont("helvetica", "normal");
		doc.text(merchant.value.name, pageWidth / 2, 28, { align: "center" });

		doc.setFontSize(10);
		doc.text(`Period: ${currentMonth}`, pageWidth / 2, 35, { align: "center" });
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
				["Current Balance", formatPrice(wallet?.balance || 0)],
				["This Month Earnings", formatPrice(summary?.totalIncome || 0)],
				["This Month Commission", formatPrice(summary?.totalExpense || 0)],
				[
					"Net Earnings",
					formatPrice(
						(summary?.totalIncome || 0) - (summary?.totalExpense || 0),
					),
				],
			],
			theme: "striped",
			headStyles: { fillColor: [168, 85, 247] },
		});

		// Commission Transactions Section
		if (commissionTransactions.length > 0) {
			const finalY = (doc as unknown as { lastAutoTable: { finalY: number } })
				.lastAutoTable.finalY;

			doc.setFontSize(14);
			doc.setFont("helvetica", "bold");
			doc.text("Commission Transactions", 14, finalY + 15);

			autoTable(doc, {
				startY: finalY + 20,
				head: [["Date", "Description", "Status", "Amount"]],
				body: commissionTransactions.map((t) => [
					formatDate(t.createdAt),
					t.description || "Platform Commission",
					t.status,
					formatPrice(Math.abs(t.amount)),
				]),
				theme: "striped",
				headStyles: { fillColor: [249, 115, 22] },
			});
		}

		// All Transactions Section
		if (transactionsResult && transactionsResult.length > 0) {
			const finalY = (doc as unknown as { lastAutoTable: { finalY: number } })
				.lastAutoTable.finalY;

			doc.setFontSize(14);
			doc.setFont("helvetica", "bold");
			doc.text("All Transactions", 14, finalY + 15);

			autoTable(doc, {
				startY: finalY + 20,
				head: [["Date", "Type", "Description", "Status", "Amount"]],
				body: transactionsResult.map((t) => {
					const isIncome = t.type === "EARNING" || t.type === "REFUND";
					return [
						formatDate(t.createdAt),
						transactionTypeConfig[t.type]?.label || t.type,
						t.description || "N/A",
						t.status,
						`${isIncome ? "+" : "-"}${formatPrice(Math.abs(t.amount))}`,
					];
				}),
				theme: "striped",
				headStyles: { fillColor: [59, 130, 246] },
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

		doc.save(`commission-report-${new Date().toISOString().split("T")[0]}.pdf`);
		toast.success("Report exported successfully");
	}, [
		merchant.value,
		wallet?.balance,
		summary,
		commissionTransactions,
		transactionsResult,
		formatPrice,
		formatDate,
		transactionTypeConfig,
	]);

	const handleExportCommissionCSV = useCallback(() => {
		if (!transactionsResult || transactionsResult.length === 0) {
			toast.error("No transactions to export");
			return;
		}

		const headers = ["Date", "Type", "Description", "Status", "Amount"];
		const rows = transactionsResult.map((t) => {
			const isIncome = t.type === "EARNING" || t.type === "REFUND";
			return [
				formatDate(t.createdAt),
				transactionTypeConfig[t.type]?.label || t.type,
				t.description || "N/A",
				t.status,
				`${isIncome ? "+" : "-"}${Math.abs(t.amount)}`,
			];
		});

		const csvContent = [headers, ...rows]
			.map((row) => row.map((cell) => `"${cell}"`).join(","))
			.join("\n");

		const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
		const url = window.URL.createObjectURL(blob);
		const a = document.createElement("a");
		a.href = url;
		a.download = `commission-report-${new Date().toISOString().split("T")[0]}.csv`;
		document.body.appendChild(a);
		a.click();
		window.URL.revokeObjectURL(url);
		document.body.removeChild(a);
		toast.success("Report exported successfully");
	}, [transactionsResult, formatDate, transactionTypeConfig]);

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.wallet()}</h2>
				<p className="text-muted-foreground">
					Manage your earnings and transaction history
				</p>
			</div>

			{/* wallet Stats */}
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
							Available for withdrawal
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							This Month Earnings
						</CardTitle>
						<TrendingUp className="h-4 w-4 text-muted-foreground" />
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
							From completed orders
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Platform Commission
						</CardTitle>
						<DollarSign className="h-4 w-4 text-muted-foreground" />
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
							Commission paid this month
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
								View all your earnings and expenses
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
									<DropdownMenuItem onClick={handleExportCommissionPDF}>
										<FileText className="mr-2 h-4 w-4" />
										Export as PDF
									</DropdownMenuItem>
									<DropdownMenuItem onClick={handleExportCommissionCSV}>
										<Download className="mr-2 h-4 w-4" />
										Export as CSV
									</DropdownMenuItem>
								</DropdownMenuContent>
							</DropdownMenu>
							<Button onClick={() => setWithdrawDialogOpen(true)}>
								Request Withdrawal
							</Button>
						</div>
					</div>
				</CardHeader>
				<CardContent>
					{transactionsLoading ? (
						<div className="space-y-3">
							<Skeleton className="h-12 w-full" />
							<Skeleton className="h-12 w-full" />
							<Skeleton className="h-12 w-full" />
						</div>
					) : !transactionsResult || transactionsResult.length === 0 ? (
						<div className="flex flex-col items-center justify-center py-12 text-center">
							<WalletIcon className="mb-4 h-12 w-12 text-muted-foreground" />
							<h3 className="mb-2 font-semibold text-lg">
								No transactions yet
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
									<TableHead>Status</TableHead>
									<TableHead className="text-right">Amount</TableHead>
									<TableHead>Date</TableHead>
								</TableRow>
							</TableHeader>
							<TableBody>
								{transactionsResult.map((transaction: Transaction) => {
									const config =
										transactionTypeConfig[transaction.type] ||
										transactionTypeConfig.PAYMENT;
									const Icon = config.icon;
									const isIncome =
										transaction.type === "EARNING" ||
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
													isIncome ? "text-green-600" : "text-red-600",
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

			<WithdrawDialog
				open={withdrawDialogOpen}
				onOpenChange={setWithdrawDialogOpen}
				availableBalance={wallet?.balance || 0}
			/>
		</>
	);
}

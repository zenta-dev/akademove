import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import type { Report, ReportCategory, ReportStatus } from "@repo/schema/report";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	AlertTriangle,
	CheckCircle2,
	Clock,
	Eye,
	Filter,
	MoreVertical,
	Search,
	Shield,
	XCircle,
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
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
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
import { Textarea } from "@/components/ui/textarea";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/operator/reports")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.REPORTS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			report: ["get", "list", "update"],
		});
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

const REPORT_CATEGORIES: { value: ReportCategory; label: string }[] = [
	{ value: "BEHAVIOR", label: "Behavior" },
	{ value: "SAFETY", label: "Safety" },
	{ value: "FRAUD", label: "Fraud" },
	{ value: "OTHER", label: "Other" },
];

const REPORT_STATUSES: { value: ReportStatus; label: string }[] = [
	{ value: "PENDING", label: "Pending" },
	{ value: "INVESTIGATING", label: "Investigating" },
	{ value: "RESOLVED", label: "Resolved" },
	{ value: "DISMISSED", label: "Dismissed" },
];

function RouteComponent() {
	const { allowed } = Route.useLoaderData();
	const navigate = useNavigate();
	const search = Route.useSearch();

	const [selectedReport, setSelectedReport] = useState<Report | null>(null);
	const [detailsDialogOpen, setDetailsDialogOpen] = useState(false);
	const [updateDialogOpen, setUpdateDialogOpen] = useState(false);
	const [statusFilter, setStatusFilter] = useState<ReportStatus | "ALL">("ALL");
	const [categoryFilter, setCategoryFilter] = useState<ReportCategory | "ALL">(
		"ALL",
	);
	const [searchQuery, setSearchQuery] = useState("");

	const { data: reportsResult, isLoading } = useQuery({
		queryKey: ["reports", search],
		queryFn: async () => {
			const result = await orpcClient.report.list({ query: search });
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body;
		},
	});

	const updateMutation = useMutation({
		mutationFn: async ({
			id,
			status,
			resolution,
		}: {
			id: string;
			status: ReportStatus;
			resolution: string;
		}) => {
			const result = await orpcClient.report.update({
				params: { id },
				body: { status, resolution },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: () => {
			toast.success("Report updated successfully");
			queryClient.invalidateQueries({ queryKey: ["reports"] });
			setUpdateDialogOpen(false);
			setSelectedReport(null);
		},
		onError: (error: Error) => {
			toast.error(`Failed to update report: ${error.message}`);
		},
	});

	if (!allowed) navigate({ to: "/" });

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

	const getStatusConfig = (status: ReportStatus) => {
		switch (status) {
			case "PENDING":
				return {
					label: "Pending",
					variant: "secondary" as const,
					icon: Clock,
					color: "text-yellow-600",
				};
			case "INVESTIGATING":
				return {
					label: "Investigating",
					variant: "default" as const,
					icon: Search,
					color: "text-blue-600",
				};
			case "RESOLVED":
				return {
					label: "Resolved",
					variant: "default" as const,
					icon: CheckCircle2,
					color: "text-green-600",
				};
			case "DISMISSED":
				return {
					label: "Dismissed",
					variant: "secondary" as const,
					icon: XCircle,
					color: "text-gray-600",
				};
		}
	};

	const getCategoryConfig = (category: ReportCategory) => {
		switch (category) {
			case "BEHAVIOR":
				return {
					label: "Behavior",
					icon: AlertTriangle,
					color: "text-orange-600",
				};
			case "SAFETY":
				return { label: "Safety", icon: Shield, color: "text-red-600" };
			case "FRAUD":
				return {
					label: "Fraud",
					icon: AlertTriangle,
					color: "text-purple-600",
				};
			case "OTHER":
				return { label: "Other", icon: AlertTriangle, color: "text-gray-600" };
		}
	};

	const filteredReports = reportsResult?.data?.filter((report) => {
		if (statusFilter !== "ALL" && report.status !== statusFilter) return false;
		if (categoryFilter !== "ALL" && report.category !== categoryFilter)
			return false;
		if (
			searchQuery &&
			!report.description.toLowerCase().includes(searchQuery.toLowerCase())
		)
			return false;
		return true;
	});

	const stats = {
		total: reportsResult?.data?.length || 0,
		pending:
			reportsResult?.data?.filter((r) => r.status === "PENDING").length || 0,
		investigating:
			reportsResult?.data?.filter((r) => r.status === "INVESTIGATING").length ||
			0,
		resolved:
			reportsResult?.data?.filter((r) => r.status === "RESOLVED").length || 0,
	};

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.reports()}</h2>
				<p className="text-muted-foreground">
					Manage user reports and safety concerns
				</p>
			</div>

			{/* Stats Cards */}
			<div className="grid gap-4 md:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Reports</CardTitle>
						<AlertTriangle className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">{stats.total}</div>
					</CardContent>
				</Card>
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Pending</CardTitle>
						<Clock className="h-4 w-4 text-yellow-600" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">{stats.pending}</div>
					</CardContent>
				</Card>
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Investigating</CardTitle>
						<Search className="h-4 w-4 text-blue-600" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">{stats.investigating}</div>
					</CardContent>
				</Card>
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Resolved</CardTitle>
						<CheckCircle2 className="h-4 w-4 text-green-600" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">{stats.resolved}</div>
					</CardContent>
				</Card>
			</div>

			{/* Filters and Search */}
			<Card>
				<CardHeader>
					<div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
						<div>
							<CardTitle>All Reports</CardTitle>
							<CardDescription>
								Review and manage safety reports from users
							</CardDescription>
						</div>
						<div className="flex gap-2">
							<Select
								value={statusFilter}
								onValueChange={(value) =>
									setStatusFilter(value as ReportStatus | "ALL")
								}
							>
								<SelectTrigger className="w-[150px]">
									<Filter className="mr-2 h-4 w-4" />
									<SelectValue />
								</SelectTrigger>
								<SelectContent>
									<SelectItem value="ALL">All Status</SelectItem>
									{REPORT_STATUSES.map((status) => (
										<SelectItem key={status.value} value={status.value}>
											{status.label}
										</SelectItem>
									))}
								</SelectContent>
							</Select>
							<Select
								value={categoryFilter}
								onValueChange={(value) =>
									setCategoryFilter(value as ReportCategory | "ALL")
								}
							>
								<SelectTrigger className="w-[150px]">
									<Filter className="mr-2 h-4 w-4" />
									<SelectValue />
								</SelectTrigger>
								<SelectContent>
									<SelectItem value="ALL">All Categories</SelectItem>
									{REPORT_CATEGORIES.map((category) => (
										<SelectItem key={category.value} value={category.value}>
											{category.label}
										</SelectItem>
									))}
								</SelectContent>
							</Select>
						</div>
					</div>
					<div className="mt-4">
						<Input
							placeholder="Search reports by description..."
							value={searchQuery}
							onChange={(e) => setSearchQuery(e.target.value)}
							className="max-w-md"
						/>
					</div>
				</CardHeader>
				<CardContent>
					{isLoading ? (
						<div className="space-y-3">
							<Skeleton className="h-12 w-full" />
							<Skeleton className="h-12 w-full" />
							<Skeleton className="h-12 w-full" />
						</div>
					) : !filteredReports || filteredReports.length === 0 ? (
						<div className="flex flex-col items-center justify-center py-12 text-center">
							<AlertTriangle className="mb-4 h-12 w-12 text-muted-foreground" />
							<h3 className="mb-2 font-semibold text-lg">No reports found</h3>
							<p className="text-muted-foreground text-sm">
								{searchQuery ||
								statusFilter !== "ALL" ||
								categoryFilter !== "ALL"
									? "Try adjusting your filters"
									: "All user reports will appear here"}
							</p>
						</div>
					) : (
						<Table>
							<TableHeader>
								<TableRow>
									<TableHead>Category</TableHead>
									<TableHead>Description</TableHead>
									<TableHead>Status</TableHead>
									<TableHead>Reported At</TableHead>
									<TableHead>Actions</TableHead>
								</TableRow>
							</TableHeader>
							<TableBody>
								{filteredReports.map((report) => {
									const statusConfig = getStatusConfig(report.status);
									const categoryConfig = getCategoryConfig(report.category);
									const StatusIcon = statusConfig.icon;
									const CategoryIcon = categoryConfig.icon;

									return (
										<TableRow key={report.id}>
											<TableCell>
												<div className="flex items-center gap-2">
													<CategoryIcon
														className={cn("h-4 w-4", categoryConfig.color)}
													/>
													<span className="font-medium">
														{categoryConfig.label}
													</span>
												</div>
											</TableCell>
											<TableCell className="max-w-[300px] truncate">
												{report.description}
											</TableCell>
											<TableCell>
												<Badge variant={statusConfig.variant}>
													<StatusIcon className="mr-1 h-3 w-3" />
													{statusConfig.label}
												</Badge>
											</TableCell>
											<TableCell className="text-muted-foreground text-sm">
												{formatDate(report.reportedAt)}
											</TableCell>
											<TableCell>
												<DropdownMenu>
													<DropdownMenuTrigger asChild>
														<Button variant="ghost" size="sm">
															<MoreVertical className="h-4 w-4" />
														</Button>
													</DropdownMenuTrigger>
													<DropdownMenuContent align="end">
														<DropdownMenuItem
															onClick={() => {
																setSelectedReport(report);
																setDetailsDialogOpen(true);
															}}
														>
															<Eye className="mr-2 h-4 w-4" />
															View Details
														</DropdownMenuItem>
														<DropdownMenuItem
															onClick={() => {
																setSelectedReport(report);
																setUpdateDialogOpen(true);
															}}
														>
															<CheckCircle2 className="mr-2 h-4 w-4" />
															Update Status
														</DropdownMenuItem>
													</DropdownMenuContent>
												</DropdownMenu>
											</TableCell>
										</TableRow>
									);
								})}
							</TableBody>
						</Table>
					)}
				</CardContent>
			</Card>

			{/* Details Dialog */}
			<Dialog open={detailsDialogOpen} onOpenChange={setDetailsDialogOpen}>
				<DialogContent className="max-w-2xl">
					<DialogHeader>
						<DialogTitle>Report Details</DialogTitle>
						<DialogDescription>
							View complete information about this report
						</DialogDescription>
					</DialogHeader>
					{selectedReport && (
						<div className="space-y-4">
							<div className="grid grid-cols-2 gap-4">
								<div>
									<Label className="text-muted-foreground text-sm">
										Category
									</Label>
									<p className="font-medium">
										{getCategoryConfig(selectedReport.category).label}
									</p>
								</div>
								<div>
									<Label className="text-muted-foreground text-sm">
										Status
									</Label>
									<p>
										<Badge
											variant={getStatusConfig(selectedReport.status).variant}
										>
											{getStatusConfig(selectedReport.status).label}
										</Badge>
									</p>
								</div>
								<div>
									<Label className="text-muted-foreground text-sm">
										Reported At
									</Label>
									<p className="font-medium">
										{formatDate(selectedReport.reportedAt)}
									</p>
								</div>
								{selectedReport.resolvedAt && (
									<div>
										<Label className="text-muted-foreground text-sm">
											Resolved At
										</Label>
										<p className="font-medium">
											{formatDate(selectedReport.resolvedAt)}
										</p>
									</div>
								)}
							</div>
							<div>
								<Label className="text-muted-foreground text-sm">
									Description
								</Label>
								<p className="mt-1">{selectedReport.description}</p>
							</div>
							{selectedReport.resolution && (
								<div>
									<Label className="text-muted-foreground text-sm">
										Resolution
									</Label>
									<p className="mt-1">{selectedReport.resolution}</p>
								</div>
							)}
							{selectedReport.evidenceUrl && (
								<div>
									<Label className="text-muted-foreground text-sm">
										Evidence
									</Label>
									<a
										href={selectedReport.evidenceUrl}
										target="_blank"
										rel="noopener noreferrer"
										className="text-primary underline"
									>
										View Evidence
									</a>
								</div>
							)}
						</div>
					)}
					<DialogFooter>
						<Button
							variant="outline"
							onClick={() => setDetailsDialogOpen(false)}
						>
							Close
						</Button>
					</DialogFooter>
				</DialogContent>
			</Dialog>

			{/* Update Status Dialog */}
			<UpdateReportDialog
				open={updateDialogOpen}
				onOpenChange={setUpdateDialogOpen}
				report={selectedReport}
				onUpdate={(status, resolution) => {
					if (selectedReport) {
						updateMutation.mutate({
							id: selectedReport.id,
							status,
							resolution,
						});
					}
				}}
				isUpdating={updateMutation.isPending}
			/>
		</>
	);
}

function UpdateReportDialog({
	open,
	onOpenChange,
	report,
	onUpdate,
	isUpdating,
}: {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	report: Report | null;
	onUpdate: (status: ReportStatus, resolution: string) => void;
	isUpdating: boolean;
}) {
	const [status, setStatus] = useState<ReportStatus>(
		report?.status || "PENDING",
	);
	const [resolution, setResolution] = useState(report?.resolution || "");

	// Update form when report changes
	useState(() => {
		if (report) {
			setStatus(report.status);
			setResolution(report.resolution || "");
		}
	});

	const handleSubmit = (e: React.FormEvent) => {
		e.preventDefault();
		if (!resolution.trim() && status !== "PENDING") {
			toast.error("Resolution notes are required when updating status");
			return;
		}
		onUpdate(status, resolution.trim());
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>Update Report Status</DialogTitle>
					<DialogDescription>
						Change the status and add resolution notes
					</DialogDescription>
				</DialogHeader>
				<form onSubmit={handleSubmit} className="space-y-4">
					<div>
						<Label htmlFor="status">Status</Label>
						<Select
							value={status}
							onValueChange={(value) => setStatus(value as ReportStatus)}
							disabled={isUpdating}
						>
							<SelectTrigger id="status">
								<SelectValue />
							</SelectTrigger>
							<SelectContent>
								{REPORT_STATUSES.map((s) => (
									<SelectItem key={s.value} value={s.value}>
										{s.label}
									</SelectItem>
								))}
							</SelectContent>
						</Select>
					</div>
					<div>
						<Label htmlFor="resolution">
							Resolution Notes{" "}
							{status !== "PENDING" && (
								<span className="text-destructive">*</span>
							)}
						</Label>
						<Textarea
							id="resolution"
							placeholder="Describe the action taken or resolution..."
							value={resolution}
							onChange={(e) => setResolution(e.target.value)}
							rows={4}
							disabled={isUpdating}
							required={status !== "PENDING"}
						/>
					</div>
					<DialogFooter>
						<Button
							type="button"
							variant="outline"
							onClick={() => onOpenChange(false)}
							disabled={isUpdating}
						>
							Cancel
						</Button>
						<Button type="submit" disabled={isUpdating}>
							{isUpdating ? "Updating..." : "Update Report"}
						</Button>
					</DialogFooter>
				</form>
			</DialogContent>
		</Dialog>
	);
}

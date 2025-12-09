import type {
	FraudEventType,
	FraudSeverity,
	FraudStatus,
} from "@repo/schema/fraud";
import { useQuery } from "@tanstack/react-query";
import {
	createFileRoute,
	Link,
	redirect,
	useNavigate,
} from "@tanstack/react-router";
import {
	AlertTriangle,
	CheckCircle,
	Clock,
	Eye,
	Loader2,
	MapPin,
	Shield,
	Users,
} from "lucide-react";
import { useMemo, useState } from "react";
import { z } from "zod";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
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

const searchSchema = z.object({
	page: z.coerce.number().default(1),
	limit: z.coerce.number().default(20),
	status: z.enum(["PENDING", "REVIEWING", "CONFIRMED", "DISMISSED"]).optional(),
	severity: z.enum(["LOW", "MEDIUM", "HIGH", "CRITICAL"]).optional(),
});

export const Route = createFileRoute("/dash/operator/fraud/")({
	validateSearch: (values) => searchSchema.parse(values),
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.FRAUD }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["OPERATOR", "ADMIN"]);
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
	const search = Route.useSearch();
	const navigate = useNavigate();

	const [statusFilter, setStatusFilter] = useState<FraudStatus | "">(
		search.status ?? "",
	);
	const [severityFilter, setSeverityFilter] = useState<FraudSeverity | "">(
		search.severity ?? "",
	);

	if (!allowed) navigate({ to: "/" });

	// Fetch fraud stats
	const { data: statsResponse, isLoading: statsLoading } = useQuery(
		orpcQuery.fraud.getStats.queryOptions({
			input: { query: { trendDays: 30 } },
		}),
	);

	// Fetch fraud events
	const { data: eventsResponse, isLoading: eventsLoading } = useQuery(
		orpcQuery.fraud.listEvents.queryOptions({
			input: {
				query: {
					page: search.page,
					limit: search.limit,
					status: statusFilter || undefined,
					severity: severityFilter || undefined,
				},
			},
		}),
	);

	const stats = useMemo(() => statsResponse?.body?.data, [statsResponse]);
	const events = useMemo(
		() => eventsResponse?.body?.data ?? [],
		[eventsResponse],
	);
	const totalPages = useMemo(
		() => eventsResponse?.body?.totalPages ?? 1,
		[eventsResponse],
	);

	const handleFilterChange = (type: "status" | "severity", value: string) => {
		if (type === "status") {
			setStatusFilter(value as FraudStatus | "");
		} else {
			setSeverityFilter(value as FraudSeverity | "");
		}
		const newStatus =
			type === "status"
				? ((value || undefined) as FraudStatus | undefined)
				: statusFilter || undefined;
		const newSeverity =
			type === "severity"
				? ((value || undefined) as FraudSeverity | undefined)
				: severityFilter || undefined;
		navigate({
			to: "/dash/operator/fraud",
			search: {
				page: 1,
				limit: search.limit,
				status: newStatus,
				severity: newSeverity,
			},
		});
	};

	if (statsLoading || eventsLoading) {
		return (
			<div className="flex min-h-[50vh] items-center justify-center">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">Fraud Detection</h2>
				<p className="text-muted-foreground">
					Monitor suspicious activities and protect platform integrity
				</p>
			</div>

			{/* Stats Cards */}
			<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Events</CardTitle>
						<Shield className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{stats?.totalEvents?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							All time fraud signals
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Pending Review
						</CardTitle>
						<Clock className="h-4 w-4 text-yellow-500" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl text-yellow-600">
							{stats?.pendingEvents?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">Needs investigation</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Confirmed Fraud
						</CardTitle>
						<AlertTriangle className="h-4 w-4 text-red-500" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl text-red-600">
							{stats?.confirmedEvents?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">Verified incidents</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							High Risk Users
						</CardTitle>
						<Users className="h-4 w-4 text-orange-500" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl text-orange-600">
							{stats?.highRiskUsers?.toLocaleString() ?? 0}
						</div>
						<p className="text-muted-foreground text-xs">
							Users flagged for monitoring
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Event Type Breakdown */}
			<div className="grid gap-4 md:grid-cols-2">
				<Card>
					<CardHeader>
						<CardTitle className="text-sm">Events by Severity</CardTitle>
					</CardHeader>
					<CardContent>
						<div className="space-y-2">
							<div className="flex items-center justify-between">
								<span className="text-muted-foreground text-sm">Critical</span>
								<Badge variant="destructive">
									{stats?.eventsBySeverity?.CRITICAL ?? 0}
								</Badge>
							</div>
							<div className="flex items-center justify-between">
								<span className="text-muted-foreground text-sm">High</span>
								<Badge className="bg-orange-500">
									{stats?.eventsBySeverity?.HIGH ?? 0}
								</Badge>
							</div>
							<div className="flex items-center justify-between">
								<span className="text-muted-foreground text-sm">Medium</span>
								<Badge className="bg-yellow-500">
									{stats?.eventsBySeverity?.MEDIUM ?? 0}
								</Badge>
							</div>
							<div className="flex items-center justify-between">
								<span className="text-muted-foreground text-sm">Low</span>
								<Badge variant="secondary">
									{stats?.eventsBySeverity?.LOW ?? 0}
								</Badge>
							</div>
						</div>
					</CardContent>
				</Card>

				<Card>
					<CardHeader>
						<CardTitle className="text-sm">Events by Type</CardTitle>
					</CardHeader>
					<CardContent>
						<div className="space-y-2">
							{Object.entries(stats?.eventsByType ?? {}).map(
								([type, count]) => (
									<div key={type} className="flex items-center justify-between">
										<span className="text-muted-foreground text-sm">
											{formatEventType(type as FraudEventType)}
										</span>
										<Badge variant="outline">{count}</Badge>
									</div>
								),
							)}
							{Object.keys(stats?.eventsByType ?? {}).length === 0 && (
								<p className="text-muted-foreground text-sm">No events yet</p>
							)}
						</div>
					</CardContent>
				</Card>
			</div>

			{/* Events Table */}
			<Card>
				<CardHeader>
					<div className="flex items-center justify-between">
						<CardTitle>Recent Fraud Events</CardTitle>
						<div className="flex gap-2">
							<Select
								value={statusFilter}
								onValueChange={(v) => handleFilterChange("status", v)}
							>
								<SelectTrigger className="w-[140px]">
									<SelectValue placeholder="Status" />
								</SelectTrigger>
								<SelectContent>
									<SelectItem value="">All Status</SelectItem>
									<SelectItem value="PENDING">Pending</SelectItem>
									<SelectItem value="REVIEWING">Reviewing</SelectItem>
									<SelectItem value="CONFIRMED">Confirmed</SelectItem>
									<SelectItem value="DISMISSED">Dismissed</SelectItem>
								</SelectContent>
							</Select>

							<Select
								value={severityFilter}
								onValueChange={(v) => handleFilterChange("severity", v)}
							>
								<SelectTrigger className="w-[140px]">
									<SelectValue placeholder="Severity" />
								</SelectTrigger>
								<SelectContent>
									<SelectItem value="">All Severity</SelectItem>
									<SelectItem value="CRITICAL">Critical</SelectItem>
									<SelectItem value="HIGH">High</SelectItem>
									<SelectItem value="MEDIUM">Medium</SelectItem>
									<SelectItem value="LOW">Low</SelectItem>
								</SelectContent>
							</Select>
						</div>
					</div>
				</CardHeader>
				<CardContent className="p-0">
					<Table>
						<TableHeader>
							<TableRow>
								<TableHead>Type</TableHead>
								<TableHead>User</TableHead>
								<TableHead>Severity</TableHead>
								<TableHead>Score</TableHead>
								<TableHead>Status</TableHead>
								<TableHead>Detected</TableHead>
								<TableHead className="text-right">Actions</TableHead>
							</TableRow>
						</TableHeader>
						<TableBody>
							{events.length === 0 ? (
								<TableRow>
									<TableCell
										colSpan={7}
										className="py-8 text-center text-muted-foreground"
									>
										No fraud events found
									</TableCell>
								</TableRow>
							) : (
								events.map((event) => (
									<TableRow key={event.id}>
										<TableCell>
											<div className="flex items-center gap-2">
												{getEventTypeIcon(event.eventType)}
												<span className="text-sm">
													{formatEventType(event.eventType)}
												</span>
											</div>
										</TableCell>
										<TableCell>
											<div className="text-sm">
												{event.user?.name ?? "Unknown"}
											</div>
											<div className="text-muted-foreground text-xs">
												{event.user?.email ?? "-"}
											</div>
										</TableCell>
										<TableCell>{getSeverityBadge(event.severity)}</TableCell>
										<TableCell>
											<span className="font-mono text-sm">{event.score}</span>
										</TableCell>
										<TableCell>{getStatusBadge(event.status)}</TableCell>
										<TableCell>
											<div className="text-sm">
												{new Date(event.detectedAt).toLocaleDateString()}
											</div>
											<div className="text-muted-foreground text-xs">
												{new Date(event.detectedAt).toLocaleTimeString()}
											</div>
										</TableCell>
										<TableCell className="text-right">
											<Button variant="ghost" size="sm" asChild>
												<Link
													to="/dash/operator/fraud/$id"
													params={{ id: event.id }}
												>
													<Eye className="h-4 w-4" />
												</Link>
											</Button>
										</TableCell>
									</TableRow>
								))
							)}
						</TableBody>
					</Table>
				</CardContent>
			</Card>

			{/* Pagination */}
			{totalPages > 1 && (
				<div className="flex justify-center gap-2">
					<Button
						variant="outline"
						size="sm"
						disabled={search.page <= 1}
						onClick={() =>
							navigate({
								to: "/dash/operator/fraud",
								search: { ...search, page: search.page - 1 },
							})
						}
					>
						Previous
					</Button>
					<span className="flex items-center px-3 text-muted-foreground text-sm">
						Page {search.page} of {totalPages}
					</span>
					<Button
						variant="outline"
						size="sm"
						disabled={search.page >= totalPages}
						onClick={() =>
							navigate({
								to: "/dash/operator/fraud",
								search: { ...search, page: search.page + 1 },
							})
						}
					>
						Next
					</Button>
				</div>
			)}
		</>
	);
}

function formatEventType(type: FraudEventType): string {
	const typeMap: Record<FraudEventType, string> = {
		GPS_SPOOF_VELOCITY: "GPS Spoofing (Velocity)",
		GPS_SPOOF_TELEPORT: "GPS Spoofing (Teleport)",
		GPS_SPOOF_MOCK_DETECTED: "Mock Location",
		DUPLICATE_BANK_ACCOUNT: "Duplicate Bank",
		DUPLICATE_IP_PATTERN: "Suspicious IP Pattern",
		DUPLICATE_NAME_SIMILARITY: "Similar Name",
		SUSPICIOUS_REGISTRATION: "Suspicious Registration",
	};
	return typeMap[type] ?? type;
}

function getEventTypeIcon(type: FraudEventType) {
	if (type.startsWith("GPS_")) {
		return <MapPin className="h-4 w-4 text-blue-500" />;
	}
	return <Users className="h-4 w-4 text-purple-500" />;
}

function getSeverityBadge(severity: FraudSeverity) {
	const variants: Record<FraudSeverity, { className: string; label: string }> =
		{
			CRITICAL: { className: "bg-red-600 text-white", label: "Critical" },
			HIGH: { className: "bg-orange-500 text-white", label: "High" },
			MEDIUM: { className: "bg-yellow-500 text-white", label: "Medium" },
			LOW: { className: "bg-gray-400 text-white", label: "Low" },
		};
	const { className, label } = variants[severity];
	return <Badge className={className}>{label}</Badge>;
}

function getStatusBadge(status: FraudStatus) {
	const variants: Record<
		FraudStatus,
		{
			variant: "default" | "secondary" | "destructive" | "outline";
			icon: React.ReactNode;
		}
	> = {
		PENDING: { variant: "outline", icon: <Clock className="mr-1 h-3 w-3" /> },
		REVIEWING: {
			variant: "secondary",
			icon: <Eye className="mr-1 h-3 w-3" />,
		},
		CONFIRMED: {
			variant: "destructive",
			icon: <AlertTriangle className="mr-1 h-3 w-3" />,
		},
		DISMISSED: {
			variant: "default",
			icon: <CheckCircle className="mr-1 h-3 w-3" />,
		},
	};
	const { variant, icon } = variants[status];
	return (
		<Badge variant={variant} className="flex w-fit items-center">
			{icon}
			{status}
		</Badge>
	);
}

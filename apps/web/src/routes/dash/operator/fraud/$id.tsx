import type {
	FraudEventType,
	FraudSeverity,
	FraudStatus,
} from "@repo/schema/fraud";
import { useMutation, useQuery } from "@tanstack/react-query";
import {
	createFileRoute,
	Link,
	redirect,
	useNavigate,
} from "@tanstack/react-router";
import {
	AlertTriangle,
	ArrowLeft,
	CheckCircle,
	Clock,
	Eye,
	Loader2,
	MapPin,
	Shield,
	User,
	Users,
} from "lucide-react";
import { useMemo, useState } from "react";
import { toast } from "sonner";
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
import { Textarea } from "@/components/ui/textarea";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient, orpcQuery, queryClient } from "@/lib/orpc";

export const Route = createFileRoute("/dash/operator/fraud/$id")({
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
	const { id } = Route.useParams();
	const navigate = useNavigate();

	const [newStatus, setNewStatus] = useState<
		Exclude<FraudStatus, "PENDING"> | ""
	>("");
	const [resolution, setResolution] = useState("");
	const [actionTaken, setActionTaken] = useState("");

	if (!allowed) navigate({ to: "/" });

	const { data: response, isLoading } = useQuery(
		orpcQuery.fraud.getEvent.queryOptions({
			input: { params: { id } },
		}),
	);

	const reviewMutation = useMutation({
		mutationFn: async (data: {
			status: Exclude<FraudStatus, "PENDING">;
			resolution?: string;
			actionTaken?: string;
		}) => {
			const result = await orpcClient.fraud.reviewEvent({
				params: { id },
				body: data,
			});
			if (result.status !== 200) {
				throw new Error(result.body.message);
			}
			return result;
		},
		onSuccess: () => {
			queryClient.invalidateQueries();
			toast.success("Fraud event updated successfully");
			setNewStatus("");
			setResolution("");
			setActionTaken("");
		},
		onError: (error) => {
			toast.error(error.message ?? "Failed to update event");
		},
	});

	const event = useMemo(() => response?.body?.data, [response]);

	if (isLoading) {
		return (
			<div className="flex min-h-[50vh] items-center justify-center">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	if (!event) {
		return (
			<div className="flex min-h-[50vh] flex-col items-center justify-center gap-4">
				<AlertTriangle className="h-12 w-12 text-muted-foreground" />
				<h2 className="font-medium text-xl">Event Not Found</h2>
				<Button asChild>
					<Link to="/dash/operator/fraud" search={{ page: 1, limit: 20 }}>
						Back to Fraud Dashboard
					</Link>
				</Button>
			</div>
		);
	}

	const handleSubmitReview = () => {
		if (!newStatus) {
			toast.error("Please select a status");
			return;
		}
		reviewMutation.mutate({
			status: newStatus,
			resolution: resolution || undefined,
			actionTaken: actionTaken || undefined,
		});
	};

	return (
		<>
			{/* Header */}
			<div className="flex items-center gap-4">
				<Button variant="ghost" size="icon" asChild>
					<Link to="/dash/operator/fraud" search={{ page: 1, limit: 20 }}>
						<ArrowLeft className="h-4 w-4" />
					</Link>
				</Button>
				<div>
					<h2 className="font-medium text-xl">Fraud Event Details</h2>
					<p className="text-muted-foreground text-sm">
						{formatEventType(event.eventType)} - {event.id.slice(0, 8)}...
					</p>
				</div>
			</div>

			<div className="grid gap-4 lg:grid-cols-3">
				{/* Main Info */}
				<div className="space-y-4 lg:col-span-2">
					{/* Event Summary */}
					<Card>
						<CardHeader>
							<div className="flex items-center justify-between">
								<CardTitle className="flex items-center gap-2">
									<Shield className="h-5 w-5" />
									Event Summary
								</CardTitle>
								{getStatusBadge(event.status)}
							</div>
						</CardHeader>
						<CardContent className="space-y-4">
							<div className="grid grid-cols-2 gap-4">
								<div>
									<label className="text-muted-foreground text-sm">
										Event Type
									</label>
									<div className="mt-1 flex items-center gap-2">
										{getEventTypeIcon(event.eventType)}
										<span className="font-medium">
											{formatEventType(event.eventType)}
										</span>
									</div>
								</div>
								<div>
									<label className="text-muted-foreground text-sm">
										Severity
									</label>
									<div className="mt-1">{getSeverityBadge(event.severity)}</div>
								</div>
								<div>
									<label className="text-muted-foreground text-sm">
										Fraud Score
									</label>
									<div className="mt-1 font-bold font-mono text-lg">
										{event.score}/100
									</div>
								</div>
								<div>
									<label className="text-muted-foreground text-sm">
										Detected At
									</label>
									<div className="mt-1">
										{new Date(event.detectedAt).toLocaleString()}
									</div>
								</div>
							</div>
						</CardContent>
					</Card>

					{/* Signal Details */}
					<Card>
						<CardHeader>
							<CardTitle>Detection Signals</CardTitle>
						</CardHeader>
						<CardContent>
							<div className="space-y-3">
								{event.signals.map((signal, idx) => (
									<div key={idx} className="rounded-lg border bg-muted/30 p-3">
										<div className="mb-2 flex items-center justify-between">
											<span className="font-medium">
												{formatEventType(signal.type as FraudEventType)}
											</span>
											<div className="flex items-center gap-2">
												{getSeverityBadge(signal.severity)}
												<Badge variant="outline">
													{signal.confidence}% confident
												</Badge>
											</div>
										</div>
										{signal.metadata && (
											<div className="text-muted-foreground text-sm">
												<pre className="overflow-auto rounded bg-muted p-2 text-xs">
													{JSON.stringify(signal.metadata, null, 2)}
												</pre>
											</div>
										)}
									</div>
								))}
							</div>
						</CardContent>
					</Card>

					{/* Location Data (for GPS events) */}
					{(event.location ?? event.velocityKmh ?? event.distanceKm) && (
						<Card>
							<CardHeader>
								<CardTitle className="flex items-center gap-2">
									<MapPin className="h-5 w-5" />
									Location Data
								</CardTitle>
							</CardHeader>
							<CardContent>
								<div className="grid grid-cols-2 gap-4 md:grid-cols-4">
									{event.location && (
										<div>
											<label className="text-muted-foreground text-sm">
												Current Location
											</label>
											<div className="mt-1 font-mono text-sm">
												{event.location.lat.toFixed(6)},{" "}
												{event.location.lng.toFixed(6)}
											</div>
										</div>
									)}
									{event.previousLocation && (
										<div>
											<label className="text-muted-foreground text-sm">
												Previous Location
											</label>
											<div className="mt-1 font-mono text-sm">
												{event.previousLocation.lat.toFixed(6)},{" "}
												{event.previousLocation.lng.toFixed(6)}
											</div>
										</div>
									)}
									{event.distanceKm !== null && (
										<div>
											<label className="text-muted-foreground text-sm">
												Distance
											</label>
											<div className="mt-1 font-mono text-sm">
												{event.distanceKm.toFixed(2)} km
											</div>
										</div>
									)}
									{event.velocityKmh !== null && (
										<div>
											<label className="text-muted-foreground text-sm">
												Velocity
											</label>
											<div className="mt-1 font-mono text-sm">
												{event.velocityKmh.toFixed(1)} km/h
											</div>
										</div>
									)}
									{event.timeDeltaSeconds !== null && (
										<div>
											<label className="text-muted-foreground text-sm">
												Time Delta
											</label>
											<div className="mt-1 font-mono text-sm">
												{event.timeDeltaSeconds}s
											</div>
										</div>
									)}
								</div>
							</CardContent>
						</Card>
					)}

					{/* Resolution History */}
					{(event.resolution ?? event.actionTaken ?? event.resolvedAt) && (
						<Card>
							<CardHeader>
								<CardTitle>Resolution</CardTitle>
							</CardHeader>
							<CardContent className="space-y-3">
								{event.handledBy && (
									<div>
										<label className="text-muted-foreground text-sm">
											Handled By
										</label>
										<div className="mt-1">{event.handledBy.name}</div>
									</div>
								)}
								{event.resolution && (
									<div>
										<label className="text-muted-foreground text-sm">
											Resolution Notes
										</label>
										<div className="mt-1">{event.resolution}</div>
									</div>
								)}
								{event.actionTaken && (
									<div>
										<label className="text-muted-foreground text-sm">
											Action Taken
										</label>
										<div className="mt-1">{event.actionTaken}</div>
									</div>
								)}
								{event.resolvedAt && (
									<div>
										<label className="text-muted-foreground text-sm">
											Resolved At
										</label>
										<div className="mt-1">
											{new Date(event.resolvedAt).toLocaleString()}
										</div>
									</div>
								)}
							</CardContent>
						</Card>
					)}
				</div>

				{/* Sidebar */}
				<div className="space-y-4">
					{/* User Info */}
					<Card>
						<CardHeader>
							<CardTitle className="flex items-center gap-2">
								<User className="h-5 w-5" />
								User Information
							</CardTitle>
						</CardHeader>
						<CardContent className="space-y-3">
							{event.user ? (
								<>
									<div>
										<label className="text-muted-foreground text-sm">
											Name
										</label>
										<div className="mt-1 font-medium">{event.user.name}</div>
									</div>
									<div>
										<label className="text-muted-foreground text-sm">
											Email
										</label>
										<div className="mt-1">{event.user.email}</div>
									</div>
									<div>
										<label className="text-muted-foreground text-sm">
											User ID
										</label>
										<div className="mt-1 break-all font-mono text-sm">
											{event.userId}
										</div>
									</div>
								</>
							) : (
								<p className="text-muted-foreground">No user associated</p>
							)}
						</CardContent>
					</Card>

					{/* Driver Info */}
					{event.driver && (
						<Card>
							<CardHeader>
								<CardTitle>Driver Information</CardTitle>
							</CardHeader>
							<CardContent className="space-y-3">
								<div>
									<label className="text-muted-foreground text-sm">
										Student ID
									</label>
									<div className="mt-1 font-mono">{event.driver.studentId}</div>
								</div>
								<div>
									<label className="text-muted-foreground text-sm">
										License Plate
									</label>
									<div className="mt-1 font-mono">
										{event.driver.licensePlate}
									</div>
								</div>
							</CardContent>
						</Card>
					)}

					{/* Request Context */}
					<Card>
						<CardHeader>
							<CardTitle>Request Context</CardTitle>
						</CardHeader>
						<CardContent className="space-y-3">
							{event.ipAddress && (
								<div>
									<label className="text-muted-foreground text-sm">
										IP Address
									</label>
									<div className="mt-1 font-mono text-sm">
										{event.ipAddress}
									</div>
								</div>
							)}
							{event.userAgent && (
								<div>
									<label className="text-muted-foreground text-sm">
										User Agent
									</label>
									<div className="mt-1 break-all text-muted-foreground text-sm">
										{event.userAgent}
									</div>
								</div>
							)}
						</CardContent>
					</Card>

					{/* Review Actions */}
					{event.status !== "CONFIRMED" && event.status !== "DISMISSED" && (
						<Card>
							<CardHeader>
								<CardTitle>Review Event</CardTitle>
							</CardHeader>
							<CardContent className="space-y-4">
								<div>
									<label className="text-muted-foreground text-sm">
										Update Status
									</label>
									<Select
										value={newStatus}
										onValueChange={(v) =>
											setNewStatus(v as Exclude<FraudStatus, "PENDING">)
										}
									>
										<SelectTrigger className="mt-1">
											<SelectValue placeholder="Select status" />
										</SelectTrigger>
										<SelectContent>
											<SelectItem value="REVIEWING">Start Review</SelectItem>
											<SelectItem value="CONFIRMED">Confirm Fraud</SelectItem>
											<SelectItem value="DISMISSED">Dismiss</SelectItem>
										</SelectContent>
									</Select>
								</div>

								<div>
									<label className="text-muted-foreground text-sm">
										Resolution Notes
									</label>
									<Textarea
										className="mt-1"
										placeholder="Enter resolution details..."
										value={resolution}
										onChange={(e) => setResolution(e.target.value)}
									/>
								</div>

								<div>
									<label className="text-muted-foreground text-sm">
										Action Taken
									</label>
									<Textarea
										className="mt-1"
										placeholder="Describe actions taken..."
										value={actionTaken}
										onChange={(e) => setActionTaken(e.target.value)}
									/>
								</div>

								<Button
									className="w-full"
									onClick={handleSubmitReview}
									disabled={!newStatus || reviewMutation.isPending}
								>
									{reviewMutation.isPending ? (
										<Loader2 className="mr-2 h-4 w-4 animate-spin" />
									) : null}
									Submit Review
								</Button>
							</CardContent>
						</Card>
					)}
				</div>
			</div>
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

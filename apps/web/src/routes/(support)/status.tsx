import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import {
	Activity,
	AlertTriangle,
	Bell,
	CheckCircle2,
	Clock,
	CreditCard,
	Globe,
	MapPin,
	Server,
	Smartphone,
	XCircle,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { APP_NAME } from "@/lib/constants";

export const Route = createFileRoute("/(support)/status")({
	component: StatusComponent,
	head: () => ({
		meta: [
			{
				title: `${m.system_status()} - ${APP_NAME}`,
			},
			{
				name: "description",
				content: m.system_status_page_desc(),
			},
		],
	}),
});

type ServiceStatus =
	| "operational"
	| "degraded"
	| "partial_outage"
	| "major_outage"
	| "maintenance";

type Service = {
	id: string;
	name: string;
	icon: React.ReactNode;
	status: ServiceStatus;
	uptime: number;
	responseTime: string;
};

function StatusComponent() {
	const getStatusConfig = (status: ServiceStatus) => {
		switch (status) {
			case "operational":
				return {
					label: m.operational(),
					color: "bg-green-500",
					icon: CheckCircle2,
					textColor: "text-green-600 dark:text-green-400",
					bgColor: "bg-green-50 dark:bg-green-950/20",
				};
			case "degraded":
				return {
					label: m.degraded_performance(),
					color: "bg-yellow-500",
					icon: AlertTriangle,
					textColor: "text-yellow-600 dark:text-yellow-400",
					bgColor: "bg-yellow-50 dark:bg-yellow-950/20",
				};
			case "partial_outage":
				return {
					label: m.partial_outage(),
					color: "bg-orange-500",
					icon: AlertTriangle,
					textColor: "text-orange-600 dark:text-orange-400",
					bgColor: "bg-orange-50 dark:bg-orange-950/20",
				};
			case "major_outage":
				return {
					label: m.major_outage(),
					color: "bg-red-500",
					icon: XCircle,
					textColor: "text-red-600 dark:text-red-400",
					bgColor: "bg-red-50 dark:bg-red-950/20",
				};
			case "maintenance":
				return {
					label: m.under_maintenance(),
					color: "bg-blue-500",
					icon: Clock,
					textColor: "text-blue-600 dark:text-blue-400",
					bgColor: "bg-blue-50 dark:bg-blue-950/20",
				};
		}
	};

	const services: Service[] = [
		{
			id: "api",
			name: m.api_services(),
			icon: <Server className="h-5 w-5" />,
			status: "operational",
			uptime: 99.9,
			responseTime: "< 100ms",
		},
		{
			id: "mobile",
			name: m.mobile_app(),
			icon: <Smartphone className="h-5 w-5" />,
			status: "operational",
			uptime: 99.8,
			responseTime: "< 200ms",
		},
		{
			id: "web",
			name: m.web_app(),
			icon: <Globe className="h-5 w-5" />,
			status: "operational",
			uptime: 99.9,
			responseTime: "< 150ms",
		},
		{
			id: "payment",
			name: m.payment_gateway(),
			icon: <CreditCard className="h-5 w-5" />,
			status: "operational",
			uptime: 99.95,
			responseTime: "< 500ms",
		},
		{
			id: "location",
			name: m.location_services(),
			icon: <MapPin className="h-5 w-5" />,
			status: "operational",
			uptime: 99.7,
			responseTime: "< 300ms",
		},
		{
			id: "notifications",
			name: m.notifications(),
			icon: <Bell className="h-5 w-5" />,
			status: "operational",
			uptime: 99.6,
			responseTime: "< 1s",
		},
	];

	const allOperational = services.every(
		(service) => service.status === "operational",
	);

	const lastUpdated = new Date().toLocaleString();

	return (
		<div className="min-h-screen bg-background">
			{/* Hero Section */}
			<div className="border-b bg-gradient-to-b from-primary/5 to-background">
				<div className="container mx-auto px-4 py-16 sm:px-6 lg:px-8">
					<div className="mx-auto max-w-3xl text-center">
						<Activity className="mx-auto mb-4 h-12 w-12 text-primary" />
						<h1 className="mb-4 font-bold text-4xl tracking-tight">
							{m.system_status_page_title()}
						</h1>
						<p className="mb-6 text-lg text-muted-foreground">
							{m.system_status_page_desc()}
						</p>

						{/* Overall Status Badge */}
						{allOperational ? (
							<div className="mx-auto inline-flex items-center gap-2 rounded-full bg-green-100 px-6 py-3 dark:bg-green-950/30">
								<CheckCircle2 className="h-5 w-5 text-green-600 dark:text-green-400" />
								<span className="font-semibold text-green-900 dark:text-green-100">
									{m.all_systems_operational()}
								</span>
							</div>
						) : (
							<div className="mx-auto inline-flex items-center gap-2 rounded-full bg-yellow-100 px-6 py-3 dark:bg-yellow-950/30">
								<AlertTriangle className="h-5 w-5 text-yellow-600 dark:text-yellow-400" />
								<span className="font-semibold text-yellow-900 dark:text-yellow-100">
									Some services are experiencing issues
								</span>
							</div>
						)}
					</div>
				</div>
			</div>

			{/* Services Status */}
			<div className="container mx-auto px-4 py-12 sm:px-6 lg:px-8">
				<div className="mx-auto max-w-5xl space-y-8">
					{/* Services Grid */}
					<div className="space-y-4">
						{services.map((service) => {
							const config = getStatusConfig(service.status);
							const StatusIcon = config.icon;

							return (
								<Card key={service.id}>
									<CardContent className="p-6">
										<div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
											<div className="flex items-center gap-4">
												<div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
													{service.icon}
												</div>
												<div>
													<h3 className="font-semibold text-lg">
														{service.name}
													</h3>
													<div className="mt-1 flex items-center gap-2">
														<StatusIcon
															className={`h-4 w-4 ${config.textColor}`}
														/>
														<span
															className={`font-medium text-sm ${config.textColor}`}
														>
															{config.label}
														</span>
													</div>
												</div>
											</div>
											<div className="flex gap-6 text-sm">
												<div>
													<div className="text-muted-foreground">
														{m.uptime()}
													</div>
													<div className="font-semibold">{service.uptime}%</div>
												</div>
												<div>
													<div className="text-muted-foreground">
														{m.response_time()}
													</div>
													<div className="font-semibold">
														{service.responseTime}
													</div>
												</div>
											</div>
										</div>
										<div className="mt-4">
											<Progress value={service.uptime} className="h-2" />
										</div>
									</CardContent>
								</Card>
							);
						})}
					</div>

					{/* Incident History */}
					<Card>
						<CardHeader>
							<CardTitle>{m.incident_history()}</CardTitle>
						</CardHeader>
						<CardContent>
							<div className="flex flex-col items-center justify-center py-8 text-center">
								<CheckCircle2 className="mb-3 h-12 w-12 text-green-600 dark:text-green-400" />
								<p className="font-medium text-lg">
									{m.no_incidents_reported()}
								</p>
								<p className="mt-2 text-muted-foreground text-sm">
									All services have been running smoothly
								</p>
							</div>
						</CardContent>
					</Card>

					{/* Subscribe Section */}
					<Card className="bg-primary/5">
						<CardContent className="p-6">
							<div className="text-center">
								<Bell className="mx-auto mb-3 h-10 w-10 text-primary" />
								<h3 className="mb-2 font-semibold text-lg">
									{m.subscribe_to_updates()}
								</h3>
								<p className="mb-4 text-muted-foreground text-sm">
									Get notified when system status changes
								</p>
								<Badge variant="outline" className="gap-1">
									<Clock className="h-3 w-3" />
									{m.last_updated_at()}: {lastUpdated}
								</Badge>
							</div>
						</CardContent>
					</Card>
				</div>
			</div>
		</div>
	);
}

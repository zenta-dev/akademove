import { useQuery } from "@tanstack/react-query";
import {
	createFileRoute,
	Link,
	redirect,
	useNavigate,
} from "@tanstack/react-router";
import {
	Car,
	CheckCircle,
	Clock,
	FileCheck,
	Loader2,
	Store,
} from "lucide-react";
import { useMemo, useState } from "react";
import {
	PendingDriversTable,
	PendingMerchantsTable,
} from "@/components/tables/pending-approvals";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { hasAccess } from "@/lib/actions";
import { orpcQuery } from "@/lib/orpc";

export const Route = createFileRoute("/dash/operator/approvals")({
	head: () => ({ meta: [{ title: "Approval Dashboard - Operator" }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["OPERATOR"]);
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
	const [activeTab, setActiveTab] = useState<"drivers" | "merchants">(
		"drivers",
	);

	if (!allowed) navigate({ to: "/" });

	// Fetch pending drivers
	const driversQuery = useQuery(
		orpcQuery.driver.list.queryOptions({
			input: {
				query: {
					statuses: ["PENDING"],
					page: 1,
					limit: 50,
					order: "desc",
				},
			},
		}),
	);

	// Fetch pending merchants
	const merchantsQuery = useQuery(
		orpcQuery.merchant.list.queryOptions({
			input: {
				query: {
					page: 1,
					limit: 50,
				},
			},
		}),
	);

	const pendingDrivers = useMemo(
		() => driversQuery.data?.body.data ?? [],
		[driversQuery.data?.body.data],
	);

	const pendingMerchants = useMemo(
		() =>
			(merchantsQuery.data?.body.data ?? []).filter(
				(m) => m.status === "PENDING",
			),
		[merchantsQuery.data?.body.data],
	);

	const isLoading = driversQuery.isPending || merchantsQuery.isPending;

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">Approval Dashboard</h2>
				<p className="text-muted-foreground">
					Review and approve pending driver and merchant applications
				</p>
			</div>

			{/* Summary Cards */}
			<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Pending Drivers
						</CardTitle>
						<Car className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{isLoading ? (
								<Loader2 className="h-6 w-6 animate-spin" />
							) : (
								pendingDrivers.length
							)}
						</div>
						<p className="text-muted-foreground text-xs">
							Awaiting document review
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Pending Merchants
						</CardTitle>
						<Store className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{isLoading ? (
								<Loader2 className="h-6 w-6 animate-spin" />
							) : (
								pendingMerchants.length
							)}
						</div>
						<p className="text-muted-foreground text-xs">
							Awaiting business verification
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Pending</CardTitle>
						<Clock className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-2xl">
							{isLoading ? (
								<Loader2 className="h-6 w-6 animate-spin" />
							) : (
								pendingDrivers.length + pendingMerchants.length
							)}
						</div>
						<p className="text-muted-foreground text-xs">
							Applications to review
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Quick Actions</CardTitle>
						<FileCheck className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent className="space-y-2">
						<Button
							variant="outline"
							size="sm"
							className="w-full justify-start"
							asChild
						>
							<Link
								to="/dash/operator/drivers"
								search={{ page: 1, limit: 11, order: "desc", mode: "offset" }}
							>
								View All Drivers
							</Link>
						</Button>
						<Button
							variant="outline"
							size="sm"
							className="w-full justify-start"
							asChild
						>
							<Link
								to="/dash/operator/merchants"
								search={{ page: 1, limit: 11, order: "desc", mode: "offset" }}
							>
								View All Merchants
							</Link>
						</Button>
					</CardContent>
				</Card>
			</div>

			{/* Tabs for Drivers and Merchants */}
			<Card>
				<Tabs
					value={activeTab}
					onValueChange={(v) => setActiveTab(v as "drivers" | "merchants")}
				>
					<CardHeader>
						<div className="flex items-center justify-between">
							<div>
								<CardTitle>Pending Applications</CardTitle>
								<CardDescription>
									Click on an application to review and approve
								</CardDescription>
							</div>
							<TabsList>
								<TabsTrigger value="drivers" className="gap-2">
									<Car className="h-4 w-4" />
									Drivers
									{pendingDrivers.length > 0 && (
										<Badge variant="secondary" className="ml-1">
											{pendingDrivers.length}
										</Badge>
									)}
								</TabsTrigger>
								<TabsTrigger value="merchants" className="gap-2">
									<Store className="h-4 w-4" />
									Merchants
									{pendingMerchants.length > 0 && (
										<Badge variant="secondary" className="ml-1">
											{pendingMerchants.length}
										</Badge>
									)}
								</TabsTrigger>
							</TabsList>
						</div>
					</CardHeader>

					<CardContent>
						<TabsContent value="drivers" className="mt-0">
							{isLoading ? (
								<div className="flex items-center justify-center py-12">
									<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
								</div>
							) : pendingDrivers.length === 0 ? (
								<div className="flex flex-col items-center justify-center py-12 text-center">
									<CheckCircle className="mb-4 h-12 w-12 text-green-500" />
									<h3 className="font-medium text-lg">All caught up!</h3>
									<p className="text-muted-foreground">
										No pending driver applications to review
									</p>
								</div>
							) : (
								<PendingDriversTable
									drivers={pendingDrivers}
									dashRole="operator"
								/>
							)}
						</TabsContent>

						<TabsContent value="merchants" className="mt-0">
							{isLoading ? (
								<div className="flex items-center justify-center py-12">
									<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
								</div>
							) : pendingMerchants.length === 0 ? (
								<div className="flex flex-col items-center justify-center py-12 text-center">
									<CheckCircle className="mb-4 h-12 w-12 text-green-500" />
									<h3 className="font-medium text-lg">All caught up!</h3>
									<p className="text-muted-foreground">
										No pending merchant applications to review
									</p>
								</div>
							) : (
								<PendingMerchantsTable
									merchants={pendingMerchants}
									dashRole="operator"
								/>
							)}
						</TabsContent>
					</CardContent>
				</Tabs>
			</Card>
		</>
	);
}

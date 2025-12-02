import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { useQuery } from "@tanstack/react-query";
import {
	createFileRoute,
	Link,
	redirect,
	useNavigate,
} from "@tanstack/react-router";
import {
	Calendar,
	Car,
	CheckCircle2,
	Clock,
	Loader2,
	MapPin,
	Package,
	Star,
	Utensils,
	XCircle,
} from "lucide-react";
import { useState } from "react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/user/history")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.USER.HISTORY }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			order: ["create", "get", "update", "cancel"],
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
	const [filterStatus, setFilterStatus] = useState<
		"active" | "completed" | "cancelled" | "all"
	>("active");

	if (!allowed) navigate({ to: "/" });

	// Fetch orders based on filter
	const { data: ordersResult, isLoading } = useQuery({
		queryKey: ["user", "orders", filterStatus, search],
		queryFn: async () => {
			let statuses: string[] | undefined;

			if (filterStatus === "active") {
				statuses = [
					"REQUESTED",
					"MATCHING",
					"ACCEPTED",
					"PREPARING",
					"READY_FOR_PICKUP",
					"ARRIVING",
					"IN_TRIP",
				];
			} else if (filterStatus === "completed") {
				statuses = ["COMPLETED"];
			} else if (filterStatus === "cancelled") {
				statuses = [
					"CANCELLED_BY_USER",
					"CANCELLED_BY_DRIVER",
					"CANCELLED_BY_MERCHANT",
					"CANCELLED_BY_SYSTEM",
				];
			}

			const result = await orpcClient.order.list({
				query: {
					...search,
					statuses,
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body;
		},
		refetchInterval: filterStatus === "active" ? 10000 : undefined,
	});

	const orderTypeIcons = {
		RIDE: Car,
		DELIVERY: Package,
		FOOD: Utensils,
	};

	const orderTypeColors = {
		RIDE: "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300",
		DELIVERY:
			"bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-300",
		FOOD: "bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-300",
	};

	const statusColors: Record<string, string> = {
		REQUESTED: "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300",
		MATCHING:
			"bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300",
		ACCEPTED: "bg-cyan-100 text-cyan-800 dark:bg-cyan-900 dark:text-cyan-300",
		PREPARING:
			"bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-300",
		READY_FOR_PICKUP:
			"bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-300",
		ARRIVING:
			"bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-300",
		IN_TRIP:
			"bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300",
		COMPLETED:
			"bg-emerald-100 text-emerald-800 dark:bg-emerald-900 dark:text-emerald-300",
		CANCELLED_BY_USER:
			"bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
		CANCELLED_BY_DRIVER:
			"bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
		CANCELLED_BY_MERCHANT:
			"bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
		CANCELLED_BY_SYSTEM:
			"bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
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

	const formatDate = (date: Date | string) => {
		return new Intl.DateTimeFormat("id-ID", {
			month: "short",
			day: "numeric",
			year: "numeric",
			hour: "2-digit",
			minute: "2-digit",
		}).format(new Date(date));
	};

	const getStatusIcon = (status: string) => {
		if (status === "COMPLETED") return CheckCircle2;
		if (status.startsWith("CANCELLED")) return XCircle;
		return Clock;
	};

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.history()}</h2>
				<p className="text-muted-foreground">View and track all your orders</p>
			</div>

			{/* Filter Tabs */}
			<Tabs
				value={filterStatus}
				onValueChange={(v) => setFilterStatus(v as typeof filterStatus)}
			>
				<TabsList>
					<TabsTrigger value="active">Active</TabsTrigger>
					<TabsTrigger value="completed">Completed</TabsTrigger>
					<TabsTrigger value="cancelled">Cancelled</TabsTrigger>
					<TabsTrigger value="all">All Orders</TabsTrigger>
				</TabsList>
			</Tabs>

			{/* Orders List */}
			<div className="space-y-4">
				{isLoading ? (
					<div className="flex min-h-[50vh] items-center justify-center">
						<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
					</div>
				) : !ordersResult?.data || ordersResult.data.length === 0 ? (
					<Card>
						<CardContent className="flex flex-col items-center justify-center py-12 text-center">
							<Package className="mb-4 h-12 w-12 text-muted-foreground" />
							<h3 className="mb-2 font-semibold text-lg">No orders found</h3>
							<p className="mb-4 text-muted-foreground text-sm">
								{filterStatus === "active" &&
									"You don't have any active orders"}
								{filterStatus === "completed" &&
									"You haven't completed any orders yet"}
								{filterStatus === "cancelled" && "No cancelled orders"}
								{filterStatus === "all" && "Start by placing your first order"}
							</p>
							{filterStatus !== "active" && (
								<Button asChild>
									<Link to="/dash/user/bookings">Place Order</Link>
								</Button>
							)}
						</CardContent>
					</Card>
				) : (
					ordersResult.data.map((order: Order) => {
						const TypeIcon = orderTypeIcons[order.type];
						const StatusIcon = getStatusIcon(order.status);
						const isActive =
							!order.status.startsWith("CANCELLED") &&
							order.status !== "COMPLETED";

						return (
							<Card
								key={order.id}
								className={cn(isActive && "border-primary/50")}
							>
								<CardHeader>
									<div className="flex items-start justify-between">
										<div className="flex items-center gap-2">
											<Badge
												variant="secondary"
												className={cn("gap-1", orderTypeColors[order.type])}
											>
												<TypeIcon className="h-3 w-3" />
												{order.type}
											</Badge>
											<Badge
												variant="secondary"
												className={cn("gap-1", statusColors[order.status])}
											>
												<StatusIcon className="h-3 w-3" />
												{formatStatus(order.status)}
											</Badge>
										</div>
										<div className="text-right">
											<p className="font-semibold text-lg">
												{formatPrice(order.totalPrice)}
											</p>
										</div>
									</div>
									<CardTitle className="text-base">
										Order #{order.id.slice(0, 8)}
									</CardTitle>
									<CardDescription className="flex items-center gap-4">
										<span className="flex items-center gap-1">
											<Calendar className="h-3 w-3" />
											{formatDate(order.createdAt)}
										</span>
										<span className="flex items-center gap-1">
											<MapPin className="h-3 w-3" />
											{order.distanceKm.toFixed(1)} km
										</span>
									</CardDescription>
								</CardHeader>
								<CardContent className="space-y-4">
									{/* Locations */}
									<div className="space-y-2">
										<div className="flex items-start gap-2">
											<div className="mt-1 h-2 w-2 rounded-full bg-green-500" />
											<div className="flex-1">
												<p className="font-medium text-sm">Pickup</p>
												<p className="text-muted-foreground text-xs">
													{order.pickupLocation.x.toFixed(4)},{" "}
													{order.pickupLocation.y.toFixed(4)}
													{order.note?.pickup && ` • ${order.note.pickup}`}
												</p>
											</div>
										</div>
										<div className="flex items-start gap-2">
											<div className="mt-1 h-2 w-2 rounded-full bg-red-500" />
											<div className="flex-1">
												<p className="font-medium text-sm">Dropoff</p>
												<p className="text-muted-foreground text-xs">
													{order.dropoffLocation.x.toFixed(4)},{" "}
													{order.dropoffLocation.y.toFixed(4)}
													{order.note?.dropoff && ` • ${order.note.dropoff}`}
												</p>
											</div>
										</div>
									</div>

									{/* Driver Info */}
									{order.driver && (
										<div className="rounded-lg border bg-muted/50 p-3">
											<p className="mb-1 font-medium text-sm">Driver</p>
											<div className="flex items-center justify-between">
												<div>
													<p className="text-sm">
														{order.driver.user?.name || "Driver"}
													</p>
													<div className="flex items-center gap-1">
														<Star className="h-3 w-3 fill-yellow-400 text-yellow-400" />
														<span className="text-muted-foreground text-xs">
															{order.driver.rating?.toFixed(2) || "N/A"}
														</span>
														<span className="text-muted-foreground text-xs">
															• {order.driver.licensePlate}
														</span>
													</div>
												</div>
											</div>
										</div>
									)}

									{/* Food Items */}
									{order.type === "FOOD" &&
										order.items &&
										order.items.length > 0 && (
											<div className="rounded-lg border bg-muted/50 p-3">
												<p className="mb-2 font-medium text-sm">
													Items ({order.items.length})
												</p>
												<div className="space-y-1">
													{order.items.slice(0, 3).map((item) => (
														<p
															key={item.item.id}
															className="text-muted-foreground text-xs"
														>
															{item.quantity}x {item.item.name}
														</p>
													))}
													{order.items.length > 3 && (
														<p className="text-muted-foreground text-xs">
															+{order.items.length - 3} more items
														</p>
													)}
												</div>
											</div>
										)}

									{/* Action Buttons */}
									<div className="flex gap-2">
										{isActive && (
											<Button variant="outline" size="sm" className="flex-1">
												Track Order
											</Button>
										)}
										{order.status === "COMPLETED" && (
											<Button variant="outline" size="sm" className="flex-1">
												<Star className="mr-2 h-4 w-4" />
												Rate Order
											</Button>
										)}
										<Button variant="ghost" size="sm">
											View Details
										</Button>
									</div>
								</CardContent>
							</Card>
						);
					})
				)}
			</div>
		</>
	);
}

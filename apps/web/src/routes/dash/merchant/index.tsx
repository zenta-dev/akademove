import { m } from "@repo/i18n";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Package } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { useOrderUpdates } from "@/hooks/use-order-updates";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/merchant/")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.MERCHANT.OVERVIEW }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			merchant: ["get", "update"],
			merchantMenu: ["list", "get", "create", "update", "delete"],
			order: ["get", "update"],
			review: ["get"],
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

	// Enable real-time order updates on dashboard
	useOrderUpdates(true, 10000);

	if (!allowed) navigate({ to: "/" });

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.overview()}</h2>
				<p className="text-muted-foreground">
					Monitor your orders, revenue, and performance
				</p>
			</div>

			{/* Quick Actions */}
			<div className="grid gap-4 md:grid-cols-3">
				<Card>
					<CardHeader>
						<CardTitle className="text-base">Orders</CardTitle>
						<CardDescription>Manage incoming orders</CardDescription>
					</CardHeader>
					<CardContent>
						<Button
							onClick={() =>
								navigate({
									to: "/dash/merchant/orders",
									search: { page: 1, limit: 15, mode: "offset", order: "desc" },
								})
							}
						>
							View Orders
						</Button>
					</CardContent>
				</Card>

				<Card>
					<CardHeader>
						<CardTitle className="text-base">Menu</CardTitle>
						<CardDescription>Update your menu items</CardDescription>
					</CardHeader>
					<CardContent>
						<Button
							onClick={() =>
								navigate({
									to: "/dash/merchant/menu",
									search: { page: 1, limit: 7, mode: "offset", order: "desc" },
								})
							}
							variant="outline"
						>
							Manage Menu
						</Button>
					</CardContent>
				</Card>

				<Card>
					<CardHeader>
						<CardTitle className="text-base">Sales</CardTitle>
						<CardDescription>View sales analytics</CardDescription>
					</CardHeader>
					<CardContent>
						<Button
							onClick={() =>
								navigate({
									to: "/dash/merchant/sales",
									search: { tab: "overview" },
								})
							}
							variant="outline"
						>
							View Sales
						</Button>
					</CardContent>
				</Card>
			</div>

			{/* Placeholder for future dashboard content */}
			<Card className="flex-1">
				<CardContent className="flex flex-col items-center justify-center py-12">
					<Package className="mb-4 h-16 w-16 text-muted-foreground" />
					<h3 className="mb-2 font-semibold text-lg">Dashboard Coming Soon</h3>
					<p className="mb-6 text-center text-muted-foreground text-sm">
						Real-time analytics, order statistics, and performance metrics will
						appear here
					</p>
					<Button
						onClick={() =>
							navigate({
								to: "/dash/merchant/orders",
								search: { page: 1, limit: 15, mode: "offset", order: "desc" },
							})
						}
					>
						Go to Orders
					</Button>
				</CardContent>
			</Card>
		</>
	);
}

import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Wifi, WifiOff } from "lucide-react";
import { OrderTable } from "@/components/tables/order/table";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { useOrderUpdates } from "@/hooks/use-order-updates";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/merchant/orders")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.MERCHANT.ORDERS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			order: ["get", "update"],
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
	const search = Route.useSearch();
	const navigate = useNavigate();

	// Enable real-time order updates (polling every 10 seconds)
	const { isConnected } = useOrderUpdates(true, 10000);

	if (!allowed) navigate({ to: "/" });

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.orders()}</h2>
					<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
				</div>
				<Badge
					variant={isConnected ? "default" : "secondary"}
					className="gap-1.5"
				>
					{isConnected ? (
						<>
							<Wifi className="h-3 w-3" />
							Live Updates
						</>
					) : (
						<>
							<WifiOff className="h-3 w-3" />
							Disconnected
						</>
					)}
				</Badge>
			</div>
			<Card className="p-0">
				<CardContent className="p-0">
					<OrderTable search={search} to="/dash/merchant/orders" />
				</CardContent>
			</Card>
		</>
	);
}

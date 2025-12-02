import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Wifi, WifiOff } from "lucide-react";
import { useCallback, useEffect, useState } from "react";
import { toast } from "sonner";
import { NotificationBanner } from "@/components/notification-banner";
import { OrderTable } from "@/components/tables/order/table";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { useNotifications } from "@/hooks/use-notifications";
import { useOrderUpdates } from "@/hooks/use-order-updates";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/driver/orders")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.DRIVER.ORDERS }] }),
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
	const { permission, showNotification } = useNotifications();
	const [showBanner, setShowBanner] = useState(true);

	// Handle new order notifications
	const handleNewOrder = useCallback(
		(order: unknown) => {
			// Play notification sound
			import("@/lib/notification-sound").then(({ notificationSound }) => {
				notificationSound.play();
			});

			// Show browser notification if permission granted
			if (permission === "granted") {
				const orderData = order as { id: string; type?: string };
				showNotification("New Order Available!", {
					body: `${orderData.type || "Order"} #${orderData.id.slice(0, 8)} - Accept it now!`,
					tag: `order-${orderData.id}`,
					requireInteraction: true,
					data: { orderId: orderData.id },
				});
			}

			// Always show toast notification
			toast.success("New Order Available!", {
				description: "A new order is available in your area. Check it out!",
			});
		},
		[permission, showNotification],
	);

	// Enable real-time order updates with notification callback
	const { isConnected } = useOrderUpdates({
		enabled: true,
		interval: 10000,
		onNewOrder: handleNewOrder,
	});

	// Listen for notification clicks to navigate to order details
	useEffect(() => {
		if (typeof window === "undefined" || !("serviceWorker" in navigator))
			return;

		const handleNotificationClick = (event: MessageEvent) => {
			if (event.data?.type === "notification-click") {
				const { orderId } = event.data.data || {};
				if (orderId) {
					navigate({
						to: "/dash/driver/orders",
						search: { page: 1, limit: 15, order: "desc", mode: "offset" },
					});
				}
			}
		};

		navigator.serviceWorker?.addEventListener(
			"message",
			handleNotificationClick,
		);

		return () => {
			navigator.serviceWorker?.removeEventListener(
				"message",
				handleNotificationClick,
			);
		};
	}, [navigate]);

	if (!allowed) navigate({ to: "/" });

	return (
		<>
			{permission !== "granted" && showBanner && (
				<NotificationBanner onDismiss={() => setShowBanner(false)} />
			)}
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.orders()}</h2>
					<p className="text-muted-foreground">
						Manage your active and completed orders
					</p>
				</div>
				<Badge
					variant={isConnected ? "default" : "secondary"}
					className="gap-1"
				>
					{isConnected ? (
						<>
							<Wifi className="h-3 w-3" />
							Live Updates
						</>
					) : (
						<>
							<WifiOff className="h-3 w-3" />
							Reconnecting...
						</>
					)}
				</Badge>
			</div>
			<Card className="p-0">
				<CardContent className="p-0">
					<OrderTable search={search} to="/dash/driver/orders" />
				</CardContent>
			</Card>
		</>
	);
}

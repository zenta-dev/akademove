import { createFileRoute, redirect } from "@tanstack/react-router";
import { MerchantStatusToggle } from "@/components/merchant/merchant-status-toggle";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { useMyMerchant } from "@/providers/merchant";

export const Route = createFileRoute("/dash/merchant/availability")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.MERCHANT.OVERVIEW }] }),
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
	const merchant = useMyMerchant();

	if (merchant.isLoading) {
		return (
			<>
				<div>
					<h2 className="font-medium text-xl">Store Availability</h2>
					<p className="text-muted-foreground">
						Manage when your store is open and taking orders
					</p>
				</div>
				<Skeleton className="h-[400px] w-full" />
			</>
		);
	}

	if (merchant.isError || !merchant.value) {
		return (
			<>
				<div>
					<h2 className="font-medium text-xl">Store Availability</h2>
					<p className="text-muted-foreground">
						Manage when your store is open and taking orders
					</p>
				</div>
				<Card>
					<CardContent className="p-8 text-center text-muted-foreground">
						Failed to load merchant data
					</CardContent>
				</Card>
			</>
		);
	}

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">Store Availability</h2>
				<p className="text-muted-foreground">
					Manage when your store is open and taking orders
				</p>
			</div>

			<Card>
				<CardHeader>
					<CardTitle>Availability Controls</CardTitle>
					<CardDescription>
						Control your online status, order-taking status, and operating
						status
					</CardDescription>
				</CardHeader>
				<CardContent>
					<MerchantStatusToggle
						merchantId={merchant.value.id}
						isOnline={merchant.value.isOnline}
						isTakingOrders={merchant.value.isTakingOrders}
						operatingStatus={merchant.value.operatingStatus}
					/>
				</CardContent>
			</Card>

			{/* Help Section */}
			<Card className="bg-muted/50">
				<CardHeader>
					<CardTitle className="text-base">How it works</CardTitle>
				</CardHeader>
				<CardContent className="space-y-3 text-sm">
					<div>
						<h4 className="mb-1 font-medium">Online/Offline</h4>
						<p className="text-muted-foreground">
							Turn on to be visible to customers and eligible for orders. Turn
							off to stop receiving order notifications.
						</p>
					</div>
					<div>
						<h4 className="mb-1 font-medium">Taking Orders</h4>
						<p className="text-muted-foreground">
							When online, you can temporarily pause accepting orders (e.g., if
							you're too busy) without going completely offline.
						</p>
					</div>
					<div>
						<h4 className="mb-1 font-medium">Store Status</h4>
						<p className="text-muted-foreground">
							Let customers know your store's status: Open, On Break, Under
							Maintenance, or Closed.
						</p>
					</div>
				</CardContent>
			</Card>
		</>
	);
}

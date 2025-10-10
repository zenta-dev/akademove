import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { PlusIcon } from "lucide-react";
import { useState } from "react";
import { MerchantMenuForm } from "@/components/foms/merchant-menu";
import { MerchantMenuTable } from "@/components/tables/menu/table";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "@/components/ui/dialog";
import { Skeleton } from "@/components/ui/skeleton";
import { hasAccess } from "@/lib/actions";
import { orpcQuery } from "@/lib/client/orpc";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/{-$lang}/dash/merchant/menu")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.MERCHANT.MENU }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			merchantMenu: ["list", "get", "create", "update", "delete"],
		});
		if (!ok) redirect({ to: "/{-$lang}", throw: true });
		return { allowed: ok };
	},
	loader: async ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

function RouteComponent() {
	const [open, setOpen] = useState(false);

	const { allowed } = Route.useLoaderData();
	const navigate = useNavigate();
	if (!allowed) navigate({ to: "/{-$lang}" });
	const merchant = useQuery(orpcQuery.merchant.getMine.queryOptions());

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.menu()}</h2>
					<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
				</div>
				{merchant.isPending ? (
					<Skeleton className="h-8 w-32" />
				) : (
					<Dialog open={open} onOpenChange={setOpen}>
						<DialogTrigger asChild>
							<Button size="sm">
								<PlusIcon />
								{m.create_menu()}
							</Button>
						</DialogTrigger>
						<DialogContent>
							<DialogHeader>
								<DialogTitle>{m.create_menu()}</DialogTitle>
								<DialogDescription>{m.create_menu_desc()}</DialogDescription>
							</DialogHeader>
							<MerchantMenuForm
								kind="new"
								merchantId={merchant.data?.body.data.id ?? ""}
								onSuccess={() => setOpen(false)}
							/>
						</DialogContent>
					</Dialog>
				)}
			</div>
			{merchant.isPending ? (
				<Skeleton className="h-96 w-full" />
			) : (
				<Card className="p-0">
					<CardContent className="p-0">
						<MerchantMenuTable merchantId={merchant.data?.body.data.id ?? ""} />
					</CardContent>
				</Card>
			)}
		</>
	);
}

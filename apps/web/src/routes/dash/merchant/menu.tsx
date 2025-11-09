import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
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
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { useMyMerchant } from "@/providers/merchant";

export const Route = createFileRoute("/dash/merchant/menu")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 7 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.MERCHANT.MENU }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			merchantMenu: ["list", "get", "create", "update", "delete"],
		});
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: async ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

function RouteComponent() {
	const { allowed } = Route.useLoaderData();
	const [open, setOpen] = useState(false);
	const search = Route.useSearch();
	const navigate = useNavigate();
	const merchant = useMyMerchant();

	if (!allowed) navigate({ to: "/" });

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.menu()}</h2>
					<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
				</div>
				{merchant.isLoading ? (
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
								merchantId={merchant.value?.id ?? ""}
								onSuccess={() => setOpen(false)}
							/>
						</DialogContent>
					</Dialog>
				)}
			</div>
			{merchant.isLoading ? (
				<Skeleton className="h-full max-h-[85vh] w-full" />
			) : (
				<Card className="p-0">
					<CardContent className="p-0">
						<MerchantMenuTable
							merchantId={merchant.value?.id ?? ""}
							search={search}
							to="/dash/merchant/menu"
						/>
					</CardContent>
				</Card>
			)}
		</>
	);
}

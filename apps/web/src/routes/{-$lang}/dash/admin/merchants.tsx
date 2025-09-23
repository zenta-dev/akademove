import { m } from "@repo/i18n";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { MerchantTable } from "@/components/tables/merchant/table";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/{-$lang}/dash/admin/merchants")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.ADMIN.MERCHANTS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			merchant: ["get", "update", "delete", "approve"],
		});
		if (!ok) redirect({ to: "/{-$lang}", throw: true });
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
	if (!allowed) navigate({ to: "/{-$lang}" });

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.merchants()}</h2>
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>
			<Card className="p-0">
				<CardContent className="p-0">
					<MerchantTable />
				</CardContent>
			</Card>
		</>
	);
}

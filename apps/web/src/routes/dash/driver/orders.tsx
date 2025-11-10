import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { OrderTable } from "@/components/tables/order/table";
import { Card, CardContent } from "@/components/ui/card";
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

	if (!allowed) navigate({ to: "/" });

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.orders()}</h2>
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>
			<Card className="p-0">
				TODO: FETCH FROM DRIVER DATA ONLY
				<CardContent className="p-0">
					<OrderTable search={search} to="/dash/driver/orders" />
				</CardContent>
			</Card>
		</>
	);
}

import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { DriverTable } from "@/components/tables/driver/table";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/operator/drivers")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.DRIVERS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			driver: ["get", "update", "ban"],
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
				<h2 className="font-medium text-xl">{m.drivers()}</h2>
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>
			<Card className="p-0">
				<CardContent className="p-0">
					<DriverTable search={search} to="/dash/operator/drivers" />
				</CardContent>
			</Card>
		</>
	);
}

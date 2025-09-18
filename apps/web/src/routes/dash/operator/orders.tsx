import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { UnderDevelopment } from "@/components/under-development";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/operator/orders")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.ORDERS }] }),
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.orders()}</h2>
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>
			<UnderDevelopment />
		</>
	);
}

import { createFileRoute } from "@tanstack/react-router";
import { requireRole } from "@/lib/middleware";

export const Route = createFileRoute("/dash/operator")({
	beforeLoad: async () => await requireRole("operator"),
	component: RouteComponent,
});

function RouteComponent() {
	return <div>Hello "/dash/merchant"!</div>;
}

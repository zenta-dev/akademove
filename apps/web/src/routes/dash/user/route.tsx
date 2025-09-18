import { createFileRoute } from "@tanstack/react-router";
import { requireRole } from "@/lib/middleware";

export const Route = createFileRoute("/dash/user")({
	beforeLoad: async () => await requireRole("user"),
	component: RouteComponent,
});

function RouteComponent() {
	return <div>Hello "/dash/merchant"!</div>;
}

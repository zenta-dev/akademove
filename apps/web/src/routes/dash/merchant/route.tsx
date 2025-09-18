import { createFileRoute } from "@tanstack/react-router";
import { requireRole } from "@/lib/middleware";

export const Route = createFileRoute("/dash/merchant")({
	beforeLoad: async () => await requireRole("merchant"),
	component: RouteComponent,
});

function RouteComponent() {
	return <div>Hello "/dash/merchant"!</div>;
}

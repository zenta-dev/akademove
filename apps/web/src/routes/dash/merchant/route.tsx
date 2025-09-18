import { createFileRoute } from "@tanstack/react-router";
import { getSession } from "@/lib/actions";
import { requireRole } from "@/lib/middleware";

export const Route = createFileRoute("/dash/merchant")({
	beforeLoad: async () => {
		const user = await getSession();
		await requireRole("merchant", user?.user);
	},
	component: RouteComponent,
});

function RouteComponent() {
	return <div>Hello "/dash/merchant"!</div>;
}

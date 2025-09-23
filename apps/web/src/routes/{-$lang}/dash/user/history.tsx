import { m } from "@repo/i18n";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { UnderDevelopment } from "@/components/under-development";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/{-$lang}/dash/user/history")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.USER.HISTORY }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			order: ["create", "get", "update", "cancel"],
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
				<h2 className="font-medium text-xl">{m.history()}</h2>
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>
			<UnderDevelopment />
		</>
	);
}

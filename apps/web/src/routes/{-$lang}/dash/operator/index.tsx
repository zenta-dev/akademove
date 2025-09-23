import { m } from "@repo/i18n";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/{-$lang}/dash/operator/")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.OVERVIEW }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			driver: ["get", "update", "ban"],
			merchant: ["get", "update"],
			order: ["get", "update", "cancel", "assign"],
			schedule: ["get", "update"],
			coupon: ["get", "update"],
			report: ["create", "get", "export"],
			review: ["get"],
			user: ["get", "update"],
			pricing: ["get", "update", "delete"],
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
				<h2 className="font-medium text-xl">{m.overview()}</h2>
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>
			<div className="grid auto-rows-min gap-4 md:grid-cols-3">
				<Card className="aspect-video rounded-xl">
					<CardContent>asdf</CardContent>
				</Card>
				<Card className="aspect-video rounded-xl">
					<CardContent>asdf</CardContent>
				</Card>
				<Card className="aspect-video rounded-xl">
					<CardContent>asdf</CardContent>
				</Card>
			</div>
			<Card className="min-h-[100vh] flex-1 rounded-xl md:min-h-min">
				<CardContent>asdf</CardContent>
			</Card>
		</>
	);
}

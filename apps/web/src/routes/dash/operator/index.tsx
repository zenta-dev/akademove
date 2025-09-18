import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { Card, CardContent } from "@/components/ui/card";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/operator/")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.OVERVIEW }] }),
	component: RouteComponent,
});

function RouteComponent() {
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

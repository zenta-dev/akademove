import { m } from "@repo/i18n";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { BannerForm } from "@/components/forms/banner-form";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/operator/banners/new")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.BANNERS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["OPERATOR"]);
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
	const navigate = useNavigate();

	if (!allowed) {
		navigate({ to: "/" });
		return null;
	}

	return (
		<div className="mx-auto w-full max-w-3xl">
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.banner_create()}</h2>
					<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
				</div>
			</div>
			<Card className="mt-4">
				<CardContent>
					<BannerForm
						kind="new"
						onSuccess={async () => {
							navigate({
								to: "/dash/operator/banners",
								search: { order: "desc", mode: "offset", limit: 10 },
							});
						}}
					/>
				</CardContent>
			</Card>
		</div>
	);
}

import { m } from "@repo/i18n";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { CommissionConfiguration } from "@/components/admin/configuration/commission-configuration";
import { PricingConfiguration } from "@/components/admin/configuration/pricing-configuration";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/admin/configurations")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.ADMIN.CONFIGURATIONS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			configurations: ["get", "update"],
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
	const navigate = useNavigate();
	if (!allowed) navigate({ to: "/" });

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.configurations()}</h2>
				<p className="text-muted-foreground">
					Manage platform commission rates and service pricing configurations
				</p>
			</div>

			<div className="space-y-6">
				<CommissionConfiguration />
				<PricingConfiguration />
			</div>
		</>
	);
}

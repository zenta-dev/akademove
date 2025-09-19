import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { UnderDevelopment } from "@/components/under-development";
import { hasAccess } from "@/lib/actions";
import { orpcQuery } from "@/lib/client/orpc";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/operator/pricing")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.PRICING }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			pricing: ["get", "update", "delete"],
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

	const asdf = useQuery(
		orpcQuery.configuration.list.queryOptions({
			input: { query: {} },
		}),
	);

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.pricing()}</h2>
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>
			<UnderDevelopment />
			{asdf.isPending ? (
				<div>Loading </div>
			) : (
				asdf.data?.body.data.map((e) => <div key={e.key}>{e.name}</div>)
			)}
		</>
	);
}

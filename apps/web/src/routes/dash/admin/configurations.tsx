import { m } from "@repo/i18n";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { UnderDevelopment } from "@/components/under-development";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/admin/configurations")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.ADMIN.CONFIGURATIONS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			driver: ["get", "update", "ban", "approve"],
			merchant: ["get", "update", "delete", "approve"],
			order: ["get", "update", "delete", "cancel", "assign"],
			schedule: ["get", "update", "delete"],
			coupon: ["create", "get", "update", "delete", "approve"],
			report: ["create", "get", "update", "delete", "export"],
			review: ["get", "update", "delete"],
			user: [
				"invite",
				"list",
				"get",
				"update",
				"delete",
				"verify",
				"set-role",
				"set-password",
				"ban",
			],
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
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>
			<UnderDevelopment />
		</>
	);
}

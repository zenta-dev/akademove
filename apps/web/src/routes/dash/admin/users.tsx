import { m } from "@repo/i18n";
import { UserListQuerySchema } from "@repo/schema/pagination";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { InviteUserDialog } from "@/components/dialogs/invite-user";
import { UserTable } from "@/components/tables/user/table";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/admin/users")({
	validateSearch: (values) => {
		const search = UserListQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 11 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.ADMIN.USERS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["ADMIN"]);
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
	const search = Route.useSearch();
	const navigate = useNavigate();

	if (!allowed) navigate({ to: "/" });

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.users()}</h2>
					<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
				</div>
				<InviteUserDialog />
			</div>
			<Card className="p-0">
				<CardContent className="p-0">
					<UserTable search={search} to="/dash/admin/users" />
				</CardContent>
			</Card>
		</>
	);
}

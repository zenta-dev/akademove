import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute } from "@tanstack/react-router";
import type { VisibilityState } from "@tanstack/react-table";
import { useEffect, useState } from "react";
import { InviteUserDialog } from "@/components/dialogs/invite-user";
import { USER_COLUMNS } from "@/components/tables/admin/user/columns";
import { DataTable } from "@/components/tables/data-table";
import { Card, CardContent } from "@/components/ui/card";
import { useIsMobile } from "@/hooks/use-mobile";
import { client } from "@/lib/api-client";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/admin/users")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.ADMIN.USERS }] }),
	component: RouteComponent,
	loader: () => {},
});

function RouteComponent() {
	const users = useQuery({
		queryKey: [client.users.$url().pathname, {}],
		queryFn: async () => {
			const response = await client.users.$get({
				query: {},
			});
			const result = await response.json();
			if (!result.success || !result.data) return [];
			return result.data;
		},
	});
	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		name: true,
		email: true,
		role: true,
		emailVerified: !isMobile,
		createdAt: !isMobile,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				emailVerified: false,
				createdAt: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				emailVerified: true,
				createdAt: true,
			}));
		}
	}, [isMobile]);

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
					<DataTable
						columns={USER_COLUMNS}
						data={users.data ?? []}
						isPending={users.isPending}
						columnVisibility={visibility}
						setColumnVisibility={setVisibility}
					/>
				</CardContent>
			</Card>
		</>
	);
}

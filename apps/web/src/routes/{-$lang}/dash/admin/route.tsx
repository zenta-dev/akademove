import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { DashboardHeader } from "@/components/header/dashboard";
import { AdminSidebar } from "@/components/sidebar/admin";
import { SidebarChildren } from "@/components/sidebar/children";
import { SidebarProvider } from "@/components/ui/sidebar";
import { ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/{-$lang}/dash/admin")({
	head: () => ({ meta: [{ title: ROUTE_TITLES.ADMINISTRATOR }] }),
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="[--header-height:calc(--spacing(14))]">
			<SidebarProvider className="flex flex-col">
				<DashboardHeader scope={m.administrator()} />
				<div className="flex flex-1">
					<AdminSidebar />
					<SidebarChildren />
				</div>
			</SidebarProvider>
		</div>
	);
}

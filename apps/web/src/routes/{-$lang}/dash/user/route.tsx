import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { DashboardHeader } from "@/components/header/dashboard";
import { SidebarChildren } from "@/components/sidebar/children";
import { UserSidebar } from "@/components/sidebar/user";
import { SidebarProvider } from "@/components/ui/sidebar";

export const Route = createFileRoute("/{-$lang}/dash/user")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="[--header-height:calc(--spacing(14))]">
			<SidebarProvider className="flex flex-col">
				<DashboardHeader scope={m.user()} />
				<div className="flex flex-1">
					<UserSidebar />
					<SidebarChildren />
				</div>
			</SidebarProvider>
		</div>
	);
}

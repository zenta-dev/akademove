import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { DashboardHeader } from "@/components/header/dashboard";
import { SidebarChildren } from "@/components/sidebar/children";
import { DriverSidebar } from "@/components/sidebar/driver";
import { SidebarProvider } from "@/components/ui/sidebar";

export const Route = createFileRoute("/dash/driver")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="[--header-height:calc(--spacing(14))]">
			<SidebarProvider className="flex flex-col">
				<DashboardHeader scope={m.driver()} />
				<div className="flex flex-1">
					<DriverSidebar />
					<SidebarChildren />
				</div>
			</SidebarProvider>
		</div>
	);
}

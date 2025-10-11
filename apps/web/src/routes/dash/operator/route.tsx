import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { DashboardHeader } from "@/components/header/dashboard";
import { SidebarChildren } from "@/components/sidebar/children";
import { OperatorSidebar } from "@/components/sidebar/operator";
import { SidebarProvider } from "@/components/ui/sidebar";

export const Route = createFileRoute("/dash/operator")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="[--header-height:calc(--spacing(14))]">
			<SidebarProvider className="flex flex-col">
				<DashboardHeader scope={m.operator()} />
				<div className="flex flex-1">
					<OperatorSidebar />
					<SidebarChildren />
				</div>
			</SidebarProvider>
		</div>
	);
}

import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { DashboardHeader } from "@/components/header/dashboard";
import { SidebarChildren } from "@/components/sidebar/children";
import { MerchantSidebar } from "@/components/sidebar/merchant";
import { SidebarProvider } from "@/components/ui/sidebar";

export const Route = createFileRoute("/{-$lang}/dash/merchant")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="[--header-height:calc(--spacing(14))]">
			<SidebarProvider className="flex flex-col">
				<DashboardHeader scope={m.merchant()} />
				<div className="flex flex-1">
					<MerchantSidebar />
					<SidebarChildren />
				</div>
			</SidebarProvider>
		</div>
	);
}

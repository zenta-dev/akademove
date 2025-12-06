import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { DashboardHeader } from "@/components/header/dashboard";
import { SidebarChildren } from "@/components/sidebar/children";
import { UserSidebar } from "@/components/sidebar/user";
import { SidebarProvider } from "@/components/ui/sidebar";

export const Route = createFileRoute("/dash/user/notifications")({
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
				<div className="container mx-auto p-6">
					<h2 className="font-medium text-xl">{m.notifications()}</h2>
					<p className="mb-6 text-muted-foreground">
						Manage your notifications
					</p>
					<div className="rounded-lg border bg-card p-6">
						<p className="text-muted-foreground">
							Notifications page coming soon...
						</p>
					</div>
				</div>
			</SidebarProvider>
		</div>
	);
}

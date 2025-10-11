import { Outlet } from "@tanstack/react-router";
import { SidebarInset } from "@/components/ui/sidebar";
import { cn } from "@/utils/cn";

export const SidebarChildren = () => {
	return (
		<SidebarInset className="bg-muted/50 dark:bg-muted/10">
			<div
				className={cn(
					"flex max-w-[100vw] flex-1 animate-in flex-col gap-3 p-3 transition-all duration-500",
				)}
			>
				<Outlet />
			</div>
		</SidebarInset>
	);
};

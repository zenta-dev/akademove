import { Outlet } from "@tanstack/react-router";
import { cn } from "@/utils/cn";
import { SidebarInset } from "../ui/sidebar";

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

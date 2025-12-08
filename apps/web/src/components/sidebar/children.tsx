import { Outlet } from "@tanstack/react-router";
import { SidebarInset, useSidebar } from "@/components/ui/sidebar";
import { useIsMobile } from "@/hooks/use-mobile";
import { cn } from "@/utils/cn";

export const SidebarChildren = () => {
	const sidebar = useSidebar();
	const isMobile = useIsMobile();
	return (
		<SidebarInset className="bg-muted/50 dark:bg-muted/10">
			<div
				className={cn(
					"flex flex-1 animate-in flex-col gap-3 p-6 transition-all duration-500 md:p-6",
					sidebar?.open
						? "max-w-[calc(100vw-var(--sidebar-width)-16px)]"
						: "max-w-[calc(100vw-48px)]",
					isMobile && "max-w-full",
				)}
			>
				<Outlet />
			</div>
		</SidebarInset>
	);
};

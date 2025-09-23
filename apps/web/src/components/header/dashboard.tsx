import { m } from "@repo/i18n";
import { SidebarIcon } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { useSidebar } from "@/components/ui/sidebar";
import { LangToggle } from "../toggle/lang-toggle";
import { ThemeToggle } from "../toggle/theme-toggle";
import { Tooltip, TooltipContent, TooltipTrigger } from "../ui/tooltip";
import { UserDropdwon } from "./user-dropdown";

export const DashboardHeader = ({ scope }: { scope: string }) => {
	const sidebar = useSidebar();
	return (
		<header className="sticky top-0 z-50 flex w-full items-center border-b bg-sidebar">
			<div className="flex h-(--header-height) w-full items-center justify-between px-2">
				<div className="flex h-(--header-height) items-center gap-[7px]">
					<Tooltip>
						<TooltipTrigger asChild>
							<Button
								className="h-8 w-8"
								variant="ghost"
								size="icon"
								onClick={sidebar.toggleSidebar}
							>
								<SidebarIcon />
							</Button>
						</TooltipTrigger>
						<TooltipContent side="right">
							<p>{sidebar.open ? m.close_sidebar() : m.open_sidebar()}</p>
						</TooltipContent>
					</Tooltip>
					<Separator orientation="vertical" className="mr-2 h-4" />
					<h1 className="font-semibold text-xl">
						<span className="hidden md:inline">AkadeMove</span>
						<span className="ml-1 font-normal text-muted-foreground">
							{scope}
						</span>
					</h1>
				</div>
				<div className="flex items-center gap-2">
					<LangToggle />
					<ThemeToggle />
					<UserDropdwon />
				</div>
			</div>
		</header>
	);
};

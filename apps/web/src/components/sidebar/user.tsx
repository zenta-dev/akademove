import { m } from "@repo/i18n";
import { Link, useRouterState } from "@tanstack/react-router";
import { BookMarked, Gauge, History, UserRound, Wallet } from "lucide-react";
import { cn } from "@/utils/cn";
import {
	Sidebar,
	SidebarContent,
	SidebarGroup,
	SidebarMenu,
	SidebarMenuButton,
	SidebarMenuItem,
	SidebarRail,
} from "../ui/sidebar";

const navMain = Object.freeze([
	{
		title: m.overview(),
		url: "/dash/user",
		icon: Gauge,
	},
	{
		title: m.bookings(),
		url: "/dash/user/bookings",
		icon: BookMarked,
	},
	{
		title: m.history(),
		url: "/dash/user/history",
		icon: History,
	},
	{
		title: m.wallet(),
		url: "/dash/user/wallet",
		icon: Wallet,
	},
	{
		title: m.profile(),
		url: "/dash/user/profile",
		icon: UserRound,
	},
] as const);

type NavMainItem = (typeof navMain)[number];

export const UserSidebar = ({
	...props
}: React.ComponentProps<typeof Sidebar>) => {
	return (
		<Sidebar
			className="top-(--header-height) h-[calc(100svh-var(--header-height))]!"
			collapsible="icon"
			{...props}
		>
			<SidebarContent>
				<SidebarGroup>
					<SidebarMenu>
						{navMain.map((item) => (
							<SidebarItem key={item.title} item={item} />
						))}
					</SidebarMenu>
				</SidebarGroup>
			</SidebarContent>
			<SidebarRail />
		</Sidebar>
	);
};

const SidebarItem = ({ item }: { item: NavMainItem }) => {
	const routerState = useRouterState();
	const isActive = routerState.location.href === item.url;

	return (
		<SidebarMenuItem>
			<SidebarMenuButton tooltip={item.title} asChild>
				<Link
					to={item.url}
					className={cn(isActive && "bg-primary/10")}
					viewTransition
				>
					{item.icon && <item.icon />}
					<span>{item.title}</span>
				</Link>
			</SidebarMenuButton>
		</SidebarMenuItem>
	);
};

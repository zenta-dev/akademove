import { m } from "@repo/i18n";
import { Link, useRouterState } from "@tanstack/react-router";
import { Gauge, LineChart, Logs, Receipt, UserRound } from "lucide-react";
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
		url: "/dash/merchant",
		icon: Gauge,
	},
	{
		title: m.menu(),
		url: "/dash/merchant/menu",
		icon: Logs,
	},
	{
		title: m.orders(),
		url: "/dash/merchant/orders",
		icon: Receipt,
	},
	{
		title: m.sales(),
		url: "/dash/merchant/sales",
		icon: LineChart,
	},
	{
		title: m.profile(),
		url: "/dash/merchant/profile",
		icon: UserRound,
	},
] as const);

type NavMainItem = (typeof navMain)[number];

export const MerchantSidebar = ({
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

import { m } from "@repo/i18n";
import { Link, useRouterState } from "@tanstack/react-router";
import {
	Bike,
	ChartLine,
	Gauge,
	Receipt,
	Settings2,
	Store,
	Users,
} from "lucide-react";
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
		url: "/dash/admin",
		icon: Gauge,
	},
	{
		title: m.users(),
		url: "/dash/admin/users",
		icon: Users,
	},
	{
		title: m.drivers(),
		url: "/dash/admin/drivers",
		icon: Bike,
	},
	{
		title: m.merchants(),
		url: "/dash/admin/merchants",
		icon: Store,
	},
	{
		title: m.orders(),
		url: "/dash/admin/orders",
		icon: Receipt,
	},
	{
		title: m.analytics(),
		url: "/dash/admin/analytics",
		icon: ChartLine,
	},
	{
		title: m.configurations(),
		url: "/dash/admin/configurations",
		icon: Settings2,
	},
] as const);

type NavMainItem = (typeof navMain)[number];

export const AdminSidebar = ({
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

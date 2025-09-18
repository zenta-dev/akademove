import { m } from "@repo/i18n";
import { Link, useRouterState } from "@tanstack/react-router";
import {
	Bike,
	DollarSign,
	Flag,
	Gauge,
	Receipt,
	Store,
	Ticket,
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
		url: "/dash/operator",
		icon: Gauge,
	},
	{
		title: m.drivers(),
		url: "/dash/operator/drivers",
		icon: Bike,
	},
	{
		title: m.merchants(),
		url: "/dash/operator/merchants",
		icon: Store,
	},
	{
		title: m.orders(),
		url: "/dash/operator/orders",
		icon: Receipt,
	},
	{
		title: m.pricing(),
		url: "/dash/operator/pricing",
		icon: DollarSign,
	},
	{
		title: m.promotions(),
		url: "/dash/operator/promotions",
		icon: Ticket,
	},
	{
		title: m.reports(),
		url: "/dash/operator/reports",
		icon: Flag,
	},
] as const);

type NavMainItem = (typeof navMain)[number];

export const OperatorSidebar = ({
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

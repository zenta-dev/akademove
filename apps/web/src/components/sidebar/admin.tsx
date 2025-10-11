import { localizeHref, m } from "@repo/i18n";
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
import {
	Sidebar,
	SidebarContent,
	SidebarGroup,
	SidebarMenu,
	SidebarMenuButton,
	SidebarMenuItem,
	SidebarRail,
} from "@/components/ui/sidebar";
import { cn } from "@/utils/cn";

const navMain = Object.freeze([
	{
		title: m.overview(),
		href: localizeHref("/dash/admin"),
		icon: Gauge,
	},
	{
		title: m.users(),
		href: localizeHref("/dash/admin/users"),
		icon: Users,
	},
	{
		title: m.drivers(),
		href: localizeHref("/dash/admin/drivers"),
		icon: Bike,
	},
	{
		title: m.merchants(),
		href: localizeHref("/dash/admin/merchants"),
		icon: Store,
	},
	{
		title: m.orders(),
		href: localizeHref("/dash/admin/orders"),
		icon: Receipt,
	},
	{
		title: m.analytics(),
		href: localizeHref("/dash/admin/analytics"),
		icon: ChartLine,
	},
	{
		title: m.configurations(),
		href: localizeHref("/dash/admin/configurations"),
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
	const isActive = routerState.location.href === item.href;

	return (
		<SidebarMenuItem>
			<SidebarMenuButton tooltip={item.title} asChild>
				<Link to={item.href} className={cn(isActive && "bg-primary/10")}>
					{item.icon && <item.icon />}
					<span>{item.title}</span>
				</Link>
			</SidebarMenuButton>
		</SidebarMenuItem>
	);
};

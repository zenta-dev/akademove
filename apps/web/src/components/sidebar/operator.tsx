import { localizeHref, m } from "@repo/i18n";
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
		href: localizeHref("/dash/operator"),
		icon: Gauge,
	},
	{
		title: m.drivers(),
		href: localizeHref("/dash/operator/drivers"),
		icon: Bike,
	},
	{
		title: m.merchants(),
		href: localizeHref("/dash/operator/merchants"),
		icon: Store,
	},
	{
		title: m.orders(),
		href: localizeHref("/dash/operator/orders"),
		icon: Receipt,
	},
	{
		title: m.pricing(),
		href: localizeHref("/dash/operator/pricing"),
		icon: DollarSign,
	},
	{
		title: m.coupons(),
		href: localizeHref("/dash/operator/coupons"),
		icon: Ticket,
	},
	{
		title: m.reports(),
		href: localizeHref("/dash/operator/reports"),
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
	const isActive = routerState.location.href === item.href;

	return (
		<SidebarMenuItem>
			<SidebarMenuButton tooltip={item.title} asChild>
				<Link to={item.href} className={cn(isActive && "b)g-primary/10")}>
					{item.icon && <item.icon />}
					<span>{item.title}</span>
				</Link>
			</SidebarMenuButton>
		</SidebarMenuItem>
	);
};

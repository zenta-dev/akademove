import { localizeHref, m } from "@repo/i18n";
import { Link, useRouterState } from "@tanstack/react-router";
import {
	Calendar,
	Gauge,
	LineChart,
	Receipt,
	Star,
	UserRound,
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
		href: localizeHref("/dash/driver"),
		icon: Gauge,
	},
	{
		title: m.schedule(),
		href: localizeHref("/dash/driver/schedule"),
		icon: Calendar,
	},
	{
		title: m.orders(),
		href: localizeHref("/dash/driver/orders"),
		icon: Receipt,
	},
	{
		title: m.earnings(),
		href: localizeHref("/dash/driver/earnings"),
		icon: LineChart,
	},
	{
		title: m.ratings(),
		href: localizeHref("/dash/driver/ratings"),
		icon: Star,
	},
	{
		title: m.profile(),
		href: localizeHref("/dash/driver/profile"),
		icon: UserRound,
	},
] as const);

type NavMainItem = (typeof navMain)[number];

export const DriverSidebar = ({
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

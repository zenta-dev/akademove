import { localizeHref, m } from "@repo/i18n";
import { Link, useRouterState } from "@tanstack/react-router";
import { UserRound } from "lucide-react";
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
	// {
	// 	title: m.overview(),
	// 	href: localizeHref("/dash/user"),
	// 	icon: Gauge,
	// },
	// {
	// 	title: m.bookings(),
	// 	href: localizeHref("/dash/user/bookings"),
	// 	icon: BookMarked,
	// },
	// {
	// 	title: m.history(),
	// 	href: localizeHref("/dash/user/history"),
	// 	icon: History,
	// },
	// {
	// 	title: m.wallet(),
	// 	href: localizeHref("/dash/user/wallet"),
	// 	icon: Wallet,
	// },
	{
		title: m.profile(),
		href: localizeHref("/dash/user/profile"),
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

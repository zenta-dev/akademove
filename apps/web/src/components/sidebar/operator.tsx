import { localizeHref, m } from "@repo/i18n";
import { Link, useRouterState } from "@tanstack/react-router";
import {
	BikeIcon,
	DollarSignIcon,
	FlagIcon,
	GaugeIcon,
	HelpCircleIcon,
	ImageIcon,
	MailIcon,
	ReceiptIcon,
	ShieldIcon,
	StoreIcon,
	TicketIcon,
	UsersIcon,
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
		icon: GaugeIcon,
	},
	{
		title: m.users(),
		href: localizeHref("/dash/operator/users"),
		icon: UsersIcon,
	},
	{
		title: m.drivers(),
		href: localizeHref("/dash/operator/drivers"),
		icon: BikeIcon,
	},
	{
		title: m.merchants(),
		href: localizeHref("/dash/operator/merchants"),
		icon: StoreIcon,
	},
	{
		title: m.orders(),
		href: localizeHref("/dash/operator/orders"),
		icon: ReceiptIcon,
	},
	{
		title: m.pricing(),
		href: localizeHref("/dash/operator/pricing"),
		icon: DollarSignIcon,
	},
	{
		title: m.coupons(),
		href: localizeHref("/dash/operator/coupons"),
		icon: TicketIcon,
	},
	{
		title: m.reports(),
		href: localizeHref("/dash/operator/reports"),
		icon: FlagIcon,
	},
	{
		title: "Fraud Detection",
		href: localizeHref("/dash/operator/fraud"),
		icon: ShieldIcon,
	},
	{
		title: m.contact_us(),
		href: localizeHref("/dash/operator/contacts"),
		icon: MailIcon,
	},
	{
		title: m.quiz_questions(),
		href: localizeHref("/dash/operator/quiz-questions"),
		icon: HelpCircleIcon,
	},
	{
		title: m.banners(),
		href: localizeHref("/dash/operator/banners"),
		icon: ImageIcon,
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

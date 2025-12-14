import { localizeHref, m } from "@repo/i18n";
import { Link, useRouterState } from "@tanstack/react-router";
import {
	BikeIcon,
	ChartLineIcon,
	ClipboardListIcon,
	DollarSignIcon,
	GaugeIcon,
	HelpCircleIcon,
	ImageIcon,
	MailIcon,
	ReceiptIcon,
	SettingsIcon,
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
		href: localizeHref("/dash/admin"),
		icon: GaugeIcon,
	},
	{
		title: m.users(),
		href: localizeHref("/dash/admin/users"),
		icon: UsersIcon,
	},
	{
		title: m.drivers(),
		href: localizeHref("/dash/admin/drivers"),
		icon: BikeIcon,
	},
	{
		title: m.merchants(),
		href: localizeHref("/dash/admin/merchants"),
		icon: StoreIcon,
	},
	{
		title: m.orders(),
		href: localizeHref("/dash/admin/orders"),
		icon: ReceiptIcon,
	},
	{
		title: m.pricing(),
		href: localizeHref("/dash/admin/pricing"),
		icon: DollarSignIcon,
	},
	{
		title: m.coupons(),
		href: localizeHref("/dash/admin/coupons"),
		icon: TicketIcon,
	},
	{
		title: m.analytics(),
		href: localizeHref("/dash/admin/analytics"),
		icon: ChartLineIcon,
	},
	{
		title: m.audit_logs(),
		href: localizeHref("/dash/admin/audit"),
		icon: ClipboardListIcon,
	},
	{
		title: "Fraud Detection",
		href: localizeHref("/dash/admin/fraud"),
		icon: ShieldIcon,
	},
	{
		title: m.contact_us(),
		href: localizeHref("/dash/admin/contacts"),
		icon: MailIcon,
	},
	{
		title: m.quiz_questions(),
		href: localizeHref("/dash/admin/quiz-questions"),
		icon: HelpCircleIcon,
	},
	{
		title: m.banners(),
		href: localizeHref("/dash/admin/banners"),
		icon: ImageIcon,
	},
	{
		title: m.configurations(),
		href: localizeHref("/dash/admin/settings"),
		icon: SettingsIcon,
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

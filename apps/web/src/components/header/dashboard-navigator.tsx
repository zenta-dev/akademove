import { localizeHref, m } from "@repo/i18n";
import { Link } from "@tanstack/react-router";
import {
	GripIcon,
	SettingsIcon,
	ShieldIcon,
	StoreIcon,
	TruckIcon,
	UserIcon,
} from "lucide-react";
import { Button } from "../ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuTrigger,
} from "../ui/dropdown-menu";

// TODO: SHOW BASED USER ROLE
const ROUTES = [
	{
		name: m.administrator(),
		href: localizeHref("/dash/admin"),
		icon: <ShieldIcon className="mr-2 h-4 w-4" />,
	},
	{
		name: m.operator(),
		href: localizeHref("/dash/operator"),
		icon: <SettingsIcon className="mr-2 h-4 w-4" />,
	},
	{
		name: m.merchant(),
		href: localizeHref("/dash/merchant"),
		icon: <StoreIcon className="mr-2 h-4 w-4" />,
	},
	{
		name: m.driver(),
		href: localizeHref("/dash/driver"),
		icon: <TruckIcon className="mr-2 h-4 w-4" />,
	},
	{
		name: m.user(),
		href: localizeHref("/dash/user"),
		icon: <UserIcon className="mr-2 h-4 w-4" />,
	},
];

export const DashboardNavigator = () => {
	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" size="icon">
					<GripIcon />
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end">
				{ROUTES.map((e) => (
					<Link key={e.name} to={e.href} className="justify-end">
						<DropdownMenuItem>
							{e.icon}
							{e.name}
						</DropdownMenuItem>
					</Link>
				))}
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

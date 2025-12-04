import { m } from "@repo/i18n";
import type { Contact } from "@repo/schema/contact";
import { useNavigate, useRouterState } from "@tanstack/react-router";
import { Eye, MoreHorizontal } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuGroup,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const ContactActionTable = ({ val }: { val: Contact }) => {
	const navigate = useNavigate();
	const routerState = useRouterState();
	const isOperator = routerState.location.pathname.includes("/dash/operator");
	const basePath = isOperator
		? "/dash/operator/contacts"
		: "/dash/admin/contacts";

	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" className="h-8 w-8 p-0">
					<span className="sr-only">{m.actions()}</span>
					<MoreHorizontal className="h-4 w-4" />
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end">
				<DropdownMenuLabel>{m.actions()}</DropdownMenuLabel>
				<DropdownMenuGroup className="flex flex-1 flex-col gap-2">
					<DropdownMenuItem
						className="flex w-full cursor-pointer items-center gap-2"
						onClick={() => navigate({ to: `${basePath}/${val.id}` })}
					>
						<Eye className="h-4 w-4" />
						View & Respond
					</DropdownMenuItem>
				</DropdownMenuGroup>
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

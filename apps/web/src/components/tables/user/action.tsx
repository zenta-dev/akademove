import { m } from "@repo/i18n";
import type { User } from "@repo/schema/user";
import { MoreHorizontal } from "lucide-react";
import { BanUserDialog } from "@/components/dialogs/ban-user";
import { UnbanUserDialog } from "@/components/dialogs/unban-user";
import { UpdateUserPasswordDialog } from "@/components/dialogs/update-user-password";
import { UpdateUserRoleDialog } from "@/components/dialogs/update-user-role";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuGroup,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const UserActionTable = ({ val }: { val: User }) => {
	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" className="h-8 w-8 p-0">
					<span className="sr-only">
						{m.perform_user_action_placeholder({ name: val.name })}
					</span>
					<MoreHorizontal className="h-4 w-4" />
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end">
				<DropdownMenuLabel>{m.actions()}</DropdownMenuLabel>
				<DropdownMenuGroup className="flex flex-1 flex-col gap-2">
					<DropdownMenuItem asChild>
						<UpdateUserRoleDialog userId={val.id} />
					</DropdownMenuItem>
					<DropdownMenuItem asChild>
						<UpdateUserPasswordDialog userId={val.id} />
					</DropdownMenuItem>
				</DropdownMenuGroup>
				<DropdownMenuSeparator />
				<DropdownMenuGroup className="flex flex-1 flex-col gap-2">
					{val.banned && (
						<DropdownMenuItem asChild>
							<UnbanUserDialog userId={val.id} />
						</DropdownMenuItem>
					)}
					{!val.banned && (
						<DropdownMenuItem asChild>
							<BanUserDialog userId={val.id} />
						</DropdownMenuItem>
					)}
				</DropdownMenuGroup>
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

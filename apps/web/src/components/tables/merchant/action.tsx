import { m } from "@repo/i18n";
import type { Merchant } from "@repo/schema/merchant";
import { MoreHorizontal } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const MerchantActionTable = ({ val }: { val: Merchant }) => {
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
				<DropdownMenuItem>View Details</DropdownMenuItem>
				<DropdownMenuItem>View Menu</DropdownMenuItem>
				{val.isActive ? (
					<DropdownMenuItem className="text-orange-600">
						Deactivate Merchant
					</DropdownMenuItem>
				) : (
					<DropdownMenuItem className="text-green-600">
						Activate Merchant
					</DropdownMenuItem>
				)}
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

import { m } from "@repo/i18n";
import type { Merchant } from "@repo/schema/merchant";
import { MoreHorizontal } from "lucide-react";
import { useState } from "react";
import { ActivateMerchantDialog } from "@/components/dialogs/activate-merchant";
import { DeactivateMerchantDialog } from "@/components/dialogs/deactivate-merchant";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const MerchantActionTable = ({ val }: { val: Merchant }) => {
	const [activateOpen, setActivateOpen] = useState(false);
	const [deactivateOpen, setDeactivateOpen] = useState(false);

	return (
		<>
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
						<DropdownMenuItem
							className="text-orange-600"
							onClick={() => setDeactivateOpen(true)}
						>
							{m.deactivate_merchant()}
						</DropdownMenuItem>
					) : (
						<DropdownMenuItem
							className="text-green-600"
							onClick={() => setActivateOpen(true)}
						>
							{m.activate_merchant()}
						</DropdownMenuItem>
					)}
				</DropdownMenuContent>
			</DropdownMenu>

			<ActivateMerchantDialog
				open={activateOpen}
				onOpenChange={setActivateOpen}
				merchant={val}
			/>
			<DeactivateMerchantDialog
				open={deactivateOpen}
				onOpenChange={setDeactivateOpen}
				merchant={val}
			/>
		</>
	);
};

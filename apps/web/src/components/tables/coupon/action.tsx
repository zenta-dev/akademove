import { m } from "@repo/i18n";
import type { Coupon } from "@repo/schema/coupon";
import { useNavigate } from "@tanstack/react-router";
import { MoreHorizontal, Pencil, Trash2 } from "lucide-react";
import { useState } from "react";
import { ActivateCouponDialog } from "@/components/dialogs/activate-coupon";
import { DeactivateCouponDialog } from "@/components/dialogs/deactivate-coupon";
import { DeleteCouponDialog } from "@/components/dialogs/delete-coupon";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const CouponActionTable = ({ val }: { val: Coupon }) => {
	const [activateOpen, setActivateOpen] = useState(false);
	const [deactivateOpen, setDeactivateOpen] = useState(false);
	const [deleteOpen, setDeleteOpen] = useState(false);
	const navigate = useNavigate();

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
					<DropdownMenuItem
						onClick={() =>
							navigate({
								to: "/dash/operator/coupons/$id",
								params: { id: val.id },
							})
						}
					>
						<Pencil className="mr-2 h-4 w-4" />
						{m.edit_coupon()}
					</DropdownMenuItem>
					<DropdownMenuSeparator />
					{val.isActive ? (
						<DropdownMenuItem
							className="text-orange-600"
							onClick={() => setDeactivateOpen(true)}
						>
							{m.deactivate_coupon()}
						</DropdownMenuItem>
					) : (
						<DropdownMenuItem
							className="text-green-600"
							onClick={() => setActivateOpen(true)}
						>
							{m.activate_coupon()}
						</DropdownMenuItem>
					)}
					<DropdownMenuItem
						className="text-destructive"
						onClick={() => setDeleteOpen(true)}
					>
						<Trash2 className="mr-2 h-4 w-4" />
						{m.coupon_delete()}
					</DropdownMenuItem>
				</DropdownMenuContent>
			</DropdownMenu>

			<ActivateCouponDialog
				open={activateOpen}
				onOpenChange={setActivateOpen}
				coupon={val}
			/>
			<DeactivateCouponDialog
				open={deactivateOpen}
				onOpenChange={setDeactivateOpen}
				coupon={val}
			/>
			<DeleteCouponDialog
				open={deleteOpen}
				onOpenChange={setDeleteOpen}
				coupon={val}
			/>
		</>
	);
};

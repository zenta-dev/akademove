import { m } from "@repo/i18n";
import type { Merchant } from "@repo/schema/merchant";
import { useQuery } from "@tanstack/react-query";
import { useNavigate } from "@tanstack/react-router";
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
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { orpcQuery } from "@/lib/orpc";

export const MerchantActionTable = ({ val }: { val: Merchant }) => {
	const { data: sessionData } = useQuery(
		orpcQuery.auth.getSession.queryOptions(),
	);
	const user = sessionData?.body.data?.user;
	const navigate = useNavigate();
	const [activateOpen, setActivateOpen] = useState(false);
	const [deactivateOpen, setDeactivateOpen] = useState(false);
	const [_locationOpen, _setLocationOpen] = useState(false);

	const handleApprovalReview = () => {
		if (user?.role === "ADMIN") {
			navigate({
				to: "/dash/admin/merchant-approval/$merchantId",
				params: { merchantId: val.id },
			});
		} else if (user?.role === "OPERATOR") {
			navigate({
				to: "/dash/operator/merchant-approval/$merchantId",
				params: { merchantId: val.id },
			});
		}
	};

	const showApprovalOption =
		val.status === "PENDING" || val.status === "REJECTED";

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
					{showApprovalOption && (
						<>
							<DropdownMenuItem
								className="text-blue-600"
								onClick={handleApprovalReview}
							>
								Review Approval
							</DropdownMenuItem>
							<DropdownMenuSeparator />
						</>
					)}
					{/* <DropdownMenuItem>View Details</DropdownMenuItem>
					<DropdownMenuItem>View Menu</DropdownMenuItem> */}
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

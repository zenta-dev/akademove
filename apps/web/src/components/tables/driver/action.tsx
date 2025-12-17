import { m } from "@repo/i18n";
import type { Driver } from "@repo/schema/driver";
import { useNavigate } from "@tanstack/react-router";
import { CheckCircle, MoreHorizontal } from "lucide-react";
// import { ApproveDriverDialog } from "@/components/dialogs/approve-driver";
import { ActivateDriverDialog } from "@/components/dialogs/activate-driver";
import { RejectDriverDialog } from "@/components/dialogs/reject-driver";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuLabel,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const DriverActionTable = ({ val }: { val: Driver }) => {
	const navigate = useNavigate();

	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" className="h-8 w-8 p-0">
					<span className="sr-only">{m.actions()}</span>
					<MoreHorizontal className="h-4 w-4" />
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end" className="w-48">
				<DropdownMenuLabel>{m.actions()}</DropdownMenuLabel>
				<Button
					className="justify-start p-2 text-start font-normal"
					variant="ghost"
					size="sm"
					onClick={() =>
						navigate({
							to: "/dash/admin/driver-approval/$driverId",
							params: { driverId: val.id },
						})
					}
				>
					<CheckCircle className="mr-2 h-4 w-4" />
					Review Application
				</Button>
				{/* <ApproveDriverDialog driverId={val.id} /> */}
				<ActivateDriverDialog driverId={val.id} />
				<RejectDriverDialog driverId={val.id} />
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

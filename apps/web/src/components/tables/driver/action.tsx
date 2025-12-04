import { m } from "@repo/i18n";
import type { Driver } from "@repo/schema/driver";
import { MoreHorizontal } from "lucide-react";
import { ActivateDriverDialog } from "@/components/dialogs/activate-driver";
import { ApproveDriverDialog } from "@/components/dialogs/approve-driver";
import { RejectDriverDialog } from "@/components/dialogs/reject-driver";
import { SuspendDriverDialog } from "@/components/dialogs/suspend-driver";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuLabel,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const DriverActionTable = ({ val }: { val: Driver }) => {
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
				{val.status === "PENDING" && (
					<>
						<ApproveDriverDialog driverId={val.id} />
						<RejectDriverDialog driverId={val.id} />
					</>
				)}
				{val.status === "APPROVED" && (
					<ActivateDriverDialog driverId={val.id} />
				)}
				{val.status === "ACTIVE" && <SuspendDriverDialog driverId={val.id} />}
				{val.status === "INACTIVE" && (
					<ActivateDriverDialog driverId={val.id} />
				)}
				{val.status === "SUSPENDED" && (
					<ActivateDriverDialog driverId={val.id} />
				)}
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

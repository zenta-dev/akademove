import { m } from "@repo/i18n";
import type { Driver } from "@repo/schema/driver";
import { MoreHorizontal } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
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
			<DropdownMenuContent align="end">
				<DropdownMenuLabel>{m.actions()}</DropdownMenuLabel>
				{val.status === "PENDING" && (
					<>
						<DropdownMenuItem>Approve Driver</DropdownMenuItem>
						<DropdownMenuItem className="text-red-600">
							Reject Driver
						</DropdownMenuItem>
					</>
				)}
				{val.status === "APPROVED" && (
					<DropdownMenuItem>Activate Driver</DropdownMenuItem>
				)}
				{val.status === "ACTIVE" && (
					<>
						<DropdownMenuItem>View Details</DropdownMenuItem>
						<DropdownMenuItem className="text-orange-600">
							Suspend Driver
						</DropdownMenuItem>
					</>
				)}
				{val.status === "INACTIVE" && (
					<DropdownMenuItem>Activate Driver</DropdownMenuItem>
				)}
				{val.status === "SUSPENDED" && (
					<DropdownMenuItem>Reactivate Driver</DropdownMenuItem>
				)}
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

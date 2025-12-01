import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import { MoreHorizontal } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const OrderActionTable = ({ val }: { val: Order }) => {
	const isCancellable =
		val.status === "REQUESTED" ||
		val.status === "MATCHING" ||
		val.status === "ACCEPTED";
	const isReassignable =
		val.status === "ACCEPTED" ||
		val.status === "ARRIVING" ||
		val.status === "IN_TRIP";

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
				<DropdownMenuItem>Track on Map</DropdownMenuItem>
				{isReassignable && (
					<DropdownMenuItem className="text-blue-600">
						Reassign Driver
					</DropdownMenuItem>
				)}
				{isCancellable && (
					<DropdownMenuItem className="text-red-600">
						Cancel Order
					</DropdownMenuItem>
				)}
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

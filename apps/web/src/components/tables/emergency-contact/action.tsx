import type { EmergencyContact } from "@repo/schema/emergency-contact";
import { Link } from "@tanstack/react-router";
import { EditIcon, MoreHorizontal, TrashIcon } from "lucide-react";
import { useState } from "react";
import { DeleteEmergencyContactDialog } from "@/components/dialogs/delete-emergency-contact";
import { ToggleEmergencyContactActiveDialog } from "@/components/dialogs/toggle-emergency-contact-active";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const EmergencyContactActionTable = ({
	val,
}: {
	val: EmergencyContact;
}) => {
	const [toggleActiveOpen, setToggleActiveOpen] = useState(false);
	const [deleteOpen, setDeleteOpen] = useState(false);

	return (
		<>
			<DropdownMenu>
				<DropdownMenuTrigger asChild>
					<Button variant="ghost" className="h-8 w-8 p-0">
						<span className="sr-only">Actions</span>
						<MoreHorizontal className="h-4 w-4" />
					</Button>
				</DropdownMenuTrigger>
				<DropdownMenuContent align="end">
					<DropdownMenuLabel>Actions</DropdownMenuLabel>
					<DropdownMenuItem asChild>
						<Link
							to="/dash/operator/emergency-contacts/$id"
							params={{ id: val.id }}
						>
							<EditIcon className="mr-2 h-4 w-4" />
							Edit
						</Link>
					</DropdownMenuItem>
					<DropdownMenuSeparator />
					{val.isActive ? (
						<DropdownMenuItem
							className="text-orange-600"
							onClick={() => setToggleActiveOpen(true)}
						>
							Deactivate
						</DropdownMenuItem>
					) : (
						<DropdownMenuItem
							className="text-green-600"
							onClick={() => setToggleActiveOpen(true)}
						>
							Activate
						</DropdownMenuItem>
					)}
					<DropdownMenuItem
						className="text-red-600"
						onClick={() => setDeleteOpen(true)}
					>
						<TrashIcon className="mr-2 h-4 w-4" />
						Delete
					</DropdownMenuItem>
				</DropdownMenuContent>
			</DropdownMenu>

			<ToggleEmergencyContactActiveDialog
				open={toggleActiveOpen}
				onOpenChange={setToggleActiveOpen}
				contact={val}
			/>
			<DeleteEmergencyContactDialog
				open={deleteOpen}
				onOpenChange={setDeleteOpen}
				contact={val}
			/>
		</>
	);
};

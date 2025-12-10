import { m } from "@repo/i18n";
import type { Banner } from "@repo/schema/banner";
import { Link } from "@tanstack/react-router";
import { EditIcon, MoreHorizontal, TrashIcon } from "lucide-react";
import { useState } from "react";
import { DeleteBannerDialog } from "@/components/dialogs/delete-banner";
import { ToggleBannerActiveDialog } from "@/components/dialogs/toggle-banner-active";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const BannerActionTable = ({ val }: { val: Banner }) => {
	const [toggleActiveOpen, setToggleActiveOpen] = useState(false);
	const [deleteOpen, setDeleteOpen] = useState(false);

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
					<DropdownMenuItem asChild>
						<Link to="/dash/operator/banners/$id" params={{ id: val.id }}>
							<EditIcon className="mr-2 h-4 w-4" />
							{m.banner_edit()}
						</Link>
					</DropdownMenuItem>
					<DropdownMenuSeparator />
					{val.isActive ? (
						<DropdownMenuItem
							className="text-orange-600"
							onClick={() => setToggleActiveOpen(true)}
						>
							{m.banner_deactivate()}
						</DropdownMenuItem>
					) : (
						<DropdownMenuItem
							className="text-green-600"
							onClick={() => setToggleActiveOpen(true)}
						>
							{m.banner_activate()}
						</DropdownMenuItem>
					)}
					<DropdownMenuItem
						className="text-red-600"
						onClick={() => setDeleteOpen(true)}
					>
						<TrashIcon className="mr-2 h-4 w-4" />
						{m.banner_delete()}
					</DropdownMenuItem>
				</DropdownMenuContent>
			</DropdownMenu>

			<ToggleBannerActiveDialog
				open={toggleActiveOpen}
				onOpenChange={setToggleActiveOpen}
				banner={val}
			/>
			<DeleteBannerDialog
				open={deleteOpen}
				onOpenChange={setDeleteOpen}
				banner={val}
			/>
		</>
	);
};

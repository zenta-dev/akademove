import { m } from "@repo/i18n";
import type { MerchantMenu } from "@repo/schema/merchant";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { EditIcon, MoreHorizontal, TrashIcon } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
import { MerchantMenuForm } from "@/components/foms/merchant-menu";
import { Submitting } from "@/components/misc/submitting";
import {
	AlertDialog,
	AlertDialogCancel,
	AlertDialogContent,
	AlertDialogDescription,
	AlertDialogFooter,
	AlertDialogHeader,
	AlertDialogTitle,
	AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import { Button, buttonVariants } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "@/components/ui/dialog";
import {
	DropdownMenu,
	DropdownMenuArrow,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const MerchantMenuActionTable = ({ val }: { val: MerchantMenu }) => {
	const [dropdownOpen, setDropdownOpen] = useState(false);
	const [editDialogOpen, setEditDialogOpen] = useState(false);

	return (
		<DropdownMenu open={dropdownOpen} onOpenChange={setDropdownOpen}>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" className="h-8 w-8 p-0">
					<span className="sr-only">
						{m.perform_menu_action_placeholder({ name: val.name })}
					</span>
					<MoreHorizontal className="h-4 w-4" />
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end">
				<DropdownMenuLabel>{m.actions()}</DropdownMenuLabel>
				<DropdownMenuSeparator />
				<DropdownMenuItem asChild>
					<Dialog open={editDialogOpen} onOpenChange={setEditDialogOpen}>
						<DialogTrigger asChild>
							<Button
								variant="ghost"
								size="sm"
								className="w-full justify-start"
							>
								<EditIcon />
								{m.edit()}
							</Button>
						</DialogTrigger>
						<DialogContent>
							<DialogHeader>
								<DialogTitle>{m.update_menu()}</DialogTitle>
								<DialogDescription>
									{m.edit_menu_desc({ name: val.name })}
								</DialogDescription>
							</DialogHeader>
							<MerchantMenuForm
								kind="edit"
								data={val}
								merchantId={val.merchantId}
								onSuccess={() => {
									setEditDialogOpen(false);
									setDropdownOpen(true);
								}}
							/>
						</DialogContent>
					</Dialog>
				</DropdownMenuItem>
				<DropdownMenuItem asChild>
					<DeleteMerchantMenuDialog
						val={val}
						onSuccess={() => setDropdownOpen(false)}
					/>
				</DropdownMenuItem>
				<DropdownMenuArrow />
			</DropdownMenuContent>
		</DropdownMenu>
	);
};

export const DeleteMerchantMenuDialog = ({
	val,
	onSuccess,
}: {
	val: MerchantMenu;
	onSuccess?: () => void;
}) => {
	const [open, setOpen] = useState(false);
	const mutation = useMutation(
		orpcQuery.merchant.menu.remove.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries({
					queryKey: orpcQuery.merchant.menu.list.queryKey({
						input: { params: { merchantId: val.merchantId }, query: {} },
					}),
				});
				toast.success(
					m.success_placeholder({
						action: capitalizeFirstLetter(
							m.delete_placeholder({ field: m.menu() }).toLowerCase(),
						),
					}),
				);
				setOpen(false);
				onSuccess?.();
			},
			onError: async () => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(
							m.delete_placeholder({ field: m.menu() }).toLowerCase(),
						),
					}),
				);
			},
		}),
	);
	return (
		<AlertDialog open={open} onOpenChange={setOpen}>
			<AlertDialogTrigger
				className={cn(
					buttonVariants({ variant: "ghost", size: "sm" }),
					"w-full justify-start",
				)}
			>
				<TrashIcon />
				{m.delete()}
			</AlertDialogTrigger>
			<AlertDialogContent>
				<AlertDialogHeader>
					<AlertDialogTitle>{m.are_you_absolutely_sure()}?</AlertDialogTitle>
					<AlertDialogDescription>
						{m.this_action_cannot_be_undone_placeholder({ name: val.name })}
					</AlertDialogDescription>
				</AlertDialogHeader>
				<AlertDialogFooter>
					<AlertDialogCancel disabled={mutation.isPending}>
						{m.cancel()}
					</AlertDialogCancel>
					<Button
						onClick={async () => await mutation.mutateAsync({ params: val })}
						disabled={mutation.isPending}
					>
						{mutation.isPending ? <Submitting /> : m.continue()}
					</Button>
				</AlertDialogFooter>
			</AlertDialogContent>
		</AlertDialog>
	);
};

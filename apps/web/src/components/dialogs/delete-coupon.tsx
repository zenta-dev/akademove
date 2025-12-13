import { m } from "@repo/i18n";
import type { Coupon } from "@repo/schema/coupon";
import { useMutation } from "@tanstack/react-query";
import { toast } from "sonner";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { orpcQuery, queryClient } from "@/lib/orpc";

interface DeleteCouponDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	coupon: Coupon;
}

export const DeleteCouponDialog = ({
	open,
	onOpenChange,
	coupon,
}: DeleteCouponDialogProps) => {
	const deleteMutation = useMutation(
		orpcQuery.coupon.remove.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(m.success_placeholder({ action: m.coupon_delete() }));
				onOpenChange(false);
			},
			onError: (error: Error) => {
				toast.error(m.failed_placeholder({ action: m.coupon_delete() }), {
					description: error.message || m.an_unexpected_error_occurred(),
				});
			},
		}),
	);

	const handleDelete = () => {
		deleteMutation.mutate({ params: { id: coupon.id } });
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.coupon_delete()}</DialogTitle>
					<DialogDescription>{m.coupon_delete_desc()}</DialogDescription>
				</DialogHeader>
				<div className="space-y-4">
					<Alert>
						<AlertDescription>
							{m.coupon()}: <strong>{coupon.name}</strong> ({coupon.code})
						</AlertDescription>
					</Alert>
				</div>
				<DialogFooter>
					<Button
						variant="outline"
						onClick={() => onOpenChange(false)}
						disabled={deleteMutation.isPending}
					>
						{m.cancel()}
					</Button>
					<Button
						variant="destructive"
						onClick={handleDelete}
						disabled={deleteMutation.isPending}
					>
						{deleteMutation.isPending ? m.deleting() : m.delete()}
					</Button>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};

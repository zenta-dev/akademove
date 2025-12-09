import { m } from "@repo/i18n";
import type { Coupon } from "@repo/schema/coupon";
import { useQueryClient } from "@tanstack/react-query";
import { useState } from "react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { orpcClient } from "@/lib/orpc";

interface DeactivateCouponDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	coupon: Coupon;
}

export const DeactivateCouponDialog = ({
	open,
	onOpenChange,
	coupon,
}: DeactivateCouponDialogProps) => {
	const [isLoading, setIsLoading] = useState(false);
	const queryClient = useQueryClient();

	const handleDeactivate = async () => {
		setIsLoading(true);
		try {
			const result = await orpcClient.coupon.deactivate({
				params: { id: coupon.id },
			});
			if (result.status === 200) {
				toast.success(m.server_coupon_deactivated());
				queryClient.invalidateQueries();
				onOpenChange(false);
			} else {
				toast.error(m.an_unexpected_error_occurred());
			}
		} catch (error) {
			toast.error(m.an_unexpected_error_occurred());
			console.error("Failed to deactivate coupon:", error);
		} finally {
			setIsLoading(false);
		}
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.deactivate_coupon()}</DialogTitle>
					<DialogDescription>{m.deactivate_coupon_desc()}</DialogDescription>
				</DialogHeader>
				<div className="py-4">
					<p className="text-muted-foreground text-sm">
						{m.are_you_absolutely_sure()}
					</p>
					<p className="mt-2 font-medium text-sm">
						{coupon.name} ({coupon.code})
					</p>
				</div>
				<DialogFooter>
					<Button
						variant="outline"
						onClick={() => onOpenChange(false)}
						disabled={isLoading}
					>
						{m.cancel()}
					</Button>
					<Button
						variant="destructive"
						onClick={handleDeactivate}
						disabled={isLoading}
					>
						{isLoading ? m.submitting() : m.deactivate()}
					</Button>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};

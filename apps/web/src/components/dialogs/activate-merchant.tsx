import { m } from "@repo/i18n";
import type { Merchant } from "@repo/schema/merchant";
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

interface ActivateMerchantDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	merchant: Merchant;
}

export const ActivateMerchantDialog = ({
	open,
	onOpenChange,
	merchant,
}: ActivateMerchantDialogProps) => {
	const [isLoading, setIsLoading] = useState(false);
	const queryClient = useQueryClient();

	const handleActivate = async () => {
		setIsLoading(true);
		try {
			const result = await orpcClient.merchant.activate({
				params: { id: merchant.id },
			});
			if (result.status === 200) {
				toast.success(m.server_merchant_activated());
				queryClient.invalidateQueries({ queryKey: ["merchants"] });
				onOpenChange(false);
			} else {
				toast.error(m.an_unexpected_error_occurred());
			}
		} catch (error) {
			toast.error(m.an_unexpected_error_occurred());
			console.error("Failed to activate merchant:", error);
		} finally {
			setIsLoading(false);
		}
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.activate_merchant()}</DialogTitle>
					<DialogDescription>{m.activate_merchant_desc()}</DialogDescription>
				</DialogHeader>
				<div className="py-4">
					<p className="text-muted-foreground text-sm">
						{m.are_you_absolutely_sure()}
					</p>
					<p className="mt-2 font-medium text-sm">{merchant.name}</p>
				</div>
				<DialogFooter>
					<Button
						variant="outline"
						onClick={() => onOpenChange(false)}
						disabled={isLoading}
					>
						{m.cancel()}
					</Button>
					<Button onClick={handleActivate} disabled={isLoading}>
						{isLoading ? m.submitting() : m.activate()}
					</Button>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};

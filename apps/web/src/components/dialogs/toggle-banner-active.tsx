import { m } from "@repo/i18n";
import type { Banner } from "@repo/schema/banner";
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

interface ToggleBannerActiveDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	banner: Banner;
}

export const ToggleBannerActiveDialog = ({
	open,
	onOpenChange,
	banner,
}: ToggleBannerActiveDialogProps) => {
	const [isLoading, setIsLoading] = useState(false);
	const queryClient = useQueryClient();
	const isActivating = !banner.isActive;

	const handleToggle = async () => {
		setIsLoading(true);
		try {
			const result = await orpcClient.banner.toggleActive({
				params: { id: banner.id },
			});
			if (result.status === 200) {
				toast.success(
					isActivating
						? m.success_placeholder({ action: m.banner_activate() })
						: m.success_placeholder({ action: m.banner_deactivate() }),
				);
				queryClient.invalidateQueries();
				onOpenChange(false);
			} else {
				toast.error(m.an_unexpected_error_occurred());
			}
		} catch (error) {
			toast.error(m.an_unexpected_error_occurred());
			console.error("Failed to toggle banner status:", error);
		} finally {
			setIsLoading(false);
		}
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>
						{isActivating ? m.banner_activate() : m.banner_deactivate()}
					</DialogTitle>
					<DialogDescription>
						{isActivating
							? m.banner_activate_desc()
							: m.banner_deactivate_desc()}
					</DialogDescription>
				</DialogHeader>
				<div className="py-4">
					<p className="text-muted-foreground text-sm">
						{m.are_you_absolutely_sure()}
					</p>
					<p className="mt-2 font-medium text-sm">{banner.title}</p>
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
						variant={isActivating ? "default" : "destructive"}
						onClick={handleToggle}
						disabled={isLoading}
					>
						{isLoading
							? m.submitting()
							: isActivating
								? m.activate()
								: m.deactivate()}
					</Button>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};

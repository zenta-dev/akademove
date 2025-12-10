import { m } from "@repo/i18n";
import type { Banner } from "@repo/schema/banner";
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

interface DeleteBannerDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	banner: Banner;
}

export const DeleteBannerDialog = ({
	open,
	onOpenChange,
	banner,
}: DeleteBannerDialogProps) => {
	const deleteMutation = useMutation(
		orpcQuery.banner.delete.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(m.success_placeholder({ action: m.banner_delete() }));
				onOpenChange(false);
			},
			onError: (error: Error) => {
				toast.error(m.failed_placeholder({ action: m.banner_delete() }), {
					description: error.message || m.an_unexpected_error_occurred(),
				});
			},
		}),
	);

	const handleDelete = () => {
		deleteMutation.mutate({ params: { id: banner.id } });
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.banner_delete()}</DialogTitle>
					<DialogDescription>{m.banner_delete_desc()}</DialogDescription>
				</DialogHeader>
				<div className="space-y-4">
					<Alert>
						<AlertDescription>
							{m.banner()}: <strong>{banner.title}</strong>
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
